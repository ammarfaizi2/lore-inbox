Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965379AbWHOQHK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965379AbWHOQHK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 12:07:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965380AbWHOQHK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 12:07:10 -0400
Received: from cantor2.suse.de ([195.135.220.15]:60044 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S965379AbWHOQHI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 12:07:08 -0400
Date: Tue, 15 Aug 2006 18:06:57 +0200
From: Karsten Keil <kkeil@suse.de>
To: linux-kernel@vger.kernel.org, isdn4linux@listserv.isdn4linux.de
Cc: Jesper Juhl <jesper.juhl@gmail.com>, David Miller <davem@davemloft.net>
Subject: Re: [PATCH] ISDN: fix double free bug in isdn_net
Message-ID: <20060815160657.GA14266@pingi.kke.suse.de>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	isdn4linux@listserv.isdn4linux.de,
	Jesper Juhl <jesper.juhl@gmail.com>,
	David Miller <davem@davemloft.net>
References: <200608122248.22639.jesper.juhl@gmail.com> <20060815.020004.76775981.davem@davemloft.net> <9a8748490608150208v4e8b7dccl6dd501a6f2cda4fc@mail.gmail.com> <20060815.021503.71555009.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060815.021503.71555009.davem@davemloft.net>
Organization: SuSE Linux AG
X-Operating-System: Linux 2.6.16.21-0.13-smp x86_64
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 15, 2006 at 02:15:03AM -0700, David Miller wrote:
> From: "Jesper Juhl" <jesper.juhl@gmail.com>
> Date: Tue, 15 Aug 2006 11:08:35 +0200
> 
> > Hmm, perhaps I made a mistake and missed a path. Maybe it would be
> > better to fix if by making isdn_writebuf_skb_stub() always set the skb
> > to NULL when it does free it. That would add a few more assignments
> > but should ensure the right result always.
> > What do you say?
> 
> Do we know if the ->writebuf_skb() method ever frees the skb?  If it
> never does, then yes your suggestion would be one way to handle this.


It does if it consumes the skb (then it returns skb->len).
But the skb have not to be freed imediately in this case, it maybe
queued or used until all bytes are written to the physical device.

If it returns any other value the skb is not freed.

This logic came from using skb for transparent data too.
Here it was possible, that the hw driver only take some bytes from the
skb (so it returns < skb->len), then the isdn layer should requeue
the skb so no transparent data get lost.

But this mechanism was never used in drivers, only 3 states:

The driver accept the packet then it is responsible for the skb
and return skb->len or the driver do not accept it (e.g. buffer full,
conntection is going down), then it return 0 and does not free the
skb.

If some internal error in the HW driver occur, it should return a
negative value and it also do not free the skb.
 
-- 
Karsten Keil
SuSE Labs
ISDN development
