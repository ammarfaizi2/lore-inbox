Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261275AbUKBSXz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261275AbUKBSXz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 13:23:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261286AbUKBSXz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 13:23:55 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:44976 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261275AbUKBSXk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 13:23:40 -0500
Date: Tue, 2 Nov 2004 13:26:29 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Pierre Ossman <drzeus-list@drzeus.cx>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: __GFP flags and kmalloc failures
Message-ID: <20041102152629.GH32054@logos.cnet>
References: <4187AC80.6050409@drzeus.cx> <20041102144429.GG32054@logos.cnet> <4187CB93.6080405@drzeus.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4187CB93.6080405@drzeus.cx>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 02, 2004 at 07:01:55PM +0100, Pierre Ossman wrote:
> Marcelo Tosatti wrote:
> 
> >On Tue, Nov 02, 2004 at 04:49:20PM +0100, Pierre Ossman wrote:
> > 
> >
> >>
> >>The problem is now that this allocation doesn't always succeed. When it 
> >>fails I get:
> >>
> >>insmod: page allocation failure. order:4, mode:0x11
> >>   
> >>
> >
> >This is a big allocation and the kernel is having problem finding such a 
> >big page, due to memory fragmentation (as you mention below).
> >
> >What kernel version are you using?
> > 
> >
> I'm currently running 2.6.9. No external patches (except for my own 
> stuff related to this driver).
> 
> >-mm contains a series of patches from Nick which should make the situation 
> >better, have you tried it? Currently kswapd doenst honour high order 
> >page shortage.
> >
> > 
> >
> No I haven't. Only saw it today and I usually don't use the -mm tree. 
> I've gotten the impression it's a bit too bleeding edge for me ;)
> What do these patches add to the mix?

They make kswapd free pages when high order allocations fail. 

> I'm also not familiar what the order means. I guess it's some kind of 
> priority system? Is there a way I can raise my priority to get access to 
> the memory that kswapd actually keeps available?

order indicates the order which 2 will be elevated, to indicate how many
physical pages this "high order page" is, in size.

"2 ^ 0" = 1 page, order 0 , "2 ^ 1" = 2 pages, order 1,
 "2 ^ 2" = 4 pages, order 2 and so on.
> 
> >>As for solutions I've tried using __GFP_REPEAT which seems to do the 
> >>trick. But the double underscore indicates (at least to me) that these 
> >>are internal defines that shouldn't be used except for very special 
> >>cases. What is the policy about these?
> >>   
> >>
> >
> >Its OK to use these flags externally. They might change in future major 
> >kernel
> >versions though, or even future v2.6 release.  ie its not a stable API.
> > 
> >
> Is there any other way of increasing the chances of actually getting the 
> pages I need? Since it is DMA it needs to be one big block.

__GFP_NOFAIL, from gfp.h:

 * Action modifiers - doesn't change the zoning
 *
 * __GFP_REPEAT: Try hard to allocate the memory, but the allocation attempt
 * _might_ fail.  This depends upon the particular VM implementation.
 *
 * __GFP_NOFAIL: The VM implementation _must_ retry infinitely: the caller
 * cannot handle allocation failures.
 *
 * __GFP_NORETRY: The VM implementation must not retry indefinitely.
 */

