Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261345AbSJ1Qaa>; Mon, 28 Oct 2002 11:30:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261346AbSJ1Qaa>; Mon, 28 Oct 2002 11:30:30 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:56849 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S261345AbSJ1Qa3>;
	Mon, 28 Oct 2002 11:30:29 -0500
Date: Mon, 28 Oct 2002 16:36:49 +0000
From: Matthew Wilcox <willy@debian.org>
To: "David S. Miller" <davem@redhat.com>
Cc: willy@debian.org, alan@lxorguk.ukuu.org.uk, rmk@arm.linux.org.uk,
       hugh@veritas.com, akpm@zip.com.au, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] shmem missing cache flush
Message-ID: <20021028163649.P27461@parcelfarce.linux.theplanet.co.uk>
References: <1035216742.27318.189.camel@irongate.swansea.linux.org.uk> <20021028.061059.38206858.davem@redhat.com> <20021028143226.N27461@parcelfarce.linux.theplanet.co.uk> <20021028.062608.78045801.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021028.062608.78045801.davem@redhat.com>; from davem@redhat.com on Mon, Oct 28, 2002 at 06:26:08AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 28, 2002 at 06:26:08AM -0800, David S. Miller wrote:
> If you can't get purely arch/* include/asm-* patches to him,
> that isn't my problem.
> 
> Yes, you might have to retransmit that patch 20/30 times over the
> course of a few days depending upon how busy Linus is, just get over
> it. :-)

I've been more concerned with getting core changes we need to him than
updating arch/parisc and include/asm-parisc.  Maybe I should have been
more pushy.

>    What do you want to do about flush_icache_page?  You want to change it
>    to flush_dcache_page at eviction time, and then we can purge that page
>    from our icache in update_mmu_cache?
>    
> That's the idea.  The other idea is "well these particular call spots
> really are special, so let's document flush_icache_page properly".

What data do you need to make that decision?  AFAICT (I'm not really
a PA CPU guru..) it's exactly the same amount of code, no matter which
way we do it.

While we're on the subject of cache flushing... these make no sense:

fs/binfmt_aout.c:357:           flush_icache_range(text_addr, text_addr+ex.a_text+ex.a_data);
fs/binfmt_aout.c:381:                   flush_icache_range((unsigned long) N_TXTADDR(ex),
fs/binfmt_aout.c:479:           flush_icache_range((unsigned long) start_addr,
fs/binfmt_elf.c:422:    flush_icache_range((unsigned long)addr,

the kernel doesn't execute the code ranges here, userspace does.  Which
means that the only place in the entire kernel which does need to call
flush_icache_range() is kernel/module.c, and that could all be done in
module_arch_init().  So I think we don't need flush_icache_range() at all.

-- 
Revolutions do not require corporate support.
