Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129837AbRCATon>; Thu, 1 Mar 2001 14:44:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129839AbRCAToe>; Thu, 1 Mar 2001 14:44:34 -0500
Received: from pizda.ninka.net ([216.101.162.242]:51335 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S129837AbRCAToY>;
	Thu, 1 Mar 2001 14:44:24 -0500
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15006.42475.79484.578530@pizda.ninka.net>
Date: Thu, 1 Mar 2001 11:41:31 -0800 (PST)
To: Dan Malek <dan@mvista.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.linuxppc.org
Subject: Re: The IO problem on multiple PCI busses
In-Reply-To: <3A9EA3FA.1A86893B@mvista.com>
In-Reply-To: <19350124090521.18330@mailhost.mipsys.com>
	<15006.40524.929644.25622@pizda.ninka.net>
	<3A9EA3FA.1A86893B@mvista.com>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Dan Malek writes:
 > "David S. Miller" wrote:
 > 
 > > I played around with something akin to this, and some of the necessary
 > > Xfree86-4.0.x hackery needed, some time ago.  But I never finished
 > > this.
 > 
 > Sounds pretty sweet.  How about we finish it?  Any complaints (well
 > reasonable ones :-) or concerns that came out of discussions or
 > your testing we need to consider?

There is only one sticking point, and that is how to convey to the
mmap() call whether you want I/O or Memory space.  In the end, my
analysis came up with basically an ioctl() on the same PCI device
node to set this, and you could keep track of this state in the
filp private area.

I thought originally you could do this with the lower bits of the
mmap() offset, but that won't work in 2.4.x because they are stripped
out and you only get a page number by the time the driver mmap
call runs.

I really like this solution because it does not involve any new
syscalls to be added to glibc and/or the Xfree86 arch/os specific
code.  Just opening files, mmap, and an ioctl number or two.  All
of this can be shared between ports.

As a side note, Alpha has a special PCI syscall to get the "PCI
controller number" a given PCI device is behind.  We could add
another ioctl number which does the same thing on /proc/bus/pci/*/*
nodes.  This way sparc64 and Alpha could have the same user visible
API for this as well.

Later,
David S. Miller
davem@redhat.com
