Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284037AbRL2PZu>; Sat, 29 Dec 2001 10:25:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284020AbRL2PZk>; Sat, 29 Dec 2001 10:25:40 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:12110 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S283588AbRL2PZb>; Sat, 29 Dec 2001 10:25:31 -0500
Date: Sat, 29 Dec 2001 16:25:42 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Dave Jones <davej@codemonkey.org.uk>,
        Trond Myklebust <trond.myklebust@fys.uio.no>,
        Dave Jones <davej@suse.de>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Chuck Lever <cel@monkey.org>
Subject: Re: Possible O_DIRECT problems ?
Message-ID: <20011229162542.G1356@athlon.random>
In-Reply-To: <20011221000806.A26849@suse.de> <shssna58lpq.fsf@charged.uio.no> <20011221003942.B26268@codemonkey.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <20011221003942.B26268@codemonkey.org.uk>; from davej@codemonkey.org.uk on Fri, Dec 21, 2001 at 12:39:42AM +0000
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 21, 2001 at 12:39:42AM +0000, Dave Jones wrote:
> On Fri, Dec 21, 2001 at 01:23:45AM +0100, Trond Myklebust wrote:
> 
>  >    O_DIRECT for NFS isn't yet merged into the kernel. Are these Chuck
>  > Lever's NFS patches you've been testing?
> 
> Nope, stock 2.4.17rc2 & 2.5.1. 
> I thought NFS might just ignore the O_DIRECT flag if it didn't
> understand it yet, I wasn't expecting such a dramatic failure.

The point of O_DIRECT is to do DMA directly into the userspace memory
(and to avoid the VM overhead but that's a secondary issue and with data
journaling we may need to put an anchor into the VM to serialize the
direct I/O with the pagecache I/O in a secondary - slower - direct_IO
callback for the data journaling fs).

But to avoid the mem copies you're required to use strict alignment and
size of the userspace buffers, just like rawio.

If you don't you will get -EINVAL. This ensures people will use O_DIRECT
correctly in their apps. In short every single bugreport like this about
this -EINVAL strict behaviour is the proof we need to be strict and to
return -EINVAL :)

Andrea
