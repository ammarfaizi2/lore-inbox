Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267656AbUJTPMi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267656AbUJTPMi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 11:12:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267686AbUJTPIp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 11:08:45 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:23943 "EHLO
	MTVMIME03.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S266679AbUJTPBw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 11:01:52 -0400
Date: Wed, 20 Oct 2004 16:01:30 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Mikael Starvik <mikael.starvik@axis.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9 PageAnon bug
In-Reply-To: <BFECAF9E178F144FAEF2BF4CE739C66818F59A@exmail1.se.axis.com>
Message-ID: <Pine.LNX.4.44.0410201542140.9192-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Oct 2004, Mikael Starvik wrote:

> There is at least one architecture supported by 2.6.9 that has no alignment
> restrictions what so ever and no struct padding added by the compiler. 

Ah, sorry for messing CRIS up, I was unaware of that.

> The patch named "rmaplock: PageAnon in mapping" in 2.6.9 doesn't work for
> this architecture because it assumes that the address of a member in a
> struct can't be odd. 

Yes.

> One possible but ugly patch below.

I don't think that's ugly, and the comment is good.
It only actually needs "aligned(2)", would that be better?

But what does "aligned(2)" or "aligned(4)" do on 64-bit machines -
any danger of it aligning stupidly?  I think not, but know little.

> Another possible patch would be to move i_data above i_bytes and i_sock.

Really?  Precarious, I think you'd still need to insist on alignment.

> I would really like a cleaner patch but I
> guess its a bad idea to add a new field to struct page?

You guessed right!

Hugh

> Index: fs.h
> ===================================================================
> RCS file: /usr/local/cvs/linux/os/lx25/include/linux/fs.h,v
> retrieving revision 1.20
> retrieving revision 1.21
> diff -r1.20 -r1.21
> 449c449,453
> < 	struct address_space	i_data;
> ---
> > 	/* The LSB in i_data below is used for the PAGE_MAPPING_ANON flag. 
> > 	 * This assumes that the address of this member isn't odd which
> > 	 * is not true for all architectures. Force the compiler to align
> it.
> > 	 */
> > 	struct address_space	i_data __attribute__ ((aligned(4)));
> 
> Anyone who knows about similar usage of bit 0 and/or 1 in pointers
> anywhere?
> 
> /Mikael 
> 
> PS. The architecture I'm referring to is CRIS but there may be more with the
> same sloppyness regarding alignment. DS

