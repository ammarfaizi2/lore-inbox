Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270925AbTHASvH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Aug 2003 14:51:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270926AbTHASvH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Aug 2003 14:51:07 -0400
Received: from cable98.usuarios.retecal.es ([212.22.32.98]:40367 "EHLO
	hell.lnx.es") by vger.kernel.org with ESMTP id S270925AbTHASu7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Aug 2003 14:50:59 -0400
Date: Fri, 1 Aug 2003 20:50:45 +0200
From: Manuel Estrada Sainz <ranty@debian.org>
To: Matthew Wilcox <willy@debian.org>
Cc: Marcel Holtmann <marcel@holtmann.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       greg@kroah.com, Patrick Mochel <mochel@osdl.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] Re: Firmware loading problem
Message-ID: <20030801185045.GA30429@ranty.pantax.net>
Reply-To: ranty@debian.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="r5Pyd7+fXNt84Ff3"
Content-Disposition: inline
In-Reply-To: <20030801150538.GA9731@ranty.pantax.net>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--r5Pyd7+fXNt84Ff3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 01, 2003 at 05:05:38PM +0200, Manuel Estrada Sainz wrote:
> On Sun, Jul 27, 2003 at 11:21:34PM +0200, Manuel Estrada Sainz wrote:
> > On Sun, Jul 27, 2003 at 08:21:11PM +0100, Matthew Wilcox wrote:
> > > On Sat, Jul 26, 2003 at 11:04:58AM +0200, Manuel Estrada Sainz wrote:
> > > > 	- hopefully adapt drivers/pci/pci-sysfs.c to this changes
> > > > 		- Please double check, I didn't look very carefully on
> > > > 		  this.
> > > 
> > > Definitely wrong.  I was going to undo this change since I realised how
> > > it doesn't work for you; but the change you made to the PCI code is wrong.
> > > It ends up copying everything to offset 0 from the buf address. 
> > 
> >  Exactly, and that is what sysfs code expects (with the rest of the
> >  patch), the buffer is just temporary storage, it doesn't really matter
> >  what offset you use as long as you don't write further than
> >  buffer+PAGE_SIZE and both sides of the issue agree.
> 
>  My fault, I was severely misguided here, Matthew is of course write.
>  Now that I understand the issue a little deeper I'll try send a correct
>  patch to get the issue done with.

 OK, this time I have tested the PCI changes and it works:

 the patches:

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

 Have a nice day

 	Manuel


-- 
--- Manuel Estrada Sainz <ranty@debian.org>
                         <ranty@bigfoot.com>
			 <ranty@users.sourceforge.net>
------------------------ <manuel.estrada@hispalinux.es> -------------------
Let us have the serenity to accept the things we cannot change, courage to
change the things we can, and wisdom to know the difference.

--r5Pyd7+fXNt84Ff3
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

--r5Pyd7+fXNt84Ff3
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

--r5Pyd7+fXNt84Ff3
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
 

--r5Pyd7+fXNt84Ff3--
