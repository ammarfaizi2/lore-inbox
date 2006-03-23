Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932237AbWCWVrg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932237AbWCWVrg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 16:47:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932190AbWCWVrg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 16:47:36 -0500
Received: from mgw1.diku.dk ([130.225.96.91]:49846 "EHLO mgw1.diku.dk")
	by vger.kernel.org with ESMTP id S932153AbWCWVre (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 16:47:34 -0500
Date: Thu, 23 Mar 2006 22:37:26 +0100 (CET)
From: Jesper Dangaard Brouer <hawk@diku.dk>
To: Eric Dumazet <dada1@cosmosbay.com>
Cc: "David S. Miller" <davem@davemloft.net>,
       Robert Olsson <Robert.Olsson@data.slu.se>, linux-net@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: Kernel panic: Route cache, RCU, possibly FIB trie.
In-Reply-To: <4422C9BC.3090400@cosmosbay.com>
Message-ID: <Pine.LNX.4.61.0603232128400.3500@ask.diku.dk>
References: <Pine.LNX.4.61.0603211113550.15500@ask.diku.dk>
 <20060321.023705.26111240.davem@davemloft.net> <Pine.LNX.4.61.0603211538280.28173@ask.diku.dk>
 <20060321.132514.24407022.davem@davemloft.net> <Pine.LNX.4.61.0603231536180.29788@ask.diku.dk>
 <Pine.LNX.4.61.0603231637360.29788@ask.diku.dk> <4422C9BC.3090400@cosmosbay.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-511516320-661058261-1143149846=:3500"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---511516320-661058261-1143149846=:3500
Content-Type: TEXT/PLAIN; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT


On Thu, 23 Mar 2006, Eric Dumazet wrote:

> Jesper Dangaard Brouer a écrit :
>
>>> grep . /proc/sys/net/ipv4/route/*
>>> /proc/sys/net/ipv4/route/error_burst:5000
>>> /proc/sys/net/ipv4/route/error_cost:1000
>>> grep: /proc/sys/net/ipv4/route/flush: Operation not permitted
>>> /proc/sys/net/ipv4/route/gc_elasticity:8
>>> /proc/sys/net/ipv4/route/gc_interval:60
>>> /proc/sys/net/ipv4/route/gc_min_interval:0
>>> /proc/sys/net/ipv4/route/gc_min_interval_ms:500
>>> /proc/sys/net/ipv4/route/gc_thresh:65536
>>> /proc/sys/net/ipv4/route/gc_timeout:300
>>> /proc/sys/net/ipv4/route/max_delay:10
>>> /proc/sys/net/ipv4/route/max_size:1048576
>>> /proc/sys/net/ipv4/route/min_adv_mss:256
>>> /proc/sys/net/ipv4/route/min_delay:2
>>> /proc/sys/net/ipv4/route/min_pmtu:552
>>> /proc/sys/net/ipv4/route/mtu_expires:600
>>> /proc/sys/net/ipv4/route/redirect_load:20
>>> /proc/sys/net/ipv4/route/redirect_number:9
>>> /proc/sys/net/ipv4/route/redirect_silence:20480
>>> /proc/sys/net/ipv4/route/secret_interval:600
>
> I would say : Change the settings :)
>
> echo 2 > /proc/sys/net/ipv4/route/gc_elasticity
> echo 1 > /proc/sys/net/ipv4/route/gc_interval
> echo 131072 > /proc/sys/net/ipv4/route/gc_thresh

These parameters do not solve the problem. I think you missed my previous 
point.  The parameter that needs adjustment is:

  /proc/sys/net/ipv4/route/max_size

The garbage collector will not be activated before the number of 
entries are above "max_size" (see: function rt_garbage_collect).

I have set:
  /proc/sys/net/ipv4/route/gc_thresh:30000
  /proc/sys/net/ipv4/route/max_size:30000

Which solves the problem of the route cache growing too large too fast.


I have read the route.c code again, to see if I missed something. Are you 
trying to make the function "rt_check_expire" to do the cleanup?

I have tried your parameters, and it does not have the desired effect.


> and watch the output of :
>
> rtstat -c 100 -i 1
> (you might have to recompile lnstat/rtstat from iproute2 package from
> http://developer.osdl.org/dev/iproute2/download/

I prefer to use Robert's version of rtstat ;-)

Hilsen
   Jesper Brouer

--
-------------------------------------------------------------------
Cand. scient datalog
Dept. of Computer Science, University of Copenhagen
-------------------------------------------------------------------
---511516320-661058261-1143149846=:3500--
