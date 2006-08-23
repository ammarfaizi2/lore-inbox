Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965160AbWHWTnu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965160AbWHWTnu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 15:43:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965156AbWHWTnh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 15:43:37 -0400
Received: from 207.47.60.150.static.nextweb.net ([207.47.60.150]:50053 "EHLO
	webmail.xensource.com") by vger.kernel.org with ESMTP
	id S965153AbWHWTne convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 15:43:34 -0400
Subject: Re: [PATCH] Translate asm version of ELFNOTE macro
	into	preprocessor macro
From: Ian Campbell <Ian.Campbell@XenSource.com>
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, Andrew Morton <akpm@osdl.org>,
       Virtualization <virtualization@lists.osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <44EC94C2.9080608@goop.org>
References: <1156333761.12949.35.camel@localhost.localdomain>
	 <44EC6B12.4060909@goop.org>
	 <1156346074.12949.129.camel@localhost.localdomain>
	 <44EC72F3.70505@goop.org> <m1sljnml73.fsf@ebiederm.dsl.xmission.com>
	 <44EC94C2.9080608@goop.org>
Content-Type: text/plain; charset=ISO-8859-1
Date: Wed, 23 Aug 2006 20:43:27 +0100
Message-Id: <1156362207.19808.69.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 
Content-Transfer-Encoding: 8BIT
X-OriginalArrivalTime: 23 Aug 2006 19:45:21.0359 (UTC) FILETIME=[AB34E5F0:01C6C6EC]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-08-23 at 10:47 -0700, Jeremy Fitzhardinge wrote:
> 
> I remember now why I decided to use the assembler macro rather than 
> cpp.  The macro names the section after the note name (".note.NAME"), 
> and it needs to be quoted so that the name can have spaces and other 
> characters which would otherwise upset the assembler.  I couldn't work
> out a clean way to do this with the C preprocessor, since "as" doesn't
> support string concatenation like C does. 

Surprisingly string concatenation doesn't appear to be required for the
majority of punctuation, at least so far as I can tell with this test
patch (this is a xen-unstable kernel I had lying around so don't pay too
much attention to head-xen.S bit). The only problem I found is comma,
which can't be escaped.

I've no idea how reliably this works across tool chain versions etc
though. It worked for me ;-)

--- ref-linux-2.6.16.13/include/linux/elfnote.h	2006-08-23 20:08:56.000000000 +0100
+++ linux-2.6.16.13-xen/include/linux/elfnote.h	2006-08-23 20:10:00.000000000 +0100
@@ -39,7 +39,7 @@
  *      ELFNOTE(XYZCo, 12, .long, 0xdeadbeef)
  */
 #define ELFNOTE(name, type, desctype, descdata)	\
-.pushsection .note.name			;	\
+.pushsection ".note.name"		;	\
   .align 4				;	\
   .long 2f - 1f		/* namesz */	;	\
   .long 4f - 3f		/* descsz */	;	\
diff -r 58b5141c8309 linux-2.6-xen-sparse/arch/i386/kernel/head-xen.S
--- a/linux-2.6-xen-sparse/arch/i386/kernel/head-xen.S	Wed Aug 23 14:43:48 2006 +0100
+++ b/linux-2.6-xen-sparse/arch/i386/kernel/head-xen.S	Wed Aug 23 20:27:05 2006 +0100
@@ -199,3 +199,11 @@ ENTRY(cpu_gdt_table)
 	ELFNOTE(Xen, XEN_ELFNOTE_PAE_MODE,       .asciz, "no")
 #endif
 	ELFNOTE(Xen, XEN_ELFNOTE_LOADER,         .asciz, "generic")
+
+	ELFNOTE(XYZ Co., 42, .asciz, "forty-two")
+	ELFNOTE(XYZ Co., 12, .long, 0xdeadbeef)
+	ELFNOTE(!\"£$%^\\&, 12, .long, 0xdeadbeef)
+	ELFNOTE(*\(\)-+-=<, 12, .long, 0xdeadbeef)
+	ELFNOTE(>./?\;\'#:, 12, .long, 0xdeadbeef)
+	ELFNOTE(@~, 12, .long, 0xdeadbeef)
+

$ readelf -S --segments arch/i386/kernel/head-xen.o
...
  [ 7] .note.Xen         NOTE            00000000 002260 000144 00      0   0  4
  [ 8] .rel.note.Xen     REL             00000000 003018 000010 08     15   7  4
  [ 9] .note.XYZ Co.     NOTE            00000000 0023a4 000038 00      0   0  4
  [10] .note.!"£$%^\&   NOTE            00000000 0023dc 00001c 00      0   0  4
  [11] .note.*()-+-=<    NOTE            00000000 0023f8 00001c 00      0   0  4
  [12] .note.>./?;'#:    NOTE            00000000 002414 00001c 00      0   0  4
  [13] .note.@~          NOTE            00000000 002430 000014 00      0   0  4
...

$ objdump -j .notes -s vmlinux
...
 85a8 72696300 08000000 0a000000 2a000000  ric.........*...
 85b8 58595a20 436f2e00 666f7274 792d7477  XYZ Co..forty-tw
 85c8 6f000000 08000000 04000000 0c000000  o...............
 85d8 58595a20 436f2e00 efbeadde 0a000000  XYZ Co..........
 85e8 04000000 0c000000 2122c2a3 24255e5c  ........!"..$%^\
 85f8 26000000 efbeadde 09000000 04000000  &...............
 8608 0c000000 2a28292d 2b2d3d3c 00000000  ....*()-+-=<....
 8618 efbeadde 09000000 04000000 0c000000  ................
 8628 3e2e2f3f 3b27233a 00000000 efbeadde  >./?;'#:........
 8638 03000000 04000000 0c000000 407e0000  ............@~..
 8648 efbeadde                             ....
...

