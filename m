Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270037AbRHGCYk>; Mon, 6 Aug 2001 22:24:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270038AbRHGCY3>; Mon, 6 Aug 2001 22:24:29 -0400
Received: from sunny-legacy.pacific.net.au ([210.23.129.40]:30658 "EHLO
	sunny.pacific.net.au") by vger.kernel.org with ESMTP
	id <S270037AbRHGCYQ>; Mon, 6 Aug 2001 22:24:16 -0400
Subject: Re: /proc/<n>/maps growing...
From: David Luyer <david_luyer@pacific.net.au>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Andrea Arcangeli <andrea@suse.de>, Chris Wedgwood <cw@f00f.org>,
        "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0108061019280.8972-100000@penguin.transmeta.com>
In-Reply-To: <Pine.LNX.4.33.0108061019280.8972-100000@penguin.transmeta.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.12.99 (Preview Release)
Date: 07 Aug 2001 12:24:05 +1000
Message-Id: <997151045.10551.11.camel@typhaon>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 06 Aug 2001 10:20:15 -0700, Linus Torvalds wrote:
> 2.4.x _does_ merge. Look for yourself. It doesn't merge mprotects, no. And
> why should glibc do mprotect() for a malloc() call? Electric Fence, yes.
> glibc, no.

What glibc does (when it decided to allocate in this way) is:

mmap(NULL,2*sz,PROT_NONE,MAP_PRIVATE|MAP_ANONYMOUS|MAP_NORESERVE,-1,0)

free up 1*sz of space which isn't sz-aligned (presumably to prevent
fragmentation of its pools, now I think about it)

allocate out bits of the block mprotecting them as PROT_READ|PROT_WRITE
as it goes

Typically it's releasing multiples of 4kb at a time just like it brk()s
multiples of 4kb at a time.  glibc doesn't catch accesses right down to
the byte but does catch accesses which are 'way off'.  But really, yes,
you're right - if it's not catching everything it shouldn't catch
anything, since it's not its job.  Unless the MAP_NORESERVE with
PROT_NONE is saving the system from even thinking about the unused parts
of the large slab glibc has just grabbed, in which case there is some
reason glibc should do things the way it does.
-- 
David Luyer                                     Phone:   +61 3 9674 7525
Engineering Projects Manager   P A C I F I C    Fax:     +61 3 9699 8693
Pacific Internet (Australia)  I N T E R N E T   Mobile:  +61 4 1111 2983
http://www.pacific.net.au/                      NASDAQ:  PCNTF
