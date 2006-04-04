Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751045AbWDDNne@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751045AbWDDNne (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Apr 2006 09:43:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964808AbWDDNne
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Apr 2006 09:43:34 -0400
Received: from cantor2.suse.de ([195.135.220.15]:32912 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751045AbWDDNnd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Apr 2006 09:43:33 -0400
From: Andreas Gruenbacher <agruen@suse.de>
Organization: Novell, SUSE Labs
To: Andrew Morton <akpm@osdl.org>, Dave Jones <davej@redhat.com>,
       Paul Fulghum <paulkf@microgate.com>
Subject: Re: yet more slab corruption.
Date: Tue, 4 Apr 2006 15:44:01 +0200
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org
References: <20060307235940.GA16843@redhat.com> <20060307231414.34c3b3a4.akpm@osdl.org>
In-Reply-To: <20060307231414.34c3b3a4.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604041544.01656.agruen@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, 08 March 2006 08:14, Andrew Morton wrote:
> Dave Jones <davej@redhat.com> wrote:
> > Garg. Is there no end to these ?
> > That kernel is based off 2.6.16rc5-git8
> >
> > This brings the current count up to 8 different patterns filed
> > against our 2.6.16rc tree in Fedora bugzilla.
> > (One of them doesn't count as it's against the out-of-tree bcm43xx
> > driver).

We have two similar bug reports to 
https://bugzilla.redhat.com/bugzilla/184310, slab corruption in an object 
freed by release_mem:

	https://bugzilla.novell.com/151111 (i386)
	https://bugzilla.novell.com/154601 (x86_64)

So this bug seems to trigger on different architectures, and with different 
hardware.

> A use-after-free on size-2048.  We wrote -1L and 0L apparently 0x6b8 bytes
> into the object.  That's an awfully large offset for tty_struct - off the
> end.  Sometimes the buffer was used as skb data too.

I don't know about offset 0x6b8: 0x6b is POISON_FREE in mm/slab.c, so this is 
probably a misread. I think the correct offset is 0xbc. Bug 151111 has the 
corruption at the same offset. On x86_64, the offset is 0x124. This seems to 
be tty_struct->winsize in all cases, even though I can't tell for sure for 
most of the reports anymore.

So this could be a tty_struct locking bug -- it's surprising that we are also 
seeing filesystem corruption, but only in some cases. There was a recent 
locking fix in this area by Paul Fulghum <paulkf@microgate.com> from Feb 15 
which might be related, but the fix looks good to me: 
http://www.kernel.org/hg/linux-2.6/?cs=623e3c38a511.

> Unless it was a DMA scribble, CONFIG_DEBUG_PAGEALLOC should catch this.

This didn't trigger anything in an overnight run. Any further ideas?

Thanks,
Andreas

-- 
Andreas Gruenbacher <agruen@suse.de>
Novell / SUSE Labs
