Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315784AbSENPl1>; Tue, 14 May 2002 11:41:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315785AbSENPl0>; Tue, 14 May 2002 11:41:26 -0400
Received: from holomorphy.com ([66.224.33.161]:18845 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S315784AbSENPlZ>;
	Tue, 14 May 2002 11:41:25 -0400
Date: Tue, 14 May 2002 08:39:56 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Rik van Riel <riel@conectiva.com.br>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC][PATCH] iowait statistics
Message-ID: <20020514153956.GI15756@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Rik van Riel <riel@conectiva.com.br>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
In-Reply-To: <Pine.LNX.4.44L.0205132214480.32261-100000@imladris.surriel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 13, 2002 at 10:19:26PM -0300, Rik van Riel wrote:
> 2) if no process is running, the timer interrupt adds a jiffy
>    to the iowait time
[...]
> 4) on SMP systems the iowait time can be overestimated, no big
>    deal IMHO but cheap suggestions for improvement are welcome

This appears to be global across all cpu's. Maybe nr_iowait_tasks
should be accounted on a per-cpu basis, where

	(1) If a task sleeps for an io while bound to a cpu it
		counts toward the cpu's number of iowait tasks.

	(2) iowait time is accounted and reports are generated already
		on a per-cpu basis, so there's nothing to do there.

	(3) The global statistic does not need to be entirely accurate;
		a lockfree approximation by summing across all cpus'
		local counters should suffice for global iowait. I also
		suspect it will not fluctuate rapidly enough for truly
		horribly inaccurate results to occur.

	(4) A per-cpu nr_iowait_tasks counter may still well need
		to be atomic as other cpu's may be stealing sleeping
		tasks purportedly bound to a given cpu at migration
		time (in order to prevent going negative) and in that
		process altering other cpus' counters.

	(5) A flag marking a task as in iowait may well need to be kept
		in the task_struct so that at migration time the
		appropriate counter adjustments can be made.

	(6) Given sufficient cpu affinity in the scheduler the case
		where one cpu's counter needs alteration from another
		should be relatively uncommon.

The scheduler already participates in keeping per_cpu_user[],
per_cpu_system[], and per_cpu_nice[] up-to-date, so it's not
unreasonable to expect its support for per_cpu_iowait[].


Cheers,
Bill
