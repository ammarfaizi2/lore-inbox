Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262360AbSJ2VqJ>; Tue, 29 Oct 2002 16:46:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262365AbSJ2VqJ>; Tue, 29 Oct 2002 16:46:09 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:33810 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S262360AbSJ2VqI>;
	Tue, 29 Oct 2002 16:46:08 -0500
Date: Tue, 29 Oct 2002 21:52:30 +0000
From: Matthew Wilcox <willy@debian.org>
To: "David S. Miller" <davem@redhat.com>
Cc: willy@debian.org, alan@lxorguk.ukuu.org.uk, rmk@arm.linux.org.uk,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] shmem missing cache flush
Message-ID: <20021029215230.K27461@parcelfarce.linux.theplanet.co.uk>
References: <20021028163649.P27461@parcelfarce.linux.theplanet.co.uk> <20021028.085536.32752918.davem@redhat.com> <20021028170633.R27461@parcelfarce.linux.theplanet.co.uk> <20021028.085851.94768450.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021028.085851.94768450.davem@redhat.com>; from davem@redhat.com on Mon, Oct 28, 2002 at 08:58:51AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 28, 2002 at 08:58:51AM -0800, David S. Miller wrote:
>    From: Matthew Wilcox <willy@debian.org>
>    Date: Mon, 28 Oct 2002 17:06:33 +0000
> 
>    On Mon, Oct 28, 2002 at 08:55:36AM -0800, David S. Miller wrote:
>    > Need to go into the revision history, discover who added these
>    > calls, and ask them why they were added.
>    
>    They're in 2.2.20, if it helps...
> 
> That's not so useful, it's the who and why that matters. :-)

Well, that's kind of hard... which revision history?  They were
added at some point during 2.1, before anyone but sparc64 supported
flush_dcache_page, and certainly long before cachetlb.txt was written.
Arguably, cachetlb.txt is the buggy one since it coopted this interface
without reference to the current users.

PA-RISC doesn't use a.out in any way, shape or form, so it doesn't
matter to me, but m68k might like it fixed, i guess.  Why the calls are
there seems fairly straightforward -- we're effectively doing a read()
of the text segment into the process' address space, and we're about to
execute it.

So flush_icache_user_range() seems like the right thing to do there.
Except that cachetlb says it can't cross a page boundary.  Maybe the
right thing to do is to change the definition of flush_icache_range in
cachetlb to indicate that the addresses are user, not kernel, addresses;
remove the flush_icache_range() in kernel/module.c and put a #error into
every arch's module_arch_init() warning them they may need to flush the
range mod to mod->size.

-- 
Revolutions do not require corporate support.
