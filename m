Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268343AbUH2WLV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268343AbUH2WLV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Aug 2004 18:11:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268347AbUH2WLV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Aug 2004 18:11:21 -0400
Received: from holomorphy.com ([207.189.100.168]:57520 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S268343AbUH2WLM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Aug 2004 18:11:12 -0400
Date: Sun, 29 Aug 2004 15:11:05 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Albert Cahalan <albert@users.sf.net>
Cc: Roger Luethi <rl@hellgate.ch>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       Paul Jackson <pj@sgi.com>
Subject: Re: [BENCHMARK] nproc: netlink access to /proc information
Message-ID: <20040829221105.GZ5492@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Albert Cahalan <albert@users.sf.net>, Roger Luethi <rl@hellgate.ch>,
	linux-kernel mailing list <linux-kernel@vger.kernel.org>,
	Paul Jackson <pj@sgi.com>
References: <20040828201435.GB25523@k3.hellgate.ch> <20040829160542.GF5492@holomorphy.com> <20040829170247.GA9841@k3.hellgate.ch> <20040829172022.GL5492@holomorphy.com> <20040829175245.GA32117@k3.hellgate.ch> <20040829181627.GR5492@holomorphy.com> <20040829190050.GA31641@k3.hellgate.ch> <1093810645.434.6859.camel@cube> <20040829204602.GW5492@holomorphy.com> <1093815946.431.6890.camel@cube>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1093815946.431.6890.camel@cube>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2004-08-29 at 16:46, William Lee Irwin III wrote:
>> You shouldn't have to try to scan the set of all tasks in any bounded
>> period of time or rely on differential updates. Scanning some part of
>> the list of a bounded size, updating the state based on what was
>> scanned, and reporting the rest as if it hadn't changed is the strategy
>> I'm describing.

On Sun, Aug 29, 2004 at 05:45:47PM -0400, Albert Cahalan wrote:
> That's defective. Users will not like it.

Scarcely. The task can't be done in realtime. The data will be stale
by the time it's reported anyway. Limiting the amount of sampling done
is vastly superior to beating the kernel's reporting interfaces to
death in a totally futile attempt to achieve infeasible consistencies,
burning ridiculous amounts of cpu in the process, and reporting
gibberish in the end anyway.


On Sun, 2004-08-29 at 16:46, William Lee Irwin III wrote:
>> Some updates can be captured, merely not all. Updating the
>> state given what was captured during the partial scan and
>> then displaying the state derived from what could be
>> captured in the refresh interval is more useful than being
>> nonfunctional at the lower refresh intervals or needlessly
>> beating the kernel in some futile attempt to exhaustively
>> search an impossibly huge dataset in some time bound that
>> can't be satisfied.

On Sun, Aug 29, 2004 at 05:45:47PM -0400, Albert Cahalan wrote:
> nice -n 19 top

No, hard cpu limits are required, and even then it just spews gibberish
and very slowly. The current algorithms are nonfunctional with any
substantial number of processes.


On Sun, 2004-08-29 at 16:46, William Lee Irwin III wrote:
>> One shouldn't really need to care; periodically rechecking the fields
>> of an active pid should suffice. You don't really care whether it's the
>> same task or not, just that the fields are up-to-date and whether any
>> task with that pid exists.

On Sun, Aug 29, 2004 at 05:45:47PM -0400, Albert Cahalan wrote:
> People use the procps tools to kill processes.
> Bad data leads to bad decisions.

Refusal to rate limit sampling doesn't make the data more coherent in
the presence of large numbers of tasks.


On Sun, 2004-08-29 at 16:46, William Lee Irwin III wrote:
>> Actually, the problem size is so small it shouldn't be problematic.
>> There are only 13 /proc/ files associated with a process, so exhaustive
>> search over 2**13 - 1 == 8191 nonempty subsets, e.g. queueing by size
>> and checking for the satisfiability of the reporting, will suffice.

On Sun, Aug 29, 2004 at 05:45:47PM -0400, Albert Cahalan wrote:
> Nice! Checking for satisfiability is only NP-complete...
> I do get your point, but I expect to see more /proc files
> as time passes. Also, there is the issue of maintainability.

No, that's not general satisfiability. Each field to be reported needs
at least one out of some set of subsets of /proc/ files associated with
a process to be includes in those parsed. Checking for inclusion of one
of a field's required subsets for each field suffices. The number of
subsets of /proc/ files from which a field is calculable is bounded by
some small constant. It must be constant, as there are a finite number
of fields, and the constant is small, as this is some specific set and
the precise upper bound can be found, and if/when it is found, it is
very likely to be well under a tenth of the total number of subsets of
/proc/ files associated with a process.


On Sun, Aug 29, 2004 at 05:45:47PM -0400, Albert Cahalan wrote:
> Example 1: It has crossed my mind to add separate files
> for the least security-critical data, so that an SE Linux
> system with moderate security could provide some minimal
> amount of basic info to normal users.
> Example 2: There could be files containing only data
> that is easy to generate or that needs the same locking.
> Even with the "ps -o pid" example given, opening /proc/*/stat
> is required to get the tty. Opening /proc/*/status is nearly
> required; one can do stat() on the directory to get that
> via st_uid though.

I don't have a whole lot to say on this subject. These sound reasonable.


-- wli
