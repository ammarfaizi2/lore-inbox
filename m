Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751393AbWCaQD5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751393AbWCaQD5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Mar 2006 11:03:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751396AbWCaQD5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Mar 2006 11:03:57 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.142]:60130 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751393AbWCaQD4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Mar 2006 11:03:56 -0500
Message-ID: <442D52D2.2050307@watson.ibm.com>
Date: Fri, 31 Mar 2006 11:03:30 -0500
From: Shailabh Nagar <nagar@watson.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Peter Chubb <peterc@gelato.unsw.edu.au>
CC: Andrew Morton <akpm@osdl.org>, balbir@in.ibm.com, greg@kroah.com,
       arjan@infradead.org, hadi@cyberus.ca, ak@suse.de,
       linux-kernel@vger.kernel.org, lse-tech@lists.sourceforge.net
Subject: Re: [Patch 0/8] per-task delay accounting
References: <442B271D.10208@watson.ibm.com>	<20060329210314.3db53aaa.akpm@osdl.org>	<20060330062357.GB18387@in.ibm.com>	<20060329224737.071b9567.akpm@osdl.org>	<442C140C.8040404@watson.ibm.com>	<17452.39418.693521.149502@wombat.chubb.wattle.id.au>	<442CBDC8.50401@watson.ibm.com> <17452.58762.293670.563445@wombat.chubb.wattle.id.au>
In-Reply-To: <17452.58762.293670.563445@wombat.chubb.wattle.id.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Chubb wrote:

>>>>>>"Shailabh" == Shailabh Nagar <nagar@watson.ibm.com> writes:
>>>>>>            
>>>>>>
>
>Shailabh> Peter Chubb wrote:
> (microstate accounting patch)
>  
>
>>> It's still maintained in a sporadic sort of way --- I update it
>>>when either I need it for something, or someone's downloaded it and
>>>asks why it doesn't work agains kernel X.Y.Z.  I see a few
>>>downloads a month.
>>>
>>>
>>>      
>>>
>Shailabh> So do you intend to pursue acceptance ? If so, do you think
>Shailabh> the netlink-based taskstats interface provided by the delay
>Shailabh> accounting patches could be an acceptable substitute for the
>Shailabh> interfaces you had (from an old lkml post, they appear to be
>Shailabh> /proc/tgid/msa and a syscall based one) ?
> 
>I'd have to take a close look. 
>
Please do ! As I mentioned in the other note where I summarize the 
various accounting packages
I think it should be fairly easy for microstate accounting to extend the 
structure returned by the
taskstats interface.

> The syscall interface is modelled on
>getrusage(), and only lets you get your own or your children's data;
>I'm not too worried about trashing it, as it should be possible to
>emulate in terms of netlink (albeit at a cost; system calls are
>relatively cheap)
>
>/proc/<pid>/task/<tid>/msa lets you get at anything you own.  I use
>awk scripts to process the msa file in /proc/... and pipe it into
>gnuplot at n second intervals; a netlink interface would need to have
>an auxiliary program to read it and then squirt it into the scripts, I
>think --- or is there a way to get ASCII out on demand?  
>
No. The use of netlink pretty much means you have to use an auxiliary 
program. We provide
one already (as part of the documentation to the patches).

What netlink  buys you is the ability to
- get data for a task after it has exited  (ie netlink  serves as a buffer)
- get data for large number of tasks more efficiently than /proc


>I quite often
>use cat to do quick checks on whats going on too --- so overall I think
>the /proc interface is desirable.
>  
>
Yes, /proc is more convenient both for cat'ting and also since its  used 
by tools like top.
Delay accounting patches also provide the "block I/O wait (including 
swapin)" statistic through
/proc/tgid/stat for convenience and so that top etc. can use it while 
displaying per-task stats.


However, the question here is this:

*if* a single, unified interface for per-task statistics was deemed to 
be desirable (as Andrew is
effectively suggesting we explore),  what would that interface be ? 
/proc-based, netlink based  or syscall-based ?

I would submit it is netlink-based since it is a superset of /proc and 
syscalls.
Neither of the latter two can return data after a task has exited 
(atleast not easily...you can always invent
infrastructure to buffer per-task stats but it would be cumbersome)
Whereas the former can, with the help of an auxiliary program, provide 
the same data that /proc and syscalls can.
The price paid by /proc and syscall users for unification is 
convenience, not loss of functionality.

Would you agree ?

--Shailabh







