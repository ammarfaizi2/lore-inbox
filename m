Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135339AbREEUh6>; Sat, 5 May 2001 16:37:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135331AbREEUhk>; Sat, 5 May 2001 16:37:40 -0400
Received: from [32.97.182.111] ([32.97.182.111]:3008 "EHLO over.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S135339AbREEUhR>;
	Sat, 5 May 2001 16:37:17 -0400
Message-ID: <3AF2C857.BEEF889E@vnet.ibm.com>
Date: Fri, 04 May 2001 10:18:47 -0500
From: Todd Inglett <tinglett@vnet.ibm.com>
X-Mailer: Mozilla 4.74 [en] (X11; U; Linux 2.2.16-3.c4eb i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andreas Ferber <aferber@techfak.uni-bielefeld.de>
CC: Keith Owens <kaos@ocs.com.au>, Alexander Viro <viro@math.psu.edu>,
        linux-kernel@vger.kernel.org
Subject: Re: SMP races in proc with thread_struct
In-Reply-To: <3AF2A1CC.C22A48E7@vnet.ibm.com> <8541.988980403@ocs3.ocs-net> <20010504162126.A14679@kallisto.sind-doof.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Ferber wrote:
> 
> On Fri, May 04, 2001 at 10:46:43PM +1000, Keith Owens wrote:
> 
> > For a read only case, the only important
> > thing is not to die, one occurrence of bad data is tolerable.
> 
> Strong NACK. The pages where the bad data comes from may in some cases
> already be reclaimed for other data, probably something security
> relevant, which should never ever be given even read access by an
> unauthorized user. Even if this event may be a very rare case, one
> single occurrence of this is one to much.

Agreed.  Worse, it is not readonly.  The /proc code task_lock's the task
struct, thus writing to it.

I'll post a patch shortly once I've tested it.  Worse case only if the
task is exiting I sweep the tasklist looking for the parent to see if
the parent is still valid.  I am not verifying if it is the actual
parent (it might be a new task allocated at the same spot).  I could
just report 0 (or 1) for the parent for any process that is exiting, but
then you won't be able to see the ppid for zombies.  Or is there another
state I can look for?  What I really need is PF_EXITED :).

I am a little concerned also about mm, file, tty and sig fields. These
appear to be NULLed in do_exit(), but I haven't tracked down tty and sig
yet.
-- 
-todd
