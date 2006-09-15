Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751461AbWION4v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751461AbWION4v (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 09:56:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751475AbWION4v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 09:56:51 -0400
Received: from nf-out-0910.google.com ([64.233.182.190]:42073 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751461AbWION4t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 09:56:49 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=plqyqTRFKfLRCkjQKa7qBqOq7Nla77xVZpYJHaZRo5L4RFY/ylmXTkyH6rLUJotl6TRyqQfbvgf6sIgztIaevfga7jH7ZMmv5B371OdA+aG1yFxXWUq01o5QOYGtGXPeSXnS0u66tTHxuthlZXm77h8ucGlrZFJonZdclJaQHM0=
Message-ID: <d120d5000609150656v544ca0d6vcf93e349508dedd8@mail.gmail.com>
Date: Fri, 15 Sep 2006 09:56:46 -0400
From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
To: "Jiri Kosina" <jikos@jikos.cz>
Subject: Re: [PATCH 0/3] Synaptics - fix lockdep warnings
Cc: "Arjan van de Ven" <arjan@infradead.org>,
       lkml <linux-kernel@vger.kernel.org>, "Ingo Molnar" <mingo@elte.hu>
In-Reply-To: <d120d5000609150651m4b7e739bv7afc0683071911a1@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <Pine.LNX.4.64.0609140227500.22181@twin.jikos.cz>
	 <d120d5000609140918j18d68a4dmd9d9e1e72d2fd718@mail.gmail.com>
	 <Pine.LNX.4.64.0609142037110.2721@twin.jikos.cz>
	 <d120d5000609141156h5e06eb68k87a6fe072a701dab@mail.gmail.com>
	 <1158260584.4200.3.camel@laptopd505.fenrus.org>
	 <d120d5000609141211o76432bd3l82582ef3896e3be@mail.gmail.com>
	 <1158298404.4332.18.camel@laptopd505.fenrus.org>
	 <d120d5000609150620p15b17debo9ace17836d788958@mail.gmail.com>
	 <Pine.LNX.4.64.0609151535190.2721@twin.jikos.cz>
	 <d120d5000609150651m4b7e739bv7afc0683071911a1@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/15/06, Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
> On 9/15/06, Jiri Kosina <jikos@jikos.cz> wrote:
> > On Fri, 15 Sep 2006, Dmitry Torokhov wrote:
> >
> > > I understand what Ingo is saying about detecting deadlocks across the
> > > pool of locks of the same class not waiting till they really clash, it
> > > is really useful. I also want to make my code as independent of lockdep
> > > as possible. Having a speciall marking on the locks themselves (done
> > > upon creation) instead of altering call sites is the cleanest way IMHO.
> > > Can we have a flag in the lock structure that would tell lockdep that it
> > > is OK for the given lock to be taken several times (i.e. the locks are
> > > really on the different objects)? This would still allow to detect
> > > incorrect locking across different classes.
> >
> > Yes, but unfortunately marking the lock as 'can-be-taken-multiple-times'
> > is weaker than using the nested locking provided by lockdep.
> >
> > i.e. if you mark a lock this way, it opens door for having deadlock, which
> > won't be detected by lockdep. This will happen if the code, by mistake,
> > really takes the _very same_ lock twice. lockdep will not be able to
> > detect this, when the lock is marked in a way you propose, but is able to
> > detect this when using the nested semantics.
> >
>
> But nested semantics breaks the notion of the locks belonging to the
> same pool so both solutions have tradeoffs. I could use either one of
> these as long as details are hidden and callers do not have to care.
>

One more thing I forgot to add - how will we deal with lockdep in
cases when we have X-over-Y-over-X protocol, when there is no tight
coupling between the X parts so it is impossible to know when to apply
special marking on the lock or callers?

-- 
Dmitry
