Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267893AbUHTIms@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267893AbUHTIms (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 04:42:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267827AbUHTIk0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 04:40:26 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:8350 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S267893AbUHTIgE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 04:36:04 -0400
Date: Fri, 20 Aug 2004 04:33:34 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Gene Heskett <gene.heskett@verizon.net>, mingo@elte.hu
Cc: linux-kernel@vger.kernel.org, Nick Piggin <nickpiggin@yahoo.com.au>,
       viro@parcelfarce.linux.theplanet.co.uk,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: Possible dcache BUG
Message-ID: <20040820073334.GB8205@logos.cnet>
References: <Pine.LNX.4.44.0408020911300.10100-100000@franklin.wrl.org> <200408190541.14131.gene.heskett@verizon.net> <20040819183643.GA5278@logos.cnet> <200408192238.19567.gene.heskett@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200408192238.19567.gene.heskett@verizon.net>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 19, 2004 at 10:38:19PM -0400, Gene Heskett wrote:
> On Thursday 19 August 2004 14:36, Marcelo Tosatti wrote:
> >Gene,
> >
> >That is:
> >
> >/*
> > * The buffer's backing address_space's private_lock must be held
> > */
> >static inline void __remove_assoc_queue(struct buffer_head *bh)
> >{
> >        BUG_ON(bh->b_assoc_buffers.next == NULL); 			<----------
> >        BUG_ON(bh->b_assoc_buffers.prev == NULL);
> >        list_del_init(&bh->b_assoc_buffers);
> >}
> >
> >Viro, Linus, Andrew, dont you have any idea what could cause such
> > mapping->b_assoc_mapping corruption?
> >
> >I can't see how that could be caused by flaky hardware.
> 
> There is still that possibility Marcelo.  Someone recommended I get 
> cpuburn and memburn, and before fixing the scanf statement (it was 
> broken) in memburn, I had compiled it for a 512 meg test the first 
> time, and a 768 meg test the next couple of runs.
> 
> All exited with errors like this:
> Passed round 133, elapsed 4827.19.
> FAILED at round 134/14208927: got ff00, expected 0!!!
> 
> REREAD: ff00, ff00, ff00!!!
> 
> [root@coyote memburn]# vim memburn.c
> [root@coyote memburn]# gcc -o memburn memburn.c
> [root@coyote memburn]# ./memburn
> Starting test with size 768 megs..
> 
> Passed round 0, elapsed 44.36.
> Passed round 1, elapsed 74.13.
> Passed round 2, elapsed 105.12.
> FAILED at round 3/25777183: got 2b00, expected 0!!!
> 
> REREAD: 2b00, 2b00, 2b00!!!
> 
> I've now rebuilt it with a better printf format string, and its 
> running over 768 megs again.  But this time the round counter is up 
> to 90 and still going...
> 
> Interesting too is that memburn has now allocated a 768 meg wide block 
> 5 times, and still no Oops.  Over a hundred megs in swap, but its 
> still running.
> 
> I lost the BUG_ON patches in fs/buffer.c, this is now 2.6.8.1-mm2 (but 
> I can go back if this fails of course)
> 
> Or can I just copy that 2.6.8-rc4/fs/buffer.c file over this one?

You can just copy it, _I think_. If you have problems just add the BUG_ON's by hand. 

Now Ingo also hit the same problem, Ingo can you reproduce that 
remove_inode_buffers()? 
