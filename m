Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265373AbRF0TRb>; Wed, 27 Jun 2001 15:17:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265379AbRF0TRU>; Wed, 27 Jun 2001 15:17:20 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:64786 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S265373AbRF0TRO>; Wed, 27 Jun 2001 15:17:14 -0400
Date: Wed, 27 Jun 2001 14:43:57 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Chris Mason <mason@suse.com>
Cc: Xuan Baldauf <xuan--lkml@baldauf.org>, linux-kernel@vger.kernel.org,
        andrea@suse.de,
        "reiserfs-list@namesys.com" <reiserfs-list@namesys.com>
Subject: Re: VM deadlock
In-Reply-To: <822790000.993654598@tiny>
Message-ID: <Pine.LNX.4.21.0106271440150.1745-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 27 Jun 2001, Chris Mason wrote:

> 
> 
> On Wednesday, June 27, 2001 04:27:45 PM +0200 Xuan Baldauf <xuan--lkml@baldauf.org> wrote:
> 
> > My linux box suddenly was not availbale using ssh|telnet,
> > but it responded to pings. On console login, I could type
> > "root", but after pressing "return", there was no reaction,
> > and pressing keys did not result in writing them on the
> > screen.
> 
> > Warning (Oops_read): Code line not seen, dumping what data
> > is available
> > 
> >>> EIP; c012839c <deactivate_page+e94/2618>   <=====
> > Trace; c0128ef5 <deactivate_page+19ed/2618>
> > Trace; c012905e <deactivate_page+1b56/2618>
> > Trace; c0129d05 <__alloc_pages+1cd/280>
> > Trace; c0129b36 <_alloc_pages+16/18>
> > Trace; c012a425 <free_pages+611/1cac>
> > Trace; c0120198 <vmtruncate+1c4/878>
> > Trace; c01201f5 <vmtruncate+221/878>
> > Trace; c0120550 <vmtruncate+57c/878>
> 
> > I had a probably similar|connected problem (but with no
> > "ping" responding) with linux-2.4.5-pre3, described here:
> > http://lists.omnipotent.net/reiserfs/200106/msg00214.html
> > 
> > Linux router 2.4.6-pre5 #3 Tue Jun 26 23:36:26 CEST 2001
> 
> Sounds like a deadlock andrea recently found.

Chris,

Looking at http://lists.omnipotent.net/reiserfs/200106/msg00214.html:

>>EIP; c0128228 <page_launder+b8/90c>   <=====
Trace; c01303df <refill_freelist+1f/54>
Trace; c01307e2 <getblk+f2/108>
Trace; c5141308 <END_OF_CODE+4e978b8/????>
Trace; c0176c4b <do_journal_end+63f/ac0>
Trace; c5160848 <END_OF_CODE+4eb6df8/????>
Trace; c01759e6 <journal_end_sync+16/1c>
Trace; c015e23a <reiserfs_write_inode+56/64>
Trace; c0141055 <try_to_sync_unused_inodes+101/1a8>
Trace; c01416dd <prune_icache+105/114>
Trace; c014170d <shrink_icache_memory+21/30>
Trace; c0128d67 <do_try_to_free_pages+2b/58>
Trace; c0128deb <kswapd+57/e4>
Trace; c0105434 <kernel_thread+28/38>



refill_freelist() calls page_launder(GFP_BUFFER). Now GFP_BUFFER _will_
block writting out buffers with try_to_free_buffers().

Maybe thats the reason for the deadlock we're seeing here at this specific
trace ? 


