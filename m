Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262924AbSKDXy2>; Mon, 4 Nov 2002 18:54:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263105AbSKDXy2>; Mon, 4 Nov 2002 18:54:28 -0500
Received: from vladimir.pegasys.ws ([64.220.160.58]:22533 "HELO
	vladimir.pegasys.ws") by vger.kernel.org with SMTP
	id <S262924AbSKDXxj>; Mon, 4 Nov 2002 18:53:39 -0500
Date: Mon, 4 Nov 2002 16:00:10 -0800
From: jw schultz <jw@pegasys.ws>
To: LKML <linux-kernel@vger.kernel.org>
Subject: Re: dcache_rcu [performance results]
Message-ID: <20021105000010.GA21914@pegasys.ws>
Mail-Followup-To: jw schultz <jw@pegasys.ws>,
	LKML <linux-kernel@vger.kernel.org>
References: <20021030161912.E2613@in.ibm.com> <20021031162330.B12797@in.ibm.com> <3DC32C03.C3910128@digeo.com> <20021102144306.A6736@dikhow> <1025970000.1036430954@flay>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1025970000.1036430954@flay>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 04, 2002 at 09:29:14AM -0800, Martin J. Bligh wrote:
> > Clearly dcache_lock is the killer when 'ps' command is used in
> > the benchmark. My guess (without looking at 'ps' code) is that
> > it has to open/close a lot of files in /proc and that increases
> > the number of acquisitions of dcache_lock. Increased # of acquisition
> > add to cache line bouncing and contention.
> 
> Strace it - IIRC it does 5 opens per PID. Vomit.

I just did, had the same reaction.  This is ugly.

It opens stat, statm, status, cmdline and environ apparently
regardless of what will be in the ouput.  At least environ
will fail on most pids if you aren't root, saving on some of
the overhead.  It compunds this by doing so for every pid
even if you have explicitly requested only one pid by
number.

Clearly ps could do with a cleanup.  There is no reason to
read environ if it wasn't asked for.   Deciding which files
are needed based on the command line options would be a
start.

I'm thinking that ps, top and company are good reasons to
make an exception of one value per file in proc.  Clearly
open+read+close of 3-5 "files" each extracting data from
task_struct isn't more efficient than one "file" that
generates the needed data one field per line.

Don't get me wrong.  I believe in the one field per file
rule but ps &co are the exception that proves (tests) the
rule.  Especially on the heavily laden systems with
tens of thousands of tasks.  We could do with a something
between /dev/kmem and five files per pid.

-- 
________________________________________________________________
	J.W. Schultz            Pegasystems Technologies
	email address:		jw@pegasys.ws

		Remember Cernan and Schmitt
