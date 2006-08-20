Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750803AbWHTOcA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750803AbWHTOcA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Aug 2006 10:32:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750801AbWHTOcA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Aug 2006 10:32:00 -0400
Received: from host147-107.pool871.interbusiness.it ([87.1.107.147]:42658 "EHLO
	memento.home.lan") by vger.kernel.org with ESMTP id S1750803AbWHTOb7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Aug 2006 10:31:59 -0400
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Subject: [PATCH] x86_64: fix linking on 32-bit system
Date: Sun, 20 Aug 2006 16:31:17 +0200
To: Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org
Message-Id: <20060820143117.6622.22777.stgit@memento.home.lan>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

When compiling a 64-bit kernel on an Ubuntu 6.06 32bit system (whose GCC is also
a cross-compiler for x86_64) I've seen that head.o is compiled as a 64-bit file
(while it should not) and ld complaining about this during linking:

ld: warning: i386:x86-64 architecture of input file
`arch/x86_64/boot/compressed/head.o' is incompatible with i386 output

I've verified that removing -m64 from compilation flags to turn
"-m64 -traditional -m32" into "-traditional -m32" fixes the issue.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 arch/x86_64/boot/compressed/Makefile |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/arch/x86_64/boot/compressed/Makefile b/arch/x86_64/boot/compressed/Makefile
index f89d96f..c6bfd23 100644
--- a/arch/x86_64/boot/compressed/Makefile
+++ b/arch/x86_64/boot/compressed/Makefile
@@ -7,7 +7,9 @@ # Note all the files here are compiled/l
 #
 
 targets		:= vmlinux vmlinux.bin vmlinux.bin.gz head.o misc.o piggy.o
-EXTRA_AFLAGS	:= -traditional -m32
+EXTRA_AFLAGS	:= -traditional
+#Gcc on Ubuntu 6.06 does not cope well with -m64 -m32 - it uses -m64.
+AFLAGS		:= $(subst -m64,-m32,$(AFLAGS))
 
 # cannot use EXTRA_CFLAGS because base CFLAGS contains -mkernel which conflicts with
 # -m32
