Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267519AbUI1Lk1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267519AbUI1Lk1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Sep 2004 07:40:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267554AbUI1Lk1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Sep 2004 07:40:27 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:30923 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S267519AbUI1LkP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Sep 2004 07:40:15 -0400
Date: Tue, 28 Sep 2004 06:38:58 -0500
From: Robin Holt <holt@sgi.com>
To: Paul Jackson <pj@sgi.com>
Cc: Jay Lan <jlan@engr.sgi.com>, linux-kernel@vger.kernel.org,
       lse-tech@lists.sourceforge.net, csa@oss.sgi.com, akpm@osdl.org,
       guillaume.thouvenin@bull.net, tim@physik3.uni-rostock.de,
       corliss@digitalmages.com
Subject: Re: [PATCH 2.6.9-rc2 2/2] enhanced MM accounting data collection
Message-ID: <20040928113858.GA1090@lnx-holt.americas.sgi.com>
References: <4158956F.3030706@engr.sgi.com> <41589927.5080803@engr.sgi.com> <20040928023350.611c84d8.pj@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040928023350.611c84d8.pj@sgi.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 28, 2004 at 02:33:50AM -0700, Paul Jackson wrote:
> nits:
> 
> 3) Is it always the case that csa_update_integrals() and
>    update_mem_hiwater() are used together?  If so, perhaps
>    they could be collapsed into one?  Even the current->mm
>    test inside them could be made one test, perhaps?

This sounds like a really good idea.  Maybe update_mem_hiwater should have
the #ifdef CONFIG_CSA inside it.  This really sounds like a good idea.
Is update_mem_hiwater everywhere that csa_update_integrals needs to be?
I seem to remember one or two places where that was not the case.
Of course that was a few years ago and my memory is really fuzzy

> 
> 4) What kind of kernel text size expansion does this cause?
>    There seem to be about a dozen of these calls.  What are
>    the pros and cons of inlining csa_update_integrals() and
>    update_mem_hiwater()?  Are these on hot enough kernel code
>    paths that we should benchmark with and without these hooks
>    enabled, both inline and out-of-line?

The size was never very noticable.  It usually did not even cause overflow
to the next 4k page.  The csa_job module added the biggest bloat, but
I have nearly always compiled that as a module.

I have benchmarked these hooks a very long time ago.  The number and
location has not changed appreciably.

I ran three seperate tests.  The first was without any csa config'd on.
The second was with csa config'd on, but no job containers and the
writing of the accounting file turned off.  Last was with everything.
We ran 7 runs of each config on a 32 cpu system.

There was no delta between the two kernels that were not writing
accounting files.  Actually, the average for the with integrals was 0.3%
above the without integrals, but this is well within the noise range.

Originally, there was a 5% decrease in performance with the writing of
the accounting data.  There was another unfortunate side effect that some
of the CSA metrics became much worse.  This problem was later identified
and fixed.  At that point, CSA logging caused a 2.7% drop in AIM7 peak
with shifting the transition point (I think that was the name I remember)
towards a higher number of processes.  Jack said that was due to a
slight serializing of process exits.

Robin
