Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132668AbRDUOiF>; Sat, 21 Apr 2001 10:38:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132672AbRDUOhz>; Sat, 21 Apr 2001 10:37:55 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:17164 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S132668AbRDUOhv>;
	Sat, 21 Apr 2001 10:37:51 -0400
Date: Sat, 21 Apr 2001 15:37:42 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        "D . W . Howells" <dhowells@astarte.free-online.co.uk>,
        dhowells@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: x86 rwsem in 2.4.4pre[234] are still buggy [was Re: rwsem benchmarks [Re: generic rwsem [Re: Alpha "process table hang"]]]
Message-ID: <20010421153742.B7576@flint.arm.linux.org.uk>
In-Reply-To: <20010420191710.A32159@athlon.random> <Pine.LNX.4.31.0104201639070.6299-100000@penguin.transmeta.com> <20010421160327.A17757@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010421160327.A17757@athlon.random>; from andrea@suse.de on Sat, Apr 21, 2001 at 04:03:27PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 21, 2001 at 04:03:27PM +0200, Andrea Arcangeli wrote:
> On Fri, Apr 20, 2001 at 04:45:32PM -0700, Linus Torvalds wrote:
> > I would suggest the following:
> > 
> >  - the generic semaphores should use the lock that already exists in the
> >    wait-queue as the semaphore spinlock.
> 
> Ok, that is what my generic code does.

rwsem-spinlock.h requires linux/types.h to be included (you're using
__u16 at towards the bottom):

gcc -D__KERNEL__ -I/usr/src2/v2.4/linux-rpc/include -Wall -Wstrict-prototypes
 -O2 -fno-strict-aliasing -pipe -mapcs-32  -march=armv3m -mtune=strongarm110
 -mshort-load-bytes -msoft-float -c -o ieee1284.o ieee1284.c
In file included from /usr/src2/v2.4/linux-rpc/include/linux/rwsem.h:56,
                 from /usr/src2/v2.4/linux-rpc/include/asm/semaphore.h:10,
                 from /usr/src2/v2.4/linux-rpc/include/linux/parport.h:101,
                 from ieee1284.c:19:
/usr/src2/v2.4/linux-rpc/include/linux/rwsem-spinlock.h:154: parse error before `rwsem_cmpxchgw'
/usr/src2/v2.4/linux-rpc/include/linux/rwsem-spinlock.h:154: parse error before `__u16'
/usr/src2/v2.4/linux-rpc/include/linux/rwsem-spinlock.h:155: warning: return-type defaults to `int'
/usr/src2/v2.4/linux-rpc/include/linux/rwsem-spinlock.h:155: warning: function declaration isn't a prototype

Here is a patch that fixes this oversight against 2.4.4-pre5:

--- orig/include/linux/rwsem-spinlock.h	Sat Apr 21 15:32:57 2001
+++ linux/include/linux/rwsem-spinlock.h	Sat Apr 21 15:28:45 2001
@@ -11,6 +11,7 @@
 #endif
 
 #include <linux/spinlock.h>
+#include <linux/types.h>
 
 #ifdef __KERNEL__
 


--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

