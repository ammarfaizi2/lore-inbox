Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263778AbTJ0XtH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Oct 2003 18:49:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263780AbTJ0Xs4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Oct 2003 18:48:56 -0500
Received: from fw.osdl.org ([65.172.181.6]:41444 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263778AbTJ0Xss (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Oct 2003 18:48:48 -0500
Date: Mon, 27 Oct 2003 15:49:11 -0800
From: Dave Olien <dmo@osdl.org>
To: rwhron@earthlink.net, piggin@cyberone.com.au
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [BENCHMARK] I/O regression after 2.6.0-test5
Message-ID: <20031027234911.GA31491@osdl.org>
References: <20031026103829.GA6549@rushmore>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="M9NhX3UHpAaciwkO"
Content-Disposition: inline
In-Reply-To: <20031026103829.GA6549@rushmore>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--M9NhX3UHpAaciwkO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Oct 26, 2003 at 05:38:29AM -0500, rwhron@earthlink.net wrote:
> 2.6.0-test8-mm1 doesn't have the AIM7 database regression
> that 2.6.0-test8 has.  The AIM7 fileserver and shared 
> workloads regression between test5-mm2 and test8-mm1 is
> about 18%.  Mainline regression was about 38% between test5
> and test8 on AIM7 fileserver and shared workloads.
> 

Yes, I've noticed this as well.  This has been the pattern since
test5.  Every mainline release (test6, test7, test8, AND test9)
has a large regression in as-iosched vs deadline scheduler performance.
The regression is considerably smaller when the mm[1-4] patches are
applied.  See the attachment for a collection of data points, collected
running REAIM, an updated version of AIM7.

In the mm[1-4] broken-out patches lists, there is an O_SYNC-SPEEDUP-2.patch
that has been in all of the mm[1-4] patches since test5.  The comments at
the head of that patch says this patch reduces the blocking of writers on i_sem.

This patch probably allows more writer concurrency.  This benefits
only O_SYNC writes.   Reaim does O_SYNC writes.  My guess this patch
is what reduces the as-iosched regression for mm[1-4] patched kernels.

I imagine the O_SYNC-SPEEDUP is unlikely to get into any more TEST kernels.
But maybe it gives a hint is to what's going on with as-iosched.
Letting in more concurrent writers seems to reduce as-iosched's peformance
regression.


--M9NhX3UHpAaciwkO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=reaim_as_vs_deadline


Some data points (marked with XXX) haven't been collected yet.
This data has been collected on the Scalable Test Platform (STP)
8-way machines at OSDL.

REAIM is an updated version of AIM7.  Information on REAIM and
performance data collected on 2, 4, and 8 way machines can be found at

        http://developer.osdl.org/cliffw/

Hardware details of the STP 8-way machine are at the bottom of this page.
More details on each test run can be viewed by construcing a URL from the
STP ID #. For example, the first entry in the table can be seen at URL

	http://khack.osdl.org/279446

						Maximum Jobs Per Minute
Kernel Version  IO Scheduler   STP ID #	      Peak Load     Quick Convergence
2.6.0-test5	Deadline	279446		8950		8542	
		As-iosched	279444		8785		8489

	mm1	Deadline	279560		8303		7998
		As-iosched	279558		8401		7935

	mm2	Deadline	279929		8309		8063
		As-iosched	281948		8224		7741

	mm3	Deadline	281859		8438		8064
		As-iosched	281813		8207		7879

	mm4	Deadline	281814		8222		7991
		As-iosched	281815		8417		7963

2.6.0-test6	Deadline	281816		8302		7949   ****
		As-iosched	281817		6934		6945

	mm1	Deadline	281864		8375		7930
		As-iosched	281863		8163		7923

	mm2	Deadline	281948		8224		7741
		As-iosched	281865		8309		7616

	mm3	Deadline	281868		8280		8022
		As-iosched	281867		8348		8017

	mm4	Deadline	281870		8512		7868
		As-iosched	281869		8307		7749

2.6.0-test7	Deadline	281231		8413		8002   ****
		As-iosched	282095		6957		6790

	mm1	Deadline	281548		8567		8033
		As-iosched	282181		8346		7755

2.6.0-test8	Deadline	281671		8294		8020   ****
		As-iosched	281669		7018		6926

	mm1	Deadline	282183		8326		7997
		As-iosched	282182		8347		XXX

2.6.0-test9	Deadline			XXXX		XXXX
		As-iosched	282310		6868		6045   ****

--M9NhX3UHpAaciwkO--
