Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750940AbWEAFbE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750940AbWEAFbE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 May 2006 01:31:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751176AbWEAFbE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 May 2006 01:31:04 -0400
Received: from cantor2.suse.de ([195.135.220.15]:37040 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750872AbWEAFaZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 May 2006 01:30:25 -0400
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Mon, 1 May 2006 15:30:19 +1000
Message-Id: <1060501053019.22949@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 004 of 11] md: Increase the delay before marking metadata clean, and make it configurable.
References: <20060501152229.18367.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


When a md array has been idle (no writes) for 20msecs it is marked as
'clean'.  This delay turns out to be too short for some real
workloads.  So increase it to 200msec (the time to update the metadata
should be a tiny fraction of that) and make it sysfs-configurable.

Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./Documentation/md.txt |    9 ++++++++
 ./drivers/md/md.c      |   54 +++++++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 61 insertions(+), 2 deletions(-)

diff ./Documentation/md.txt~current~ ./Documentation/md.txt
--- ./Documentation/md.txt~current~	2006-05-01 15:09:20.000000000 +1000
+++ ./Documentation/md.txt	2006-05-01 15:10:18.000000000 +1000
@@ -207,6 +207,15 @@ All md devices contain:
      available.  It will then appear at md/dev-XXX (depending on the
      name of the device) and further configuration is then possible.
 
+   safe_mode_delay
+     When an md array has seen no write requests for a certain period
+     of time, it will be marked as 'clean'.  When another write
+     request arrive, the array is marked as 'dirty' before the write
+     commenses.  This is known as 'safe_mode'.
+     The 'certain period' is controlled by this file which stores the
+     period as a number of seconds.  The default is 200msec (0.200).
+     Writing a value of 0 disables safemode.
+
    sync_speed_min
    sync_speed_max
      This are similar to /proc/sys/dev/raid/speed_limit_{min,max}

diff ./drivers/md/md.c~current~ ./drivers/md/md.c
--- ./drivers/md/md.c~current~	2006-05-01 15:10:17.000000000 +1000
+++ ./drivers/md/md.c	2006-05-01 15:10:18.000000000 +1000
@@ -43,6 +43,7 @@
 #include <linux/suspend.h>
 #include <linux/poll.h>
 #include <linux/mutex.h>
+#include <linux/ctype.h>
 
 #include <linux/init.h>
 
@@ -1968,6 +1969,54 @@ static void analyze_sbs(mddev_t * mddev)
 }
 
 static ssize_t
+safe_delay_show(mddev_t *mddev, char *page)
+{
+	int msec = (mddev->safemode_delay*1000)/HZ;
+	return sprintf(page, "%d.%03d\n", msec/1000, msec%1000);
+}
+static ssize_t
+safe_delay_store(mddev_t *mddev, const char *cbuf, size_t len)
+{
+	int scale=1;
+	int dot=0;
+	int i;
+	unsigned long msec;
+	char buf[30];
+	char *e;
+	/* remove a period, and count digits after it */
+	if (len >= sizeof(buf))
+		return -EINVAL;
+	strlcpy(buf, cbuf, len);
+	buf[len] = 0;
+	for (i=0; i<len; i++) {
+		if (dot) {
+			if (isdigit(buf[i])) {
+				buf[i-1] = buf[i];
+				scale *= 10;
+			}
+			buf[i] = 0;
+		} else if (buf[i] == '.') {
+			dot=1;
+			buf[i] = 0;
+		}
+	}
+	msec = simple_strtoul(buf, &e, 10);
+	if (e == buf || (*e && *e != '\n'))
+		return -EINVAL;
+	msec = (msec * 1000) / scale;
+	if (msec == 0)
+		mddev->safemode_delay = 0;
+	else {
+		mddev->safemode_delay = (msec*HZ)/1000;
+		if (mddev->safemode_delay == 0)
+			mddev->safemode_delay = 1;
+	}
+	return len;
+}
+static struct md_sysfs_entry md_safe_delay =
+__ATTR(safe_mode_delay, 0644,safe_delay_show, safe_delay_store);
+
+static ssize_t
 level_show(mddev_t *mddev, char *page)
 {
 	struct mdk_personality *p = mddev->pers;
@@ -2423,6 +2472,7 @@ static struct attribute *md_default_attr
 	&md_size.attr,
 	&md_metadata.attr,
 	&md_new_device.attr,
+	&md_safe_delay.attr,
 	NULL,
 };
 
@@ -2695,7 +2745,7 @@ static int do_md_run(mddev_t * mddev)
 	mddev->safemode = 0;
 	mddev->safemode_timer.function = md_safemode_timeout;
 	mddev->safemode_timer.data = (unsigned long) mddev;
-	mddev->safemode_delay = (20 * HZ)/1000 +1; /* 20 msec delay */
+	mddev->safemode_delay = (200 * HZ)/1000 +1; /* 200 msec delay */
 	mddev->in_sync = 1;
 
 	ITERATE_RDEV(mddev,rdev,tmp)
@@ -4581,7 +4631,7 @@ void md_write_end(mddev_t *mddev)
 	if (atomic_dec_and_test(&mddev->writes_pending)) {
 		if (mddev->safemode == 2)
 			md_wakeup_thread(mddev->thread);
-		else
+		else if (mddev->safemode_delay)
 			mod_timer(&mddev->safemode_timer, jiffies + mddev->safemode_delay);
 	}
 }
