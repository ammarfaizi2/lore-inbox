Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964803AbVJaWem@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964803AbVJaWem (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 17:34:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932340AbVJaWem
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 17:34:42 -0500
Received: from xproxy.gmail.com ([66.249.82.197]:61091 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932166AbVJaWel convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 17:34:41 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=QMO1ECV6/MGHQK0ewuAHgoNLmnnshygoPZYiax3T48gvV0i2juxDpQk5VDkJRcJa19DHwZ0tuU5m6SCM4NEwTF1ZBW5WMZnguDZU7cuD9eQnEPbCE7gvxXJmmIi9+daTlaLYeAdhbvaYHac20o+xHZv0rhBhVP3Mwkbg91c8rLQ=
Message-ID: <9a8748490510311434m1803851bpad0225feff037e6b@mail.gmail.com>
Date: Mon, 31 Oct 2005 23:34:39 +0100
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: [PATCH 2/9] mm: arm ready for split ptlock
Cc: Jesper Juhl <jesper.juhl@gmail.com>, Nicolas Pitre <nico@cam.org>,
       Hugh Dickins <hugh@veritas.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20051031222731.GE20452@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <Pine.LNX.4.61.0510221716380.18047@goblin.wat.veritas.com>
	 <Pine.LNX.4.61.0510221719370.18047@goblin.wat.veritas.com>
	 <20051022170240.GA10631@flint.arm.linux.org.uk>
	 <Pine.LNX.4.64.0510241922040.5288@localhost.localdomain>
	 <20051025075555.GA25020@flint.arm.linux.org.uk>
	 <Pine.LNX.4.64.0510251056380.5288@localhost.localdomain>
	 <20051026002016.GB25420@flint.arm.linux.org.uk>
	 <9a8748490510311419o7c4cc615qa7123d7aa124e3df@mail.gmail.com>
	 <20051031222731.GE20452@flint.arm.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/31/05, Russell King <rmk+lkml@arm.linux.org.uk> wrote:
> On Mon, Oct 31, 2005 at 11:19:21PM +0100, Jesper Juhl wrote:
> > On 10/26/05, Russell King <rmk+lkml@arm.linux.org.uk> wrote:
> > > No.  If we're emulating a cmpxchg() on a clean BSS page, this code
> > > as it stands today will write to the zero page making it a page which
> > > is mostly zero.  Bad news when it's mapped into other processes BSS
> > > pages.
> > >
> > > Changing this for pte_dirty() means that we'll refuse to do a cmpxchg()
> > > on a clean BSS page.  The data may compare correctly, but because it
> > > isn't already dirty, you'll fail.
> > >
> > > If we still had it, I'd say you need to use verify_area() to tell the
> > > kernel to pre-COW the pages.  However, that got removed a while back.
> > >
> >
> > Yes, I removed verify_area() since it was just a wrapper for access_ok().
> > If verify_area() was/is needed, then access_ok() should be just fine
> > as a replacement as far as I can see.
>
> Except verify_area() would pre-fault the pages in whereas access_ok()
> just verifies that the address is a user page.  That's quite important
> in this case because in order to fault the page in, we need to use
> put_user() to get the permission checking correct.
>
> However, we can't use put_user() because then the cmpxchg emulation
> becomes completely non-atomic.
>
Colour me stupid, but I don't see how that can be.

Looking at verify_area() from 2.6.13 - the arm version (
http://sosdg.org/~coywolf/lxr/source/include/asm-arm/uaccess.h?v=2.6.13#L81
) :

static inline int __deprecated verify_area(int type, const void __user
*addr, unsigned long size)
{
        return access_ok(type, addr, size) ? 0 : -EFAULT;
}

How will this cause pre-faulting if a call to access_ok() will not?
Please enlighten me.


--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
