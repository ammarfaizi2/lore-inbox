Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932115AbWDJTG6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932115AbWDJTG6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Apr 2006 15:06:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932116AbWDJTG6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Apr 2006 15:06:58 -0400
Received: from e31.co.us.ibm.com ([32.97.110.149]:34970 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S932115AbWDJTG4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Apr 2006 15:06:56 -0400
Subject: Re: [Ext2-devel] Re: [RFC][PATCH 0/2]Extend ext3 filesystem limit
	from 8TB to 16TB
From: Mingming Cao <cmm@us.ibm.com>
Reply-To: cmm@us.ibm.com
To: Laurent Vivier <Laurent.Vivier@bull.net>, kiran@scalex86.org
Cc: Andrew Morton <akpm@osdl.org>, Takashi Sato <sho@tnes.nec.co.jp>,
       linux-kernel@vger.kernel.org,
       ext2-devel <ext2-devel@lists.sourceforge.net>,
       linux-fsdevel@vger.kernel.org
In-Reply-To: <1144688279.3964.7.camel@dyn9047017067.beaverton.ibm.com>
References: <20060325223358sho@rifu.tnes.nec.co.jp>
	 <1143485147.3970.23.camel@dyn9047017067.beaverton.ibm.com>
	 <20060327131049.2c6a5413.akpm@osdl.org>
	 <20060327225847.GC3756@localhost.localdomain>
	 <1143530126.11560.6.camel@openx2.frec.bull.fr>
	 <1143568905.3935.13.camel@dyn9047017067.beaverton.ibm.com>
	 <1143623605.5046.11.camel@openx2.frec.bull.fr>
	 <1143682730.4045.145.camel@dyn9047017067.beaverton.ibm.com>
	 <20060329175446.67149f32.akpm@osdl.org>
	 <1144660270.5816.3.camel@openx2.frec.bull.fr>
	 <1144688279.3964.7.camel@dyn9047017067.beaverton.ibm.com>
Content-Type: text/plain; charset=UTF-8
Organization: IBM LTC
Date: Mon, 10 Apr 2006 12:06:51 -0700
Message-Id: <1144696012.3964.76.camel@dyn9047017067.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-04-10 at 09:57 -0700, Mingming Cao wrote:
> On Mon, 2006-04-10 at 11:11 +0200, Laurent Vivier wrote:
> > Le jeu 30/03/2006 à 03:54, Andrew Morton a écrit :
> > > Mingming Cao <cmm@us.ibm.com> wrote:
> > > >
> > > > The things need to be done to complete this work is the issue with
> > > >  current percpu counter, which could not handle u32 type count well. 
> > > 
> > > I'm surprised there's much of a problem here.  It is a 32-bit value, so it
> > > should mainly be a matter of treating the return value from
> > > percpu_counter_read() as unsigned long.
> > > 
> > > However a stickier problem is when dealing with a filesystem which has,
> > > say, 0xffff_ff00 blocks.  Because percpu counters are approximate, and a
> > > counter which really has a value of 0xffff_feee might return 0x00000123. 
> > > What do we do then?
> > > 
> > > Of course the simple option is to nuke the percpu counters in ext3 and use
> > > atomic_long_t (which is signed, so appropriate treat-it-as-unsigned code
> > > would be needed).  I doubt if the percpu counters in ext3 are gaining us
> > > much.
> > 
> > I tried to make something in this way.
> > Does the attached patch look like the thing you though about ?
> > 
> 
Hi Laurent,

Just looked at your patch, shouldn't we use atomic_long_add() instead of
atomic_long_set() to replace percpu_counter_mod()?

> I tried the other way -- I am trying to keep the percpu counter in use
> in ext2/3 as much as possible.  I proposed a fix for percpu counter to
> deal with the possible "overflow" (i.e, a counter really has a value of
> 0xfff_feee and after updating one local counter it truens 0x00000123).
> Will send the proposed patch out for review and comments soon.
> 

Anyway, I am not against the atomic way. Just thought there must be
reasons where we use percpu counters -- the cache pollution on smp
machine is certainly a concern if we use atomic instead, so I  tried to
fix percpu counter first.

I think my fix for percpu counter should work, and the changes doesn't
affect other users of current percpu counters(vfs and network).  Kiran,
Andrew, please review it (posted in another seperate thread). If not,
then I guess we have to use atomic counter -- this is performance vs
capacity kind of trade off.

But both methods don't support 64 bit ext3 block number on 32 bit
machine...I am not happy with this but can't think of a way to fix this
without taking a global lock:(


Mingming
> -------------------------------------------------------
> This SF.Net email is sponsored by xPML, a groundbreaking scripting language
> that extends applications into web and mobile media. Attend the live webcast
> and join the prime developer group breaking into this new coding territory!
> http://sel.as-us.falkag.net/sel?cmd=lnk&kid0944&bid$1720&dat1642
> _______________________________________________
> Ext2-devel mailing list
> Ext2-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ext2-devel

