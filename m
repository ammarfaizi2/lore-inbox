Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932505AbWAFT4o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932505AbWAFT4o (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 14:56:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932511AbWAFT4o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 14:56:44 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:5538 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S932505AbWAFT4n
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 14:56:43 -0500
Date: Fri, 6 Jan 2006 19:56:31 +0000
From: Al Viro <viro@ftp.linux.org.uk>
To: Zan Lynx <zlynx@acm.org>
Cc: Jens Axboe <axboe@suse.de>, Jesper Juhl <jesper.juhl@gmail.com>,
       Khushil Dep <khushil.dep@help.basilica.co.uk>,
       Luiz Fernando Capitulino <lcapitulino@mandriva.com.br>,
       akpm <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] bio: gcc warning fix.
Message-ID: <20060106195631.GW27946@ftp.linux.org.uk>
References: <8941BE5F6A42CC429DA3BC4189F9D442014FAE@bashdad01.hd.basilica.co.uk> <9a8748490601061041y532cb797u6d106f03625d3daa@mail.gmail.com> <20060106184810.GR3389@suse.de> <1136576037.10342.6.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1136576037.10342.6.camel@localhost>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 06, 2006 at 12:33:56PM -0700, Zan Lynx wrote:
> On Fri, 2006-01-06 at 19:48 +0100, Jens Axboe wrote:
> > On Fri, Jan 06 2006, Jesper Juhl wrote:
> > > gcc is right to warn in the sense that it doesn't know if
> > > bvec_alloc_bs() will read or write into idx when its address is passed
> > 
> > The function is right there, on top of bio_alloc_bioset(). It's even
> > inlined. gcc has absolutely no reason to complain.
> 
> GCC complains because it is possible for that function to return without
> ever setting a value into idx.  It's the "default" case in the switch.
> Of course, if that happens, idx will not be used and so it is not
> actually a problem.

If gcc would look at that code *after* it expands the call, it would
actually notice that everything's fine.  The codepath leaving the
inlined block without setting idx would look like

	bvl = NULL;
	goto l1;
...
l1:
	if (!bvl)
		goto l2;
	use idx
...
l2:
	mempool_free(bio, bs->bio_pool);
	bio = NULL;
	goto out;

and after that exit collapses into jump directly to l2, we end up with
situation when every path to use of idx obviously going through l1 and,
before that, end of switch() in inlined block.  All possible precursors
of that end of switch assign idx.

And yes, if you inline it manually gcc _will_ see that everything's OK.
Path that confuses it is
	default in switch -> exit from bio_alloc_bs() -> l1 -> use of idx
and 
		return value will be NULL	=>	  we will go to l2
is what it doesn't notice when it inlines itself.
