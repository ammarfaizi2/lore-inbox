Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262386AbTE0AQ4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 May 2003 20:16:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262403AbTE0AQ4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 May 2003 20:16:56 -0400
Received: from rwcrmhc52.attbi.com ([216.148.227.88]:40881 "EHLO
	rwcrmhc52.attbi.com") by vger.kernel.org with ESMTP id S262386AbTE0AQy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 May 2003 20:16:54 -0400
Message-ID: <3ED2B18C.20705@acm.org>
Date: Mon, 26 May 2003 19:30:04 -0500
From: Corey Minyard <minyard@acm.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030313
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Keith Owens <kaos@ocs.com.au>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.21-rc3 - ipmi unresolved
References: <5110.1053921270@kao2.melbourne.sgi.com>
In-Reply-To: <5110.1053921270@kao2.melbourne.sgi.com>
X-Enigmail-Version: 0.74.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith Owens wrote:

>On Sun, 25 May 2003 22:37:17 -0500, 
>Corey Minyard <minyard@acm.org> wrote:
>  
>
>>Keith Owens wrote:
>>    
>>
>>>Danger Will Robinson: panic notification to modules is racy.
>>>
>>>Registering via panic_notifier_list does not bump the module use count,
>>>a panic can occur while a module is being unloaded and you are dead.
>>>No big deal for panic, you are already dying, but it is just a symptom
>>>of a larger problem, yet another uncounted reference to module code.
>>>_ANY_ notifier callback to a module is racy, think very carefully
>>>before exporting any XXX_notifier_list.
>>>
>>>I would go so far as to say that no XXX_notifier_list should be
>>>exported, that includes notifier_chain_register() itself.  If a module
>>>needs to be notified then it should have glue code in the main kernel
>>>that does try_inc_mod_count() on the module before calling any module
>>>functions.
>>>
>>>      
>>>
>>Although, as you noted, this one is not a problem, you are probably
>>right in general.
>>
>>However, having every modules that uses a notifier list have its own
>>custom code in the kernel is probably not a very good option, either.
>>It makes things messy and adds unneeded bloat to the kernel.
>>
>>Would it be possible to have a notifier_chain_register_module() that did
>>the job generically?
>>    
>>
>
>notifier_chain_register_module() is possible, just pass __THIS_MODULE
>and the code that runs the notifier chain does try_inc_mod_count()
>before making the upcall.  But that new function cannot be mixed with
>notifier_chain_register(), it has to be a complete replacement.  Not
>going to happen in 2.4.
>
>I considered making notifier_chain_register() a macro which called
>notifier_chain_register_module() with __THIS_MODULE, but that assumes
>that all calls to notifier_chain_register() are local, i.e. from the
>top level functions.  Alas there are any service routines that call
>notifier_chain_register() on behalf of their caller, so the macro
>approach will result in the wrong value for __THIS_MODULE.
>
Why can't you have a module id in the notifier chain, and use a boolean
to tell if it is set, or something similar to that?  That way you could
mix them, if the bool is set then do the try_in_module_count thing, if
not then just call the function.  It does add some components to the
register structure, but that shouldn't hurt anything besides taking a
little more memory.

>
>  
>
>>Or maybe if notifier_chain_unregister() did a
>>synchronize_kernel()
>>(the RCU call to wait until everything is clear) would that be good
>>enough?  It would
>>only work if all the notifier chain calls where done while the kernel
>>was unpreemptable,
>>if I understand this correctly.  I realize the RCU option is not
>>available in 2.4, though.
>>    
>>
>
>notifier_chain_unregister() is not a problem, that is a downcall from
>the module into the kernel when the module is going away, downcalls are
>"always" safe.  The race is a module that has started to unload, and
>another cpu (or even the same cpu under some circumstances) runs the
>notifier chain, doing an upcall from the kernel into a module without
>locking or refcounts.  Given the right timing, the notifier code could
>even branch to a module that has been completely removed.  Note that
>notifier_call_chain() has no locking, so it is also racy against
>notifier_chain_unregister().
>  
>
You don't understand how the RCU code works.  The race is as you
describe.  If notifier_chain_unregister() removes the item from the list
and then calls synchronize_kernel(), and all the notifier calls are in
unpreemptable sections, you guarantee that no one can be left that can
call the notifier, they will all have left their preemptable sections
before synchronize_kernel() will return.  It's a little wierd, but it
does work.

If the calls to the notifier chain are outside unpreemptable sections,
though, then there's no guaranteed of when they will run (with a
preemptable kernel) so this won't work.

-Corey

