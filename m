Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267164AbSKXC7N>; Sat, 23 Nov 2002 21:59:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267166AbSKXC7M>; Sat, 23 Nov 2002 21:59:12 -0500
Received: from CPE3236333432363339.cpe.net.cable.rogers.com ([24.114.185.204]:2820
	"HELO coredump.sh0n.net") by vger.kernel.org with SMTP
	id <S267164AbSKXC7K>; Sat, 23 Nov 2002 21:59:10 -0500
From: Shawn Starr <spstarr@sh0n.net>
Organization: sh0n.net
To: linux-kernel@vger.kernel.org
Subject: [RFC][TRIVIAL][PATCH][2.5] - Supplimental fix to ACPI_SLEEP & SOFTWARE_SUSPEND compile issue
Date: Sat, 23 Nov 2002 22:06:52 -0500
User-Agent: KMail/1.5
Cc: Andrew Grover <andrew.grover@intel.com>, Pavel Machek <pavel@ucw.cz>
MIME-Version: 1.0
Content-Type: Multipart/Alternative;
  boundary="Boundary-00=_MJE49WnBlLfjFip"
Message-Id: <200211232206.58081.spstarr@sh0n.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_MJE49WnBlLfjFip
Content-Type: Text/Plain;
  charset="iso-8859-3"
Content-Transfer-Encoding: 7bit
Content-Description: clearsigned data
Content-Disposition: inline

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

This patch should fix remaining issues regarding compiling ACPI Sleep states with Software suspend. 
You need to enable ACPI_SLEEP in config to use software suspend.

The problem is, kbuild doesn't seem to allow this (right?). if ACPI_SLEEP is enabled it will allow you to select 
SOFTWARE_SUSPEND but if you uncheck SOFTWARE_SUSPEND it doesn't disable ACPI_SLEEP which 
IMHO it should not be because sleeping the system doesn't always mean power off. Standby might be a 
sleep state too.

Here's the patch, please comment :)

Shawn.

- From Pavel:

> > Could you make it so that CONFIG_ACPI_SLEEP is not selectable without
> > CONFIG_SOFTWARE_SUSPEND  and move CONFIG_SOFTWARE_SUSPEND into "power
> > managment" submenu?
> >                                                             Pavel
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE94EJQePHb7Xli5GsRAiYgAJ0ZQYfqCSKn+IL6VPeym44mgUbF8gCfW30a
u03BGOgvMjFwIJ5EoF4ByR8=
=kv0+
-----END PGP SIGNATURE-----

--Boundary-00=_MJE49WnBlLfjFip
Content-Type: text/x-diff;
  charset="iso-8859-3";
  name="2.5.49-acpi-swsusp-2.diff.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="2.5.49-acpi-swsusp-2.diff.patch"

diff -Nrup linux-2.5.49-vanilla/arch/i386/Kconfig linux-2.5.49-wip/arch/i386/Kconfig
--- linux-2.5.49-vanilla/arch/i386/Kconfig	2002-11-22 16:40:21.000000000 -0500
+++ linux-2.5.49-wip/arch/i386/Kconfig	2002-11-23 17:48:33.000000000 -0500
@@ -1516,35 +1516,6 @@ source "arch/i386/oprofile/Kconfig"
 
 menu "Kernel hacking"
 
-config SOFTWARE_SUSPEND
-	bool "Software Suspend (EXPERIMENTAL)"
-	depends on EXPERIMENTAL && PM
-	---help---
-	  Enable the possibilty of suspendig machine. It doesn't need APM.
-	  You may suspend your machine by 'swsusp' or 'shutdown -z <time>' 
-	  (patch for sysvinit needed). 
-
-	  It creates an image which is saved in your active swaps. By the next
-	  booting the, pass 'resume=/path/to/your/swap/file' and kernel will 
-	  detect the saved image, restore the memory from
-	  it and then it continues to run as before you've suspended.
-	  If you don't want the previous state to continue use the 'noresume'
-	  kernel option. However note that your partitions will be fsck'd and
-	  you must re-mkswap your swap partitions/files.
-
-	  Right now you may boot without resuming and then later resume but
-	  in meantime you cannot use those swap partitions/files which were
-	  involved in suspending. Also in this case there is a risk that buffers
-	  on disk won't match with saved ones.
-
-	  SMP is supported ``as-is''. There's a code for it but doesn't work.
-	  There have been problems reported relating SCSI.
-
-	  This option is about getting stable. However there is still some
-	  absence of features.
-
-	  For more information take a look at Documentation/swsusp.txt.
-
 config DEBUG_KERNEL
 	bool "Kernel debugging"
 	help
diff -Nrup linux-2.5.49-vanilla/drivers/acpi/Kconfig linux-2.5.49-wip/drivers/acpi/Kconfig
--- linux-2.5.49-vanilla/drivers/acpi/Kconfig	2002-11-22 16:41:12.000000000 -0500
+++ linux-2.5.49-wip/drivers/acpi/Kconfig	2002-11-23 18:04:55.000000000 -0500
@@ -76,6 +76,36 @@ config ACPI_SLEEP
 	  This option is not recommended for anyone except those doing driver
 	  power management development.
 
+config SOFTWARE_SUSPEND
+        bool "Software Suspend (EXPERIMENTAL)"
+        depends on EXPERIMENTAL && X86 && ACPI && ACPI_SLEEP && !ACPI_HT_ONLY
+	default y
+        ---help---
+          Enable the possibilty of suspendig machine. It doesn't need APM.
+          You may suspend your machine by 'swsusp' or 'shutdown -z <time>'
+          (patch for sysvinit needed).
+
+          It creates an image which is saved in your active swaps. By the next
+          booting the, pass 'resume=/path/to/your/swap/file' and kernel will
+          detect the saved image, restore the memory from
+          it and then it continues to run as before you've suspended.
+          If you don't want the previous state to continue use the 'noresume'
+          kernel option. However note that your partitions will be fsck'd and
+          you must re-mkswap your swap partitions/files.
+
+          Right now you may boot without resuming and then later resume but
+          in meantime you cannot use those swap partitions/files which were
+          involved in suspending. Also in this case there is a risk that buffers
+          on disk won't match with saved ones.
+
+          SMP is supported ``as-is''. There's a code for it but doesn't work.
+          There have been problems reported relating SCSI.
+
+          This option is about getting stable. However there is still some
+          absence of features.
+
+          For more information take a look at Documentation/swsusp.txt.
+
 config ACPI_AC
 	tristate "AC Adapter"
 	depends on X86 && ACPI && !ACPI_HT_ONLY

--Boundary-00=_MJE49WnBlLfjFip--

