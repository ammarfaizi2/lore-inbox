Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319305AbSIKUSu>; Wed, 11 Sep 2002 16:18:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319311AbSIKUSu>; Wed, 11 Sep 2002 16:18:50 -0400
Received: from vladimir.pegasys.ws ([64.220.160.58]:10764 "HELO
	vladimir.pegasys.ws") by vger.kernel.org with SMTP
	id <S319305AbSIKUSt>; Wed, 11 Sep 2002 16:18:49 -0400
Date: Wed, 11 Sep 2002 13:23:34 -0700
From: jw schultz <jw@pegasys.ws>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pid_max hang again...
Message-ID: <20020911202333.GB10315@pegasys.ws>
Mail-Followup-To: jw schultz <jw@pegasys.ws>,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.33.0209111428280.20725-100000@ccvsbarc.wipro.com> <20020911171934.GA12449@win.tue.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020911171934.GA12449@win.tue.nl>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 11, 2002 at 07:19:34PM +0200, Andries Brouwer wrote:
> > >> I don't know what the problem is. The present scheme is very
> > >> efficient on the average (since the pid space is very large,
> > >> much larger than the number of processes, this scan is hardly
> > >> ever done)
> > 
> > > The scan itself i don't mind. It is the rescan that bothers me
> 
> Again. We have 2^30 = 10^9 pids. In reality there are fewer than 10^4
> processes. So once in 10^5 pid allocations do we make a scan over
> these 10^4 processes, that is: for each pid allocation we look at
> 0.1 other processes. This 0.1 is a small number. As soon as you start
> introducing structures that have to be updated for each fork or exit,
> things become at least ten times as expensive as they are now.

Some clarification.  The problems were triggered when
PID_MAX was 2^15.  Linus has bumped it with a recomendation
of somthing on the order of 2^20 - 2^24 not 2^30 
to allow for SSI clusters.

Once last_pid cylces we do a complete scan of the task list
testing four task_struct values for every free pid we get.
If the attempted pid is in use the scan will abort
(somewhere about half way through, perhaps less, on average)
and a new scan will be started.  The increase of PID_MAX will
(when it takes effect) dramatically reduce the frequency of
collisons causing rescans but not eliminate them.

I am less certain than you that a little more structure
managment on fork and exit might not reduce the amount of
scanning we have to do.  From what i see in sched there is
lot of task list scanning going on there as well.  Structure
management is a fixed cost.  The cost of scanning the entire
task list is linear.

> Some polishing is possible in that code. I think I once gave a shorter
> and more efficient version. The fragment "if(last_pid & ~PID_MASK);
> last_pid = 300;" occurs twice, and the correct version has it only once.
> The correct version does not have the "goto inside".
> 
> But, the code may only become smaller and more beautiful.
> Large ugly code can be justified only by the need for efficiency,
> and there is no such need here, and indeed, none of the proposals
> made things more efficient. Once the number of processes gets
> above 10^5 we can invent simpleminded schemes to make this
> for_each_task faster.

Let's relax and see what comes out.  Maybe someone will
suprise you.  I trust Linus to reject patches that make
things worse especially if they haven't been vetted by a
leutenant.

-- 
________________________________________________________________
	J.W. Schultz            Pegasystems Technologies
	email address:		jw@pegasys.ws

		Remember Cernan and Schmitt
