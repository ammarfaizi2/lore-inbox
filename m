Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751656AbVLFEpZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751656AbVLFEpZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 23:45:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751657AbVLFEpZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 23:45:25 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.144]:59604 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751654AbVLFEpY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 23:45:24 -0500
Subject: Re: [ckrm-tech] [RFC][PATCH]  Add timestamp to process event
	connector message
From: Matt Helsley <matthltc@us.ibm.com>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       john stultz <johnstul@us.ibm.com>,
       Jean-Pierre Dion <jean-pierre.dion@bull.net>,
       Guillaume Thouvenin <guillaume.thouvenin@bull.net>,
       Badari Pulavarty <pbadari@us.ibm.com>, Ram Pai <linuxram@us.ibm.com>,
       CKRM-Tech <ckrm-tech@lists.sourceforge.net>,
       Erich Focht <efocht@hpce.nec.com>,
       elsa-devel <elsa-devel@lists.sourceforge.net>,
       ay Lan <jlan@engr.sgi.com>, Erik Jacobson <erikj@sgi.com>,
       Jack Steiner <steiner@sgi.com>
In-Reply-To: <1133836764.6296.1.camel@localhost>
References: <1133835717.25202.1317.camel@stark>
	 <1133836764.6296.1.camel@localhost>
Content-Type: text/plain
Date: Mon, 05 Dec 2005 20:35:45 -0800
Message-Id: <1133843745.25202.1360.camel@stark>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-12-05 at 18:39 -0800, Dave Hansen wrote: 
> On Mon, 2005-12-05 at 18:21 -0800, Matt Helsley wrote:
> > +static inline void get_timestamp(struct timespec *ts)
> > +{
> > +       unsigned int seq;
> > +       struct timespec wall2mono;
> > +
> > +       /* synchronize with settimeofday() changes */
> > +       do {
> > +               seq = read_seqbegin(&xtime_lock);
> > +               getnstimeofday(ts);
> > +               wall2mono = wall_to_monotonic;
> > +       } while(read_seqretry(&xtime_lock, seq));
> > +
> > +       /* adjust to monotonicaly-increasing values */
> > +       ts += wall2mono.tv_sec;
> > +       ts += wall2mono.tv_nsec;
> > +       while ((ts->tv_nsec - NSEC_PER_SEC) >= 0) {
> > +               ts->tv_nsec -= NSEC_PER_SEC;
> > +               ts->tv_sec++;
> > +       }
> > +}
> 
> This seems like something a bit too generic to have in your
> drivers/connector/cn_proc.c file.  Is there a generic timekeeping
> function that should be used instead?  Or, should this go into one of
> the timekeeping files?
> 
> -- Dave

An excellent point! 

There are two functions that might seem appropriate for a timestamp:

current_kernel_time()
do_gettimeofday()


	The former has jiffies resolution and hence may not be sufficient to
distinguish ordering between two events in the same process. The second
is interpolated wall time and may not necessarily monotonic. 

	Most other methods, such as get_cycles(), reading the tsc, etc. are not
SMP-safe or do not provide the needed resolution. Hence the patch gets
the time in nanoseconds and converts to a monotonicly increasing value.

	I'll split out a similarly-named function (get_timestamp exists in
ibmasm.c) to kernel/time.c and repost as two patches.

Thanks,
	-Matt Helsley

