Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261396AbUFMXpU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261396AbUFMXpU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jun 2004 19:45:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261405AbUFMXpU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jun 2004 19:45:20 -0400
Received: from gizmo08ps.bigpond.com ([144.140.71.18]:49593 "HELO
	gizmo08ps.bigpond.com") by vger.kernel.org with SMTP
	id S261396AbUFMXpK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jun 2004 19:45:10 -0400
Message-ID: <40CCE700.3050500@bigpond.net.au>
Date: Mon, 14 Jun 2004 09:45:04 +1000
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Shane Shrybman <shrybman@aei.ca>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][2.6.7-rc3] Single Priority Array CPU Scheduler
References: <1086961198.2787.19.camel@mars> <40CA49DD.5040500@bigpond.net.au> <1087051846.2444.4.camel@mars> <40CBAAB6.5050007@bigpond.net.au> <1087148790.2340.166.camel@mars>
In-Reply-To: <1087148790.2340.166.camel@mars>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Shane Shrybman wrote:
[bits deleted]
> 
> I am doing the same basic test as before but I should mention a few
> things. In mozilla I have ten tabs open, 7 of them with loaded web
> pages. Depending on which tab is focused the interactive responsiveness
> varies greatly. Performance decreases rapidly with the complexity of the
> web page to be rendered. I am using the Debian 4.3.0-7 20040318043201
> version of XFree86 with the nv driver. This driver is incredibly hungry
> for CPU resources (absolute pig really). 
> 
> Here is what I see:
> 
> At the default setting of 500 I see mozilla and XFree86 each at about
> 49% cpu (fighting for cpu), each with a priority ~30-33, with no idle
> time. Metacity, the window manager, also looks to be trying to get some
> CPU, cause it is usually third on the list at ~3% cpu.
> 
> As cpu_hog_threshold is decreased to 400. CPU X=50% pri=30, mozilla=40%
> pri=34-37, metacity=4.5% pri=29. Feels a tad less jerky, cause metacity
> gets a bit more cpu?
> 
> Decreasing cpu_hog_threshold to 300 feels worse than 500.

This probably means that a CPU hog managed to get some interactive bonus 
points and the lower threshold stops them being taken away.

> 
> Decreasing the time_slice to 10-20 makes things noticeably smoother. Are
> time slices dynamic in the SPA scheduler?

No.  Each task gets a fixed fresh time slice when it wakes up and at the 
end of an expired time slice.

> and the vanilla (0)1
> scheduler?

The vanilla scheduler uses time slices to control "nice" and the 
allocated size varies widely.  The default value in SPA is the average 
of what vanilla would have awarded.  This is not necessarily the best 
time slice for interactive response with SPA.

> 
> My humble assessment is that to provide a good interactive feel for this
> workload; Xfree86, mozilla and metacity all need to get CPU in a timely
> manner. This is a tricky balancing act because XFree86 and mozilla can
> easily fall into the cpu hog category, or if they are not cpu hogs they
> can act to starve metacity of cpu resources.

It is indeed a tricky balancing act and it would be easier if more was 
known about the behavioural characteristics of the protagonists.  I have 
added a logging switch which when on will log the scheduling statistics 
for exiting tasks to the system log and I plan to use this to get an 
idea of the characteristics of the tasks involved in a kernel build.

I'm also writing a tool that can be pointed at a particular task (such 
as the X server) and gather time series data on the behaviour of that 
task using the statistics in /proc/<tgid>/task/<tid>/cpustats. 
Hopefully, that will help in working out the best settings or perhaps 
suggest other criteria that may be better for deciding interactiveness.

I had hoped that the throughput bonus would have helped in situations 
such as the one you describe, where several interactive tasks are 
fighting it out, by minimizing queuing.  I suspect that the reason it 
isn't helping is that a linear mapping from CPU delay to the bonus is 
inadequate as it means quite large discrepancies (20%) are required to 
get one bonus point.  I will look at modifying the mapping function to 
give more emphasis to small discrepancies.

> 
> Right now I am using cpu_hog_threshold=400 and timeslice=20 and it seems
> to be an improvement. But this is fairly subjective of course.

You might also try increasing the promotion interval a little as this 
will accentuate the differences between the allocated priorities.

Thanks again for the feedback
Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce

