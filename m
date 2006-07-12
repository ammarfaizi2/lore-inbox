Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750866AbWGLIE7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750866AbWGLIE7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 04:04:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750847AbWGLIE6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 04:04:58 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:26520 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750839AbWGLIEs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 04:04:48 -0400
Date: Wed, 12 Jul 2006 09:04:44 +0100
From: Christoph Hellwig <hch@infradead.org>
To: David Miller <davem@davemloft.net>
Cc: bos@serpentine.com, linux-kernel@vger.kernel.org, arjan@infradead.org
Subject: Re: [PATCH] Add memcpy_cachebypass, a copy routine that tries to keep cache pressure down
Message-ID: <20060712080444.GA12498@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	David Miller <davem@davemloft.net>, bos@serpentine.com,
	linux-kernel@vger.kernel.org, arjan@infradead.org
References: <da0cd816c4cb37c4376b.1152651055@localhost.localdomain> <20060711.135729.104381402.davem@davemloft.net> <1152653401.16499.35.camel@chalcedony.pathscale.com> <20060711.145751.77136364.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060711.145751.77136364.davem@davemloft.net>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 11, 2006 at 02:57:51PM -0700, David Miller wrote:
> From: Bryan O'Sullivan <bos@serpentine.com>
> Date: Tue, 11 Jul 2006 14:30:01 -0700
> 
> > The last time I tried submitting a patch that followed that style (for
> > __iowrite_copy*), it got NAKed for propagating preprocessor abuse (Linus
> > roundly flamed someone for a similar patch a few weeks before I
> > submitted mine), and Andrew suggested that I use the same scheme that
> > this patch uses.
> > 
> > So whose instructions do I follow?  Yours of today, or Andrew's and
> > Linus's of a few months ago?
> 
> I didn't realize there was change afoot in this area, sorry.
> I was just striving for consistency with current practice.
> 
> If Andrew suggested to use weak, that's fine, but it's kind
> of erroneous for something like lib/string.c because that
> gets built into a library lib.a file, which resolves any
> unresolved references.
> 
> When the kernel is linked, lib.a implementations only get brought in
> if they are not already resolved by definitions present in the other
> objects of the kernel image.
> 
> Weak makes more sense when dealing with object files, not archives.

Weak is generally the wrong thing for what we do in kernel land.  We don't
even want to build the generic version if we have a better one.  It also
makes it really hard to find out what exactly in use.  Linus only argued
against __ARCH_HAVE_FOO, but his suggested replacemenet is:

#ifndef foo
#define foo	generic_version
#endif
