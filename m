Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264213AbTEZDmw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 May 2003 23:42:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264227AbTEZDmw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 May 2003 23:42:52 -0400
Received: from zok.sgi.com ([204.94.215.101]:63711 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id S264213AbTEZDmv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 May 2003 23:42:51 -0400
X-Mailer: exmh version 2.5 01/15/2001 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Corey Minyard <minyard@acm.org>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.21-rc3 - ipmi unresolved 
In-reply-to: Your message of "Sun, 25 May 2003 22:37:17 EST."
             <3ED18BED.40407@acm.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 26 May 2003 13:54:30 +1000
Message-ID: <5110.1053921270@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 25 May 2003 22:37:17 -0500, 
Corey Minyard <minyard@acm.org> wrote:
>Keith Owens wrote:
>>Danger Will Robinson: panic notification to modules is racy.
>>
>>Registering via panic_notifier_list does not bump the module use count,
>>a panic can occur while a module is being unloaded and you are dead.
>>No big deal for panic, you are already dying, but it is just a symptom
>>of a larger problem, yet another uncounted reference to module code.
>>_ANY_ notifier callback to a module is racy, think very carefully
>>before exporting any XXX_notifier_list.
>>
>>I would go so far as to say that no XXX_notifier_list should be
>>exported, that includes notifier_chain_register() itself.  If a module
>>needs to be notified then it should have glue code in the main kernel
>>that does try_inc_mod_count() on the module before calling any module
>>functions.
>>
>Although, as you noted, this one is not a problem, you are probably
>right in general.
>
>However, having every modules that uses a notifier list have its own
>custom code in the kernel is probably not a very good option, either.
>It makes things messy and adds unneeded bloat to the kernel.
>
>Would it be possible to have a notifier_chain_register_module() that did
>the job generically?

notifier_chain_register_module() is possible, just pass __THIS_MODULE
and the code that runs the notifier chain does try_inc_mod_count()
before making the upcall.  But that new function cannot be mixed with
notifier_chain_register(), it has to be a complete replacement.  Not
going to happen in 2.4.

I considered making notifier_chain_register() a macro which called
notifier_chain_register_module() with __THIS_MODULE, but that assumes
that all calls to notifier_chain_register() are local, i.e. from the
top level functions.  Alas there are any service routines that call
notifier_chain_register() on behalf of their caller, so the macro
approach will result in the wrong value for __THIS_MODULE.

>Or maybe if notifier_chain_unregister() did a
>synchronize_kernel()
>(the RCU call to wait until everything is clear) would that be good
>enough?  It would
>only work if all the notifier chain calls where done while the kernel
>was unpreemptable,
>if I understand this correctly.  I realize the RCU option is not
>available in 2.4, though.

notifier_chain_unregister() is not a problem, that is a downcall from
the module into the kernel when the module is going away, downcalls are
"always" safe.  The race is a module that has started to unload, and
another cpu (or even the same cpu under some circumstances) runs the
notifier chain, doing an upcall from the kernel into a module without
locking or refcounts.  Given the right timing, the notifier code could
even branch to a module that has been completely removed.  Note that
notifier_call_chain() has no locking, so it is also racy against
notifier_chain_unregister().

