Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129406AbRAXXet>; Wed, 24 Jan 2001 18:34:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129413AbRAXXei>; Wed, 24 Jan 2001 18:34:38 -0500
Received: from wire.cadcamlab.org ([156.26.20.181]:63751 "EHLO
	wire.cadcamlab.org") by vger.kernel.org with ESMTP
	id <S129406AbRAXXeb>; Wed, 24 Jan 2001 18:34:31 -0500
Date: Wed, 24 Jan 2001 17:33:12 -0600
To: Jonathan Earle <jearle@nortelnetworks.com>
Cc: "'Mathieu Chouquet-Stringer'" <mchouque@e-steel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [UPDATE] Zerocopy patches, against 2.4.1-pre10
Message-ID: <20010124173312.A6941@cadcamlab.org>
In-Reply-To: <28560036253BD41191A10000F8BCBD116BDCD7@zcard00g.ca.nortel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <28560036253BD41191A10000F8BCBD116BDCD7@zcard00g.ca.nortel.com>; from jearle@nortelnetworks.com on Wed, Jan 24, 2001 at 04:52:19PM -0500
From: Peter Samuelson <peter@cadcamlab.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[Jonathan Earle]
> Hmm.. so things like routing should be faster then?

Other network traffic too.  Say you have an FTP server running and it
wants to send a file out to a client.  The old way was for it to read()
the file into memory and then write() it to the network socket.  To
avoid having to copy all that data into the userspace buffer during
read(), you can use mmap() instead.  In Linux 2.1.1xx we gained a new
syscall sendfile() which works like mmap()+write(), except faster since
the necessary kernel memory management is a lot simpler.  Using either
sendfile() or mmap(), the userspace program (ftpd) doesn't have to
touch the memory involved, just send it on to the socket.  That was the
first optimization relevant here, and it's been around awhile now.

Now with mmap()+write() or sendfile(), the kernel reads the data off
the disk using the page cache, then the network stack copies it to
other buffers, doing the TCP checksum in the process, and eventually
the Ethernet card does a DMA transfer of some sort and sends it out the
wire.  Notice that the CPU has to copy the data from the disk DMA
buffer to the network card DMA buffer, checksumming it somewhere along
the way.  Depending on circumstance, of course, there may be other
copying involved as well.

With zerocopy, when you issue sendfile(), the kernel does the network
DMA straight from the page cache, avoiding that extra copy.  In the
case where the network card is capable of doing the TCP checksum in
hardware (as a lot of newer cards can), the kernel doesn't even have to
look at the data between the disk DMA and the network DMA.  This can
save memory accesses and CPU data cache pollution.  The only way to get
a more direct route would be to do the DMA from disk controller to
network card without touching main memory at all, but this can have a
lot of complications and is probably not worth it in general -- see a
recent discussion on this list.

> What caveats should one watch for (ie: what functionalities will not
> work as before - if any)?

Ideally as a regular user you don't notice anything except things go
perhaps a bit faster.  I have no idea whether Davem's patch achieves
this yet..

Peter
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
