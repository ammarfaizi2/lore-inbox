Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751112AbWAIMn4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751112AbWAIMn4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 07:43:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751404AbWAIMn4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 07:43:56 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:15376 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1751112AbWAIMnz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 07:43:55 -0500
Date: Mon, 9 Jan 2006 12:43:47 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: balamurugan@sahasrasolutions.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: REG: problem i am facing
Message-ID: <20060109124347.GA19131@flint.arm.linux.org.uk>
Mail-Followup-To: balamurugan@sahasrasolutions.com,
	linux-kernel@vger.kernel.org
References: <63513.203.101.32.152.1136810517.squirrel@66.98.166.28>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <63513.203.101.32.152.1136810517.squirrel@66.98.166.28>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 09, 2006 at 12:41:57PM -0000, balamurugan@sahasrasolutions.com wrote:
> hi all,
> 
> i am using Fedora 1.0 and i am using kernel-2.6.15 and i am using
> arm-linux-3.4.1 to cross compile, i am facing the problem while i am make
> the compilation , in make menuconfig it will compiled correctly but we
> make it compile it will showing one error as
> 
> fs/built-in.o(.data+0x22c4): undefined reference to `adfspart_check_ICS'
> fs/built-in.o(.data+0x22c8): undefined reference to `adfspart_check_POWERTEC'
> fs/built-in.o(.data+0x22cc): undefined reference to `adfspart_check_EESOX'
> fs/built-in.o(.data+0x22d0): undefined reference to `adfspart_check_CUMANA'
> fs/built-in.o(.data+0x22d4): undefined reference to `adfspart_check_ADFS'
> make: *** [.tmp_vmlinux1] Error 1
> 
> pls give the solution for this problem ASAP , because i am now compiling
> the ting u pls support us.

It looks like fs/partitions/Kconfig is messed up for one combination.
If ACORN_PARTITION is not set, we won't include any of the partition
support for Acorn formats, so we should not allow them to be selected.

Please try this patch:

diff --git a/fs/partitions/Kconfig b/fs/partitions/Kconfig
--- a/fs/partitions/Kconfig
+++ b/fs/partitions/Kconfig
@@ -21,26 +21,30 @@ config ACORN_PARTITION
 	  Support hard disks partitioned under Acorn operating systems.
 
 config ACORN_PARTITION_CUMANA
-	bool "Cumana partition support" if PARTITION_ADVANCED && ACORN_PARTITION
+	bool "Cumana partition support" if PARTITION_ADVANCED
 	default y if ARCH_ACORN
+	depends on ACORN_PARTITION
 	help
 	  Say Y here if you would like to use hard disks under Linux which
 	  were partitioned using the Cumana interface on Acorn machines.
 
 config ACORN_PARTITION_EESOX
-	bool "EESOX partition support" if PARTITION_ADVANCED && ACORN_PARTITION
+	bool "EESOX partition support" if PARTITION_ADVANCED
 	default y if ARCH_ACORN
+	depends on ACORN_PARTITION
 
 config ACORN_PARTITION_ICS
-	bool "ICS partition support" if PARTITION_ADVANCED && ACORN_PARTITION
+	bool "ICS partition support" if PARTITION_ADVANCED
 	default y if ARCH_ACORN
+	depends on ACORN_PARTITION
 	help
 	  Say Y here if you would like to use hard disks under Linux which
 	  were partitioned using the ICS interface on Acorn machines.
 
 config ACORN_PARTITION_ADFS
-	bool "Native filecore partition support" if PARTITION_ADVANCED && ACORN_PARTITION
+	bool "Native filecore partition support" if PARTITION_ADVANCED
 	default y if ARCH_ACORN
+	depends on ACORN_PARTITION
 	help
 	  The Acorn Disc Filing System is the standard file system of the
 	  RiscOS operating system which runs on Acorn's ARM-based Risc PC
@@ -48,15 +52,17 @@ config ACORN_PARTITION_ADFS
 	  `Y' here, Linux will support disk partitions created under ADFS.
 
 config ACORN_PARTITION_POWERTEC
-	bool "PowerTec partition support" if PARTITION_ADVANCED && ACORN_PARTITION
+	bool "PowerTec partition support" if PARTITION_ADVANCED
 	default y if ARCH_ACORN
+	depends on ACORN_PARTITION
 	help
 	  Support reading partition tables created on Acorn machines using
 	  the PowerTec SCSI drive.
 
 config ACORN_PARTITION_RISCIX
-	bool "RISCiX partition support" if PARTITION_ADVANCED && ACORN_PARTITION
+	bool "RISCiX partition support" if PARTITION_ADVANCED
 	default y if ARCH_ACORN
+	depends on ACORN_PARTITION
 	help
 	  Once upon a time, there was a native Unix port for the Acorn series
 	  of machines called RISCiX.  If you say 'Y' here, Linux will be able
@@ -224,5 +230,3 @@ config EFI_PARTITION
 	  Say Y here if you would like to use hard disks under Linux which
 	  were partitioned using EFI GPT.  Presently only useful on the
 	  IA-64 platform.
-
-#      define_bool CONFIG_ACORN_PARTITION_CUMANA y


-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
