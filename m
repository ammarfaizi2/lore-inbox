Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262080AbTIDIXL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 04:23:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264782AbTIDIXL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 04:23:11 -0400
Received: from verein.lst.de ([212.34.189.10]:22475 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S262080AbTIDIXH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 04:23:07 -0400
Date: Thu, 4 Sep 2003 10:22:35 +0200
From: Christoph Hellwig <hch@lst.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: "David S. Miller" <davem@redhat.com>, paulus@samba.org,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fix ppc ioremap prototype
Message-ID: <20030904082235.GA15159@lst.de>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>,
	Linus Torvalds <torvalds@osdl.org>,
	"David S. Miller" <davem@redhat.com>, paulus@samba.org,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20030904010940.5fa0e560.davem@redhat.com> <Pine.LNX.4.44.0309040111290.20151-100000@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0309040111290.20151-100000@home.osdl.org>
User-Agent: Mutt/1.3.28i
X-Spam-Score: -5 () EMAIL_ATTRIBUTION,IN_REP_TO,QUOTED_EMAIL_TEXT,REFERENCES,REPLY_WITH_QUOTES,USER_AGENT_MUTT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 04, 2003 at 01:12:28AM -0700, Linus Torvalds wrote:
> 
> On Thu, 4 Sep 2003, David S. Miller wrote:
> > 
> > My suggestion is to just pass a resource and an offset to ioremap().
> 
> Actually, my suggestion right now is to ignore the issue, and let the 
> current ppc440x code stand as-is. After all, it works, and it does what 
> the ppc people want. We may at some point switch over _all_ ioremap users, 
> but there is no real reason to do so right now.

So how should it work?  What basically all drivers to curretnly is
to have a unsigned long they get from pci_resource_start and pass it
to ioremap(), e.g. in tg3.c:

	unsigned long tg3reg_base, tg3reg_len;

	...

	tg3reg_base = pci_resource_start(pdev, 0);

	...

	tp->regs = (unsigned long) ioremap(tg3reg_base, tg3reg_len);

with the ppc4xx code you'd have to change the unsigned long to
a phys_addr_t to actually work with the high io addresses, which doesn't
exist on the other architectures.

Given that patch must make any sense (which I don't know as no one
even tried to explain it!) the pci code on ppc4xx doesn't actually use
the high bits of phys_addr_t.  But then this whole change to ioremap
doesn't make any sense and those arch-specific drivers should just use
a ioremap64 variant which seems to be present on ppc44x aswell..

