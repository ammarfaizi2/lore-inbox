Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266152AbUBRAsi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 19:48:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266982AbUBRAqW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 19:46:22 -0500
Received: from fw.osdl.org ([65.172.181.6]:33003 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266152AbUBRAml (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 19:42:41 -0500
Date: Tue, 17 Feb 2004 16:44:27 -0800
From: Andrew Morton <akpm@osdl.org>
To: Pragnesh Sampat <pragnesh.sampat@timesys.com>
Cc: bos@serpentine.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sprintf modifiers in usr/gen_init_cpio.c
Message-Id: <20040217164427.027b5643.akpm@osdl.org>
In-Reply-To: <1077063980.9721.22.camel@dagoban.timesys>
References: <1077063980.9721.22.camel@dagoban.timesys>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pragnesh Sampat <pragnesh.sampat@timesys.com> wrote:
>
> The file initramfs_data.cpio is slightly different when generated on
> cygwin, compared to linux, which causes the kernel to panic with the
> message "no cpio magic" (See Documentation/early-userspace/README).
> 
> The problem in cpio generation is due to the difference in sprintf
> modifiers on cygwin.  The code uses "%08ZX" for strlen of a device
> node.  printf man pages discourages "Z" and has 'z' instead.
> Both of these are not available on cygwin sprintf (at least some
> versions of cygwin).  The net result of all of this is that the
> generated file literally contains "ZX" and then the strlen after that
> and messes up that 110 offset etc.  The file is 516 bytes long on the
> system that I tested and on linux it is 512 bytes.
> 
> The fix below just uses "%08X" for that field.  Any basic portable
> modifier should be ok, I think.

ugh, OK.

We'll also need to cast the return value of strlen to the correct type.  On
ppc64 (at least) size_t is 8 bytes and the printf will otherwise grab the wrong
things off the stack.



diff -puN usr/gen_init_cpio.c~cygwin-cpio-fix usr/gen_init_cpio.c
--- 25/usr/gen_init_cpio.c~cygwin-cpio-fix	Tue Feb 17 16:42:36 2004
+++ 25-akpm/usr/gen_init_cpio.c	Tue Feb 17 16:43:49 2004
@@ -56,7 +56,7 @@ static void cpio_trailer(void)
 	const char name[] = "TRAILER!!!";
 
 	sprintf(s, "%s%08X%08X%08lX%08lX%08X%08lX"
-	       "%08X%08X%08X%08X%08X%08ZX%08X",
+	       "%08X%08X%08X%08X%08X%08X%08X",
 		"070701",		/* magic */
 		0,			/* ino */
 		0,			/* mode */
@@ -69,7 +69,7 @@ static void cpio_trailer(void)
 		0,			/* minor */
 		0,			/* rmajor */
 		0,			/* rminor */
-		strlen(name) + 1,	/* namesize */
+		(unsigned)strlen(name) + 1, /* namesize */
 		0);			/* chksum */
 	push_hdr(s);
 	push_rest(name);
@@ -87,7 +87,7 @@ static void cpio_mkdir(const char *name,
 	time_t mtime = time(NULL);
 
 	sprintf(s,"%s%08X%08X%08lX%08lX%08X%08lX"
-	       "%08X%08X%08X%08X%08X%08ZX%08X",
+	       "%08X%08X%08X%08X%08X%08X%08X",
 		"070701",		/* magic */
 		ino++,			/* ino */
 		S_IFDIR | mode,		/* mode */
@@ -100,7 +100,7 @@ static void cpio_mkdir(const char *name,
 		1,			/* minor */
 		0,			/* rmajor */
 		0,			/* rminor */
-		strlen(name) + 1,	/* namesize */
+		(unsigned)strlen(name) + 1,/* namesize */
 		0);			/* chksum */
 	push_hdr(s);
 	push_rest(name);
@@ -119,7 +119,7 @@ static void cpio_mknod(const char *name,
 		mode |= S_IFCHR;
 
 	sprintf(s,"%s%08X%08X%08lX%08lX%08X%08lX"
-	       "%08X%08X%08X%08X%08X%08ZX%08X",
+	       "%08X%08X%08X%08X%08X%08X%08X",
 		"070701",		/* magic */
 		ino++,			/* ino */
 		mode,			/* mode */
@@ -132,7 +132,7 @@ static void cpio_mknod(const char *name,
 		1,			/* minor */
 		maj,			/* rmajor */
 		min,			/* rminor */
-		strlen(name) + 1,	/* namesize */
+		(unsigned)strlen(name) + 1,/* namesize */
 		0);			/* chksum */
 	push_hdr(s);
 	push_rest(name);
@@ -176,7 +176,7 @@ void cpio_mkfile(const char *filename, c
 	}
 
 	sprintf(s,"%s%08X%08X%08lX%08lX%08X%08lX"
-	       "%08X%08X%08X%08X%08X%08ZX%08X",
+	       "%08X%08X%08X%08X%08X%08X%08X",
 		"070701",		/* magic */
 		ino++,			/* ino */
 		mode,			/* mode */
@@ -189,7 +189,7 @@ void cpio_mkfile(const char *filename, c
 		1,			/* minor */
 		0,			/* rmajor */
 		0,			/* rminor */
-		strlen(location) + 1,	/* namesize */
+		(unsigned)strlen(location) + 1,/* namesize */
 		0);			/* chksum */
 	push_hdr(s);
 	push_string(location);

_

