Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266894AbUHRBTO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266894AbUHRBTO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 21:19:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266895AbUHRBTO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 21:19:14 -0400
Received: from sccrmhc13.comcast.net ([204.127.202.64]:25002 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S266894AbUHRBTL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 21:19:11 -0400
Subject: Re: [PATCH] Re: boot time, process start time, and NOW time
From: Albert Cahalan <albert@users.sf.net>
To: john stultz <johnstul@us.ibm.com>
Cc: Albert Cahalan <albert@users.sourceforge.net>,
       Tim Schmielau <tim@physik3.uni-rostock.de>,
       george anzinger <george@mvista.com>, Andrew Morton OSDL <akpm@osdl.org>,
       OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
       lkml <linux-kernel@vger.kernel.org>, voland@dmz.com.pl,
       nicolas.george@ens.fr, kaukasoi@elektroni.ee.tut.fi,
       david+powerix@blue-labs.org
In-Reply-To: <1092791363.2429.319.camel@cog.beaverton.ibm.com>
References: <1087948634.9831.1154.camel@cube>
	 <87smcf5zx7.fsf@devron.myhome.or.jp>
	 <20040816124136.27646d14.akpm@osdl.org>
	 <Pine.LNX.4.53.0408172207520.24814@gockel.physik3.uni-rostock.de>
	 <412285A5.9080003@mvista.com>
	 <1092782243.2429.254.camel@cog.beaverton.ibm.com>
	 <Pine.LNX.4.53.0408180051540.25366@gockel.physik3.uni-rostock.de>
	 <1092787863.2429.311.camel@cog.beaverton.ibm.com>
	 <1092781172.2301.1654.camel@cube>
	 <1092791363.2429.319.camel@cog.beaverton.ibm.com>
Content-Type: text/plain
Organization: 
Message-Id: <1092782754.5759.1679.camel@cube>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 17 Aug 2004 18:45:54 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-08-17 at 21:09, john stultz wrote:
> On Tue, 2004-08-17 at 15:19, Albert Cahalan wrote:
> > On Tue, 2004-08-17 at 20:11, john stultz wrote:
> > 
> > > --- 1.62/fs/proc/array.c	2004-08-05 13:36:53 -07:00
> > > +++ edited/fs/proc/array.c	2004-08-17 17:08:07 -07:00
> > > @@ -356,7 +356,14 @@
> > >  	read_unlock(&tasklist_lock);
> > >  
> > >  	/* Temporary variable needed for gcc-2.96 */
> > > -	start_time = jiffies_64_to_clock_t(task->start_time - INITIAL_JIFFIES);
> > > +	/* convert timespec -> nsec*/
> > > +	start_time = (unsigned long long)task->start_time.tv_sec * NSEC_PER_SEC 
> > > +				+ task->start_time.tv_nsec;
> > > +	/* convert nsec -> ticks */
> > > +	start_time *= HZ;
> > > +	do_div(start_time, NSEC_PER_SEC);
> > > +	/* convert ticks -> USER_HZ ticks */
> > > +	start_time = jiffies_64_to_clock_t(start_time);
> > 
> > This would overflow in about 6 months at 1024 USER_HZ.
> > Various possible alternatives:
> 
> Everybody sing: Thanks, nice catch/Here's an updated patch!
> 
> -john
> 
> ===== fs/proc/array.c 1.62 vs edited =====
> --- 1.62/fs/proc/array.c	2004-08-05 13:36:53 -07:00
> +++ edited/fs/proc/array.c	2004-08-17 18:03:55 -07:00
> @@ -356,7 +356,13 @@
>  	read_unlock(&tasklist_lock);
>  
>  	/* Temporary variable needed for gcc-2.96 */
> -	start_time = jiffies_64_to_clock_t(task->start_time - INITIAL_JIFFIES);
> +	/* convert timespec -> nsec*/
> +	start_time = (unsigned long long)task->start_time.tv_sec * NSEC_PER_SEC 
> +				+ task->start_time.tv_nsec;
> +	/* convert nsec -> ticks */
> +	do_div(start_time, NSEC_PER_SEC/HZ);
> +	/* convert ticks -> USER_HZ ticks */
> +	start_time = jiffies_64_to_clock_t(start_time);

NSEC_PER_SEC/HZ isn't an integer when HZ is 1024.
Also, you're doing two conversions. You can go directly
from nanoseconds to USER_HZ, without using HZ at all.

I think you really need the #if for this.
It could go in a header if you like, creating
a timespec_to_clock_t macro for use in proc.


