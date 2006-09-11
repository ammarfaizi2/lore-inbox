Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932210AbWIKSHz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932210AbWIKSHz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 14:07:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932216AbWIKSHz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 14:07:55 -0400
Received: from outbound-mail-01.bluehost.com ([70.103.189.11]:65257 "HELO
	outbound-mail-01.bluehost.com") by vger.kernel.org with SMTP
	id S932210AbWIKSHx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 14:07:53 -0400
From: Jesse Barnes <jbarnes@virtuousgeek.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Opinion on ordering of writel vs. stores to RAM
Date: Mon, 11 Sep 2006 11:08:17 -0700
User-Agent: KMail/1.9.4
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, David Miller <davem@davemloft.net>,
       jeff@garzik.org, paulus@samba.org, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, akpm@osdl.org, segher@kernel.crashing.org
References: <17666.11971.416250.857749@cargo.ozlabs.ibm.com> <200609101725.49234.jbarnes@virtuousgeek.org> <1157936412.31071.282.camel@localhost.localdomain>
In-Reply-To: <1157936412.31071.282.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609111108.18138.jbarnes@virtuousgeek.org>
X-Identified-User: {642:box128.bluehost.com:virtuous:virtuousgeek.org} {sentby:smtp auth 70.103.140.128 authed with jbarnes@virtuousgeek.org}
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday, September 10, 2006 6:00 pm, Benjamin Herrenschmidt wrote:
> > If we accept this, I don't think we're much better off than we are
> > currently (not that I have a problem with that).  That is, many
> > drivers
> > would still need to be fixed up.
>
> Not necessarily if you introduce the trick of doing the mmiowb() in
> spin_unlock when a per-cpu flag has been set previously by writel... not
> sure if it's worth tho.

True, though again this would add a branch to writeX.

> > Depends on what you mean by "ordered between MMIO and MMIO".
> > mmiowb()
> > was initially introduced to allow ordering of writes between CPUs,
> > and
> > really didn't say anything about memory vs. I/O, so the semantics you
> > describe here would also be different (and more expensive) than what
> > we
> > have now.
>
> No. What I mean is that two consecutive MMIO writes on the same CPU stay
> in order, and reads can't cross writes. The relaxed versions would still
> require mmiowb() (or another name) for synchronisation against
> spinlocks. As I told you before, I much prefer to sync of mmiowb() as a
> sync with locks than a sync with "other MMIOs on anotehr CPU" since that
> doesn't mean anything outside of the context of a lock.

Sure, that's where one would typically use it, but it really is a memory 
barrier...

>
> > This is what mmiowb() is supposed to be, though only for writes.
> > I.e.
> > two writes from different CPUs may arrive out of order if you don't
> > use
> > mmiowb() carefully.  Do you also need a mmiorb() macro or just a
> > stronger mmiob()?
>
> No, you misunderstand me. That's the main problem with mmiowb() and
> that's why it's so not clear to so many people: the way you keep
> presenting it as synchronizing MMIO vs. MMIO. I think it's a lot more
> clear if you present it as synchronizing MMIOs with locks. MMIO vs. MMIO
> is anohter matter.

That's because it *is* a barrier.  I don't think it's any harder to understand 
then regular memory barriers for example.  It's just that you'd typically use 
it in conjunction with locks to ensure proper device access.

> It's wether consecutive MMIO writes can be 
> re-ordered, wether MMIO loads can cross a write (either because the load
> is performed late, only when the value is actually used, or because the
> load can be exucuted before a preceeding write). That's what current
> __raw_* versions on PowerPC will allow, in addition to not doing endian
> swap. My proposal was that __writel/__readl, however, would keep MMIO
> vs. MMIO ordering (wouldn't allow that sort of re-ordering), however,
> they wouldn't order vs. spinlock (would still require mmiowb) nor vs.
> main memory (cacheable storage).

Ok, that's fine, though I think you'd only want the very weak semantics (as 
provided by your __raw* routines) on write combined memory typically?

> > mmiowb() could be written as io_to_io_write_barrier() if we wanted to be
> > extra verbose.  AIUI it's the same thing as smb_wmb() but for MMIO
> > space.
>
> I'm very much against your terminology. It's -not- an IO to IO barrier.
> It's an IO to lock barrier. Really. IO to IO is something else. ordering
> of IOs between CPUs has absolutely no meaning outside of the context of
> locked regions in any case.

But it *is* MMIO vs. MMIO.  There's confusion because your __raw* routines 
don't even guarantee same CPU ordering, while mmiowb() is solely intended for 
inter-CPU ordering.

But as you say, the most common (maybe only) use model for it is to make sure 
critical sections protecting device access behave correctly, so I don't have 
a problem tying it to locks somehow.

Jesse
