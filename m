Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932505AbVIHNAu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932505AbVIHNAu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 09:00:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932509AbVIHNAu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 09:00:50 -0400
Received: from mx1.redhat.com ([66.187.233.31]:6373 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932505AbVIHNAt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 09:00:49 -0400
Subject: [PATCH] util-linux: swsuspend support
From: Karel Zak <kzak@redhat.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: List linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Thu, 08 Sep 2005 15:08:56 +0200
Message-Id: <1126184936.3740.139.camel@petra>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


 Hi Adrian,

if you have a swap partition that's been used for swsuspend and you boot
into a different kernel, we should have the swapon re-initialize the
swap to avoid later resuming and causing data corruption. (quote from RH
bugzilla)


Note: there will be support for swsuspend swap detection in the next
release of libblkid (from Theo's e2fsprogs).


	Karel



Signed-off-by: Karel Zak <kzak@redhat.com>
----

--- util-linux-2.13-pre2/mount/swapon.c.swsuspend	2005-08-14 17:17:49.000000000 +0200
+++ util-linux-2.13-pre2/mount/swapon.c	2005-09-08 14:34:51.000000000 +0200
@@ -11,6 +11,9 @@
 #include <mntent.h>
 #include <errno.h>
 #include <sys/stat.h>
+#include <sys/types.h>
+#include <sys/wait.h>
+#include <fcntl.h>
 #include "xmalloc.h"
 #include "swap_constants.h"
 #include "swapargs.h"
@@ -22,6 +25,7 @@
 
 #define	_PATH_FSTAB     "/etc/fstab"
 #define PROC_SWAPS      "/proc/swaps"
+#define PATH_MKSWAP	"/sbin/mkswap"
 
 #define SWAPON_NEEDS_TWO_ARGS
 
@@ -163,6 +167,84 @@
        return 0 ;
 }
 
+/*
+ * It's better do swsuspend detection by follow routine than
+ * include huge mount_guess_fstype.o to swapon. We need only
+ * swsuspend and no the others filesystems.
+ */
+#ifdef HAVE_LIBBLKID
+static int
+swap_is_swsuspend(const char *device) {
+	const char *type = blkid_get_tag_value(blkid, "TYPE", device);
+	
+	if (type && strcmp(type, "swsuspend")==0)
+		return 0;
+	return 1;
+}
+#else
+static int
+swap_is_swsuspend(const char *device) {
+	int fd, re = 1, n = getpagesize() - 10;
+	char buf[10];
+	
+	fd = open(device, O_RDONLY);
+	if (fd < 0)
+		return -1;
+
+	if (lseek(fd, n, SEEK_SET) >= 0 &&
+	    read(fd, buf, sizeof buf) == sizeof buf &&
+	    (memcmp("S1SUSPEND", buf, 9)==0 ||
+			memcmp("S2SUSPEND", buf, 9)==0))
+		re = 0;
+
+	close(fd);
+	return re;
+}
+#endif
+
+/* calls mkswap */
+static int
+swap_reinitialize(const char *device) {
+	const char *label = mount_get_volume_label_by_spec(device);
+	pid_t pid;
+	
+	switch((pid=fork())) {
+		case -1: /* fork error */
+			fprintf(stderr, _("%s: cannot fork: %s\n"),
+				progname, strerror(errno));
+			return -1;
+			
+		case 0:	/* child */
+			if (label && *label)
+				execl(PATH_MKSWAP, PATH_MKSWAP, "-L", label, device, NULL);
+			else
+				execl(PATH_MKSWAP, PATH_MKSWAP, device, NULL);
+			exit(1); /* error  */
+			
+		default: /* parent */
+		{
+			int status;
+			int ret;
+
+			do {
+				if ((ret = waitpid(pid, &status, 0)) < 0 
+						&& errno == EINTR)
+					continue;
+				else if (ret < 0) {
+					fprintf(stderr, _("%s: waitpid: %s\n"),
+						progname, strerror(errno));
+					return -1;
+		      		}
+			} while (0);
+
+			/* mkswap returns: 0=suss, 1=error */
+			if (WIFEXITED(status) && WEXITSTATUS(status)==0)
+				return 0; /* ok */
+		}
+	}
+	return -1; /* error */
+}
+	
 static int
 do_swapon(const char *orig_special, int prio) {
 	int status;
@@ -186,6 +268,18 @@
 		return -1;
 	}
 
+	/* We have to reinitialize swap with old (=useless) software suspend 
+	 * data. The problem is that if we don't do it, then we get data 
+	 * corruption the next time with suspended on.
+	 */
+	if (swap_is_swsuspend(special)==0) {
+		fprintf(stdout, _("%s: %s: software suspend data detected. "
+					"Reinitializing the swap.\n"), 
+			progname, special);
+		if (swap_reinitialize(special) < 0)
+			return -1;
+	}
+	
 	/* people generally dislike this warning - now it is printed
 	   only when `verbose' is set */
 	if (verbose) {
--- util-linux-2.13-pre2/mount/get_label_uuid.c.swsuspend	2005-07-31 23:58:38.000000000 +0200
+++ util-linux-2.13-pre2/mount/get_label_uuid.c	2005-09-08 14:34:51.000000000 +0200
@@ -93,7 +93,24 @@
 	}
 	return 0;
 }
-	    
+
+static int
+is_swsuspend_partition(int fd, char **label, char *uuid) {
+	int n = getpagesize();
+	char *buf = xmalloc(n);
+	struct swap_header_v1_2 *p = (struct swap_header_v1_2 *) buf;
+
+	if (lseek(fd, 0, SEEK_SET) == 0
+	    && read(fd, buf, n) == n
+	    && (strncmp(buf+n-10, "S1SUSPEND", 9)==0 || 
+		    strncmp(buf+n-10, "S2SUSPEND", 9)==0)
+	    && p->version == 1) {
+		store_uuid(uuid, p->uuid);
+		store_label(label, p->volume_name, 16);
+		return 1;
+	}
+	return 0;
+}
 
 /*
  * Get both label and uuid.
@@ -126,6 +143,8 @@
 
 	if (is_v1_swap_partition(fd, label, uuid))
 		goto done;
+	if (is_swsuspend_partition(fd, label, uuid))
+		goto done;
 
 	if (lseek(fd, 1024, SEEK_SET) == 1024
 	    && read(fd, (char *) &e2sb, sizeof(e2sb)) == sizeof(e2sb)




