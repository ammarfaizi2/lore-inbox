Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263338AbTE0Ecl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 00:32:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263339AbTE0Eck
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 00:32:40 -0400
Received: from sccrmhc01.attbi.com ([204.127.202.61]:23487 "EHLO
	sccrmhc01.attbi.com") by vger.kernel.org with ESMTP id S263338AbTE0Eci
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 00:32:38 -0400
Message-ID: <3ED2ED73.7090300@acm.org>
Date: Mon, 26 May 2003 23:45:39 -0500
From: Corey Minyard <minyard@acm.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030313
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Keith Owens <kaos@ocs.com.au>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Registering for notifier chains in modules (was Linux 2.4.21-rc3
 - ipmi unresolved)
References: <18292.1054004949@kao2.melbourne.sgi.com>
In-Reply-To: <18292.1054004949@kao2.melbourne.sgi.com>
X-Enigmail-Version: 0.74.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith Owens wrote:

>On Mon, 26 May 2003 19:30:04 -0500, 
>Corey Minyard <minyard@acm.org> wrote:
>  
>
>>Keith Owens wrote:
>>    
>>
>>>I considered making notifier_chain_register() a macro which called
>>>notifier_chain_register_module() with __THIS_MODULE, but that assumes
>>>that all calls to notifier_chain_register() are local, i.e. from the
>>>top level functions.  Alas there are any service routines that call
>>>notifier_chain_register() on behalf of their caller, so the macro
>>>approach will result in the wrong value for __THIS_MODULE.
>>>
>>>      
>>>
>>Why can't you have a module id in the notifier chain, and use a boolean
>>to tell if it is set, or something similar to that?  That way you could
>>mix them, if the bool is set then do the try_in_module_count thing, if
>>not then just call the function.  It does add some components to the
>>register structure, but that shouldn't hurt anything besides taking a
>>little more memory.
>>    
>>
>
>It is a change of API in a 2.4 kernel.  Not a good idea.
>
Does adding a field to a structure (where the user does not have to do
anything with the
field) change the API?  That would be the only API change here.

>
>  
>
>>>notifier_chain_unregister() is not a problem, that is a downcall from
>>>the module into the kernel when the module is going away, downcalls are
>>>"always" safe.  The race is a module that has started to unload, and
>>>another cpu (or even the same cpu under some circumstances) runs the
>>>notifier chain, doing an upcall from the kernel into a module without
>>>locking or refcounts.  Given the right timing, the notifier code could
>>>even branch to a module that has been completely removed.  Note that
>>>notifier_call_chain() has no locking, so it is also racy against
>>>notifier_chain_unregister().
>>> 
>>>
>>>      
>>>
>>You don't understand how the RCU code works.
>>    
>>
>
>(a) I understand how RCU works, I was working on lock free code for
>    years before RCU appeared in the kernel.
>
Then maybe I don't understand it.  The writers of the RCU code pointed
it out to me
for a very similar situation.  Why doesn't calling synchronize_kernel() in
notifier_chain_unregister() fix the module unload and unregister races?

Or perhaps not all notifier chains get called when the kernel is
unpreemptable?
You could turn preempt off in notifier_call_chain(), though that might have
some bad effects.  In the preemptable kernel case, I'm not sure if the RCU
code waits until all threads of execution leave the kernel.  If it does,
then
preemption shouldn't even matter.

>
>(b) This is 2.4, not 2.5, there is no RCU.
>  
>
Understood (I already said this).  But I was thinking it might be a good
addition to 2.5,
if it solved the problem.

-Corey

