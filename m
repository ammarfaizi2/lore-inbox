Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264793AbUDWNCs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264793AbUDWNCs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Apr 2004 09:02:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264802AbUDWNCs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Apr 2004 09:02:48 -0400
Received: from smtp809.mail.sc5.yahoo.com ([66.163.168.188]:1960 "HELO
	smtp809.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S264793AbUDWNCp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Apr 2004 09:02:45 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [OOPS/HACK] atmel_cs and the latest changes in sysfs/symlink.c
Date: Fri, 23 Apr 2004 08:02:40 -0500
User-Agent: KMail/1.6.1
Cc: Andrew Morton <akpm@osdl.org>, Greg KH <greg@kroah.com>,
       linux-kernel@vger.kernel.org, Simon Kelley <simon@thekelleys.org.uk>
References: <200404230142.46792.dtor_core@ameritech.net> <1082723147.1843.14.camel@merlin>
In-Reply-To: <1082723147.1843.14.camel@merlin>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200404230802.42293.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 23 April 2004 07:25 am, Marcel Holtmann wrote:
> Hi Dmitry,
> 
> > The latest change in sysfs/symlink (conversion to use kobject_name instead
> > of name fiedld directly) broke atmel_cs driver:
> > 
> > Apr 23 00:30:10 core kernel: Oops: 0000 [#1]
> > Apr 23 00:30:10 core kernel: PREEMPT
> > Apr 23 00:30:10 core kernel: CPU:    0
> > Apr 23 00:30:10 core kernel: EIP:    0060:[<c0182ef9>]    Not tainted
> > Apr 23 00:30:10 core kernel: EFLAGS: 00010246   (2.6.6-rc2)
> > Apr 23 00:30:10 core kernel: EIP is at object_path_length+0x19/0x30
<skip>
> > Apr 23 00:30:10 core kernel: Call Trace:
> > Apr 23 00:30:10 core kernel:  [<c0182f99>] sysfs_create_link+0x29/0x140
> > Apr 23 00:30:10 core kernel:  [<c01ac578>] kobject_hotplug+0x58/0x60
> > Apr 23 00:30:10 core kernel:  [<c0211490>] class_device_dev_link+0x30/0x40
<skip>
> > 
> > Below is the "fix" that helps avoid oopsing, and should be removed when
> > atmel_cs driver properly registers atmel_device.
> 
> I haven't tested it yet, but the same problem should apply to the
> bt3c_cs driver for the 3Com Bluetooth card. Are there any patches
> available that integrates the PCMCIA subsystem into the driver model, so
> we don't have to hack around it if a firmware download is needed?
> 
I do not know. But the problem seems to be somewhat widespread - I just got
oops with the following trace:

 [<c0182f99>] sysfs_create_link+0x29/0x140
 [<c01ac578>] kobject_hotplug+0x58/0x60
 [<c0211490>] class_device_dev_link+0x30/0x40
 [<c02117ad>] class_device_add+0xed/0x130
 [<e185ffab>] usb_register_dev+0x12b/0x170 [usbcore]
 [<e1b2bf2a>] hiddev_connect+0x7a/0x120 [usbhid]

I think we should not oops, just complain loudly, when we come across a
kobject which has never beek kobject_add()ed, like in patch below.

-- 
Dmitry

===== include/linux/kobject.h 1.26 vs edited =====
--- 1.26/include/linux/kobject.h	Thu Mar 11 08:20:22 2004
+++ edited/include/linux/kobject.h	Fri Apr 23 07:58:52 2004
@@ -39,6 +39,11 @@
 
 static inline char * kobject_name(struct kobject * kobj)
 {
+	if (unlikely(!kobj->k_name)) {
+		printk("kobject_name(): not registered kobject\n");
+		dump_stack();
+		return kobj->name;
+	}
 	return kobj->k_name;
 }
 
