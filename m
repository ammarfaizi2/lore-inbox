Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263993AbTEZDYI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 May 2003 23:24:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264185AbTEZDYI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 May 2003 23:24:08 -0400
Received: from rwcrmhc53.attbi.com ([204.127.198.39]:13733 "EHLO
	rwcrmhc53.attbi.com") by vger.kernel.org with ESMTP id S263993AbTEZDYG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 May 2003 23:24:06 -0400
Message-ID: <3ED18BED.40407@acm.org>
Date: Sun, 25 May 2003 22:37:17 -0500
From: Corey Minyard <minyard@acm.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030313
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Keith Owens <kaos@ocs.com.au>
CC: Eyal Lebedinsky <eyal@eyal.emu.id.au>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.21-rc3 - ipmi unresolved
References: <28098.1053849441@ocs3.intra.ocs.com.au>
In-Reply-To: <28098.1053849441@ocs3.intra.ocs.com.au>
X-Enigmail-Version: 0.74.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith Owens wrote:

>On Fri, 23 May 2003 23:38:53 +1000, 
>Eyal Lebedinsky <eyal@eyal.emu.id.au> wrote:
>  
>
>>The exports in ksyms are still necessary, and missing:
>>
>>depmod: *** Unresolved symbols in
>>/lib/modules/2.4.21-rc3/kernel/drivers/char/ipmi/ipmi_msghandler.o
>>depmod:         panic_notifier_list
>>depmod: *** Unresolved symbols in
>>/lib/modules/2.4.21-rc3/kernel/drivers/char/ipmi/ipmi_watchdog.o
>>depmod:         panic_notifier_list
>>depmod:         panic_timeout
>>    
>>
>
>Danger Will Robinson: panic notification to modules is racy.
>
>Registering via panic_notifier_list does not bump the module use count,
>a panic can occur while a module is being unloaded and you are dead.
>No big deal for panic, you are already dying, but it is just a symptom
>of a larger problem, yet another uncounted reference to module code.
>_ANY_ notifier callback to a module is racy, think very carefully
>before exporting any XXX_notifier_list.
>
>I would go so far as to say that no XXX_notifier_list should be
>exported, that includes notifier_chain_register() itself.  If a module
>needs to be notified then it should have glue code in the main kernel
>that does try_inc_mod_count() on the module before calling any module
>functions.
>
Although, as you noted, this one is not a problem, you are probably
right in general.

However, having every modules that uses a notifier list have its own
custom code
in the kernel is probably not a very good option, either.  It makes
things messy and
adds unneeded bloat to the kernel.

Would it be possible to have a notifier_chain_register_module() that did
the job
generically?  Or maybe if notifier_chain_unregister() did a
synchronize_kernel()
(the RCU call to wait until everything is clear) would that be good
enough?  It would
only work if all the notifier chain calls where done while the kernel
was unpreemptable,
if I understand this correctly.  I realize the RCU option is not
available in 2.4, though.

-Corey

