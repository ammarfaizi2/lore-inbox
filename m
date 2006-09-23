Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751470AbWIWKNX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751470AbWIWKNX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Sep 2006 06:13:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751467AbWIWKM6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Sep 2006 06:12:58 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:18112 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1751461AbWIWKMj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Sep 2006 06:12:39 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH -mm 6/6] swsusp: Document support for swap files
Date: Sat, 23 Sep 2006 12:13:01 +0200
User-Agent: KMail/1.9.1
Cc: Dave Jones <davej@redhat.com>, Pavel Machek <pavel@ucw.cz>,
       LKML <linux-kernel@vger.kernel.org>
References: <200609231158.00147.rjw@sisk.pl>
In-Reply-To: <200609231158.00147.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609231213.02501.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Document the "resume_offset=" command line parameter as well as the way in
which swap files are supported by swsusp.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
Acked-by: Pavel Machek <pavel@ucw.cz>
---
 Documentation/kernel-parameters.txt           |    6 ++
 Documentation/power/swsusp-and-swap-files.txt |   60 ++++++++++++++++++++++++++
 Documentation/power/swsusp.txt                |   18 ++-----
 3 files changed, 71 insertions(+), 13 deletions(-)

Index: linux-2.6.18-rc7-mm1/Documentation/kernel-parameters.txt
===================================================================
--- linux-2.6.18-rc7-mm1.orig/Documentation/kernel-parameters.txt
+++ linux-2.6.18-rc7-mm1/Documentation/kernel-parameters.txt
@@ -1370,6 +1370,12 @@ and is between 256 and 4096 characters. 
 	resume=		[SWSUSP]
 			Specify the partition device for software suspend
 
+	resume_offset=	[SWSUSP]
+			Specify the offset from the beginning of the partition
+			given by "resume=" at which the swap header is located,
+			in <PAGE_SIZE> units (needed only for swap files).
+			See  Documentation/power/swsusp-and-swap-files.txt
+
 	rhash_entries=	[KNL,NET]
 			Set number of hash buckets for route cache
 
Index: linux-2.6.18-rc7-mm1/Documentation/power/swsusp-and-swap-files.txt
===================================================================
--- /dev/null
+++ linux-2.6.18-rc7-mm1/Documentation/power/swsusp-and-swap-files.txt
@@ -0,0 +1,60 @@
+Using swap files with software suspend (swsusp)
+	(C) 2006 Rafael J. Wysocki <rjw@sisk.pl>
+
+The Linux kernel handles swap files almost in the same way as it handles swap
+partitions and there are only two differences between these two types of swap
+areas:
+(1) swap files need not be contiguous,
+(2) the header of a swap file is not in the first block of the partition that
+holds it.  From the swsusp's point of view (1) is not a problem, because it is
+already taken care of by the swap-handling code, but (2) has to be taken into
+consideration.
+
+In principle the location of a swap file's header may be determined with the
+help of appropriate filesystem driver.  Unfortunately, however, it requires the
+filesystem holding the swap file to be mounted, and if this filesystem is
+journaled, it cannot be mounted during resume from disk.  For this reason to
+identify a swap file swsusp uses the name of the partition that holds the file
+and the offset from the beginning of the partition at which the swap file's
+header is located.  For convenience, this offset is expressed in <PAGE_SIZE>
+units.
+
+In order to use a swap file with swsusp, you need to:
+
+1) Create the swap file and make it active, eg.
+
+# dd if=/dev/zero of=<swap_file_path> bs=1024 count=<swap_file_size_in_k>
+# mkswap <swap_file_path>
+# swapon <swap_file_path>
+
+Then, the kernel will place the following line in the dmesg:
+
+Adding <swap_file_size_in_k - 1>k swap on <swap_file_path>.  Priority:-2 extents:<nr_extents> across:<span_in_k>k offset:<swap_file_offset>
+
+where <nr_extents>, <span_in_k>, <swap_file_offset> are numbers that describe
+the swap file configuration.  The last one, <swap_file_offset>, is needed by
+swsusp.
+
+2) Add the following parameters to the kernel command line:
+
+resume=<swap_file_partition> resume_offset=<swap_file_offset>
+
+where <swap_file_partition> is the partition on which the swap file is located.
+
+Now, swsusp will use the swap file in the same way in which it would use a swap
+partition.  [Of course this means that the resume from a swap file cannot be
+initiated from whithin an initrd of initramfs image.]  In particular, the
+swap file has to be active (ie. be present in /proc/swaps) so that it can be
+used for suspending.
+
+Note that the location of a swap file's header may also be determined by
+an application using the FIBMAP ioctl to retrieve the header's block number
+from the kernel.  Next, the information obtained this way can be used to
+update the kernel command line in the boot loader configuration file.
+This approach may be used, for example, by distribution installers and
+automated administration tools.
+
+Note also that if the swap file used for suspending is deleted and recreated,
+the location of its header need not be the same as before.  Thus every time
+this happens the value of the "resume_offset=" kernel command line parameter
+has to be updated.
Index: linux-2.6.18-rc7-mm1/Documentation/power/swsusp.txt
===================================================================
--- linux-2.6.18-rc7-mm1.orig/Documentation/power/swsusp.txt
+++ linux-2.6.18-rc7-mm1/Documentation/power/swsusp.txt
@@ -297,20 +297,12 @@ system is shut down or suspended. Additi
 suspend image to prevent sensitive data from being stolen after
 resume.
 
-Q: Why can't we suspend to a swap file?
+Q: Can I suspend to a swap file?
 
-A: Because accessing swap file needs the filesystem mounted, and
-filesystem might do something wrong (like replaying the journal)
-during mount.
-
-There are few ways to get that fixed:
-
-1) Probably could be solved by modifying every filesystem to support
-some kind of "really read-only!" option. Patches welcome.
-
-2) suspend2 gets around that by storing absolute positions in on-disk
-image (and blocksize), with resume parameter pointing directly to
-suspend header.
+A: Generally, yes, you can.  However, it requires you to use the "resume=" and
+"resume_offset=" kernel command line parameters, so the resume from a swap file
+cannot be initiated from an initrd or initramfs image.  See
+swsusp-and-swap-files.txt for details.
 
 Q: Is there a maximum system RAM size that is supported by swsusp?
 
