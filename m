Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265401AbTIJR77 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 13:59:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265405AbTIJR77
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 13:59:59 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:44960
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S265401AbTIJR74 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 13:59:56 -0400
Date: Wed, 10 Sep 2003 20:01:28 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Martin Konold <martin.konold@erfrakon.de>
Cc: Luca Veraldi <luca.veraldi@katamail.com>, linux-kernel@vger.kernel.org
Subject: Re: Efficient IPC mechanism on Linux
Message-ID: <20030910180128.GP21086@dualathlon.random>
References: <00f201c376f8$231d5e00$beae7450@wssupremo> <20030910165944.GL21086@dualathlon.random> <200309101939.17967.martin.konold@erfrakon.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200309101939.17967.martin.konold@erfrakon.de>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 10, 2003 at 07:39:17PM +0200, Martin Konold wrote:
> Am Wednesday 10 September 2003 06:59 pm schrieb Andrea Arcangeli:
> 
> Hi,
> 
> > design that I'm suggesting. Obviously lots of apps are already using
> > this design and there's no userspace API simply because that's not
> > needed.
> 
> HPC people have investigated High performance IPC many times basically it 
> boils down to:
> 
> 1. Userspace is much more efficient than kernel space. So efficient 
> implementions avoid kernel space even for message transfers over networks 
> (e.g. DMA directly to userspace). 
> 
> 2. The optimal protocol to use and the number of copies to do is depending on 
> the message size.
> 
> Small messages are most efficiently handled with a single/dual copy (short 
> protocol / eager protocol) and large messages are more efficient with 
> single/zero copy techniques (get protocol) depending if a network is involved 
> or not.
> 
> Traditionally in a networked environment single copy means PIO and zero copy 
> means DMA when using network hardware.
> 
> The idea is while DMA has much higher bandwidth than PIO DMA is more expensive 
> to initiate than PIO. So DMA is only useful for large messages.

agreed.

> 
> In the local SMP case there do exist userspace APIs like MPI which can do 

btw, so far we were only discussing IPC in a local box (UP or SMP or
NUMA) w/o networking involved. Luca's currnet implementation as well was
only working locally.

> single copy Message passing at memory speed in pure userspace since many 
> years.
> 
> The following PDF documents a measurement where the communication between two 
> processes running on different CPUs in an SMP system is exactly the memcpy 
> bandwidth for large messages using a single copy get protocol.
> 
> 	http://ipdps.eece.unm.edu/1999/pc-now/takahash.pdf
> 
> Numbers from a Dual P-II-333, Intel 440LX (100MB/s memcpy)
> 
> 					eager 	get
> min. Latency µs		8.62		9.98
> max Bandwidth MB/s	48.03	100.02
> half bandwith point KB	0.3		2.5
> 
> You can easily see that the eager has better latency for very short messages 
> and that the get has a max bandwidth beeing equivalent of a memcpy (single 
> copy).
> 
> True zero copy has unlimited (sigh!) bandwidth within an SMP and does not 
> really make sense in contrast to a network.

if you can avoid to enter kernel, you'd better do that, because entering
kernel will take much more time than the copy itself.

with the shm/futex approch you can also have a ring buffer to handle
parallelism better while it's at the same time zerocopy and enterely
userspace based in the best case (thought that's not the common case).

thanks,

Andrea

/*
 * If you refuse to depend on closed software for a critical
 * part of your business, these links may be useful:
 *
 * rsync.kernel.org::pub/scm/linux/kernel/bkcvs/linux-2.5/
 * rsync.kernel.org::pub/scm/linux/kernel/bkcvs/linux-2.4/
 * http://www.cobite.com/cvsps/
 *
 * svn://svn.kernel.org/linux-2.6/trunk
 * svn://svn.kernel.org/linux-2.4/trunk
 */
