Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263220AbTH0Gx3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Aug 2003 02:53:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263230AbTH0Gx3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Aug 2003 02:53:29 -0400
Received: from holomorphy.com ([66.224.33.161]:15541 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S263220AbTH0Gx1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Aug 2003 02:53:27 -0400
Date: Tue, 26 Aug 2003 23:54:35 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Peter Chubb <peterc@gelato.unsw.edu.au>
Cc: akpm@digeo.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.6.0-test4 -- add context switch counters
Message-ID: <20030827065435.GV4306@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Peter Chubb <peterc@gelato.unsw.edu.au>, akpm@digeo.com,
	linux-kernel@vger.kernel.org
References: <16204.520.61149.961640@wombat.disy.cse.unsw.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16204.520.61149.961640@wombat.disy.cse.unsw.edu.au>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 27, 2003 at 10:57:44AM +1000, Peter Chubb wrote:
> Currently, the context switch counters reported by getrusage() are
> always zero.  The appended patch adds fields to struct task_struct to
> count context switches, and adds code to do the counting.
> The patch adds 4 longs to struct task struct, and a single addition to
> the fast path in schedule().

Thanks, this will be useful. We're still missing a fair number of them:

struct  rusage {
        struct timeval ru_utime;        /* user time used */
        struct timeval ru_stime;        /* system time used */
        long    ru_maxrss;              /* maximum resident set size */
        long    ru_ixrss;               /* integral shared memory size */
        long    ru_idrss;               /* integral unshared data size */
        long    ru_isrss;               /* integral unshared stack size */
        long    ru_minflt;              /* page reclaims */
        long    ru_majflt;              /* page faults */
        long    ru_nswap;               /* swaps */
        long    ru_inblock;             /* block input operations */
        long    ru_oublock;             /* block output operations */
        long    ru_msgsnd;              /* messages sent */
        long    ru_msgrcv;              /* messages received */
        long    ru_nsignals;            /* signals received */
        long    ru_nvcsw;               /* voluntary context switches */
        long    ru_nivcsw;              /* involuntary " */
};

...

                case RUSAGE_SELF:
                        jiffies_to_timeval(p->utime, &r.ru_utime);
                        jiffies_to_timeval(p->stime, &r.ru_stime);
                        r.ru_minflt = p->min_flt;
                        r.ru_majflt = p->maj_flt;
                        r.ru_nswap = p->nswap;
                        break;

and we're worse off yet: "FIXME! Get the fault counts properly!" ...
AFAICT literally the only useful number here is utime/stime.


-- wli

P.S.:
The stuff in /proc/$PID/statm isn't a big deal; I've got full 2.4.x
semantics (modulo the VSZ correction) with fully O(1) algorithmic
overhead in some patch originally by bcrl I forward ported somewhere.
