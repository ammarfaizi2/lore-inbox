Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262667AbSJTH1q>; Sun, 20 Oct 2002 03:27:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262712AbSJTH1q>; Sun, 20 Oct 2002 03:27:46 -0400
Received: from c16688.thoms1.vic.optusnet.com.au ([210.49.244.54]:44939 "EHLO
	pc.kolivas.net") by vger.kernel.org with ESMTP id <S262667AbSJTH1p>;
	Sun, 20 Oct 2002 03:27:45 -0400
Content-Type: text/plain; charset=US-ASCII
From: Con Kolivas <conman@kolivas.net>
Reply-To: conman@kolivas.net
To: Jim Houston <jim.houston@attbi.com>, linux-kernel@vger.kernel.org,
       mingo@elte.hu, andrea@suse.de, jim.houston@ccur.com,
       riel@conectiva.com.br, akpm@digeo.com
Subject: Re: [PATCH] Re: Pathological case identified from contest
Date: Sun, 20 Oct 2002 17:33:20 +1000
User-Agent: KMail/1.4.3
References: <200210200319.g9K3J5s07242@linux.local>
In-Reply-To: <200210200319.g9K3J5s07242@linux.local>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200210201733.44683.conman@kolivas.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Sun, 20 Oct 2002 01:19 pm, Jim Houston wrote:
> Reply-to: jim.houston@attbi.com
> --text follows this line--
>
> Hi Ingo,
>
> I ran into the same problems with the scehduler behaving
> badly under load and reported them in this email:
>
>    http://marc.theaimsgroup.com/?l=linux-kernel&m=103133744217082&w=2
>
> I was testing with the LTP and ran into a live-lock because
> scheduler got into a stable state where it always picked the
> same processes to run.  See the earlier mail for the full
> story.  I exchanged a few messages with Andrea Arcangeli about
> this problem and tried a couple of his patches.  They prevented
> the lockup but it got me started thinking about how to make the
> scheduler more fair.
>
> The result is the following patch.  It is against 2.5.40.
>
> The patch includes:
>
>      -	Code to calculate a traditional unix p_cpu style run
> 	average.  This is an exponentially decaying average
> 	run time.  Based on the process being found running.
> 	I'm  doing a first order aproximation for the exponential
> 	 function.
>
> 	I'm punishing processes that actually get to run rather
> 	than rewarding proceses that sleep.  The decaying average
> 	means that the value represents the fraction of the cpu
> 	the process has used.  The current sleep average tends
> 	to clamp to the limit values.
>
>      -	Code which gradually raises the priority of all of
> 	the processes in the run queue.  This increase is balanced
> 	by making time slices shorter for more favorable priorites.
> 	Rrocesses that consume there time slice with out sleeping
> 	are moved to a less favorable priority.  This replaces
> 	the array switch.
>
> I have only done a little testing.  I timed building the kernel
> with/without this change and it made no difference.  I also tested
> with the witpid06 test which had cause the live-lock.
>
> I had been planning a few more changes but got side tracked with
> real work.  I was thinking about adding some feed back which would
> adjust the rate at which the priorities of processes in the run
> queue increase.  I also wanted to play with nice.  The patch currently
> uses a weighted average of the prio and static_prio when it calculates
> a new effective priority.
>
> The method I use to raise the priorities of the running processes is
> to remap prio values for processes in the run queue.  See the functions
> queue_prio an real_prio.  Changing the value of prio_ind changes all
> of the priorities.  I have not done anything to the process migration
> code so it will migrate processes with random priorities.  I don't
> know if this will have any noticeable effect.
>
> I had fun playing with this.  I hope others find it useful.

Hi Jim.

My problem turned out to be a bug in the pipe implementation.
Nonetheless your patch sounded interesting so I gave it a run. Hopefully I 
patched it correctly to 2.5.44 as it compiled and ran ok. These are the 
benchmark results with contest that were different b/w 2.5.44 and your 
patched version:

process_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.44 [3]              90.9    76      32      26      1.27
2.5.44-jh [1]           186.5   37      76      63      2.61

xtar_load:
Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
2.5.44 [3]              117.0   65      1       7       1.64
2.5.44-jh [1]           141.7   54      2       8       1.98

The rest of the results were otherwise similar. It seems your patch served to 
disadvantage kernel compilation in preference for more of the background 
load. Process_load runs 4*num_cpus processes and context switches between 
them continually, so I guess it is most obvious there where kernel 
compilation will still be on the same process in that time. Not sure how much 
that represents a real life situation. Xtar load is busy extracting a tar 
file while trying to do a kernel compilation, and in this case there are more 
unused cpu cycles with the total cpu% being lower.

Cheers,
Con.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE9slxAF6dfvkL3i1gRAkGXAJ9H7eg9JF0CBTdWSaqal7bbp61iWwCfeIal
2tgLO3WblzymxlJT0cszfDY=
=UO49
-----END PGP SIGNATURE-----
