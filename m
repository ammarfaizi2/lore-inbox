Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269965AbUJNES3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269965AbUJNES3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Oct 2004 00:18:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269966AbUJNES3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Oct 2004 00:18:29 -0400
Received: from main.gmane.org ([80.91.229.2]:53134 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S269965AbUJNESQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Oct 2004 00:18:16 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Kevin Puetz <puetzk@puetzk.org>
Subject: Re: single linked list header in kernel?
Date: Wed, 13 Oct 2004 23:18:10 -0500
Message-ID: <ckkum3$i0b$1@sea.gmane.org>
References: <416C1F48.4040407@nortelnetworks.com> <pan.2004.10.13.05.50.46.937470@smurf.noris.de> <416D4255.9080501@nortelnetworks.com> <pan.2004.10.13.18.25.41.367757@smurf.noris.de> <20041014001619.GA19436@thundrix.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 12-219-2-179.client.mchsi.com
User-Agent: KNode/0.8.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tonnerre wrote:

> Salut,
> 
> On Wed, Oct 13, 2004 at 08:25:43PM +0200, Matthias Urlichs wrote:
>> I dunno, though -- open-coding a singly-linked list isn't that much of a
>> problem; compared to a doubly-linked one, there's simply fewer things
>> that can go horribly wrong. :-/
> 
> The problem is that
> 
> 1. you have to use circular lists
> 
> 2. going forward is  O(1), going backward is O(N).  This doesn't sound
>    like a problem,  but deleting from lists and  alike requires you to
>    go back in the list.
> 
> I guess  that if  you have lists  that you  edit a lot,  double linked
> lists should be  less overhead. However, if you only  walk the lists a
> lot, both models should perform equally well.
> 
> Insertion is faster, but that's the only good news..
> 
> I'm all against them, though. ;)
> 
> Tonnerre

And of course there's the ever-infamous 'two-half-linked list' (for want of
a better name).  If you really need O(1) access in both directions but the
constant factor isn't terribly important, it *is* (surprisingly) possible
to achieve this without any size overhead in the list elements, though the
code and iterator sizes will be a little higher and the "number of things
that can go horribly wrong will swell impressively". 

Read on only if you a) already know what I have in mind, but want to tell my
I described it wrong or b) genuinely enjoy disgustingly clever trickery, or
c) the previous, plus have some specific need to make an uncorrupted
programmer's head explode. Do NOT read on if you are intending to implement
what I describe, unless you have a damned good reason not to use a sane
doubly-linked list :-)

What you do is take advantage of the fact that when iterating, it's usually
pretty straightforward to make your 'iterator' keep track of of the
previous node as the current one. Then, instead of storing a 'next' pointer
or a 'previous' pointer in the node, you store the two XORed together (or
choose your favorite mixing function, there are many viable choices). Then,
when you are at a node, you can recover the pointer for whichever direction
you are travelling in by XORing the mix from the node with your stored
'previous' pointer, thus giving you whichever neighbor you didn't already
know. Then you can move to the next node (prev=current, current=neighbor)
and do it again. Or just swap prev and current if you want to go the other
direction.

So, you end up with:
O(1) forward and reverse iteration
only 1 pointer of overhead per node

but, you pay for it with:
2 pointers of size for a moveable iterator pointing to a node
an extra fetch (though probably still in a register if you're in a tight
loop) and an XOR for every step along the chain.

