Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129045AbQJ3HJS>; Mon, 30 Oct 2000 02:09:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129053AbQJ3HJI>; Mon, 30 Oct 2000 02:09:08 -0500
Received: from Cantor.suse.de ([194.112.123.193]:41230 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S129045AbQJ3HJB>;
	Mon, 30 Oct 2000 02:09:01 -0500
Date: Mon, 30 Oct 2000 08:08:58 +0100
From: Andi Kleen <ak@suse.de>
To: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: 2.2.18Pre Lan Performance Rocks!
Message-ID: <20001030080858.A32204@gruyere.muc.suse.de>
In-Reply-To: <39FCB09E.93B657EC@timpanogas.org> <E13q2R7-0006S7-00@the-village.bc.nu> <20001029183531.A7155@vger.timpanogas.org> <20001030074700.A31783@gruyere.muc.suse.de> <20001029235821.A19076@vger.timpanogas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20001029235821.A19076@vger.timpanogas.org>; from jmerkey@vger.timpanogas.org on Sun, Oct 29, 2000 at 11:58:21PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 29, 2000 at 11:58:21PM -0700, Jeff V. Merkey wrote:
> On Mon, Oct 30, 2000 at 07:47:00AM +0100, Andi Kleen wrote:
> > On Sun, Oct 29, 2000 at 06:35:31PM -0700, Jeff V. Merkey wrote:
> > > On Mon, Oct 30, 2000 at 12:04:23AM +0000, Alan Cox wrote:
> > > > > It's still got some problems with NFS (I am seeing a few RPC timeout
> > > > > errors) so I am backreving to 2.2.17 for the Ute-NWFS release next week,
> > > > > but it's most impressive.
> > > > 
> > > > Can you send a summary of the NFS reports to nfs-devel@linux.kernel.org
> > > 
> > > Yes.  I just went home, so I am emailing from my house.  I'll post late 
> > > tonight or in the morning.  Performance on 100Mbit with NFS going 
> > > Linux->Linux is getting better throughput than IPX NetWare Client -> 
> > > NetWare 5.x on the same network by @ 3%.  When you start loading up a 
> > > Linux server, it drops off sharply and NetWare keeps scaling, however, 
> > > this does indicate that the LAN code paths are equivalent relative to 
> > > latency vs. MSM/TSM/HSM in NetWare.  NetWare does better caching 
> > > (but we'll fix this in Linux next).  I think the ring transitions to 
> > > user space daemons are what are causing the scaling problems 
> > > Linux vs. NetWare.
> > 
> > There are no user space daemons involved in the knfsd fast path, only in slow paths
> > like mounting.
> 
> So why is it spawning off nfsd servers in user space?  I did notice that all

They just provide a process context, the actual work is only done in kernel mode.

> the connect logic is down in the kernel with the RPC stuff in xprt.c, and this
> looks to be pretty fast.  I know about the checksumming problem with TCPIP.
> But cycles are cheap on todays processors, so even with this overhead, it 
> could still get faster.  IPX uses small packets that are less wire efficient 
> since the ratio of header size to payload is larger than what NFS in Linux
> is doing, plus there's more of them for an equivalent data transfer, even
> with packet burst.   IPX would tend to be faster if there were multiple 
> routers involved, since the latency of smaller packets would be less and
> IPX never has to deal with the problem of fragmentation.
> 
> Is there any CR3 reloading or tasking switching going on for each interrupt
> that comes in you know of, BTW?  EMON stats show the server's bus utilization

No, interrupts do not change CR3.

One problem in Linux 2.2 is that kernel threads reload their VM on context switch
(that would include the nfsd thread), this should be fixed in 2.4 with lazy mm.
Hmm actually it should be only fixed for true kernel threads that have been started 
with kernel_thread(), the "pseudo kernel threads" like nfsd uses probably do not 
get that optimization because they don't set their MM to init_mm. 

> to get disproportiantely higher in Linux than NetWare 5.x and when it hits
> 60% of total clock cycles, Linux starts dropping off.  NetWare 5.x is 1/8 

I think that can be explained by the copying.

To be sure you could e.g. use the ktrace patch from IKD, it will give you
cycle accurate traces of execution of functions.

> the bus utilitization, which would suggest clocks are being used for something
> other than pushing packets in and out of the box (the checksumming is done 
> in the tcp code when it copies the fragments, which is very low overhead).

No, unfortunately not. NFS uses UDP and the UDP defragmenting doesn't do copy-checksum
currently.


-Andi
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
