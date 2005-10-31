Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964802AbVJaW1i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964802AbVJaW1i (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 17:27:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964801AbVJaW1i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 17:27:38 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:44298 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S964803AbVJaW1h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 17:27:37 -0500
Date: Mon, 31 Oct 2005 22:27:31 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: Nicolas Pitre <nico@cam.org>, Hugh Dickins <hugh@veritas.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/9] mm: arm ready for split ptlock
Message-ID: <20051031222731.GE20452@flint.arm.linux.org.uk>
Mail-Followup-To: Jesper Juhl <jesper.juhl@gmail.com>,
	Nicolas Pitre <nico@cam.org>, Hugh Dickins <hugh@veritas.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.61.0510221716380.18047@goblin.wat.veritas.com> <Pine.LNX.4.61.0510221719370.18047@goblin.wat.veritas.com> <20051022170240.GA10631@flint.arm.linux.org.uk> <Pine.LNX.4.64.0510241922040.5288@localhost.localdomain> <20051025075555.GA25020@flint.arm.linux.org.uk> <Pine.LNX.4.64.0510251056380.5288@localhost.localdomain> <20051026002016.GB25420@flint.arm.linux.org.uk> <9a8748490510311419o7c4cc615qa7123d7aa124e3df@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a8748490510311419o7c4cc615qa7123d7aa124e3df@mail.gmail.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 31, 2005 at 11:19:21PM +0100, Jesper Juhl wrote:
> On 10/26/05, Russell King <rmk+lkml@arm.linux.org.uk> wrote:
> > No.  If we're emulating a cmpxchg() on a clean BSS page, this code
> > as it stands today will write to the zero page making it a page which
> > is mostly zero.  Bad news when it's mapped into other processes BSS
> > pages.
> >
> > Changing this for pte_dirty() means that we'll refuse to do a cmpxchg()
> > on a clean BSS page.  The data may compare correctly, but because it
> > isn't already dirty, you'll fail.
> >
> > If we still had it, I'd say you need to use verify_area() to tell the
> > kernel to pre-COW the pages.  However, that got removed a while back.
> >
> 
> Yes, I removed verify_area() since it was just a wrapper for access_ok().
> If verify_area() was/is needed, then access_ok() should be just fine
> as a replacement as far as I can see.

Except verify_area() would pre-fault the pages in whereas access_ok()
just verifies that the address is a user page.  That's quite important
in this case because in order to fault the page in, we need to use
put_user() to get the permission checking correct.

However, we can't use put_user() because then the cmpxchg emulation
becomes completely non-atomic.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
