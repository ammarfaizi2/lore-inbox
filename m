Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264937AbUGJXWU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264937AbUGJXWU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jul 2004 19:22:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265986AbUGJXWU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jul 2004 19:22:20 -0400
Received: from natsmtp00.rzone.de ([81.169.145.165]:9933 "EHLO
	natsmtp00.rzone.de") by vger.kernel.org with ESMTP id S264937AbUGJXWN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jul 2004 19:22:13 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Peter Osterlund <petero2@telia.com>
Subject: Re: [PATCH] CDRW packet writing support for 2.6.7-bk13
Date: Sun, 11 Jul 2004 01:20:45 +0200
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
       Jens Axboe <axboe@suse.de>, Andrew Morton <akpm@osdl.org>
References: <m2lli36ec9.fsf@telia.com> <m2llhz5o4o.fsf@telia.com> <m2fz875nkv.fsf@telia.com>
In-Reply-To: <m2fz875nkv.fsf@telia.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200407110120.47256.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Montag, 5. Juli 2004 02:01, Peter Osterlund wrote:

> And here is a combined patch consisting of the 7 patches I've posted
> so far, which should make it easier for those who want to test the
> driver. Applies to 2.6.7-bk15 and probably -bk16 and -bk17 too.

I tried the version from -mm7 on my opteron box with a dvd+rw medium
and 32 bit user tools. The success was rather mixed. Besides the patch
below to make it work at all, I noticed that I was not able to rw-mount
/dev/dvd after writing a disk through /dev/pktcdvd0. However, I could
actually remount,rw /dev/dvd after mounting it read-only.

Also, I believe I hit a race running hdparm while writing to a mounted
/dev/pktcdvd0. This resulted in the writing process getting stuck in
wait_on_buffer, but I could not reproduce this behaviour later.

> +static int pkt_ioctl(struct inode *inode, struct file *file, unsigned int cmd, unsigned long arg)
> +{

> +	switch (cmd) {
> +	case PACKET_GET_STATS:
> +		if (copy_to_user(&arg, &pd->stats, sizeof(struct packet_stats)))
> +			return -EFAULT;
> +		break;

This clearly doesn't work, since arg is not what copy_to_user expects here.
Even if it worked, this particular interface would still be just wrong and
should be removed.

> +#if PACKET_DEBUG
> +#define DPRINTK(fmt, args...) printk(KERN_NOTICE fmt, ##args)
> +#else
> +#define DPRINTK(fmt, args...)
> +#endif
> +
> +#if PACKET_DEBUG > 1
> +#define VPRINTK(fmt, args...) printk(KERN_NOTICE fmt, ##args)
> +#else
> +#define VPRINTK(fmt, args...)
> +#endif

These definitions should not be in the pktcdvd header file, since they
conflict with similar definitions in other headers. If you want to keep
them, they should be moved to the .c file.

> +#define PACKET_SETUP_DEV	_IOW(PACKET_IOCTL_MAGIC, 1, unsigned int)
> +#define PACKET_TEARDOWN_DEV	_IOW(PACKET_IOCTL_MAGIC, 2, unsigned int)

These are actually incorrect definitions since the ioctl argument is
not a pointer to unsigned int but instead just an int. However, that's
too late to fix without breaking the existing tools.

	Arnd <><

========
[PATCH] fix packet CD/DVD writing for compat mode

This adds support for 32 bit compatibility mode to the new pktcdvd
ioctl interface. The contained changes are:
- Add ULONG_IOCTL() definitions to <linux/compat_ioctl.h> for the 
  setup/teardown ioctls.
- Remove the PACKET_GET_STATS ioctl. It would require a compat handler
  function to emulate, however it is completely bogus and did not
  work as designed anyway.
- move conflicting DPRINTK/VPRINTK out of the header file so it can
  be included from fs/compat_ioctl.c. 

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

--- 1.1/drivers/block/pktcdvd.c	Sat Jul 10 20:34:47 2004
+++ edited/drivers/block/pktcdvd.c	Sat Jul 10 22:33:51 2004
@@ -52,6 +52,18 @@
 
 #include <asm/uaccess.h>
 
+#if PACKET_DEBUG
+#define DPRINTK(fmt, args...) printk(KERN_NOTICE fmt, ##args)
+#else
+#define DPRINTK(fmt, args...)
+#endif
+
+#if PACKET_DEBUG > 1
+#define VPRINTK(fmt, args...) printk(KERN_NOTICE fmt, ##args)
+#else
+#define VPRINTK(fmt, args...)
+#endif
+
 #define ZONE(sector, pd) (((sector) + (pd)->offset) & ~((pd)->settings.size - 1))
 
 static struct pktcdvd_device *pkt_devs;
@@ -2475,11 +2487,6 @@
 	}
 
 	switch (cmd) {
-	case PACKET_GET_STATS:
-		if (copy_to_user(&arg, &pd->stats, sizeof(struct packet_stats)))
-			return -EFAULT;
-		break;
-
 	case PACKET_SETUP_DEV:
 		if (pd->dev) {
 			printk("pktcdvd: dev already setup\n");
===== fs/compat_ioctl.c 1.37 vs edited =====
--- 1.37/fs/compat_ioctl.c	Fri Jul  9 07:40:22 2004
+++ edited/fs/compat_ioctl.c	Sat Jul 10 22:30:15 2004
@@ -68,6 +68,7 @@
 #include <linux/i2c.h>
 #include <linux/i2c-dev.h>
 #include <linux/wireless.h>
+#include <linux/pktcdvd.h>
 
 #include <net/sock.h>          /* siocdevprivate_ioctl */
 #include <net/bluetooth/bluetooth.h>
--- 1.28/include/linux/compat_ioctl.h	Fri Jul  9 07:40:22 2004
+++ edited/include/linux/compat_ioctl.h	Sat Jul 10 22:31:17 2004
@@ -382,6 +382,9 @@
 COMPATIBLE_IOCTL(DVD_READ_STRUCT)
 COMPATIBLE_IOCTL(DVD_WRITE_STRUCT)
 COMPATIBLE_IOCTL(DVD_AUTH)
+/* pktcdvd */
+ULONG_IOCTL(PACKET_SETUP_DEV)
+ULONG_IOCTL(PACKET_TEARDOWN_DEV)
 /* Big L */
 ULONG_IOCTL(LOOP_SET_FD)
 COMPATIBLE_IOCTL(LOOP_CLR_FD)
===== include/linux/pktcdvd.h 1.1 vs edited =====
--- 1.1/include/linux/pktcdvd.h	Sat Jul 10 20:34:51 2004
+++ edited/include/linux/pktcdvd.h	Sat Jul 10 22:34:46 2004
@@ -40,18 +40,6 @@
  * No user-servicable parts beyond this point ->
  */
 
-#if PACKET_DEBUG
-#define DPRINTK(fmt, args...) printk(KERN_NOTICE fmt, ##args)
-#else
-#define DPRINTK(fmt, args...)
-#endif
-
-#if PACKET_DEBUG > 1
-#define VPRINTK(fmt, args...) printk(KERN_NOTICE fmt, ##args)
-#else
-#define VPRINTK(fmt, args...)
-#endif
-
 /*
  * device types
  */
@@ -98,22 +86,9 @@
 #undef PACKET_USE_LS
 
 /*
- * Very crude stats for now
- */
-struct packet_stats
-{
-	unsigned long		pkt_started;
-	unsigned long		pkt_ended;
-	unsigned long		secs_w;
-	unsigned long		secs_rg;
-	unsigned long		secs_r;
-};
-
-/*
  * packet ioctls
  */
 #define PACKET_IOCTL_MAGIC	('X')
-#define PACKET_GET_STATS	_IOR(PACKET_IOCTL_MAGIC, 0, struct packet_stats)
 #define PACKET_SETUP_DEV	_IOW(PACKET_IOCTL_MAGIC, 1, unsigned int)
 #define PACKET_TEARDOWN_DEV	_IOW(PACKET_IOCTL_MAGIC, 2, unsigned int)
 
@@ -131,6 +106,18 @@
 	__u8			write_type;
 	__u8			track_mode;
 	__u8			block_mode;
+};
+
+/*
+ * Very crude stats for now
+ */
+struct packet_stats
+{
+	unsigned long		pkt_started;
+	unsigned long		pkt_ended;
+	unsigned long		secs_w;
+	unsigned long		secs_rg;
+	unsigned long		secs_r;
 };
 
 struct packet_cdrw
