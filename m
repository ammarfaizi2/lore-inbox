Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261422AbTEYHoZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 May 2003 03:44:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261444AbTEYHoZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 May 2003 03:44:25 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:49677 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id S261422AbTEYHoY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 May 2003 03:44:24 -0400
X-Mailer: exmh version 2.5 01/15/2001 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.21-rc3 - ipmi unresolved 
In-reply-to: Your message of "Fri, 23 May 2003 23:38:53 +1000."
             <3ECE246D.E3B27BCB@eyal.emu.id.au> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 25 May 2003 17:57:21 +1000
Message-ID: <28098.1053849441@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 May 2003 23:38:53 +1000, 
Eyal Lebedinsky <eyal@eyal.emu.id.au> wrote:
>The exports in ksyms are still necessary, and missing:
>
>depmod: *** Unresolved symbols in
>/lib/modules/2.4.21-rc3/kernel/drivers/char/ipmi/ipmi_msghandler.o
>depmod:         panic_notifier_list
>depmod: *** Unresolved symbols in
>/lib/modules/2.4.21-rc3/kernel/drivers/char/ipmi/ipmi_watchdog.o
>depmod:         panic_notifier_list
>depmod:         panic_timeout

Danger Will Robinson: panic notification to modules is racy.

Registering via panic_notifier_list does not bump the module use count,
a panic can occur while a module is being unloaded and you are dead.
No big deal for panic, you are already dying, but it is just a symptom
of a larger problem, yet another uncounted reference to module code.
_ANY_ notifier callback to a module is racy, think very carefully
before exporting any XXX_notifier_list.

I would go so far as to say that no XXX_notifier_list should be
exported, that includes notifier_chain_register() itself.  If a module
needs to be notified then it should have glue code in the main kernel
that does try_inc_mod_count() on the module before calling any module
functions.

