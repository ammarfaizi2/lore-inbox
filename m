Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265595AbSJSMF3>; Sat, 19 Oct 2002 08:05:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265596AbSJSMF3>; Sat, 19 Oct 2002 08:05:29 -0400
Received: from [211.167.76.68] ([211.167.76.68]:26761 "HELO soulinfo")
	by vger.kernel.org with SMTP id <S265595AbSJSMF0>;
	Sat, 19 Oct 2002 08:05:26 -0400
Date: Sat, 19 Oct 2002 20:01:04 +0800
From: Hu Gang <hugang@soulinfo.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>,
       mochel@osdl.org
Subject: [PATCH]1/2: fix power manager recall problem.
Message-Id: <20021019200104.650ba8bc.hugang@soulinfo.com>
Organization: Beijing Soul
X-Mailer: Sylpheed version 0.8.2claws28 (GTK+ 1.2.10; i386-linux-debian-i386-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1"; boundary="=.Hz7Snl41h65OI8"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=.Hz7Snl41h65OI8
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hello Patrick Mochel, Pavel Machek:

I'm tested the 2.5.3X suspend function and found the problem.
I'm enable debug option here is the log.
----------------------
skip...
Freeing memory: |
Syncing disks before copy
call device_resume SUSPEND_NOTIFY
Suspending devices
suspending device PCI device 8086:7111
suspending device PCI device 1022:2000
call device_resume SUSPEND_SAVE_STATE
Suspending devices
suspending device PCI device 8086:7111
suspending device PCI device 1022:2000
call device_resume SUSPEND_DISABLE
Suspending devices
suspending device PCI device 8086:7111
suspending device PCI device 1022:2000
call pm_send_all PM_SUSPEND
call pci_pm_suspend
call pcnet32_suspend
/critical section: Counting pages to copy[nosave c02af000] (pages needed: 4795+512=5307 free: 27972)
Alloc pagedir
[nosave c02af000]<4>Freeing prev allocated pagedir
call device_resume RESUME_RESTORE_STATE
resuming device PCI device 1022:2000
call pcnet32_resume
resuming device PCI device 8086:7111
resuming device i8259A PIC
skip......
------------------------
first the we call device suspend it suspend pci device and other device, but when we call pm_send_all to pm_suspend, it retry to suspend pci device, here is the real problem. 

This patch can fix it. Please apply.
------------------------------
diff -ur linux-2.5.44-clean/drivers/base/power.c linux-2.5.44-suspend/drivers/base/power.c
--- linux-2.5.44-clean/drivers/base/power.c	Sat Oct 19 15:56:47 2002
+++ linux-2.5.44-suspend/drivers/base/power.c	Sat Oct 19 18:00:28 2002
@@ -37,6 +37,14 @@
 	down(&device_sem);
 	list_for_each(node,&global_device_list) {
 		struct device * dev = to_dev(node);
+		if (dev->bus) {
+			char *name = dev->bus->name;
+			pr_debug("bus is %s\n", name);
+			if (strncmp(name, "pci", 3) ==  0) {
+				pr_debug("skip pci bus\n");
+				continue;
+			}
+		}
 		if (device_present(dev) && dev->driver && dev->driver->suspend) {
 			pr_debug("suspending device %s\n",dev->name);
 			error = dev->driver->suspend(dev,state,level);
@@ -63,6 +71,14 @@
 	down(&device_sem);
 	list_for_each_prev(node,&global_device_list) {
 		struct device * dev = to_dev(node);
+		if (dev->bus) {
+			char *name = dev->bus->name;
+			pr_debug("bus is %s\n", name);
+			if (strncmp(name, "pci", 3) ==  0) {
+				pr_debug("skip pci bus\n");	
+				continue;
+			}
+		}
 		if (device_present(dev) && dev->driver && dev->driver->resume) {
 			pr_debug("resuming device %s\n",dev->name);
 			dev->driver->resume(dev,level);
-- 
		- Hu Gang

--=.Hz7Snl41h65OI8
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.0 (GNU/Linux)

iD8DBQE9sUmDPM4uCy7bAJgRAs4BAJ9h85BbsY3ZYuJbKFQ12JO5YLQzYgCdHKr/
6Qt3WYZDh1Bv8DGkud/grNw=
=78QX
-----END PGP SIGNATURE-----

--=.Hz7Snl41h65OI8--
