Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272418AbTGZIus (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jul 2003 04:50:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272427AbTGZIuc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jul 2003 04:50:32 -0400
Received: from cable98.usuarios.retecal.es ([212.22.32.98]:1498 "EHLO
	hell.lnx.es") by vger.kernel.org with ESMTP id S272401AbTGZIuD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jul 2003 04:50:03 -0400
Date: Sat, 26 Jul 2003 11:04:58 +0200
From: Manuel Estrada Sainz <ranty@debian.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, greg@kroah.com,
       willy@debian.org
Subject: [PATCH] Re: Firmware loading problem
Message-ID: <20030726090458.GA16634@ranty.pantax.net>
Reply-To: ranty@debian.org
References: <1058885139.2757.27.camel@pegasus> <20030722145546.GC23593@ranty.pantax.net> <1058888301.2755.8.camel@pegasus>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="mYCpIKhGyMATD0i+"
Content-Disposition: inline
In-Reply-To: <1058888301.2755.8.camel@pegasus>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--mYCpIKhGyMATD0i+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jul 22, 2003 at 05:38:15PM +0200, Marcel Holtmann wrote:
> Hi Manuel,
> 
> > > I installed linux-2.6.0-test1-ac2 and tried to port my driver for the
> > > BlueFRITZ! USB Bluetooth dongle to 2.6. This device needs a firmware
> > > download and I want to use the new firmware class for getting the
> > > firmware file from userspace. After reading the documentation and
> > > testing the driver samples I got the results that I expected.
> > > 
> > > My problem is now that the firmware loader is not working with my
> > > firmware file and it seems that this is a problem of the file size,
> > > because copying small files through the same interface is working fine.
> > > This is the file I want to load:
> > > 
> > > -rw-r--r--  1 holtmann staff  418352 Jul 11 12:38 bfubase.frm
> > > 
> > > I have written my own firmware.agent hotplug script, which looks in
> > > general something like this:
> > > 
> > > 	echo 1 > $LOADING
> > > 	cp bfubase.frm $DATA
> > > 	echo 0 > $LOADING
> > > 
> > > Loading the above firmware file through this interface results in
> > > different behaviours. The results are complete freezes, instant reboots,
> > > X server crashes with black screens and sometimes I see an oops about
> > > virtual memory, but it goes bye bye too fast to let me do anything
> > > useful with it.
> > 
> >  Could you send me a tarball with a sample showing the problem. If
> >  possible I would like to do "make test" and have it compile and crash
> >  the system appropriately :)
> 
> I tracked down the problem to request_firmware() or a sysfs problem.
> With the firmware included in a header file the driver itself works
> perfect.

 You are right, the problem was in sysfs, attached goes a patch that
 WorksForMe (tm), please test and report.

> Attached is a sample of how I use the request_firmware() and from the
> documentation it seems correct to me.

 Not what I was asking for, but it seams OK.

 About the patch:
	- undo recent change, made in the believe that "buffer" was the
	  size of the whole file, it is just PAGE_SIZE in size.
		- Since files are allowed to have unknown sizes, by
		  setting their size to 0, we can't preallocate a buffer
		  of their size on open.

	- don't use any offset when handling buffer
		- simplifies code
		- since it is temporary storage it doesn't really matter

	- undo relevant changes to request_firmware() code.

	- hopefully adapt drivers/pci/pci-sysfs.c to this changes
		- Please double check, I didn't look very carefully on
		  this.

 Have a nice day

 	Manuel
-- 
--- Manuel Estrada Sainz <ranty@debian.org>
                         <ranty@bigfoot.com>
			 <ranty@users.sourceforge.net>
------------------------ <manuel.estrada@hispalinux.es> -------------------
Let us have the serenity to accept the things we cannot change, courage to
change the things we can, and wisdom to know the difference.

--mYCpIKhGyMATD0i+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="sysfs-bin-unbreak.diff"

Index: drivers/base/firmware_class.c
===================================================================
RCS file: /home/cvs/linux-2.5/drivers/base/firmware_class.c,v
retrieving revision 1.3
diff -u -r1.3 firmware_class.c
--- drivers/base/firmware_class.c	4 Jul 2003 02:21:18 -0000	1.3
+++ drivers/base/firmware_class.c	26 Jul 2003 06:53:47 -0000
@@ -149,7 +149,7 @@
 	if (offset + count > fw->size)
 		count = fw->size - offset;
 
-	memcpy(buffer + offset, fw->data + offset, count);
+	memcpy(buffer, fw->data + offset, count);
 	return count;
 }
 static int
@@ -198,7 +198,7 @@
 	if (retval)
 		return retval;
 
-	memcpy(fw->data + offset, buffer + offset, count);
+	memcpy(fw->data + offset, buffer, count);
 
 	fw->size = max_t(size_t, offset + count, fw->size);
 
Index: drivers/pci/pci-sysfs.c
===================================================================
RCS file: /home/cvs/linux-2.5/drivers/pci/pci-sysfs.c,v
retrieving revision 1.6
diff -u -r1.6 pci-sysfs.c
--- drivers/pci/pci-sysfs.c	4 Jul 2003 02:21:18 -0000	1.6
+++ drivers/pci/pci-sysfs.c	26 Jul 2003 06:53:50 -0000
@@ -87,7 +87,7 @@
 	while (off & 3) {
 		unsigned char val;
 		pci_read_config_byte(dev, off, &val);
-		buf[off] = val;
+		buf[0] = val;
 		off++;
 		if (--size == 0)
 			break;
@@ -96,10 +96,10 @@
 	while (size > 3) {
 		unsigned int val;
 		pci_read_config_dword(dev, off, &val);
-		buf[off] = val & 0xff;
-		buf[off + 1] = (val >> 8) & 0xff;
-		buf[off + 2] = (val >> 16) & 0xff;
-		buf[off + 3] = (val >> 24) & 0xff;
+		buf[0] = val & 0xff;
+		buf[1] = (val >> 8) & 0xff;
+		buf[2] = (val >> 16) & 0xff;
+		buf[3] = (val >> 24) & 0xff;
 		off += 4;
 		size -= 4;
 	}
@@ -107,7 +107,7 @@
 	while (size > 0) {
 		unsigned char val;
 		pci_read_config_byte(dev, off, &val);
-		buf[off] = val;
+		buf[0] = val;
 		off++;
 		--size;
 	}
@@ -129,24 +129,24 @@
 	}
 
 	while (off & 3) {
-		pci_write_config_byte(dev, off, buf[off]);
+		pci_write_config_byte(dev, off, buf[0]);
 		off++;
 		if (--size == 0)
 			break;
 	}
 
 	while (size > 3) {
-		unsigned int val = buf[off];
-		val |= (unsigned int) buf[off + 1] << 8;
-		val |= (unsigned int) buf[off + 2] << 16;
-		val |= (unsigned int) buf[off + 3] << 24;
+		unsigned int val = buf[0];
+		val |= (unsigned int) buf[1] << 8;
+		val |= (unsigned int) buf[2] << 16;
+		val |= (unsigned int) buf[3] << 24;
 		pci_write_config_dword(dev, off, val);
 		off += 4;
 		size -= 4;
 	}
 
 	while (size > 0) {
-		pci_write_config_byte(dev, off, buf[off]);
+		pci_write_config_byte(dev, off, buf[0]);
 		off++;
 		--size;
 	}
Index: fs/sysfs/bin.c
===================================================================
RCS file: /home/cvs/linux-2.5/fs/sysfs/bin.c,v
retrieving revision 1.9
diff -u -r1.9 bin.c
--- fs/sysfs/bin.c	4 Jul 2003 02:21:18 -0000	1.9
+++ fs/sysfs/bin.c	26 Jul 2003 06:53:59 -0000
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

--mYCpIKhGyMATD0i+--
