Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132512AbRDDWkw>; Wed, 4 Apr 2001 18:40:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132514AbRDDWkd>; Wed, 4 Apr 2001 18:40:33 -0400
Received: from monza.monza.org ([209.102.105.34]:36625 "EHLO monza.monza.org")
	by vger.kernel.org with ESMTP id <S132512AbRDDWkc>;
	Wed, 4 Apr 2001 18:40:32 -0400
Date: Wed, 4 Apr 2001 15:39:23 -0700
From: Tim Wright <timw@splhi.com>
To: christophe barbe <christophe.barbe@lineo.fr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: uninteruptable sleep (D state => load_avrg++)
Message-ID: <20010404153923.B2144@kochanski>
Reply-To: timw@splhi.com
Mail-Followup-To: christophe barbe <christophe.barbe@lineo.fr>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20010404094708.A4718@pc8.inup.com> <E14klGU-0001kB-00@the-village.bc.nu> <20010404141349.A6702@pc8.inup.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <20010404141349.A6702@pc8.inup.com>; from christophe.barbe@lineo.fr on Wed, Apr 04, 2001 at 02:13:49PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 04, 2001 at 02:13:49PM +0200, christophe barbe wrote:
> The sleep should certainly be interruptible and I that's what I said to the GFS guy.
> But what the reason to increment the load average for each D process ?
> 

OK, the Unix history goes something like this. Synchronization was achieved
using two primitives, sleep() and wakeup(). These guys rendezvous'd on a
wait channel, which was simply an 'int', and by convention was actually the
address of a data structure (yes I know int and pointers aren't the same, this
is a long time ago, OK ? :-).
Anyway, when you called sleep, you also had an associated priority. Priority
values less than PZERO were "high" priority, and >= PZERO were "low" priority.
sleeping above PZERO was interruptible, and processes sleeping at this priority
did not count towards the load. The idea was to use this for events that
potentially might never happen. Sleeping at a priority < PZERO was intended
to be used for things that are absolutely 100% guaranteed to happen, preferably
sometime very soon. Disk I/O (real disks, not NFS) fell into this category,
and hence it counts towards the load since this could be deemed a "fast wait"
state, and the process is nominally runnable. All a bit hand-wavy I know, but
it worked well enough.

The really important part of all this is that you should never sleep
uninterruptibly for anything that you cannot absolutely guarantee will happen,
otherwise you wind up with a stuck process.

Regards,

Tim


-- 
Tim Wright - timw@splhi.com or timw@aracnet.com or twright@us.ibm.com
IBM Linux Technology Center, Beaverton, Oregon
Interested in Linux scalability ? Look at http://lse.sourceforge.net/
"Nobody ever said I was charming, they said "Rimmer, you're a git!"" RD VI
