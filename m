Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262718AbVE1Nhb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262718AbVE1Nhb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 May 2005 09:37:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262721AbVE1Nhb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 May 2005 09:37:31 -0400
Received: from mailfe01.swip.net ([212.247.154.1]:23437 "EHLO swip.net")
	by vger.kernel.org with ESMTP id S262718AbVE1NhX convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 May 2005 09:37:23 -0400
X-T2-Posting-ID: jLUmkBjoqvly7NM6d2gdCg==
Subject: Re: 2.6.12-rc5-git3 fails compile -- acpi_boot_table_init
From: Alexander Nyberg <alexn@telia.com>
To: Pete Clements <clem@clem.clem-digital.net>
Cc: torvalds@osdl.org, linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <200505281206.j4SC6iLa015878@clem.clem-digital.net>
References: <200505281206.j4SC6iLa015878@clem.clem-digital.net>
Content-Type: text/plain; charset=ISO-8859-1
Date: Sat, 28 May 2005 15:37:19 +0200
Message-Id: <1117287439.952.17.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

lör 2005-05-28 klockan 08:06 -0400 skrev Pete Clements:
> Fyi:
> 
> 
>   LD      .tmp_vmlinux1
> arch/i386/kernel/built-in.o: In function `setup_arch':
> arch/i386/kernel/built-in.o(.init.text+0x14ec): undefined reference to `acpi_boot_table_init'
> arch/i386/kernel/built-in.o(.init.text+0x14f1): undefined reference to `acpi_boot_init'
> make: *** [.tmp_vmlinux1] Error 1
> 

This is a neverending story

linux/acpi.h contains empty declarations for acpi_boot_init() &
acpi_boot_table_init() but they are nested inside #ifdef CONFIG_ACPI.

So we'll have to #ifdef in arch/i386/kernel/setup.c: setup_arch()

Signed-off-by: Alexander Nyberg <alexn@telia.com>

Index: meep/arch/i386/kernel/setup.c
===================================================================
--- meep.orig/arch/i386/kernel/setup.c	2005-05-28 14:39:06.000000000 +0200
+++ meep/arch/i386/kernel/setup.c	2005-05-28 14:59:34.000000000 +0200
@@ -1502,11 +1502,13 @@
 	if (efi_enabled)
 		efi_map_memmap();
 
+#ifdef CONFIG_ACPI_BOOT
 	/*
 	 * Parse the ACPI tables for possible boot-time SMP configuration.
 	 */
 	acpi_boot_table_init();
 	acpi_boot_init();
+#endif
 
 #ifdef CONFIG_X86_LOCAL_APIC
 	if (smp_found_config)


