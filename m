Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263515AbTJLTr7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Oct 2003 15:47:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263518AbTJLTr7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Oct 2003 15:47:59 -0400
Received: from meryl.it.uu.se ([130.238.12.42]:20728 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id S263515AbTJLTr5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Oct 2003 15:47:57 -0400
Date: Sun, 12 Oct 2003 21:47:48 +0200 (MEST)
Message-Id: <200310121947.h9CJlmtK015045@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: benh@kernel.crashing.org
Subject: Re: non-modular 2.6 ppc kernels miscompiled by gcc-3.3.1?
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.linuxppc.org,
       sam@ravnborg.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 12 Oct 2003 15:19:22 +0200, Benjamin Herrenschmidt wrote:
>On Sun, 2003-10-12 at 15:10, Mikael Pettersson wrote:
>> When I compile a non-modular 2.6 kernel for ppc with gcc-3.3.1,
>> it oopses in __copy_tofrom_user() [copy_mount_options()] in
>> user-space's first mount /proc call. User-space limps along
>> for a while, oopsing in every mount call, and then hangs.
>> 
>> This occurs with 2.6.0-test5, test6, and the test7-based
>> linuxppc-2.5 tree (rsync:ed today).
>> 
>> Enabling CONFIG_MODULES=y but still keeping everything built-in
>> prevents the oopses.
>
>Smells like some section alignement issues. Can you check
>how the __ex_table  section is aligned and where __start___ex_table
>points to ? (using objdump)

You're right, it turned out to be an alignment issue. Here's what
my System.map looks like with gcc-3.3.1 and CONFIG_MODULES=n:

c017ba4d ? __start___kcrctab
c017ba4d ? __start___kcrctab_gpl
c017ba4d ? __start___ksymtab
c017ba4d ? __start___ksymtab_gpl
c017ba4d ? __stop___kcrctab
c017ba4d ? __stop___kcrctab_gpl
c017ba4d ? __stop___ksymtab
c017ba4d ? __stop___ksymtab_gpl
c017ba4d A __start___ex_table
c017cf08 A __start___bug_table
c017cf08 A __stop___ex_table
c01801c8 A __stop___bug_table

Notice __start___ex_table[]'s address: it's not 4-byte aligned.
With gcc-3.2.3 it got an 8-byte aligned address in my 2.6 kernel.

vmlinux.lds.S doesn't explicitly align __start___ex_table, so I
simply put ". = ALIGN(4);" before it and Voila! now it works.

/Mikael

--- linuxppc-2.5/arch/ppc/kernel/vmlinux.lds.S.~1~	2003-09-28 12:19:36.000000000 +0200
+++ linuxppc-2.5/arch/ppc/kernel/vmlinux.lds.S	2003-10-12 21:16:24.121283928 +0200
@@ -47,6 +47,7 @@
 
   .fixup   : { *(.fixup) }
 
+  . = ALIGN(4);
   __start___ex_table = .;
   __ex_table : { *(__ex_table) }
   __stop___ex_table = .;
