Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261375AbUJNL0P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261375AbUJNL0P (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Oct 2004 07:26:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261451AbUJNL0P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Oct 2004 07:26:15 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:62082 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S261375AbUJNL0G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Oct 2004 07:26:06 -0400
Date: Thu, 14 Oct 2004 04:23:07 -0700
From: Paul Jackson <pj@sgi.com>
To: ebiederm@xmission.com (Eric W. Biederman)
Cc: mbligh@aracnet.com, Simon.Derr@bull.net, colpatch@us.ibm.com,
       pwil3058@bigpond.net.au, frankeh@watson.ibm.com, dipankar@in.ibm.com,
       akpm@osdl.org, ckrm-tech@lists.sourceforge.net, efocht@hpce.nec.com,
       lse-tech@lists.sourceforge.net, hch@infradead.org, steiner@sgi.com,
       jbarnes@sgi.com, sylvain.jeaugey@bull.net, djh@sgi.com,
       linux-kernel@vger.kernel.org, ak@suse.de, sivanich@sgi.com
Subject: Re: [Lse-tech] [PATCH] cpusets - big numa cpu and memory placement
Message-Id: <20041014042307.0172d229.pj@sgi.com>
In-Reply-To: <m1ekk1egdx.fsf@ebiederm.dsl.xmission.com>
References: <20040805100901.3740.99823.84118@sam.engr.sgi.com>
	<20041002145521.GA8868@in.ibm.com>
	<415ED3E3.6050008@watson.ibm.com>
	<415F37F9.6060002@bigpond.net.au>
	<821020000.1096814205@[10.10.2.4]>
	<20041003083936.7c844ec3.pj@sgi.com>
	<834330000.1096847619@[10.10.2.4]>
	<835810000.1096848156@[10.10.2.4]>
	<20041003175309.6b02b5c6.pj@sgi.com>
	<838090000.1096862199@[10.10.2.4]>
	<20041003212452.1a15a49a.pj@sgi.com>
	<843670000.1096902220@[10.10.2.4]>
	<Pine.LNX.4.61.0410051111200.19964@openx3.frec.bull.fr>
	<58780000.1097004886@flay>
	<20041005172808.64d3cc2b.pj@sgi.com>
	<1193270000.1097025361@[10.10.2.4]>
	<20041005190852.7b1fd5b5.pj@sgi.com>
	<1097103580.4907.84.camel@arrakis>
	<20041007015107.53d191d4.pj@sgi.com>
	<Pine.LNX.4.61.0410071439070.19964@openx3.frec.bull.fr>
	<1250810000.1097160595@[10.10.2.4]>
	<20041007105425.02e26dd8.pj@sgi.com>
	<1344740000.1097172805@[10.10.2.4]>
	<m1ekk1egdx.fsf@ebiederm.dsl.xmission.com>
Organization: SGI
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric wrote:
> I have been quite confused by this thread in that I have not seen
> any mechanism that looks beyond an individual processes at a time,
> which seems so completely wrong.

In the simplest form, we obtain the equivalent of gang scheduling for
the several threads of a tightly coupled job by arranging to have only
one runnable thread per cpu, each such thread pinned on one cpu, and all
threads in a given job simultaneously runnable.

For compute bound jobs, this is often sufficient.  Time share (to a
coarse granularity of minutes or hours) and overlap of various sized
jobs is handled using suspension and migration in order to obtain the
above invariants of one runnable thread per cpu at any given time, and
of having all threads in a tightly coupled job pinned to distinct cpus
and runnable simultaneously.

For jobs that are not compute bound, where other delays such as i/o
would allow for running more than one such job at a time (both
intermittendly runnable on a finer scale of seconds), then one needs
something like gang scheduling in order to keep all the threads in a
tightly coupled job running together, while still obtaining maximum
utilization of cpu/memory hardware from jobs with cpu duty cycles of
less than 50%.

The essential purpose of cpusets is to take the placement of individual
threads by the sched_setaffinity and mbind/set_mempolicy calls, and
extend that to manage placing groups of tasks on administratively
designated and controlled groups of cpus/nodes.

If you see nothing beyond individual processes, then I think you are
missing that.

However, it is correct that we haven't (so far as I recall) considered
the gang scheduling that you describe.  My crystal ball says we might
get to that next year.

Gang scheduling isn't needed for the compute bound jobs, because just
running a single job at a time on a given subset of a systems cpus and
memory obtains the same result.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
