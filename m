Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264520AbTIDCVw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 22:21:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264514AbTIDCVw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 22:21:52 -0400
Received: from miranda.zianet.com ([216.234.192.169]:13320 "HELO
	miranda.zianet.com") by vger.kernel.org with SMTP id S264520AbTIDCUw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 22:20:52 -0400
Subject: Re: Scaling noise
From: Steven Cole <elenstev@mesatop.com>
To: Daniel Phillips <phillips@arcor.de>
Cc: Antonio Vargas <wind@cocodriloo.com>, Larry McVoy <lm@bitmover.com>,
       CaT <cat@zip.com.au>, Anton Blanchard <anton@samba.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <200309040350.31949.phillips@arcor.de>
References: <20030903040327.GA10257@work.bitmover.com>
	 <20030903124716.GE2359@wind.cocodriloo.com>
	 <1062603063.1723.91.camel@spc9.esa.lanl.gov>
	 <200309040350.31949.phillips@arcor.de>
Content-Type: text/plain
Organization: 
Message-Id: <1062641965.3483.78.camel@spc>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4-1.1mdk 
Date: 03 Sep 2003 20:19:26 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-09-03 at 19:50, Daniel Phillips wrote:
> On Wednesday 03 September 2003 17:31, Steven Cole wrote:
> > On Wed, 2003-09-03 at 06:47, Antonio Vargas wrote:
> > > As you may probably know, CC-clusters were heavily advocated by the
> > > same Larry McVoy who has started this thread.
> >
> > Yes, thanks.  I'm well aware of that.  I would like to get a discussion
> > going again on CC-clusters, since that seems to be a way out of the
> > scaling spiral.  Here is an interesting link:
> > http://www.opersys.com/adeos/practical-smp-clusters/
> 
> As you know, the argument is that locking overhead grows by some factor worse 
> than linear as the size of an SMP cluster increases, so that the locking 
> overhead explodes at some point, and thus it would be more efficient to 
> eliminate the SMP overhead entirely and run a cluster of UP kernels, 
> communicating through the high bandwidth channel provided by shared memory.
> 
> There are other arguments, such as how complex locking is, and how it will 
> never work correctly, but those are noise: it's pretty much done now, the 
> complexity is still manageable, and Linux has never been more stable.
> 
> There was a time when SMP locking overhead actually cost something in the high 
> single digits on Linux, on certain loads.  Today, you'd have to work at it to 
> find a real load where the 2.5/6 kernel spends more than 1% of its time in 
> locking overhead, even on a large SMP machine (sample size of one: I asked 
> Bill Irwin how his 32 node Numa cluster is running these days).  This blows 
> the ccCluster idea out of the water, sorry.  The only way ccCluster gets to 
> live is if SMP locking is pathetic and it's not.

I would never call the SMP locking pathetic, but it could be improved.
Looking at Figure 6 (Star-CD, 1-64 processors on Altix) and Figure 7
(Gaussian 1-32 processors on Altix) on page 13 of "Linux Scalability for
Large NUMA Systems", available for download here:
http://archive.linuxsymposium.org/ols2003/Proceedings/
it appears that for those applications, the curves begin to flatten
rather alarmingly.  This may have little to do with locking overhead.

One possible benefit of using ccClusters would be to stay on that lower
part of the curve for the nodes, using  perhaps 16 CPUs in a node.  That
way, a 256 CPU (e.g. Altix 3000) system might perform better than if a
single kernel were to be used.  I say might.  It's likely that only
empirical data will tell the tale for sure.

> 
> As for Karim's work, it's a quintessentially flashy trick to make two UP 
> kernels run on a dual processor.  It's worth doing, but not because it blazes 
> the way forward for ccClusters.  It can be the basis for hot kernel swap: 
> migrate all the processes to one of the two CPUs, load and start a new kernel 
> on the other one, migrate all processes to it, and let the new kernel restart 
> the first processor, which is now idle.
> 
Thank you for that very succinct summary of my rather long-winded
exposition on that subject which I posted here:
http://marc.theaimsgroup.com/?l=linux-kernel&m=105214105131450&w=2
Quite a bit of the complexity which I mentioned, if it were necessary at
all, could go into user space helper processes which get spawned for the
kernel going away, and before init for the on-coming kernel. Also, my
comment about not being able to shoe-horn two kernels in at once for
32-bit arches may have been addressed by Ingo's 4G/4G split.

Steven

