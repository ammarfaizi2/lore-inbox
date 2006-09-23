Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964914AbWIWUyj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964914AbWIWUyj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Sep 2006 16:54:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964918AbWIWUyj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Sep 2006 16:54:39 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:36314 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S964914AbWIWUyj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Sep 2006 16:54:39 -0400
Date: Sat, 23 Sep 2006 21:54:35 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Linus Torvalds <torvalds@osdl.org>, rolandd@cisco.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] missing includes from infiniband merge
Message-ID: <20060923205434.GO29920@ftp.linux.org.uk>
References: <20060923154416.GH29920@ftp.linux.org.uk> <20060923202912.GA22293@uranus.ravnborg.org> <20060923203605.GN29920@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060923203605.GN29920@ftp.linux.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 23, 2006 at 09:36:05PM +0100, Al Viro wrote:
> On Sat, Sep 23, 2006 at 10:29:12PM +0200, Sam Ravnborg wrote:
> > On Sat, Sep 23, 2006 at 04:44:16PM +0100, Al Viro wrote:
> > > indirect chains of includes are arch-specific and can't
> > > be relied upon...  (hell, even attempt to build it for
> > > itanic would trigger vmalloc.h ones; err.h triggers
> > > on e.g. alpha).
> > > 
> > > Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> > > ---
> > >  drivers/infiniband/core/mad_priv.h           |    1 +
> > >  drivers/infiniband/hw/amso1100/c2_provider.c |    1 +
> > >  drivers/infiniband/hw/amso1100/c2_rnic.c     |    1 +
> > >  drivers/infiniband/hw/ipath/ipath_diag.c     |    1 +
> > >  4 files changed, 4 insertions(+), 0 deletions(-)
> > A better fix would be to avoid the arch dependency in the non-arch .h
> > files so that in most cases it just works??
> 
> What "it"?  Use of vmalloc() without including vmalloc.h since on i386
> it just happens to be pulled via the
> linux/pci.h -> linux/dmapool.h -> asm-i386/io.h -> linux/vmalloc.h
> chain?

BTW, to do what you suggest we would mean the following:

let H(arch,foo) = {bar | asm-arch/foo.h pulls asm-arch/bar.h via chain that
doesn't include linux/*}
let M(arch,foo) = {baz | asm-arch/bar.h includes linux/baz.h for some bar in
H(arch,foo)}
let L(foo) = union of M(arch,foo) by all arch.
make sure that for each arch and for each bar in L(foo) we have asm-arch/foo.h
pulling linux/bar.h

Have fun doing that and maintaining the results.  Note that addition of
include between asm-weird-crap/foo.h and asm-weird-crap/bar.h will require
changes all over the place in asm-*/* - not only for asm-*/foo.h.

It won't be pretty, it will be hell to even try to clean dependencies
_and_ it will break all the time due to ordering requirements.
