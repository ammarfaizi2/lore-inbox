Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316168AbSEJXp1>; Fri, 10 May 2002 19:45:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316169AbSEJXp1>; Fri, 10 May 2002 19:45:27 -0400
Received: from 212.Red-80-35-44.pooles.rima-tde.net ([80.35.44.212]:21390 "EHLO
	DervishD.viadomus.com") by vger.kernel.org with ESMTP
	id <S316168AbSEJXp0>; Fri, 10 May 2002 19:45:26 -0400
Date: Sat, 11 May 2002 01:50:21 +0200
Organization: ViaDomus
To: vda@port.imtp.ilyichevsk.odessa.ua
Subject: Re: mmap() doesn't like certain value...
Cc: marcelo@conectiva.com.br, Linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <3CDC5CBD.mail72C11PGID@viadomus.com>
In-Reply-To: <3CD983C5.mail1K71EX1NG@viadomus.com>
 <200205100810.g4A8AaX28554@Port.imtp.ilyichevsk.odessa.ua>
 <3CDB8740.mailBO1BW5NO@viadomus.com>
 <200205101438.g4AEc9X29850@Port.imtp.ilyichevsk.odessa.ua>
User-Agent: nail 9.29 12/10/01
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
From: DervishD <raul@viadomus.com>
Reply-To: DervishD <raul@viadomus.com>
X-Mailer: DervishD TWiSTiNG Mailer
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Hi Denis and Marcelo :)

>>     And is corrected just by inverting the two quoted code snips :)
>You are right

    I've added a couple of comments and one more test. I don't think
that mmap() should return 'addr' when len=0. Moreover, mmap() cannot
return '0' under *any* circumstance (so says the man page).

    I've tested the patch with a little program to test every
possible 'len' value and checking for mmap() returning the correct
value.

    This is the patch:

--- begin ---

--- mm/mmap.c.orig	2002-05-10 10:40:51.000000000 +0200
+++ mm/mmap.c	2002-05-10 10:47:54.000000000 +0200
@@ -389,6 +389,11 @@
 	return 0;
 }
 
+
+/*
+	NOTE: in this function we rely on TASK_SIZE being lower than
+SIZE_MAX-PAGE_SIZE at least. I'm pretty sure that it is.
+*/
 unsigned long do_mmap_pgoff(struct file * file, unsigned long addr, unsigned long len,
 	unsigned long prot, unsigned long flags, unsigned long pgoff)
 {
@@ -402,12 +407,11 @@
 	if (file && (!file->f_op || !file->f_op->mmap))
 		return -ENODEV;
 
-	if ((len = PAGE_ALIGN(len)) == 0)
-		return addr;
-
-	if (len > TASK_SIZE)
+	if (!len || len > TASK_SIZE)
 		return -EINVAL;
 
+	len = PAGE_ALIGN(len);  /* This CANNOT be zero */
+
 	/* offset overflow? */
 	if ((pgoff + (len >> PAGE_SHIFT)) < pgoff)
 		return -EINVAL;

--- end ---

>>     I'll give a try to the inversion, that should work. I have
>> written a small stress program for mmap, so in a few hours the patch
>> will be ready. Must I post it here or send it directly to Marcello?
>Post here and to Marcelo. BTW, is 2.5 affected?

    I don't really know, but I'm pretty sure... Anyway I think that
the same patch is valid for both kernels with little or no
modification.

    BTW, the patch is not only mine, David Gómez Espinosa
(davidge@viadomus.com) has helped me with this issue too.

    Raúl
