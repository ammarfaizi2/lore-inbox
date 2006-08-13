Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750721AbWHMGyL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750721AbWHMGyL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Aug 2006 02:54:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750724AbWHMGyL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Aug 2006 02:54:11 -0400
Received: from ns1.suse.de ([195.135.220.2]:41900 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750721AbWHMGyL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Aug 2006 02:54:11 -0400
From: Andi Kleen <ak@suse.de>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH for review] [109/145] x86_64: Convert modlist_lock to be a raw spinlock
Date: Sun, 13 Aug 2006 08:52:46 +0200
User-Agent: KMail/1.9.3
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>
References: <20060810 935.775038000@suse.de> <20060810193707.9DE2013C0B@wotan.suse.de> <20060812224825.1da23a1a.akpm@osdl.org>
In-Reply-To: <20060812224825.1da23a1a.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608130852.46300.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 13 August 2006 07:48, Andrew Morton wrote:
> On Thu, 10 Aug 2006 21:37:07 +0200 (CEST)
> Andi Kleen <ak@suse.de> wrote:
> 
> > This is a preparationary patch for converting stacktrace over to the
> > new dwarf2 unwinder. lockdep uses stacktrace and the new unwinder
> > takes the modlist_lock so using a normal spinlock would cause a deadlock.
> > Use a raw lock instead.
> > 
> 
> It breaks the build on most architectures.

Hmm, I grepped and most architectures seem to have both __raw_spin_lock
and local_save_flags. I didn't actually compile them because crosstool
doesn't love me anymore since I use gcc 4.0.

What is the official portable interface to do a raw spinlock
if this one doesn't work?


> > -	spin_lock_irqsave(&modlist_lock, flags);
> > +	raw_local_save_flags(flags);
> > +	__raw_spin_lock(&modlist_lock);
> >  	if (!__find_symbol(symbol, &owner, &crc, 1))
> >  		BUG();
> >  	module_put(owner);
> > -	spin_unlock_irqrestore(&modlist_lock, flags);
> > +	__raw_spin_unlock(&modlist_lock);
> > +	raw_local_irq_restore(flags);
> 
> That looks fairly hacky.  Wouldn't it be better to implement
> raw_spin_lock_irqsave()?

Possible.

-Andi

