Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261914AbSI3A4L>; Sun, 29 Sep 2002 20:56:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261915AbSI3A4L>; Sun, 29 Sep 2002 20:56:11 -0400
Received: from LIGHT-BRIGADE.MIT.EDU ([18.244.1.25]:28946 "HELO
	light-brigade.mit.edu") by vger.kernel.org with SMTP
	id <S261914AbSI3Azt>; Sun, 29 Sep 2002 20:55:49 -0400
Date: Sun, 29 Sep 2002 21:01:13 -0400
From: Gerald Britton <gbritton@alum.mit.edu>
To: Dominik Brodowski <linux@brodo.de>
Cc: Gerald Britton <gbritton@alum.mit.edu>, linux-kernel@vger.kernel.org,
       cpufreq@www.linux.org.uk
Subject: Re: [PATCH] Re: [2.5.39] (3/5) CPUfreq i386 drivers
Message-ID: <20020929210113.A22311@light-brigade.mit.edu>
References: <20020928112503.E1217@brodo.de> <20020928134457.A14784@brodo.de> <20020928134739.A11797@light-brigade.mit.edu> <20020929111603.F1250@brodo.de> <20020929121018.A811@brodo.de> <20020929155648.A20308@light-brigade.mit.edu> <20020930013926.A11768@brodo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020930013926.A11768@brodo.de>; from linux@brodo.de on Mon, Sep 30, 2002 at 01:39:26AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > [rounding] 
> > There probably isn't a lot that can be done about these unfortunately, but
> > they won't necessarily converge to a stable value so things may eventually
> > start to fail.
> Yes, that's a problem; but as cpufreq doesn't change speed dynamically yet
> (and thus the number of transitions is somewhat limited) it shouldn't cause
> too much trouble _yet_. But I'll try to think of a better solution _soon_.

One thought here might be.. for each variable which needs to be scaled, save
off the boot value and boot frequency and always scale from that value so that
we don't accumulate errors.  Fairly simple implementation (i doubt there are
very many things which will need scaling, so it doesn't bloat much).  simply
do something like this:

static unsigned int orig_freq;
statid unsigned long orig_scalable;
...
if (type == CPUFREQ_PRECHANGE) {
	if (!orig_freq) {
		orig_freq = freqs->old;
		orig_scalable = scalable;
	}
	if (scale_on_pre)
		scalable = cpufreq_scale(orig_scalable, orig_freq, freqs->new);
} else if (type == CPUFREQ_POSTCHANGE) {
	BUG_ON(!orig_freq);
	if (scale_on_post)
		scalable = cpufreq_scale(orig_scalable, orig_freq, freqs->new);
}

It seems to be working ok on my system adding saved boot values for
loops_per_jiffy in cpufreq.c and cpu_khz, fast_gettimeoffset_quotient, and
the per cpu loops_per_jiffy values in time.c.

				-- Gerald

