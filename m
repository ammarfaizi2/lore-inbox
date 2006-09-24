Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751055AbWIXTTV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751055AbWIXTTV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Sep 2006 15:19:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751103AbWIXTTV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Sep 2006 15:19:21 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:47033 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1751055AbWIXTTU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Sep 2006 15:19:20 -0400
Date: Sun, 24 Sep 2006 20:19:17 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Linus Torvalds <torvalds@osdl.org>, rolandd@cisco.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] missing includes from infiniband merge
Message-ID: <20060924191917.GQ29920@ftp.linux.org.uk>
References: <20060923154416.GH29920@ftp.linux.org.uk> <20060923202912.GA22293@uranus.ravnborg.org> <20060923203605.GN29920@ftp.linux.org.uk> <20060924064446.GA13320@uranus.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060924064446.GA13320@uranus.ravnborg.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 24, 2006 at 08:44:47AM +0200, Sam Ravnborg wrote:
> On Sat, Sep 23, 2006 at 09:36:05PM +0100, Al Viro wrote:
> > > A better fix would be to avoid the arch dependency in the non-arch .h
> > > files so that in most cases it just works??
> > 
> > What "it"?  Use of vmalloc() without including vmalloc.h since on i386
> > it just happens to be pulled via the
> > linux/pci.h -> linux/dmapool.h -> asm-i386/io.h -> linux/vmalloc.h
> > chain?
> The other way around. Try to get rid of the evil includes in arch-$(ASM)
> that is just sitting there for no other purpose than to let a developer skip
> a single include.
> In this case the right fix IMO would have been to kill the include of
> linux/vmalloc.h from asm-i386/io.h and let all users that previously failed
> to include vmalloc.h now do so themself.

> Looking through asm-i386/io.h at fist look there is zero use of
> linux/vmalloc.h so the include has no business there.

There are obvious asm/page.h uses, so just ripping it out won't be enough.
Even for that particular case.  And we have shitloads of places were
asm-foo/bar.h genuinely needs linux/baz.h for e.g. implementation of
an inlined helper.  With other targets not needing it at all.  Would you
mandate including it from every user of asm/foo.h?  And maintain such
rules afterwards ("asm/foo.h needs linux/baz.h included before it since
on $WEIRD_TARGET we include asm/unique_turd.h that won't compile unless
linux/baz.h will be aready there").
