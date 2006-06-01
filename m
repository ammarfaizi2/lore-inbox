Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964891AbWFAFQB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964891AbWFAFQB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 01:16:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964890AbWFAFOd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 01:14:33 -0400
Received: from cantor2.suse.de ([195.135.220.15]:17833 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S964893AbWFAFO3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 01:14:29 -0400
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Thu, 1 Jun 2006 15:14:18 +1000
Message-Id: <1060601051418.27661@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 010 of 10] md: Allow the write_mostly flag to be set via sysfs.
References: <20060601150955.27444.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


It appears in /sys/mdX/md/dev-YYY/state
and can be set or cleared by writing 'writemostly' or '-writemostly'
respectively.

Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./Documentation/md.txt |    5 +++++
 ./drivers/md/md.c      |   12 ++++++++++++
 2 files changed, 17 insertions(+)

diff ./Documentation/md.txt~current~ ./Documentation/md.txt
--- ./Documentation/md.txt~current~	2006-06-01 15:05:30.000000000 +1000
+++ ./Documentation/md.txt	2006-06-01 15:05:30.000000000 +1000
@@ -309,6 +309,9 @@ Each directory contains:
 	      faulty   - device has been kicked from active use due to
                          a detected fault
 	      in_sync  - device is a fully in-sync member of the array
+	      writemostly - device will only be subject to read
+		         requests if there are no other options.
+			 This applies only to raid1 arrays.
 	      spare    - device is working, but not a full member.
 			 This includes spares that are in the process
 			 of being recoverred to
@@ -316,6 +319,8 @@ Each directory contains:
 	This can be written to.
 	Writing "faulty"  simulates a failure on the device.
 	Writing "remove" removes the device from the array.
+	Writing "writemostly" sets the writemostly flag.
+	Writing "-writemostly" clears the writemostly flag.
 
       errors
 	An approximate count of read errors that have been detected on

diff ./drivers/md/md.c~current~ ./drivers/md/md.c
--- ./drivers/md/md.c~current~	2006-06-01 15:05:30.000000000 +1000
+++ ./drivers/md/md.c	2006-06-01 15:05:30.000000000 +1000
@@ -1737,6 +1737,10 @@ state_show(mdk_rdev_t *rdev, char *page)
 		len += sprintf(page+len, "%sin_sync",sep);
 		sep = ",";
 	}
+	if (test_bit(WriteMostly, &rdev->flags)) {
+		len += sprintf(page+len, "%swrite_mostly",sep);
+		sep = ",";
+	}
 	if (!test_bit(Faulty, &rdev->flags) &&
 	    !test_bit(In_sync, &rdev->flags)) {
 		len += sprintf(page+len, "%sspare", sep);
@@ -1751,6 +1755,8 @@ state_store(mdk_rdev_t *rdev, const char
 	/* can write
 	 *  faulty  - simulates and error
 	 *  remove  - disconnects the device
+	 *  writemostly - sets write_mostly
+	 *  -writemostly - clears write_mostly
 	 */
 	int err = -EINVAL;
 	if (cmd_match(buf, "faulty") && rdev->mddev->pers) {
@@ -1766,6 +1772,12 @@ state_store(mdk_rdev_t *rdev, const char
 			md_new_event(mddev);
 			err = 0;
 		}
+	} else if (cmd_match(buf, "writemostly")) {
+		set_bit(WriteMostly, &rdev->flags);
+		err = 0;
+	} else if (cmd_match(buf, "-writemostly")) {
+		clear_bit(WriteMostly, &rdev->flags);
+		err = 0;
 	}
 	return err ? err : len;
 }
