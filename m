Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313305AbSHFQmq>; Tue, 6 Aug 2002 12:42:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313477AbSHFQmq>; Tue, 6 Aug 2002 12:42:46 -0400
Received: from air-2.osdl.org ([65.172.181.6]:19370 "EHLO cherise.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S313305AbSHFQmp>;
	Tue, 6 Aug 2002 12:42:45 -0400
Date: Tue, 6 Aug 2002 09:48:33 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: mochel@cherise.pdx.osdl.net
To: Patrick Mansfield <patmans@us.ibm.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: driverfs API Updates
In-Reply-To: <20020805163839.A13073@eng2.beaverton.ibm.com>
Message-ID: <Pine.LNX.4.44.0208060923100.1241-100000@cherise.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > DEVICE_ATTR(name,"strname",mode,show,store);
> 
> Do you any plans to simplify the show or store interfaces? 

Yes. But, I'm not sure how I want to do it. A while back, I converted it 
to use the seq_file interface, with a (probably broken) implementation of 
seq_write(). I'm not sure how well it would fit into what we have now, but 
I definitely agree that it should be simpler.

> Passing a single page or two (4k to 8k buffer), with no offset, and letting
> the driverfs_read_file fill buf might be OK, but breaks seeks (and short
> buffer usage), but at least the show/restore functions would be less likely
> to be broken. Limiting the offset to a fit in a page might help.
> 
> If the show and store interfaces could return a pointer, lengths, and
> a specifier ("%s", "%d", etc.), that might be pretty simple, and would
> allow for correct offset and overflow checks.

The seq_file interface would allow for that.

One purely evil solution might be to just pass a zero'd page-sized buffer 
to be filled one time. We then do strlen() on it for the size, and copy 
what the user wants. It would still require some extra state, but it would 
force people to stick to ASCII, instead of trying to sneak in some binary 
data ;)

> Most of the current show interfaces are broken for a short buffer or seek,
> and they are being copied to create new interfaces, example usage:
> 
> [patman@elm3a50 linux-2.5.29-p1]$ cat /devices/root/pci0/00:0f.2/name
> PCI device 1166:0220
> [patman@elm3a50 linux-2.5.29-p1]$ dd if=/devices/root/pci0/00:0f.2/name of=/tmp/xx bs=1 count=10 ; cat /tmp/xx ; echo 
> 1+0 records in
> 1+0 records out
> P

Yeah, that's definitely broken. 

> For the above to function I also had to change:

Thanks, applied. 

	-pat

