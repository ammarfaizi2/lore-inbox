Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932243AbWJYVaI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932243AbWJYVaI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Oct 2006 17:30:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932278AbWJYVaI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Oct 2006 17:30:08 -0400
Received: from madara.hpl.hp.com ([192.6.19.124]:39666 "EHLO madara.hpl.hp.com")
	by vger.kernel.org with ESMTP id S932243AbWJYVaG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Oct 2006 17:30:06 -0400
Date: Wed, 25 Oct 2006 14:29:40 -0700
From: Stephane Eranian <eranian@hpl.hp.com>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH] x86_64 add missing enter_idle() calls
Message-ID: <20061025212940.GA10003@frankl.hpl.hp.com>
Reply-To: eranian@hpl.hp.com
References: <20061006081607.GB8793@frankl.hpl.hp.com> <200610161636.52721.ak@suse.de> <20061021091837.GA24670@frankl.hpl.hp.com> <200610211522.53938.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200610211522.53938.ak@suse.de>
User-Agent: Mutt/1.4.1i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: eranian@hpl.hp.com
X-HPL-MailScanner: Found to be clean
X-HPL-MailScanner-From: eranian@hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi,

Looking a the exit_idle() code:

static void __exit_idle(void)
{
        if (read_pda(isidle) == 0)
                return;
        write_pda(isidle, 0);
        atomic_notifier_call_chain(&idle_notifier, IDLE_END, NULL);
}

I am wondering whether you are exposed to a race condition  w.r.t. to interrupts.
Supposed you are in idle, you get an interrupt and you execute __exit_idle(), the
test evaluate to false but before you can change the value of isidle, you get 
a higher priority interrupt which then also calls __exit_idle(), the test is still
false and you invoke the notifier, when you return from this interrupt you also
clear the isidle, but you call the notifier yet a second time.

I think that isidle needs to be test_and_clear atomically for this to guarantee
only one call the notifier on __exit_idle().

what do you think?

On Sat, Oct 21, 2006 at 03:22:53PM +0200, Andi Kleen wrote:
> 
> > I finally found the culprit for this. The current code is wrong for the
> > simple reason that the cpu_idle() function is NOT always the lowest level
> > idle loop function. For enter_idle()/__exit_idle() to work correctly they
> > must be placed in the lowest-level idle loop. The cpu_idle() eventually ends
> > up in the idle() function, but this one may have a loop in it! This is the
> > case when idle()=cpu_default_idle() and idle()=poll_idle(), for instance. 
> 
> Ah now I remember - i had actually fixed that (it was the cleanup-idle-loops
> patch) that moved the loops one level up. But then I disabled the patch
> at the request of Andrew because it conflicted with some ACPI idle changes.
> 
> I'll readd it for .20, then things should be ok.
> 
> -Andi

-- 

-Stephane
