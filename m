Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270448AbTHBXtt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Aug 2003 19:49:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270452AbTHBXtt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Aug 2003 19:49:49 -0400
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:25512
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S270448AbTHBXtp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Aug 2003 19:49:45 -0400
From: Rob Landley <rob@landley.net>
Reply-To: rob@landley.net
To: Roman Zippel <zippel@linux-m68k.org>
Subject: Re: More fun with menuconfig...
Date: Sat, 2 Aug 2003 19:52:03 -0400
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org
References: <200308020605.58423.rob@landley.net> <Pine.LNX.4.44.0308021805400.714-100000@serv>
In-Reply-To: <Pine.LNX.4.44.0308021805400.714-100000@serv>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308021952.06963.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 02 August 2003 12:08, Roman Zippel wrote:
> Hi,
>
> On Sat, 2 Aug 2003, Rob Landley wrote:
> > I fire up make menuconfig and expand the advanced partition menu (setting
> > CONFIG_ADVANCED_PARTITION to y).  MSDOS partition support is NOT set in
> > the newly opened menu, I.E. opening the menu has the side effect of
> > deselecting CONFIG_MSDOS_PARTITION.
>
> The condition prevents the default from being used, remove the unnecessary
> "!PARTITION_ADVANCED" part and you get the result you want.
>
> bye, Roman

Thanks.  The larger question was about what state is maintained:
CONFIG_MSDOS_PARTITION=y was in the existing .config that I'd loaded, and
changing the view caused a gratuitous change of state that was only expressed
in the default value.

I guess that whenever the value is currently at the default value, and the
default value changes, the current value follows the default value.  That
makes sense.  (And I understand that the contents of non-visible choices are
all set to the default values when you save.)

It looks to me like ALL the PARTITION_ADVANCED instances in the default value
logic in that menu are unnecessary.  The architecture values never change
(and thus never affect the existing values loaded in from the .config unless
the .config is blank), so removing PARTITION_ADVANCED means that toggling the
view doesn't cause a gratuitous change of state (a non-obvious thing).  The
behavior would then be that expanding the menu shows you what was selected
before you expanded the menu, which isn't harmful to advanced users and less
likely to bite explorers.

Something like this:

--- old-kconfig/fs/partitions/Kconfig	2003-07-27 13:08:29.000000000 -0400
+++ linux-2.6.0-test2/fs/partitions/Kconfig	2003-08-02 19:44:48.000000000 -0400
@@ -16,31 +16,31 @@
 
 config ACORN_PARTITION
 	bool "Acorn partition support" if PARTITION_ADVANCED
-	default y if !PARTITION_ADVANCED && ARCH_ACORN
+	default y if ARCH_ACORN
 	help
 	  Support hard disks partitioned under Acorn operating systems.
 
 config ACORN_PARTITION_CUMANA
 	bool "Cumana partition support" if PARTITION_ADVANCED && ACORN_PARTITION
-	default y if !PARTITION_ADVANCED && ARCH_ACORN
+	default y if ARCH_ACORN
 	help
 	  Say Y here if you would like to use hard disks under Linux which
 	  were partitioned using the Cumana interface on Acorn machines.
 
 config ACORN_PARTITION_EESOX
 	bool "EESOX partition support" if PARTITION_ADVANCED && ACORN_PARTITION
-	default y if !PARTITION_ADVANCED && ARCH_ACORN
+	default y if ARCH_ACORN
 
 config ACORN_PARTITION_ICS
 	bool "ICS partition support" if PARTITION_ADVANCED && ACORN_PARTITION
-	default y if !PARTITION_ADVANCED && ARCH_ACORN
+	default y if ARCH_ACORN
 	help
 	  Say Y here if you would like to use hard disks under Linux which
 	  were partitioned using the ICS interface on Acorn machines.
 
 config ACORN_PARTITION_ADFS
 	bool "Native filecore partition support" if PARTITION_ADVANCED && ACORN_PARTITION
-	default y if !PARTITION_ADVANCED && ARCH_ACORN
+	default y if ARCH_ACORN
 	help
 	  The Acorn Disc Filing System is the standard file system of the
 	  RiscOS operating system which runs on Acorn's ARM-based Risc PC
@@ -49,14 +49,14 @@
 
 config ACORN_PARTITION_POWERTEC
 	bool "PowerTec partition support" if PARTITION_ADVANCED && ACORN_PARTITION
-	default y if !PARTITION_ADVANCED && ARCH_ACORN
+	default y if ARCH_ACORN
 	help
 	  Support reading partition tables created on Acorn machines using
 	  the PowerTec SCSI drive.
 
 config ACORN_PARTITION_RISCIX
 	bool "RISCiX partition support" if PARTITION_ADVANCED && ACORN_PARTITION
-	default y if !PARTITION_ADVANCED && ARCH_ACORN
+	default y if ARCH_ACORN
 	help
 	  Once upon a time, there was a native Unix port for the Acorn series
 	  of machines called RISCiX.  If you say 'Y' here, Linux will be able
@@ -64,21 +64,21 @@
 
 config OSF_PARTITION
 	bool "Alpha OSF partition support" if PARTITION_ADVANCED
-	default y if !PARTITION_ADVANCED && ALPHA
+	default y if ALPHA
 	help
 	  Say Y here if you would like to use hard disks under Linux which
 	  were partitioned on an Alpha machine.
 
 config AMIGA_PARTITION
 	bool "Amiga partition table support" if PARTITION_ADVANCED
-	default y if !PARTITION_ADVANCED && (AMIGA || AFFS_FS=y)
+	default y if (AMIGA || AFFS_FS=y)
 	help
 	  Say Y here if you would like to use hard disks under Linux which
 	  were partitioned under AmigaOS.
 
 config ATARI_PARTITION
 	bool "Atari partition table support" if PARTITION_ADVANCED
-	default y if !PARTITION_ADVANCED && ATARI
+	default y if ATARI
 	help
 	  Say Y here if you would like to use hard disks under Linux which
 	  were partitioned under the Atari OS.
@@ -93,14 +93,14 @@
 
 config MAC_PARTITION
 	bool "Macintosh partition map support" if PARTITION_ADVANCED
-	default y if !PARTITION_ADVANCED && MAC
+	default y if MAC
 	help
 	  Say Y here if you would like to use hard disks under Linux which
 	  were partitioned on a Macintosh.
 
 config MSDOS_PARTITION
 	bool "PC BIOS (MSDOS partition tables) support" if PARTITION_ADVANCED
-	default y if !PARTITION_ADVANCED && !AMIGA && !ATARI && !MAC && !SGI_IP22 && !ARM && !SGI_IP27
+	default y if !AMIGA && !ATARI && !MAC && !SGI_IP22 && !ARM && !SGI_IP27
 	help
 	  Say Y here if you would like to use hard disks under Linux which
 	  were partitioned on an x86 PC (not necessarily by DOS).
@@ -189,21 +189,21 @@
 
 config NEC98_PARTITION
 	bool "NEC PC-9800 partition table support" if PARTITION_ADVANCED
-	default y if !PARTITION_ADVANCED && X86_PC9800
+	default y if X86_PC9800
 	help
 	  Say Y here if you would like to be able to read the hard disk
 	  partition table format used by NEC PC-9800 machines.
 
 config SGI_PARTITION
 	bool "SGI partition support" if PARTITION_ADVANCED
-	default y if !PARTITION_ADVANCED && (SGI_IP22 || SGI_IP27)
+	default y if (SGI_IP22 || SGI_IP27)
 	help
 	  Say Y here if you would like to be able to read the hard disk
 	  partition table format used by SGI machines.
 
 config ULTRIX_PARTITION
 	bool "Ultrix partition table support" if PARTITION_ADVANCED
-	default y if !PARTITION_ADVANCED && DECSTATION
+	default y if DECSTATION
 	help
 	  Say Y here if you would like to be able to read the hard disk
 	  partition table format used by DEC (now Compaq) Ultrix machines.
@@ -211,7 +211,7 @@
 
 config SUN_PARTITION
 	bool "Sun partition tables support" if PARTITION_ADVANCED
-	default y if !PARTITION_ADVANCED && (SPARC32 || SPARC64)
+	default y if (SPARC32 || SPARC64)
 	---help---
 	  Like most systems, SunOS uses its own hard disk partition table
 	  format, incompatible with all others. Saying Y here allows you to

