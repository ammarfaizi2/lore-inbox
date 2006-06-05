Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1750987AbWFEVgr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750987AbWFEVgr (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 5 Jun 2006 17:36:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751006AbWFEVgr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jun 2006 17:36:47 -0400
Received: from quickstop.soohrt.org ([85.131.246.152]:20096 "EHLO
	quickstop.soohrt.org") by vger.kernel.org with ESMTP
	id S1750987AbWFEVgq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jun 2006 17:36:46 -0400
Date: Mon, 5 Jun 2006 23:36:45 +0200
From: Horst Schirmeier <horst@schirmeier.com>
To: Eric Sesterhenn <snakebyte@gmx.de>
Cc: LKML <linux-kernel@vger.kernel.org>, bdirks@pacbell.net
Subject: Re: [Patch] Zoran strncpy() cleanup
Message-ID: <20060605213645.GO7236@quickstop.soohrt.org>
Mail-Followup-To: Eric Sesterhenn <snakebyte@gmx.de>,
	LKML <linux-kernel@vger.kernel.org>, bdirks@pacbell.net
References: <1149538357.16994.7.camel@alice> <20060605210230.GN7236@quickstop.soohrt.org> <1149542155.17537.3.camel@alice>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1149542155.17537.3.camel@alice>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 05 Jun 2006, Eric Sesterhenn wrote:
> On Mon, 2006-06-05 at 23:02 +0200, Horst Schirmeier wrote:
> > On Mon, 05 Jun 2006, Eric Sesterhenn wrote:
> > > hi,
> > > 
> > > this was spotted by coverity ( bug id #536 ). While
> > > it is not really a bug, i think we should clean it up.
> > > std->name can only hold 24 chars, not 32 as the strncpy() calls
> > > suggest. std->name can hold 32 chars, but since we use constant
> > > fixed-sized strings, which will always fit into these arrays, i changed
> > > the strncpy() calls to strcpy(). If you prefer strncpy(foo->name, "bar", sizeof(foo->name))
> > > please let me know and i redo the patch.
> > > 
> > > Signed-off-by: Eric Sesterhenn <snakebyte@gmx.de>
> > 
> > This _is_ really a bug. strncpy() pads the remaining bytes of dest with
> > zeroes, which destroys parts of the v4l2_standard structure (in
> > particular, the v4l2_fract substructure). I'd suggest not to use
> > strcpy() although it's safe here -- until someone changes the structure
> > sizes.
> 
> Thanks for the fast reply, here is an updated version.
> This patch changes all strncpy() calls to use sizeof(foo)-1 as the
> last parameter.

Problem is, the strings are (possibly) still not zero-terminated:
strncpy() only appends zeroes if src contents are short enough; if they
are not, dest is only zero-terminated if dest[sizeof(dest)-1] was zero
before.
strlcpy() semantics promise more sanity; dest is always zero-terminated
(if its size is >= 1), and the size parameter holds total dest size.
(See lib/string.c for more details.)

Kind regards,
 Horst

-- 
PGP-Key 0xD40E0E7A
