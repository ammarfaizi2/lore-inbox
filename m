Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270700AbTHJVHV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Aug 2003 17:07:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270692AbTHJVHV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Aug 2003 17:07:21 -0400
Received: from cable98.usuarios.retecal.es ([212.22.32.98]:60908 "EHLO
	hell.lnx.es") by vger.kernel.org with ESMTP id S270700AbTHJVG7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Aug 2003 17:06:59 -0400
Date: Sun, 10 Aug 2003 23:06:46 +0200
From: Manuel Estrada Sainz <ranty@debian.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Matthew Wilcox <willy@debian.org>
Subject: [PATCH] [2.6.0-test3] request_firmware related problems.
Message-ID: <20030810210646.GA6746@ranty.pantax.net>
Reply-To: ranty@debian.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="XsQoSWH+UP9D9v3l"
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--XsQoSWH+UP9D9v3l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

 Hi,

 Please apply the following patches.
 
 Matthew Wilcox seams busy lately and didn't confirm the pci changes,
 but I have tested them and it works. He can modify it later with nicer
 code if he finds it necessary, sysfs binary support has been broken for
 too much time already being in this stage of development :-/.

 - sysfs-bin-unbreak-2-main.diff:
	- undo recent change, made in the believe that "buffer" was the
	  size of the whole file, it is just PAGE_SIZE in size. This was
	  causing kernel memory corruption.

		- Since files are allowed to have unknown sizes, by
		  setting their size to 0, we can't preallocate a buffer
		  of their size on open.

 - sysfs-bin-unbreak-2-request_firmware.diff:
	- Adapt to the above sysfs change.

 - sysfs-bin-unbreak-2-pci.diff:
  	- hopefully adapt drivers/pci/pci-sysfs.c to this changes.
		- Matthew can probably make it look prettier, but for
		  now it works.

 - request_firmware_own-workqueue.diff:
	-  In it's current form request_firmware_async() sleeps way too
	   long on the system's shared workqueue, which makes it
	   unresponsive until the firmware load finishes, gets canceled
	   or times out.


 Have a nice day

 	Manuel


-- 
--- Manuel Estrada Sainz <ranty@debian.org>
                         <ranty@bigfoot.com>
			 <ranty@users.sourceforge.net>
------------------------ <manuel.estrada@hispalinux.es> -------------------
Let us have the serenity to accept the things we cannot change, courage to
change the things we can, and wisdom to know the difference.

--XsQoSWH+UP9D9v3l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="sysfs-bin-unbreak-2-main.diff"

--- fs/sysfs/bin.c	4 Jul 2003 02:21:18 -0000	1.9
+++ fs/sysfs/bin.c	1 Aug 2003 14:26:45 -0000
@@ -47,7 +47,7 @@
 		return ret;
 	count = ret;
 
-	if (copy_to_user(userbuf, buffer + offs, count) != 0)
+	if (copy_to_user(userbuf, buffer, count) != 0)
 		return -EINVAL;
 
 	pr_debug("offs = %lld, *off = %lld, count = %zd\n", offs, *off, count);
@@ -83,7 +83,7 @@
 			count = size - offs;
 	}
 
-	if (copy_from_user(buffer + offs, userbuf, count))
+	if (copy_from_user(buffer, userbuf, count))
 		return -EFAULT;
 
 	count = flush_write(dentry, buffer, offs, count);

--XsQoSWH+UP9D9v3l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="sysfs-bin-unbreak-2-pci.diff"

--- drivers/pci/pci-sysfs.c	4 Jul 2003 02:21:18 -0000	1.6
+++ drivers/pci/pci-sysfs.c	1 Aug 2003 14:26:43 -0000
@@ -67,6 +67,7 @@
 {
 	struct pci_dev *dev = to_pci_dev(container_of(kobj,struct device,kobj));
 	unsigned int size = 64;
+	loff_t init_off = off;
 
 	/* Several chips lock up trying to read undefined config space */
 	if (capable(CAP_SYS_ADMIN)) {
@@ -87,7 +88,7 @@
 	while (off & 3) {
 		unsigned char val;
 		pci_read_config_byte(dev, off, &val);
-		buf[off] = val;
+		buf[off - init_off] = val;
 		off++;
 		if (--size == 0)
 			break;
@@ -96,10 +97,10 @@
 	while (size > 3) {
 		unsigned int val;
 		pci_read_config_dword(dev, off, &val);
-		buf[off] = val & 0xff;
-		buf[off + 1] = (val >> 8) & 0xff;
-		buf[off + 2] = (val >> 16) & 0xff;
-		buf[off + 3] = (val >> 24) & 0xff;
+		buf[off - init_off] = val & 0xff;
+		buf[off - init_off + 1] = (val >> 8) & 0xff;
+		buf[off - init_off + 2] = (val >> 16) & 0xff;
+		buf[off - init_off + 3] = (val >> 24) & 0xff;
 		off += 4;
 		size -= 4;
 	}
@@ -107,7 +108,7 @@
 	while (size > 0) {
 		unsigned char val;
 		pci_read_config_byte(dev, off, &val);
-		buf[off] = val;
+		buf[off - init_off] = val;
 		off++;
 		--size;
 	}
@@ -120,6 +121,7 @@
 {
 	struct pci_dev *dev = to_pci_dev(container_of(kobj,struct device,kobj));
 	unsigned int size = count;
+	loff_t init_off = off;
 
 	if (off > 256)
 		return 0;
@@ -129,24 +131,24 @@
 	}
 
 	while (off & 3) {
-		pci_write_config_byte(dev, off, buf[off]);
+		pci_write_config_byte(dev, off, buf[off - init_off]);
 		off++;
 		if (--size == 0)
 			break;
 	}
 
 	while (size > 3) {
-		unsigned int val = buf[off];
-		val |= (unsigned int) buf[off + 1] << 8;
-		val |= (unsigned int) buf[off + 2] << 16;
-		val |= (unsigned int) buf[off + 3] << 24;
+		unsigned int val = buf[off - init_off];
+		val |= (unsigned int) buf[off - init_off + 1] << 8;
+		val |= (unsigned int) buf[off - init_off + 2] << 16;
+		val |= (unsigned int) buf[off - init_off + 3] << 24;
 		pci_write_config_dword(dev, off, val);
 		off += 4;
 		size -= 4;
 	}
 
 	while (size > 0) {
-		pci_write_config_byte(dev, off, buf[off]);
+		pci_write_config_byte(dev, off, buf[off - init_off]);
 		off++;
 		--size;
 	}

--XsQoSWH+UP9D9v3l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="sysfs-bin-unbreak-2-request_firmware.diff"

--- drivers/base/firmware_class.c	26 Jul 2003 08:38:07 -0000
+++ drivers/base/firmware_class.c	1 Aug 2003 14:26:41 -0000
@@ -151,7 +151,7 @@
 	if (offset + count > fw->size)
 		count = fw->size - offset;
 
-	memcpy(buffer + offset, fw->data + offset, count);
+	memcpy(buffer, fw->data + offset, count);
 	return count;
 }
 static int
@@ -200,7 +200,7 @@
 	if (retval)
 		return retval;
 
-	memcpy(fw->data + offset, buffer + offset, count);
+	memcpy(fw->data + offset, buffer, count);
 
 	fw->size = max_t(size_t, offset + count, fw->size);
 

--XsQoSWH+UP9D9v3l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="request_firmware_own-workqueue.diff"

Index: drivers/base/firmware_class.c
===================================================================
RCS file: /home/cvs/linux-2.5/drivers/base/firmware_class.c,v
retrieving revision 1.3
diff -u -r1.3 drivers/base/firmware_class.c
--- drivers/base/firmware_class.c	4 Jul 2003 02:21:18 -0000	1.3
+++ drivers/base/firmware_class.c	26 Jul 2003 08:38:07 -0000
@@ -22,6 +22,8 @@
 MODULE_LICENSE("GPL");
 
 static int loading_timeout = 10;	/* In seconds */
+static struct workqueue_struct *firmware_wq;
+
 
 struct firmware_priv {
 	char fw_id[FIRMWARE_NAME_MAX];
@@ -467,7 +469,7 @@
 	};
 	INIT_WORK(&fw_work->work, request_firmware_work_func, fw_work);
 
-	schedule_work(&fw_work->work);
+	queue_work(firmware_wq, &fw_work->work);
 	return 0;
 }
 
@@ -485,12 +487,20 @@
 		       __FUNCTION__);
 		class_unregister(&firmware_class);
 	}
+	firmware_wq = create_workqueue("firmware");
+	if (!firmware_wq) {
+		printk(KERN_ERR "%s: create_workqueue failed\n", __FUNCTION__);
+		class_remove_file(&firmware_class, &class_attr_timeout);
+		class_unregister(&firmware_class);
+		error = -EIO;
+	}
 	return error;
 
 }
 static void __exit
 firmware_class_exit(void)
 {
+	destroy_workqueue(firmware_wq);
 	class_remove_file(&firmware_class, &class_attr_timeout);
 	class_unregister(&firmware_class);
 }

--XsQoSWH+UP9D9v3l--
