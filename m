Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261290AbTABKa0>; Thu, 2 Jan 2003 05:30:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261292AbTABKa0>; Thu, 2 Jan 2003 05:30:26 -0500
Received: from gate.mvhi.com ([195.224.96.166]:1546 "EHLO gate.mvhi.com")
	by vger.kernel.org with ESMTP id <S261290AbTABKaZ>;
	Thu, 2 Jan 2003 05:30:25 -0500
Message-ID: <15892.5819.765394.237342@devel19.axiom.internal>
Date: Thu, 2 Jan 2003 10:38:51 +0000
From: Peter.Benie@mvhi.com (Peter Benie)
To: Robert Love <rml@tech9.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Does cli() need to be called before reading avenrun?
In-Reply-To: <1041468799.1126.8.camel@icbm>
References: <15891.35418.412034.594225@server.axiom.internal>
	<1041468799.1126.8.camel@icbm>
X-Mailer: VM 6.92 under 21.1 (patch 14) "Cuyahoga Valley" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert Love writes ("Re: Does cli() need to be called before reading avenrun?"):
> On Wed, 2003-01-01 at 19:39, Peter Benie wrote:
> > In kernel 2.4, in sys_sysinfo(), the code reads:
> > 
> >    cli();
> >    val.uptime = jiffies / HZ;
> > 
> >    val.loads[0] = avenrun[0] << (SI_LOAD_SHIFT - FSHIFT);
> >    val.loads[1] = avenrun[1] << (SI_LOAD_SHIFT - FSHIFT);
> >    val.loads[2] = avenrun[2] << (SI_LOAD_SHIFT - FSHIFT);
> > 
> >    val.procs = nr_threads-1;
> >    sti();
> > 
> > In loadavg_read_proc, the code is in essence the same, except that it
> > isn't wrapped in cli/sti.  
> > 
> > Is there a reason for the cli?
> 
> The reason we need some sort of protection is that there are the three
> array entries, so we need to make sure we read all three atomically (not
> that its a huge deal if we do not).

This is exactly what I have my doubts about. These are three load
averages with different time constants - it isn't meaningful to
compare them so it doesn't matter if they are not sampled at exactly
the same time.

What caused me to look at this code is was a complaint in the exim
source about how long sysinfo() took compared with reading
/proc/loadavg - the difference is a factor of 100 which is large
enough to seriously affect exim's performance. This looks like a
possible cause.

Peter
