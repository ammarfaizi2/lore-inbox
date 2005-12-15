Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161138AbVLOFyf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161138AbVLOFyf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 00:54:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161139AbVLOFye
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 00:54:34 -0500
Received: from smtp.osdl.org ([65.172.181.4]:50118 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161138AbVLOFyd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 00:54:33 -0500
Date: Wed, 14 Dec 2005 21:56:13 -0800
From: Stephen Hemminger <shemminger@osdl.org>
To: "David S. Miller" <davem@davemloft.net>
Cc: mpm@selenic.com, sri@us.ibm.com, ak@suse.de, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Subject: Re: [RFC][PATCH 0/3] TCP/IP Critical socket communication mechanism
Message-ID: <20051214215613.70f9cafa@localhost.localdomain>
In-Reply-To: <20051214.212309.127095596.davem@davemloft.net>
References: <20051215033937.GC11856@waste.org>
	<20051214.203023.129054759.davem@davemloft.net>
	<20051215050250.GT8637@waste.org>
	<20051214.212309.127095596.davem@davemloft.net>
X-Mailer: Sylpheed-Claws 1.9.100 (GTK+ 2.6.10; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Dec 2005 21:23:09 -0800 (PST)
"David S. Miller" <davem@davemloft.net> wrote:

> From: Matt Mackall <mpm@selenic.com>
> Date: Wed, 14 Dec 2005 21:02:50 -0800
> 
> > There needs to be two rules:
> > 
> > iff global memory critical flag is set
> > - allocate from the global critical receive pool on receive
> > - return packet to global pool if not destined for a socket with an
> >   attached send mempool
> 
> This shuts off a router and/or firewall just because iSCSI or NFS peed
> in it's pants.  Not really acceptable.
> 
> > I think this will provide the desired behavior
> 
> It's not desirable.
> 
> What if iSCSI is protected by IPSEC, and the key management daemon has
> to process a security assosciation expiration and negotiate a new one
> in order for iSCSI to further communicate with it's peer when this
> memory shortage occurs?  It needs to send packets back and forth with
> the remove key management daemon in order to do this, but since you
> cut it off with this critical receive pool, the negotiation will never
> succeed.
> 
> This stuff won't work.  It's not a generic solution and that's
> why it has more holes than swiss cheese. :-)

Also, all this stuff is just a band aid because linux OOM behavior is so
fucked up. The VM system just lets the user dig themselves into a huge
over commit, then we get into trying to change every other system to
compensate.  How about cutting things off earlier, and not falling
off the cliff? How about pushing out pages to swap earlier when memory
pressure starts to get noticed. Then you can free those non-dirty pages
to make progress. Too many of the VM decisions seem to be made in favor
of keep-it-in-memory benchmark situations.
