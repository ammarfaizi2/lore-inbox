Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932387AbVJaTkW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932387AbVJaTkW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 14:40:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932406AbVJaTkW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 14:40:22 -0500
Received: from main.gmane.org ([80.91.229.2]:53979 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932387AbVJaTkW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 14:40:22 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Joe Seigh <jseigh_02@xemaps.com>
Subject: Re: [RFC,PATCH] RCUify single-thread case of clock_gettime()
Date: Mon, 31 Oct 2005 14:37:05 -0500
Message-ID: <dk5ro9$3h8$1@sea.gmane.org>
References: <20051031174416.GA2762@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: stenquists.hsd1.ma.comcast.net
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
In-Reply-To: <20051031174416.GA2762@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul E. McKenney wrote:
> Hello!
> 
> The attached patch uses RCU to avoid the need to acquire tasklist_lock
> in the single-thread case of clock_gettime().  Still acquires tasklist_lock
> when asking for the time of a (potentially multithreaded) process.
> 
> Experimental, has been touch-tested on x86 and POWER.  Requires RCU on
> task_struct.  Further more focused testing in progress.
> 
> Thoughts?  (Why?  Some off-list users want to be able to monitor CPU
> consumption of specific threads.  They need to do so quite frequently,
> so acquiring tasklist_lock is inappropriate.)


I'd like to see the time the thread is dispatched put into a read only
memory segment along with a virtual timer and real timer offsets.  The
thread gets the read or virtual time by reading the virtual offset,
reading the real clock (whatever that is), rereading the virtual offset,
and if that hasn't changed, getting the desired timer value by adding the
appropiate offset.  No kernel entanglements required.  This is an old
trick VM used to support virtual timers for MVS.

And while we're at it, throw in the rest of the thread usage stats.

The use of mapped memory segments to avoid syscalls is a good idea.  relayfs
has already established that precedent.  relayfs only handles circular
producer/consumer queues but you could use RCU for preeemptive user threads
or RCU+SMR for other data structures in mapped memory managed by the kernel
or another process even.


--
Joe Seigh

