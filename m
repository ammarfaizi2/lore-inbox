Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932251AbVLDP0K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932251AbVLDP0K (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Dec 2005 10:26:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932252AbVLDP0K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Dec 2005 10:26:10 -0500
Received: from mtagate2.de.ibm.com ([195.212.29.151]:9145 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP id S932251AbVLDP0I
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Dec 2005 10:26:08 -0500
In-Reply-To: <20051124044313.6259092d.pj@sgi.com>
Subject: Re: Inconsistent timing results of multithreaded program on an SMP machine.
To: Paul Jackson <pj@sgi.com>
Cc: kernel@kolivas.org, linux-kernel@vger.kernel.org, mulix@mulix.org
X-Mailer: Lotus Notes Build V70_M4_12162004 Beta 3NP December 16, 2004
Message-ID: <OFF63E8FCE.68FFD508-ONC22570CD.0052EFE9-C22570CD.0054D27C@il.ibm.com>
From: Marcel Zalmanovici <MARCEL@il.ibm.com>
Date: Sun, 4 Dec 2005 17:26:29 +0200
X-MIMETrack: Serialize by Router on D12ML102/12/M/IBM(Release 6.51HF338 | June 21, 2004) at
 04/12/2005 17:26:06
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org






Hi Paul,

I've tried (again) running on a single CPU just to reassure myself that
everything is stable there. The differences were negligible.
Also, I've ran the test on a Regatta machine with 2 hyperthreaded CPUs
(just like my Intel Xeon). The results surprised me somewhat since they
were VERY stable; less than a second between the shortest and longest runs.
In addition to that, other users were connected to the machine at that
time.

I've converted the *writes* to the array tp *reads* from it and ran this
test on my machine.
The results were even more stable than I could possible hope for; maybe 0.2
sec between extremities.

I think that the conclusion from this test is that the write-back algorithm
might be responsible for the oscillating results.
Unfortunetaly, after looking at the hardware configuration I'm more
puzzled; it has write back and write through with the former being set as
default.
Write back is supposed to yield better results since data is written back
only when needed. Not seeing a correlation between run times and CPU on
which the threads run puzzles me even more now.

Any ideas come to mind ? cause I'm running out of.

Marcel



                                                                                                                                                  
                      Paul Jackson                                                                                                                
                      <pj@sgi.com>             To:       Marcel Zalmanovici/Haifa/IBM@IBMIL                                                       
                                               cc:       kernel@kolivas.org, linux-kernel@vger.kernel.org, mulix@mulix.org                        
                      24/11/2005 14:43         Subject:  Re: Inconsistent timing results of multithreaded program on an SMP machine.              
                                                                                                                                                  
                                                                                                                                                  
                                                                                                                                                  



Marcel,

I condensed the results you attached to another reply earlier
today on this query into a little table, showing for each of
8 threads, in order, which of the two CPUs 0 or 1 they finished
on, and the real (elapsed) time:

    0 0 0 1 0 1 0 0 14.49
    1 1 0 0 1 1 1 1 15.18
    0 1 0 1 0 0 1 1 14.64
    1 1 0 0 0 1 0 0 14.65
    0 0 0 1 1 1 1 1 14.61
    1 1 0 0 1 1 1 1 18.89
    0 1 0 0 1 1 0 1 14.62
    1 1 0 1 0 0 1 1 14.51
    0 0 1 1 0 0 0 1 14.54
    0 1 0 1 1 1 1 1 14.73
    0 1 0 1 0 1 1 1 14.78
    0 1 1 1 0 0 0 1 18.90
    0 0 0 1 1 1 0 1 14.57
    1 1 0 1 0 1 0 0 17.07
    0 1 1 1 0 1 1 1 14.56
    0 1 0 0 1 1 0 0 14.49
    0 1 1 1 0 1 0 0 17.80
    0 1 0 1 1 1 1 1 14.62
    0 1 0 1 0 1 0 0 19.55
    0 1 0 1 0 0 1 1 19.57

I notice that the deviation of the faster runs is very low,
with the best 13 of 20 runs all finishing in times between
14.49 and 14.78 seconds, but the slower runs have a higher
deviation, with the worst 7 of 20 runs finishing in times
between 15.18 and 19.57 seconds, a wider range of times.

That is, the best 13 runs differ in time by only 0.29 secs,
but the worst 7 runs differ in time by 4.39 seconds, a much
wider range.

I agree with you that I don't see a pattern in which CPU
the threads finished on or any relation between that and
the real times.

However this skewed distribution of times does suggest that
something is intruding - something that only happens perhaps
a third of the time is running or making things worse.

What I might suggest next is that you look for nice ways
that fit on a page or less and condense out all nonessential
detail to present these timing results.  People have a
tendency to dump a big attachment of raw output data onto
email lists, which almost no one ever reads closely,
especially if it is in some homebrew format perculiar to
that particular inquiry.  Time spent cleaning up the show
of data is often well spent, because then others might
actually look at the data and recognize a pattern that
they have something useful to say about.

Then after you have it collapsed to a nice table format,
go even the next step and describe in words any patterns
that are apparent, which will catch another chunk of
potential readers, who will skim over a data table without
really thinking.  Then fine tune that wording, until it
would be understood by someone, the first time they heard
it, standing at the coffee urn, discussing sports.  Often
times, by the time you get that far, you will have an
'aha' moment, leading to further experiments and insights,
before you even get a chance to ask someone else.

Question - how do you know its the multithreading that
is causing the variance?  Try this with single threads,
just one per cpu, with or without hyperthread perhaps.
Never assume that you know the cause of something until
you have bracketed the tests with demonstrations that
all else being equal (or as close as can be) just adding
or removing the one suspect element causes the observed
affect to come and go.

--
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401


