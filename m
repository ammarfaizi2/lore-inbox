Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262894AbUKXX0N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262894AbUKXX0N (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 18:26:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262951AbUKXXYq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 18:24:46 -0500
Received: from mail.dif.dk ([193.138.115.101]:15239 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S262904AbUKXXMZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 18:12:25 -0500
Date: Thu, 25 Nov 2004 00:21:58 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org
Subject: Any reason why we don't initialize all members of struct Xgt_desc_struct
 in doublefault.c ?
Message-ID: <Pine.LNX.4.61.0411250011160.3447@dragon.hygekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Yes, this is nitpicking, but I just can't leave small corners like this 
unpolished ;)

in arch/i386/kernel/doublefault.c you will find this (line 20) :

struct Xgt_desc_struct gdt_desc = {0, 0};

but, struct Xgt_desc_struct has 3 members, 

struct Xgt_desc_struct {
        unsigned short size;
        unsigned long address __attribute__((packed));
        unsigned short pad;
} __attribute__ ((packed));

so why only initialize two of them explicitly?


Wouldn't this be nicer? :

Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>

diff -up linux-2.6.10-rc2-bk9-orig/arch/i386/kernel/doublefault.c linux-2.6.10-rc2-bk9/arch/i386/kernel/doublefault.c
--- linux-2.6.10-rc2-bk9-orig/arch/i386/kernel/doublefault.c	2004-10-18 23:53:21.000000000 +0200
+++ linux-2.6.10-rc2-bk9/arch/i386/kernel/doublefault.c	2004-11-25 00:02:34.000000000 +0100
@@ -17,7 +17,7 @@ static unsigned long doublefault_stack[D
 
 static void doublefault_fn(void)
 {
-	struct Xgt_desc_struct gdt_desc = {0, 0};
+	struct Xgt_desc_struct gdt_desc = {0, 0, 0};
 	unsigned long gdt, tss;
 
 	__asm__ __volatile__("sgdt %0": "=m" (gdt_desc): :"memory");


or, if we want to be completely explicit about it how about :

Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>

diff -up linux-2.6.10-rc2-bk9-orig/arch/i386/kernel/doublefault.c linux-2.6.10-rc2-bk9/arch/i386/kernel/doublefault.c
--- linux-2.6.10-rc2-bk9-orig/arch/i386/kernel/doublefault.c	2004-10-18 23:53:21.000000000 +0200
+++ linux-2.6.10-rc2-bk9/arch/i386/kernel/doublefault.c	2004-11-25 00:06:18.000000000 +0100
@@ -17,7 +17,11 @@ static unsigned long doublefault_stack[D
 
 static void doublefault_fn(void)
 {
-	struct Xgt_desc_struct gdt_desc = {0, 0};
+	struct Xgt_desc_struct gdt_desc = {
+		.size = 0,
+		.address = 0,
+		.pad = 0
+	};
 	unsigned long gdt, tss;
 
 	__asm__ __volatile__("sgdt %0": "=m" (gdt_desc): :"memory");


--
Jesper Juhl


