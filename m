Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751369AbWCJAVj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751369AbWCJAVj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 19:21:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752015AbWCJAVi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 19:21:38 -0500
Received: from agminet01.oracle.com ([141.146.126.228]:19020 "EHLO
	agminet01.oracle.com") by vger.kernel.org with ESMTP
	id S1751369AbWCJAVh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 19:21:37 -0500
Date: Thu, 9 Mar 2006 16:21:21 -0800
From: Mark Fasheh <mark.fasheh@oracle.com>
To: Daniel Phillips <phillips@google.com>
Cc: Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, ocfs2-devel@oss.oracle.com
Subject: Re: [Ocfs2-devel] Ocfs2 performance
Message-ID: <20060310002121.GJ27280@ca-server1.us.oracle.com>
Reply-To: Mark Fasheh <mark.fasheh@oracle.com>
References: <4408C2E8.4010600@google.com> <20060303233617.51718c8e.akpm@osdl.org> <440B9035.1070404@google.com> <20060306025800.GA27280@ca-server1.us.oracle.com> <440BC1C6.1000606@google.com> <20060306195135.GB27280@ca-server1.us.oracle.com> <p733bhvgc7f.fsf@verdi.suse.de> <20060307045835.GF27280@ca-server1.us.oracle.com> <440FCA81.7090608@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <440FCA81.7090608@google.com>
Organization: Oracle Corporation
User-Agent: Mutt/1.5.11
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

E-mail subject line change, because the old one has worn thin ;)

On Wed, Mar 08, 2006 at 10:26:09PM -0800, Daniel Phillips wrote:
> I don't know how you got your statistics, but I went to the bother of
> writing a proc interface to dump the bucket counts.
The initial set of numbers I posted was collected by hacking the dlm to dump
bucket lengths at about 20,000 locks. I have since written some user space
code to model the dlm hash and output chain lengths. This allowed me to test
hash distributions at a rapid rate. As a data set, I used debugfs.ocfs2 to
collect lock names from a file system with a fully untarred kernel tree. The
program outputs in a format suitable for import into gnuplot. If interested,
you can get the program and a sample data set from:

http://oss.oracle.com/~mfasheh/dlm_hash/distribution_modeling/

Standard disclaimers apply - that code is a hack and wasn't edited to be
particularly performant, error resistant or pretty. It's also clearly not
intended for testing the actual performance of the hash (just distribution
output). Anyway, it turns out that full_name_hash() didn't have the severe
spikes in distribution that my original hack to compare only the last parts
of a lockres name had. This makes it inappropriate for general use, even
though it resulted in a performance gain on our micro-benchmark.

> So if we improve the hash function, 128K buckets (512K table size) is
> the right number, given a steady-state number of hash resources around
> 128K.  This is pretty much independent of load: if you run light loads
> long enough, you will eventually fill up the hash table.
Your hash sizes are still ridiculously large. All my data shows that we need
to increase the hash size by much much less. At the following location you
will find a series of files detailing the results of 10 untar runs with
various hash allocations. The short story is that we really only need
an allocation on the order of a few pages. 

http://oss.oracle.com/~mfasheh/dlm_hash/untar_timings/

If you average up the untar times you'll get something close to this:
1 page:   23 seconds
2 pages:  18 seconds
4 pages:  16 seconds
6 pages:  15 seconds
8 pages:  14 seconds
16 pages: 14 seconds
32 pages: 14 seconds
64 pages: 14 seconds

PAGE_SIZE on this system is 4096

So our largest performance gain is by just adding a page, and things seem to
top out at 6-8 pages. I will likely have a patch in the next few days or so
which will allocate a small array of pages at dlm startup. The bottom line
is that the default is extremely likely to be on the order of a few pages.
Eventually this will also be user configurable.

> Of course, if we take a critical look at your locking strategy we might
> find some fat to cut there too. Could I possibly interest you in writing
> up a tech note on your global locking strategy?
Sure, but it'll take a while. I've already got one OCFS2 related paper to
write. Perhaps I'll be able to kill two birds with one stone.

By the way, an interesting thing happened when I recently switched disk
arrays - the fluctuations in untar times disappeared. The new array is much
nicer, while the old one was basically Just A Bunch Of Disks. Also, sync
times dropped dramatically.
	--Mark

--
Mark Fasheh
Senior Software Developer, Oracle
mark.fasheh@oracle.com
