Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262296AbSI1RmT>; Sat, 28 Sep 2002 13:42:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262297AbSI1RmT>; Sat, 28 Sep 2002 13:42:19 -0400
Received: from LIGHT-BRIGADE.MIT.EDU ([18.244.1.25]:1042 "HELO
	light-brigade.mit.edu") by vger.kernel.org with SMTP
	id <S262296AbSI1RmS>; Sat, 28 Sep 2002 13:42:18 -0400
Date: Sat, 28 Sep 2002 13:47:39 -0400
From: Gerald Britton <gbritton@alum.mit.edu>
To: Dominik Brodowski <linux@brodo.de>
Cc: linux-kernel@vger.kernel.org, cpufreq@www.linux.org.uk
Subject: Re: [PATCH] Re: [2.5.39] (3/5) CPUfreq i386 drivers
Message-ID: <20020928134739.A11797@light-brigade.mit.edu>
References: <20020928112503.E1217@brodo.de> <20020928134457.A14784@brodo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020928134457.A14784@brodo.de>; from linux@brodo.de on Sat, Sep 28, 2002 at 01:44:57PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> -		if (!speedstep_low_freq || !speedstep_high_freq || 
> +		if (!low || !high || 
>  		    (speedstep_low_freq == speedstep_high_freq))
>  			return -EIO;

This is still obviously broken.

First time through the loop, high and low are 0, one of the two of them gets
set and the other is still 0.  This !low || !high test is still within the loop
so it will drop out with -EIO.  I'd been using cpufreq under 2.4 for a while
and with the recent updates (profile api), speedstep hasn't started up because
of this, or because it was sending bad data into the notifier chains.  Your
patch here passes bogus data into the notifier chains, which could be bad imho.

If I fix the init by moving the !low || !high test below the loop, and prevent
bad data from being passed into the notifier chains, I start getting memory
corruption being detected by slab poisioning.  This causes an oops during boot
and also shortly after load if speedstep is modular.

Also, the irq locking in speedstep.c is rather screwy and redundant in places:

/* Disable IRQs */
local_irq_save(flags);
local_irq_disable();
  . . .
/* Enable IRQs */
local_irq_enable();
local_irq_restore(flags);

				-- Gerald

