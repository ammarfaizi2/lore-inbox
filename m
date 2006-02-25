Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932401AbWBYGvj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932401AbWBYGvj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Feb 2006 01:51:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932406AbWBYGvi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Feb 2006 01:51:38 -0500
Received: from dsl093-016-182.msp1.dsl.speakeasy.net ([66.93.16.182]:45739
	"EHLO cinder.waste.org") by vger.kernel.org with ESMTP
	id S932401AbWBYGvi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Feb 2006 01:51:38 -0500
Date: Sat, 25 Feb 2006 00:51:36 -0600
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/7] inflate pt1: clean up input logic
Message-ID: <20060225065136.GH13116@waste.org>
References: <0.399206195@selenic.com> <4.399206195@selenic.com> <20060224221909.GD28855@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060224221909.GD28855@flint.arm.linux.org.uk>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 24, 2006 at 10:19:09PM +0000, Russell King wrote:
> On Fri, Feb 24, 2006 at 02:12:16PM -0600, Matt Mackall wrote:
> > -static const u16 mask_bits[] = {
> > -	0x0000,
> > -	0x0001, 0x0003, 0x0007, 0x000f, 0x001f, 0x003f, 0x007f, 0x00ff,
> > -	0x01ff, 0x03ff, 0x07ff, 0x0fff, 0x1fff, 0x3fff, 0x7fff, 0xffff
> > -};
> > +static inline u32 readbits(u32 *b, u32 *k, int n)
> > +{
> > +	for( ; *k < n; *k += 8)
> > +		*b |= (u32)get_byte() << *k;
> > +	return *b & ((1 << n) - 1);
> > +}
> >  
> > -#define NEXTBYTE()  ({ int v = get_byte(); if (v < 0) goto underrun; (u8)v; })
> 
> How does this change handle the case where we run out of input data?
> This condition needs to be handled explicitly because the inflate
> functions can infinitely loop.

And if you look at the current users, you'll see that only two of 15
actually use it.

> Relying on a bit pattern returned by get_byte() is how this code
> pre-fix used to work, and it caused several confused bug reports.

Just about everywhere, get_byte prints an error message and halts. In
the final refactoring, get_byte goes away and is replaced by a
->fill() method that's only called when the input buffer is emptied,
rather than byte by byte. Most of the users leave this null (since
they have the entire contents in memory already), which will give us a
nice oops. I can add another patch in the next batch that makes an
attempt to call a null ->fill instead do ->error("gunzip underrun").

-- 
Mathematics is the supreme nostalgia of our time.
