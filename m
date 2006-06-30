Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750732AbWF3CV5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750732AbWF3CV5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 22:21:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750768AbWF3CV5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 22:21:57 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:48316 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1750732AbWF3CV4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 22:21:56 -0400
Date: Thu, 29 Jun 2006 19:21:29 -0700
From: Paul Jackson <pj@sgi.com>
To: Paul Jackson <pj@sgi.com>
Cc: nagar@watson.ibm.com, akpm@osdl.org, Valdis.Kletnieks@vt.edu,
       jlan@engr.sgi.com, balbir@in.ibm.com, csturtiv@sgi.com,
       linux-kernel@vger.kernel.org
Subject: Re: [Patch][RFC] Disabling per-tgid stats on task exit in taskstats
Message-Id: <20060629192129.f9d799ca.pj@sgi.com>
In-Reply-To: <20060629173805.f189de1a.pj@sgi.com>
References: <44892610.6040001@watson.ibm.com>
	<449C6620.1020203@engr.sgi.com>
	<20060623164743.c894c314.akpm@osdl.org>
	<449CAA78.4080902@watson.ibm.com>
	<20060623213912.96056b02.akpm@osdl.org>
	<449CD4B3.8020300@watson.ibm.com>
	<44A01A50.1050403@sgi.com>
	<20060626105548.edef4c64.akpm@osdl.org>
	<44A020CD.30903@watson.ibm.com>
	<20060626111249.7aece36e.akpm@osdl.org>
	<44A026ED.8080903@sgi.com>
	<20060626113959.839d72bc.akpm@osdl.org>
	<44A2F50D.8030306@engr.sgi.com>
	<20060628145341.529a61ab.akpm@osdl.org>
	<44A2FC72.9090407@engr.sgi.com>
	<20060629014050.d3bf0be4.pj@sgi.com>
	<200606291230.k5TCUg45030710@turing-police.cc.vt.edu>
	<20060629094408.360ac157.pj@sgi.com>
	<20060629110107.2e56310b.akpm@osdl.org>
	<20060629112642.66f35dd5.pj@sgi.com>
	<44A426DC.9090009@watson.ibm.com>
	<20060629124148.48d4c9ad.pj@sgi.com>
	<44A4492E.6090307@watson.ibm.com>
	<20060629152319.cfffe0d6.pj@sgi.com>
	<44A46C6C.1090405@watson.ibm.com>
	<20060629173805.f189de1a.pj@sgi.com>
Organization: SGI
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Shailabh wrote:
> The overhead of creating cpusets just for this
> reason seems excessive when the need is only to
> reduce the number of sockets to monitor

As I reread this thread, some of my ancient interactions with process
accounting come to mind again.

K.I.S.S. - keep it simple, I'm telling myself.

I'm also thinking that since this is a system wide stat tool, it
wants to minimize interactions with other mechanisms.

Hog tying cpusets and process accounting together seems just
plain weird, and risks imposing conflicting demands on the cpuset
configuration of a system.

Please be so kind as to forget I suggested that ;).


How about a simple way to disable collection on specified CPUs.

Collecting this sort of data makes sense for certain managed system
situations, where one chooses to spend some portion of the system
tracking the rest of it.

Collecting it may put an intolerable performance impact on pedal to
the metal maximum performance beasts running on dedicated cpus/nodes.


I propose a per-cpu boolean flag to disable collection.

If this flag is set on the cpu on which a task happens to be when
exiting, then we just drop that data on the floor, silently, with no
accumulation, as quickly as we can, avoiding any system-wide locks.

Then I could run a managed job mix, collecting accounting data, on
some nodes, while running dedicated performance beasts on other nodes,
without the accounting interfering with the performance beasts.

Independently, the cpuset friendly customers could make use of cpusets
to help manage which jobs were on which cpus, so that they collected
their accounting data as desired.  But no need for the accounting
system to be aware of that, past the state of its per-cpu flag.

Such a flag reduces the need for further (over) designing this to
handle the extreme case.  If someone has such an extreme case, they
can turn off collecting on some cpus, to get a handle on the situation.

This could be done as a variant of your idea for multiple
TASKSTATS_LISTEN_GROUP's.  Essentially, for now, we would have two
GROUP's - one that drops the data on the floor, and one that collects
it.  Each cpu is in either one or the other group.  Later on, when the
need arises, we add support for more GROUP's that can actually collect
data.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
