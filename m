Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261242AbUCAMiF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Mar 2004 07:38:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261245AbUCAMiF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Mar 2004 07:38:05 -0500
Received: from pr-117-210.ains.net.au ([202.147.117.210]:48835 "EHLO
	mail.ocs.com.au") by vger.kernel.org with ESMTP id S261242AbUCAMiA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Mar 2004 07:38:00 -0500
X-Mailer: exmh version 2.5 01/15/2001 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Arnd Bergmann <arnd@arndb.de>
Cc: kernel-janitors@lists.osdl.org, linux-kernel@vger.kernel.org
Subject: Re: finding unused globals in the kernel 
In-reply-to: Your message of "Mon, 01 Mar 2004 10:42:09 BST."
             <200403011042.10099.arnd@arndb.de> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 01 Mar 2004 23:37:37 +1100
Message-ID: <3585.1078144657@ocs3.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 1 Mar 2004 10:42:09 +0100, 
Arnd Bergmann <arnd@arndb.de> wrote:
>On Monday 01 March 2004 07:11, Keith Owens wrote:
>> It is a bit harder than a simple compare.  EXPORT_SYMBOL(foo) generates
>> a reference to foo even if nothing uses it, which hides unused
>> variables.  Certain symbols appear as unused but are really used by the
>> 2.4 version of insmod.  Your script does not handle modules at all.
>> 
>> namespace.pl below handles all the special cases on kernels from 2.0
>> through 2.4.  It needs updating for 2.6 kernels, enjoy.
>
>Well, your script is about a related, but still different question.
>namespace.pl apparently gives a list of symbols that could/should have 
>been marked static because they are not referenced outside of their
>files. I have another script that does this as well, though yours
>is a lot better at it.
>
>The question that my checkunused.sh is trying to answer is which symbols 
>are never referenced at all and therefore could be removed from the 
>kernel binary. I intentionally kept the references from EXPORT_SYMBOL,
>because I didn't want to think about whether there might be modules
>using them.

Your script depends on relocation data to see if a symbol is used or
not, but reloc data is not reliable for this test.  On architectures
that use pc relative addressing, the compiler may not generate
relocation entries for references within the same source file, because
the compiler already knows the offset between the call and the target
instruction so it can code the instruction directly instead of leaving
it to the linker.  Even when reloc data is available, objdump does not
always print it the way that you want, e.g. ia64 uses PCREL21B amongst
others, not R_IA64_....

When I wrote namespace.pl I decided not to rely on relocation data that
may not be complete or may be in a strange format.  Instead I used the
'nm' output which is standard across all architectures.

Not only does namespace.pl find symbols that could be marked static, it
finds duplicate symbols as well as symbols that are exported and never
used.  Relocation data cannot cope with exported symbols, all exported
symbols appear to be "referenced" but may not be used at all.

For the symbols that could be marked static, the act of changing them
to static and rebuilding will do two things.  Static symbols often let
gcc generate better code.  If a static symbol is not referenced at all,
gcc will now tell you about it.  It takes extra steps (mark static,
rebuild, see warning message, remove dead symbol) but takes care of all
cases and you end up with a cleaner code base when compared to doing a
simple "any references" test.

>Finding exported symbols that no module in the tree uses is yet
>another problem. Your namespace.pl does this on object files, but
>using cscope at source level could perhaps do this better.

Source analysis via cscope or similar is not good enough.  By running
off the object files, I find symbols that are defined but are not used
in the current config.  In some cases the symbols are completely dead,
in others they should be wrapped in #ifdef CONFIG_foo so they are only
built when they are needed.

Cscope will not tell you if a symbol is used in a particular config or
architecture.  Nor will it tell you that a symbol is referenced from a
macro or inline function but that macro or function is never called.
The only way to tell for certain is to build and analyse the objects,
hence namespace.pl.

