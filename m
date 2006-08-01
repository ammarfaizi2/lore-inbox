Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751335AbWHAOmx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751335AbWHAOmx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 10:42:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751343AbWHAOmx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 10:42:53 -0400
Received: from mba.ocn.ne.jp ([210.190.142.172]:53696 "EHLO smtp.mba.ocn.ne.jp")
	by vger.kernel.org with ESMTP id S1751335AbWHAOmv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 10:42:51 -0400
Date: Tue, 01 Aug 2006 23:44:22 +0900 (JST)
Message-Id: <20060801.234422.25910237.anemo@mba.ocn.ne.jp>
To: schwidefsky@googlemail.com
Cc: johnstul@us.ibm.com, akpm@osdl.org, zippel@linux-m68k.org,
       clameter@engr.sgi.com, linux-kernel@vger.kernel.org,
       ralf@linux-mips.org, ak@muc.de
Subject: Re: [PATCH] simplify update_times (avoid jiffies/jiffies_64
 aliasing problem)
From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <6e0cfd1d0607310336o355693a5l939db098b9210d81@mail.gmail.com>
References: <20060305.021542.126141997.anemo@mba.ocn.ne.jp>
	<20060730.235403.108306254.anemo@mba.ocn.ne.jp>
	<6e0cfd1d0607310336o355693a5l939db098b9210d81@mail.gmail.com>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 31 Jul 2006 12:36:38 +0200, "Martin Schwidefsky" <schwidefsky@googlemail.com> wrote:
> > --- a/arch/x86_64/kernel/time.c
> > +++ b/arch/x86_64/kernel/time.c
> > @@ -423,7 +423,8 @@ #endif
> >
> >         if (lost > 0) {
> >                 handle_lost_ticks(lost, regs);
> > -               jiffies += lost;
> > +               while (lost--)
> > +                       do_timer(regs);
> >         }
> >
> >  /*
> 
> I think that this is going into the wrong direction. There are a
> number of architectures that call do_timer(regs) in a while loop. It
> would be much nicer if do_timer would get the number of passed ticks
> as an argument. And the "regs" argument to do_timer is just useless.

But normally do_timer() is called just once, isn't it?  These loops
are just for lost ticks, which would be rarely happened.  So I think
tunning for usual case is better.

I agree that the "regs" argument is useless.  Another candidate for
cleanup.

---
Atsushi Nemoto
