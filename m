Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267548AbUJGSQW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267548AbUJGSQW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 14:16:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267618AbUJGSQV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 14:16:21 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:13798 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S267548AbUJGR5U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 13:57:20 -0400
Date: Thu, 7 Oct 2004 10:54:25 -0700
From: Paul Jackson <pj@sgi.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Simon.Derr@bull.net, colpatch@us.ibm.com, pwil3058@bigpond.net.au,
       frankeh@watson.ibm.com, dipankar@in.ibm.com, akpm@osdl.org,
       ckrm-tech@lists.sourceforge.net, efocht@hpce.nec.com,
       lse-tech@lists.sourceforge.net, hch@infradead.org, steiner@sgi.com,
       jbarnes@sgi.com, sylvain.jeaugey@bull.net, djh@sgi.com,
       linux-kernel@vger.kernel.org, ak@suse.de, sivanich@sgi.com
Subject: Re: [Lse-tech] [PATCH] cpusets - big numa cpu and memory placement
Message-Id: <20041007105425.02e26dd8.pj@sgi.com>
In-Reply-To: <1250810000.1097160595@[10.10.2.4]>
References: <20040805100901.3740.99823.84118@sam.engr.sgi.com>
	<20040806231013.2b6c44df.pj@sgi.com>
	<411685D6.5040405@watson.ibm.com>
	<20041001164118.45b75e17.akpm@osdl.org>
	<20041001230644.39b551af.pj@sgi.com>
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
Organization: SGI
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin wrote:
> 
> So we have the purely exclusive stuff, which needs kernel support in the form
> of sched_domains alterations. The rest of cpusets is just poking and prodding
> at cpus_allowed, the membind API, and the irq binding stuff. All of which
> you could do from userspace, without any further kernel support, right?
> Or am I missing something?

Well ... we're gaining.  A couple of days ago you were suggesting
that cpusets could be replaced with some exclusive domains plus
CKRM.

Now it's some exclusive domains plus poking the affinity masks.

Yes - you're still missing something.

But I must keep in mind that I had concluded, perhaps three years ago,
just what you conclude now: that cpusets is just poking some affinity
masks, and that I could do most of it from user land.  The result ended
up missing some important capabilities.  User level code could not
manage collections of hardware nodes (sets of CPUs and Memory Nodes) in
a co-ordinated and controlled manner.

The users of cpusets need to have system wide names for them, with
permissions for viewing, modifying and attaching to them, and with the
ability to list both what hardware (CPUs and Memory) in a cpuset, and
what tasks are attached to a cpuset.  As is usual in such operating
systems, the kernel manages such system wide synchronized controlled
access views.

As I quote below, I've been saying this repeatedly.  Could you
tell me, Martin, whether the disconnect is:
 1) that you didn't yet realize that cpusets provided this model (names,
    permissions, ...) or
 2) you don't think such a model is useful, or
 3) you think that such a model can be provided sensibly from user space?

If I knew this, I could focus my response better.

The rest of this message is just quotes from this last week - many
can stop reading here.

===

Date: Fri, 1 Oct 2004 23:06:44 -0700
From: Paul Jackson <pj@sgi.com>

Even the flat model (no hierarchy) uses require some way to
name and control access to cpusets, with distinct permissions
for examining, attaching to, and changing them, that can be
used and managed on a system wide basis.

===

Date: Sat, 2 Oct 2004 12:14:30 -0700
From: Paul Jackson <pj@sgi.com>

And our customers _do_ want to manage these logically isolated
chunks as named "virtual computers" with system managed permissions
and integrity (such as the system-wide attribute of "Exclusive"
ownership of a CPU or Memory by one cpuset, and a robust ability
to list all tasks currently in a cpuset).

===

Date: Sat, 2 Oct 2004 19:26:03 -0700
From: Paul Jackson <pj@sgi.com>

Consider the following use case scenario, which emphasizes this
isolation aspect (and ignores other requirements, such as the need for
system admins to manage cpusets by name [some handle valid across
process contexts], with a system wide imposed permission model and
exclusive use guarantees, and with a well defined system supported
notion of which tasks are "in" which cpuset at any point in time).

===

Date: Sun, 3 Oct 2004 18:41:24 -0700
From: Paul Jackson <pj@sgi.com>

SGI makes heavy and critical use of the cpuset facilities on both Irix
and Linux that have been developed since pset.  These facilities handle
both cpu and memory placment, and provide the essential kernel support
(names and permissions and operations to query, modify and attach) for a
system wide administrative interface for managing the resulting sets of
CPUs and Memory Nodes.

===

Date: Tue, 5 Oct 2004 02:17:36 -0700
From: Paul Jackson <pj@sgi.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>

The /dev/cpuset pseudo file system api was chosen because it was
convenient for small scale work, learning and experimentation, because
it was a natural for the hierarchical name space with permissions that I
required, and because it was convenient to leverage existing vfs
structure in the kernel.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
