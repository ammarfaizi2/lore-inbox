Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263033AbTCLEqU>; Tue, 11 Mar 2003 23:46:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263036AbTCLEqU>; Tue, 11 Mar 2003 23:46:20 -0500
Received: from packet.digeo.com ([12.110.80.53]:2202 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S263033AbTCLEqS>;
	Tue, 11 Mar 2003 23:46:18 -0500
Date: Tue, 11 Mar 2003 20:57:49 -0800
From: Andrew Morton <akpm@digeo.com>
To: george anzinger <george@mvista.com>
Cc: torvalds@transmeta.com, felipe_alfaro@linuxmail.org, cobra@compuserve.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Re: Runaway cron task on 2.5.63/4 bk?
Message-Id: <20030311205749.436eea7a.akpm@digeo.com>
In-Reply-To: <3E6EAD5F.801@mvista.com>
References: <Pine.LNX.4.44.0303101529040.20597-100000@home.transmeta.com>
	<3E6EAD5F.801@mvista.com>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 12 Mar 2003 04:56:52.0054 (UTC) FILETIME=[CBE57F60:01C2E853]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

george anzinger <george@mvista.com> wrote:
>
> Ok, here is what I have.  I changed nano sleep to use a local 64-bit
> value for the target expire time in jiffies.  As much as MAX-INT/2-1
> will be put in the timer at any one time. It loops till the target
> time is met or exceeded.  The changes affect (clock)nanosleep only and
> not timers (they still error out for large values).

Seem sane.

> I now use the simple u64=(long long) a * b for the mpy so I have 
> dropped the sc_math.h stuff (I will bring that round again :).

Resistance shall be unflagging!

> What do you think?

Sorry, but this little bit:

	while ((active = del_timer_sync(&new_timer) || 
		rq_time > get_jiffies_64()) &&
 	       !test_thread_flag(TIF_SIGPENDING));
 

 	if (abs_struct.list.next) {
 		spin_lock_irq(&nanosleep_abs_list_lock);
 		list_del(&abs_struct.list);
 		spin_unlock_irq(&nanosleep_abs_list_lock);
 	}
 	if (active) {

should be dragged out and mercifully shot.  Is it possible to make that while
loop a little clearer?

The abs_list exactly duplicates the kernel's existing waitqueue
functionality.  You can use prepare_to_wait()/finish_wait() there.

posix_timers_id, posix_clocks[], nanosleep_abs_list_lock and
nanosleep_abs_list should be static to posix-timers.c.
