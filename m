Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262325AbVAEHNQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262325AbVAEHNQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jan 2005 02:13:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262326AbVAEHNQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jan 2005 02:13:16 -0500
Received: from ozlabs.org ([203.10.76.45]:38601 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S262325AbVAEHNK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jan 2005 02:13:10 -0500
Date: Wed, 5 Jan 2005 18:12:24 +1100
From: Anton Blanchard <anton@samba.org>
To: Nicholas Berry <nikberry@med.umich.edu>
Cc: grendel@caudium.net, willy@w.ods.org, linux-kernel@vger.kernel.org
Subject: Re: Very high load on P4 machines with 2.4.28
Message-ID: <20050105071224.GL7335@krispykreme.ozlabs.ibm.com>
References: <s1dad55b.011@med-gwia-02a.med.umich.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s1dad55b.011@med-gwia-02a.med.umich.edu>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
> Indeed. AIX (sorry) 5.3 on POWER5 explicitly disables SMT (IBM
> hyperthreading) if the load doesn't warrant it.
> 
> (Now how about that for Linux?) :)

Its all there in ppc64 2.6 mainline:

for i in `seq 0 127`
do
	echo XXX > /sys/devices/system/cpu/cpu$i/smt_snooze_delay
done

Will enable dynamic ST-SMT switching (XXX is the number of microseconds
we wait in the idle loop before sleeping the thread). Since the SMT
scheduler in 2.6 fills up primary threads first, we will keep SMT
disabled until we have enough work to do. This is probably what you are
referring to here.

To switch SMT off permanently on the fly:

for i in `seq 0 2 127`
do
	echo 0 > /sys/devices_system/cpu/cpu$i/online
done

(ie hotplug cpu disable every second thread) and to switch SMT on again:

for i in `seq 0 2 127`
do
	echo 1 > /sys/devices_system/cpu/cpu$i/online
done

Switching off SMT using either mode will give you a gain in performance
on some things, particularly single threaded stuff. The POWER5 chip
actually reconfigures itself on the fly and reallocates all the
resources to the one thread. eg on a single CPU, two thread box:

SMT enabled:

# ./lat_syscall -N 1
Simple syscall: 0.3360 microseconds

now disable SMT:

# echo 0 > /sys/devices/system/cpu/cpu1/online

# ./lat_syscall -N 1 null
Simple syscall: 0.2970 microseconds

Anton
