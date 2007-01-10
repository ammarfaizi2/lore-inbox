Return-Path: <linux-kernel-owner+w=401wt.eu-S965041AbXAJUCr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965041AbXAJUCr (ORCPT <rfc822;w@1wt.eu>);
	Wed, 10 Jan 2007 15:02:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965048AbXAJUCr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Jan 2007 15:02:47 -0500
Received: from mail-out.m-online.net ([212.18.0.9]:41242 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965041AbXAJUCq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Jan 2007 15:02:46 -0500
Date: Wed, 10 Jan 2007 21:02:49 +0100
From: Olaf Hering <olaf@aepfle.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Jean Delvare <khali@linux-fr.org>, Roman Zippel <zippel@linux-m68k.org>,
       Andrey Borzenkov <arvidjaar@mail.ru>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Andy Whitcroft <apw@shadowen.org>,
       Herbert Poetzl <herbert@13thfloor.at>
Subject: Re: .version keeps being updated
Message-ID: <20070110200249.GA30676@aepfle.de>
References: <20070109102057.c684cc78.khali@linux-fr.org> <20070109170550.AFEF460C343@tzec.mtu.ru> <20070109214421.281ff564.khali@linux-fr.org> <Pine.LNX.4.64.0701101426400.14458@scrub.home> <20070110181053.3b3632a8.khali@linux-fr.org> <Pine.LNX.4.64.0701101058200.3594@woody.osdl.org> <20070110193136.GA30486@aepfle.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20070110193136.GA30486@aepfle.de>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 10, Olaf Hering wrote:

> On Wed, Jan 10, Linus Torvalds wrote:
> 
> > Grr.
> 
> It did work for me for some reason, but I was wondering why it did work.

with such a change, it will always be first. Tested on powerpc.
I could even add an ELF parser and look for the first bytes in the
.rodata section.

diff --git a/arch/powerpc/kernel/vmlinux.lds.S b/arch/powerpc/kernel/vmlinux.lds.S
diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 9fcc8d9..2050d8e 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -11,6 +11,11 @@ #define ALIGN_FUNCTION()  . = ALIGN(8)
 
 #define RODATA								\
 	. = ALIGN(4096);						\
+									\
+	.rodata.uts         : AT(ADDR(.data.uts) - LOAD_OFFSET) {	\
+		*(.data.uts)						\
+	}								\
+									\
 	.rodata           : AT(ADDR(.rodata) - LOAD_OFFSET) {		\
 		VMLINUX_SYMBOL(__start_rodata) = .;			\
 		*(.rodata) *(.rodata.*)					\
diff --git a/init/version.c b/init/version.c
index 9d96d36..03f5916 100644
--- a/init/version.c
+++ b/init/version.c
@@ -19,6 +19,8 @@ #define version_string(a) version(a)
 
 int version_string(LINUX_VERSION_CODE);
 
+const char __attribute__ ((__section__ (".rodata.uts"))) get_kernel_version[] = "fiXme Linux version " UTS_RELEASE;
+
 struct uts_namespace init_uts_ns = {
 	.kref = {
 		.refcount	= ATOMIC_INIT(2),
