Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751329AbVJaWTX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751329AbVJaWTX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 17:19:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751330AbVJaWTX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 17:19:23 -0500
Received: from xproxy.gmail.com ([66.249.82.202]:64025 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751329AbVJaWTW convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 17:19:22 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=fY6wtMz8LTZYAjCVQrqnWvKcAOxo0EURyrCO5UUD/3oBmiOjG62OMu4wBILaKwVnjjsQgb8wAMRe/AYZC/jDCd7L+g0333niVw6SZYCyQgc2VgxiN0aM3NHL3KYVq+yUFroZyPnUK/5Dr6Imjz9hbQVM1BKqcwdtou3WJ7hXvks=
Message-ID: <9a8748490510311419o7c4cc615qa7123d7aa124e3df@mail.gmail.com>
Date: Mon, 31 Oct 2005 23:19:21 +0100
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: [PATCH 2/9] mm: arm ready for split ptlock
Cc: Nicolas Pitre <nico@cam.org>, Hugh Dickins <hugh@veritas.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20051026002016.GB25420@flint.arm.linux.org.uk>
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
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/26/05, Russell King <rmk+lkml@arm.linux.org.uk> wrote:
> On Tue, Oct 25, 2005 at 11:00:09AM -0400, Nicolas Pitre wrote:
> > On Tue, 25 Oct 2005, Russell King wrote:
> >
> > > On Mon, Oct 24, 2005 at 10:45:04PM -0400, Nicolas Pitre wrote:
> > > > On Sat, 22 Oct 2005, Russell King wrote:
> > > > > Please contact Nicolas Pitre about that - that was my suggestion,
> > > > > but ISTR apparantly the overhead is too high.
> > > >
> > > > Going through a kernel buffer will simply double the overhead.  Let's
> > > > suppose it should not be a big enough issue to stop the patch from being
> > > > merged though (and it looks cleaner that way). However I'd like for the
> > > > WARN_ON((unsigned long)frame & 7) to remain as both the kernel and user
> > > > buffers should be 64-bit aligned.
> > >
> > > The WARN_ON is pointless because we guarantee that the stack is always
> > > 64-bit aligned on signal handler setup and return.
> >
> > Sure, but the iWMMXt context is stored after the standard sigcontext
> > which also must be 64 bits in size (which might not be always the case
> > if things change in the structure or in its padding).
> >
> > > > I don't see how standard COW could not happen.  The only difference with
> > > > a true write fault as if we used put_user() is that we bypassed the data
> > > > abort vector and the code to get the FAR value.  Or am I missing
> > > > something?
> > >
> > > pte_write() just says that the page _may_ be writable.  It doesn't say
> > > that the MMU is programmed to allow writes.  If pte_dirty() doesn't
> > > return true, that means that the page is _not_ writable from userspace.
> >
> > Argh...  So only suffice to s/pte_write/pte_dirty/ I'd guess?
>
> No.  If we're emulating a cmpxchg() on a clean BSS page, this code
> as it stands today will write to the zero page making it a page which
> is mostly zero.  Bad news when it's mapped into other processes BSS
> pages.
>
> Changing this for pte_dirty() means that we'll refuse to do a cmpxchg()
> on a clean BSS page.  The data may compare correctly, but because it
> isn't already dirty, you'll fail.
>
> If we still had it, I'd say you need to use verify_area() to tell the
> kernel to pre-COW the pages.  However, that got removed a while back.
>

Yes, I removed verify_area() since it was just a wrapper for access_ok().
If verify_area() was/is needed, then access_ok() should be just fine
as a replacement as far as I can see.

--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
