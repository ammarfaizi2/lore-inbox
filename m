Return-Path: <linux-kernel-owner+w=401wt.eu-S1030436AbWLaTJY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030436AbWLaTJY (ORCPT <rfc822;w@1wt.eu>);
	Sun, 31 Dec 2006 14:09:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030438AbWLaTJY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Dec 2006 14:09:24 -0500
Received: from nic.NetDirect.CA ([216.16.235.2]:59265 "EHLO
	rubicon.netdirect.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030436AbWLaTJX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Dec 2006 14:09:23 -0500
X-Originating-Ip: 74.109.98.100
Date: Sun, 31 Dec 2006 14:04:16 -0500 (EST)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@localhost.localdomain
To: Paul Mundt <lethal@linux-sh.org>
cc: Arjan van de Ven <arjan@infradead.org>,
       Denis Vlasenko <vda.linux@googlemail.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: replace "memset(...,0,PAGE_SIZE)" calls with "clear_page()"?
In-Reply-To: <20061231183949.GA8323@linux-sh.org>
Message-ID: <Pine.LNX.4.64.0612311355520.17978@localhost.localdomain>
References: <Pine.LNX.4.64.0612290106550.4023@localhost.localdomain>
 <200612302149.35752.vda.linux@googlemail.com>
 <Pine.LNX.4.64.0612301705250.16056@localhost.localdomain>
 <1167518748.20929.578.camel@laptopd505.fenrus.org>
 <Pine.LNX.4.64.0612301750550.16519@localhost.localdomain>
 <20061231183949.GA8323@linux-sh.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Net-Direct-Inc-MailScanner-Information: Please contact the ISP for more information
X-Net-Direct-Inc-MailScanner: Found to be clean
X-Net-Direct-Inc-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,
	score=-16.8, required 5, autolearn=not spam, ALL_TRUSTED -1.80,
	BAYES_00 -15.00)
X-Net-Direct-Inc-MailScanner-From: rpjday@mindspring.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 1 Jan 2007, Paul Mundt wrote:

> On Sat, Dec 30, 2006 at 06:04:14PM -0500, Robert P. J. Day wrote:
> > fair enough.  *technically*, not every call of the form
> > "memset(ptr,0,PAGE_SIZE)" necessarily represents an address that's on
> > a page boundary.  but, *realistically*, i'm guessing most of them do.
> > just grabbing a random example from some grep output:
> >
> > arch/sh/mm/init.c:
> >   ...
> >   /* clear the zero-page */
> >   memset(empty_zero_page, 0, PAGE_SIZE);
> >   ...
> >
> The problem with random grepping is that it doesn't give you any
> context. clear_page() isn't available in this case since we have a
> couple of different ways of implementing it, and the optimal
> approach is selected later on. There are also additional assumptions
> regarding alignment that don't allow clear_page() to be used
> directly as replacement for the memset() callsites (as has already
> been pointed out for some of the other architectures). While the
> empty_zero_page in this case sits on a full page boundary, others do
> not.
>
> You might find some places in drivers that do this where you might
> be able to optimize things slightly with a clear_page() (or
> copy_page() in the memcpy() case), but it's going to need a lot of
> manual auditing rather than a find and replace. Any sort of wins you
> get out of this would be marginal at best, anyways.
>
> The more interesting case would be page clustering/bulk page
> clearing with offload engines, and there's certainly room to build
> on the SGI patches for this.

your point is well taken -- i wasn't trying to suggest that a blind
cut-and-replace would be appropriate, only that there were an awful
lot of places where it wasn't clear that that kind of replacement
*wasn't* appropriate.  or perhaps even recommended.  (doing that kind
of search in the drivers/ directory would perhaps be more meaningful
than in the arch/ directory.  just my luck i picked a bad example.)

clearly, that kind of replacement might require manual intervention in
a lot of cases, no question.  as with other examples i've brought up
here, i'm just looking at this from a relatively newbie perspective,
where i'm perusing the code and, in this case, got to thinking, "gee,
given that every architecture defines a clear_page() macro, i wonder
why all these people keep calling memset()."  that's all.

kind of like how, given that include/linux/gfp.h defines the macro
__get_dma_pages(), so many people persist in calling
__get_free_pages() with a GFP_DMA setting.  that sort of thing.  :-)

rday
