Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313304AbSEJKUl>; Fri, 10 May 2002 06:20:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313305AbSEJKUk>; Fri, 10 May 2002 06:20:40 -0400
Received: from mailout02.sul.t-online.com ([194.25.134.17]:26341 "EHLO
	mailout02.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S313304AbSEJKUk>; Fri, 10 May 2002 06:20:40 -0400
To: Andrew Morton <akpm@zip.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: khttpd rotten?
In-Reply-To: <20020509114009.GD3855@higherplane.net> <20020509.042938.78984470.davem@redhat.com> <3CDACE73.6692A31E@zip.com.au>
From: Andi Kleen <ak@muc.de>
Date: 10 May 2002 12:20:17 +0200
Message-ID: <m3elgk8ftq.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.070095 (Pterodactyl Gnus v0.95) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@zip.com.au> writes:

> "David S. Miller" wrote:
> > 
> >    From: john slee <indigoid@higherplane.net>
> >    Date: Thu, 9 May 2002 21:40:09 +1000
> > 
> >    tux is more an application than an interface or mechanism.  applications
> >    historically haven't been distributed as part of the main kernel tree.
> > 
> > Arguable nfsd is an application.
> > 
> > Providing a direct in-kernel link between the page cache and providing
> > content (be it HTTP, FTP, NFS files, whatever) over sockets is a very
> > powerful concept.
> 
> We want to expose all the zerocopy infrastructure to
> userspace so all relevant applications can benefit.

It is basically impossible without hardware support/major stack changes to 
do it securely for networking RX. The problem is that to put data directly
from the NIC into an user space address range the NIC already needs
to demultiplex the sockets before it starts to DMA. 

With kernel space applications you can just DMA into a shared buffer
like it is currently done and give whoever ends up to be the socket owner
that shared buffer.

For userspace you would need to put it into an page aligned buffer and
change the page tables of the user space process, but especially on SMP
that is usually slower than just copying. Managing the stuff in a shared
memory segment is also likely not secure

[There is a special hack in the stack to do it for network sniffing,
but it is not general purpose enough for real protocols] 

Zerocopy TX is different of course and easier and can be exposed to user
space. The natural interface for that is POSIX aio; I believe one of the
kernel aio patchkits floating around already does it.

-Andi
