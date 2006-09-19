Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751012AbWISVOQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751012AbWISVOQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Sep 2006 17:14:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751040AbWISVOQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Sep 2006 17:14:16 -0400
Received: from smtp-out.google.com ([216.239.45.12]:45776 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1751011AbWISVOP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Sep 2006 17:14:15 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:message-id:date:from:to:subject:cc:in-reply-to:
	mime-version:content-type:content-transfer-encoding:
	content-disposition:references;
	b=K6R9t5bW6lPQC7bCi7xxNiYuQl0om8UtsJFiMSGs6CRdylDJNSpnefZXuBtRfFsBb
	qoQfZ5u3q9DWtXHFLFd1g==
Message-ID: <404ea8000609191414q2551799dn71cc5f211eef7e4c@mail.google.com>
Date: Tue, 19 Sep 2006 14:14:07 -0700
From: "Dmitriy Zavin" <dmitriyz@google.com>
To: "Andi Kleen" <ak@suse.de>
Subject: Re: [PATCH] x86_64/i386: Rework thermal throttling detection/handling code for Intel P4/Xeons.
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
In-Reply-To: <200609190811.16649.ak@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060915004236.GA9766@google.com> <200609160634.55250.ak@suse.de>
	 <404ea8000609181521g4d5f2c1aq41d49b9941ea188@mail.google.com>
	 <200609190811.16649.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Ok if you want complex features like this you'll have to get rid
> of some other code in your patch.
...
> Currently the bloat:feature ratio is imho not good enough at least.

You are right. I was trying to do too much, unnecessarily. The count
is enough to be exported, and if someone cares to do interval
monitoring (etc.) they can write a daemon that watches it (since the
original patch was in second granularity, userspace can easily handle
that). If it turns out that we do need interval tracking, that can be
added at a later time. I'll have an updated series of patches to
address the issues.

>
> > > We have a 64bit jiffies for that now on 32bit too.
> >
> > The problem with using jiffies_64 is that the time_before/time_after
> > macros in linux/jiffies.h always typecast to "long" which is not 64
> > bits on 32bit systems. So it will get truncated, and behave as 32bits
> > and won't solve the problem
>
> Then please submit a separate patch to add time_before/after64 instead of trying
> to work around that.

Will do.

> > > > > Instead of having this evinfo structure you could just directly
> > > > > fill in struct mces in the caller.
> > > >
> > > > But the caller won't know what to fill the struct mce with since this
> > > > function does the logic of figuring out the thermal event info. I
> > > > can't have this function take "struct mce *" since that doesn't exist
> > > > on i386. I could have it accept pointers to values as arguments, but
> > > > that's messy.
> > >
> > > Then either define struct mce for i386 or use two different functions
> > > for i386/x86-64.
> >
> > I'll add a patch to pull out mcelog related stuff into mce_log.c, and
> > share that between i386/x86_64. Put mcelog.c to
> > arch/i386/kernel/cpu/mcheck
>
> Please keep it in x86-64.
>
> > , and have x86_64 just compile that in
> > directly. Does that sound like a workable solution? There's no need to
> > maintain identical code in 2 places.
>
> It depends on how ugly that patch is. Unification is fine as long
> as it improves something, but if it requires weird hacks again it's a net loss.

I decided against it. The patch would in fact be pretty ugly. Going
back in archives, I saw there were several attempts to do this, and it
was never successful. The pain of doing this would outweigh any use i
have for it at the moment.

Thanks for your insights.

--Dima
