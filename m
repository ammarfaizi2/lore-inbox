Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964794AbWFHLBO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964794AbWFHLBO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jun 2006 07:01:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964820AbWFHLBO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jun 2006 07:01:14 -0400
Received: from canuck.infradead.org ([205.233.218.70]:39395 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S964794AbWFHLBN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jun 2006 07:01:13 -0400
Subject: Re: mutex vs. local irqs (Was: 2.6.18 -mm merge plans)
From: David Woodhouse <dwmw2@infradead.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       paulus@samba.org
In-Reply-To: <20060608105342.GA2346@elte.hu>
References: <20060604135011.decdc7c9.akpm@osdl.org>
	 <1149652378.27572.109.camel@localhost.localdomain>
	 <20060606212930.364b43fa.akpm@osdl.org>
	 <1149656647.27572.128.camel@localhost.localdomain>
	 <20060606222942.43ed6437.akpm@osdl.org>
	 <1149662671.27572.158.camel@localhost.localdomain>
	 <20060607132155.GB14425@elte.hu>
	 <1149726685.23790.8.camel@localhost.localdomain>
	 <1149763768.13596.140.camel@pmac.infradead.org>
	 <20060608105342.GA2346@elte.hu>
Content-Type: text/plain
Date: Thu, 08 Jun 2006 12:01:06 +0100
Message-Id: <1149764466.13596.147.camel@pmac.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.1.dwmw2.2) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-06-08 at 12:53 +0200, Ingo Molnar quoted Andrew:
> Nonsense.  mutex_lock() can sleep.  Sleeping will enable interrupts.
> Therefore, hence, ergo ipso facto mutex_lock() can enable interrupts. QED,
> that's it.
> 
> But now, because some broken piece of hardware is coming out of
> reset/firmware asserting an interrupt we need to change the rules to be
> "mutex_lock() must preserve local interrupts if the lock is uncontended".
> Ditto down(), down_read() and down_write().
> 
> And why does this bizarre restriction upon the implementation of our
> locking primtives exist?  Because of your broken PIC and because of our
> inability to sort out the early boot code.  And because the early boot code
> has this implicit knowledge that the locks will be uncontended, else we're
> toast.
> 
> We're doing mutex_lock(), down(), down_read() and down_write() with local
> interrupts disabled, which is a bug.  We have explicit code in there to
> *disable* our runtime debugging checks because we know about this bug but
> don't know how to fix it.
> 
> I call that sucky. 

OK, if you put it like that, and you're going to be consistent by
declaring the disabling of __might_sleep() warnings to be sucky too,
then I suppose we can buy that argument.

Yes, we need to sort out the early boot code. It isn't so much that
we're unable as that nobody's really tried very hard. People seem scared
of it -- they even invent pointless special cases like the
'earlyconsole' crap instead of just registering the damn consoles
earlier, for example. Register_console() has _always_ worked right from
the beginning of setup_arch(), and I've often put it there.

Let's make a concerted effort to reorder the startup code so that we
_can_ enable interrupts and have slab working quite early. Ben's plans
for this look sane enough to me.

-- 
dwmw2

