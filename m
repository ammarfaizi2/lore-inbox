Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263178AbUABC6Q (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jan 2004 21:58:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263260AbUABC6Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jan 2004 21:58:16 -0500
Received: from havoc.gtf.org ([63.247.75.124]:31424 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S263178AbUABC6H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jan 2004 21:58:07 -0500
Date: Thu, 1 Jan 2004 21:58:07 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: "David S. Miller" <davem@redhat.com>
Cc: benh@kernel.crashing.org, linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: Problem with dev_kfree_skb_any() in 2.6.0
Message-ID: <20040102025807.GB3851@gtf.org>
References: <1072567054.4112.14.camel@gaston> <20031227170755.4990419b.davem@redhat.com> <3FF0FA6A.8000904@pobox.com> <20031229205157.4c631f28.davem@redhat.com> <20031230051519.GA6916@gtf.org> <20031229220122.30078657.davem@redhat.com> <3FF11745.4060705@pobox.com> <20031229221345.31c8c763.davem@redhat.com> <3FF1B939.1090108@pobox.com> <20040101124218.258e8b73.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040101124218.258e8b73.davem@redhat.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 01, 2004 at 12:42:18PM -0800, David S. Miller wrote:
> On Tue, 30 Dec 2003 12:43:21 -0500
> Jeff Garzik <jgarzik@pobox.com> wrote:
> 
> > Luckily, I feel there is an easy solution, as shown in the attached 
> > patch.  We _already_ queue skbs in dev_kfree_skb_irq().  Therefore, 
> > dev_kfree_skb_any() can simply use precisely that same solution.  The 
> > raise-softirq code will immediately proceed to action if we are not in 
> > hard IRQ context, otherwise it will follow the expected path.
> 
> Ok, this is reasonable and works.
> 
> Though, is there any particular reason you don't like adding a
> "|| irqs_disabled()" check to the if statement instead?
> I prefer that solution better actually.

Yep, in fact when I wrote the above message, I came across a couple when I
was pondering...
* the destructor runs in a more predictable context.
* given the problem that started this thread, the 'if' test is a
  potentially problematic area.  Why not eliminate all possibility that
  this problem will occur again?

The only counter argument to this -- to which I have no data to answer --
is that there may be advantage to calling __kfree_skb immediately
instead of deferring it slightly.  I didn't think that disadvantage
outweighted the above, but who knows...  I can possibly be convinced
otherwise.  (and "otherwise" would be using || irqs_disabled())

For the users who don't know/don't care about their context, it just
seemed to me that they were not a hot path like users of dev_kfree_skb()
and dev_kfree_skb_irq() [unconditional] are...

	Jeff



