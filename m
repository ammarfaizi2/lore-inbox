Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261823AbREVB6l>; Mon, 21 May 2001 21:58:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261640AbREVB6a>; Mon, 21 May 2001 21:58:30 -0400
Received: from zeus.kernel.org ([209.10.41.242]:20712 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S261670AbREVB6N>;
	Mon, 21 May 2001 21:58:13 -0400
Date: Mon, 21 May 2001 21:00:10 -0400
From: "Eric S. Raymond" <esr@thyrsus.com>
To: CML2 <linux-kernel@vger.kernel.org>, kbuild-devel@lists.sourceforge.net
Subject: Dead symbols in CMl1
Message-ID: <20010521210010.A20837@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	CML2 <linux-kernel@vger.kernel.org>,
	kbuild-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I think I've identified a number of dead symbols.  Here's a list:

CONFIG_BAGETBSM          (Baget Backplane Shared Memory support)
  Set in arch/mips64/config.in, not used anywhere.

CONFIG_ACPI_INTERPRETER  (ACPI interpreter)
  Set in arch/ia64/config.in, not used anywhere.

CONFIG_BINFMT_JAVA (Kernel support for JAVA binaries)
  Set in arch/parisc/config.in and arch/cris/config.in, not used anywhere.

CONFIG_SCSI_DECSII       (DEC SII SCSI Driver)
  Set in drivers/scsi/Config.in, not used anywhere.

CONFIG_PROFILE           (Enable traffic profiling)
CONFIG_PROFILE_SHIFT     (Profile shift count)
  Set in arch/cris/config.in, not used anywhere.

CONFIG_SERIAL_21285_OLD  (Use /dev/ttyS0 device)
  Set in drivers/char/Config.in, not used anywhere

The following patch removes them cleanly:

Diffs between last version checked in and current workfile(s):

--- arch/cris/config.in	2001/05/22 00:55:28	1.1
+++ arch/cris/config.in	2001/05/22 00:56:22
@@ -20,9 +20,6 @@
 bool 'System V IPC' CONFIG_SYSVIPC
 
 tristate 'Kernel support for ELF binaries' CONFIG_BINFMT_ELF
-if [ "$CONFIG_EXPERIMENTAL" = "y" ]; then
-  tristate 'Kernel support for JAVA binaries' CONFIG_BINFMT_JAVA
-fi
 
 bool 'Use kernel gdb debugger' CONFIG_ETRAX_KGDB
 
@@ -232,8 +229,4 @@
 comment 'Kernel hacking'
 
 #bool 'Debug kmalloc/kfree' CONFIG_DEBUG_MALLOC
-bool 'Kernel profiling support' CONFIG_PROFILE
-if [ "$CONFIG_PROFILE" = "y" ]; then
-  int ' Profile shift count' CONFIG_PROFILE_SHIFT 2
-fi
 endmenu
--- arch/ia64/config.in	2001/05/22 00:51:05	1.1
+++ arch/ia64/config.in	2001/05/22 00:51:26
@@ -89,7 +89,6 @@
 	if [ "$CONFIG_ACPI_KERNEL_CONFIG" = "y" ]; then
 	  define_bool CONFIG_PM y
 	  define_bool CONFIG_ACPI y
-	  define_bool CONFIG_ACPI_INTERPRETER y
 	fi
 fi
 
--- arch/mips64/config.in	2001/05/22 00:50:33	1.1
+++ arch/mips64/config.in	2001/05/22 00:50:44
@@ -183,7 +183,6 @@
       fi
       if [ "$CONFIG_BAGET_MIPS" = "y" ]; then
 	 tristate 'Baget AMD LANCE support' CONFIG_BAGETLANCE
-	 tristate 'Baget Backplane Shared Memory support' CONFIG_BAGETBSM
       fi
       if [ "$CONFIG_ATM" = "y" ]; then
 	 source drivers/atm/Config.in
--- arch/parisc/config.in	2001/05/22 00:55:04	1.1
+++ arch/parisc/config.in	2001/05/22 00:55:14
@@ -68,9 +68,6 @@
 tristate 'Kernel support for SOM binaries' CONFIG_BINFMT_SOM
 tristate 'Kernel support for ELF binaries' CONFIG_BINFMT_ELF
 tristate 'Kernel support for MISC binaries' CONFIG_BINFMT_MISC
-if [ "$CONFIG_EXPERIMENTAL" = "y" ]; then
-  tristate 'Kernel support for JAVA binaries (obsolete)' CONFIG_BINFMT_JAVA
-fi
 
 endmenu
 
--- drivers/char/Config.in	2001/05/22 00:56:44	1.1
+++ drivers/char/Config.in	2001/05/22 00:56:56
@@ -63,9 +63,6 @@
 if [ "$CONFIG_FOOTBRIDGE" = "y" ]; then
    bool 'DC21285 serial port support' CONFIG_SERIAL_21285
    if [ "$CONFIG_SERIAL_21285" = "y" ]; then
-      if [ "$CONFIG_OBSOLETE" = "y" ]; then
-         bool '  Use /dev/ttyS0 device (OBSOLETE)' CONFIG_SERIAL_21285_OLD
-      fi
       bool '  Console on DC21285 serial port' CONFIG_SERIAL_21285_CONSOLE
    fi
 fi
--- drivers/scsi/Config.in	2001/05/22 00:55:54	1.1
+++ drivers/scsi/Config.in	2001/05/22 00:56:01
@@ -39,7 +39,6 @@
    if [ "$CONFIG_TC" = "y" ]; then
       dep_tristate 'DEC NCR53C94 Scsi Driver' CONFIG_SCSI_DECNCR $CONFIG_SCSI
    fi
-   dep_tristate 'DEC SII Scsi Driver' CONFIG_SCSI_DECSII $CONFIG_SCSI
 fi
 
 if [ "$CONFIG_PCI" = "y" ]; then

End of diffs.
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

Hoplophobia (n.): The irrational fear of weapons, correctly described by 
Freud as "a sign of emotional and sexual immaturity".  Hoplophobia, like
homophobia, is a displacement symptom; hoplophobes fear their own
"forbidden" feelings and urges to commit violence.  This would be
harmless, except that they project these feelings onto others.  The
sequelae of this neurosis include irrational and dangerous behaviors
such as passing "gun-control" laws and trashing the Constitution.
