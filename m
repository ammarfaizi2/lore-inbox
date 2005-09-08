Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751321AbVIHHXr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751321AbVIHHXr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 03:23:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751323AbVIHHXr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 03:23:47 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:10681 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S1751321AbVIHHXp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 03:23:45 -0400
Date: Thu, 8 Sep 2005 00:23:23 -0700
From: Paul Jackson <pj@sgi.com>
To: KUROSAWA Takahiro <kurosawa@valinux.co.jp>,
       Dinakar Guniguntala <dino@in.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] SUBCPUSETS: a resource control functionality using
 CPUSETS
Message-Id: <20050908002323.181fd7d5.pj@sgi.com>
In-Reply-To: <20050908053912.1352770031@sv1.valinux.co.jp>
References: <20050908053912.1352770031@sv1.valinux.co.jp>
Organization: SGI
X-Mailer: Sylpheed version 2.0.0beta5 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[ Adding Dinakar to explicit cc list, since I mention his work.
  Hopefully he can correct any mispresentations of his work I
  might have presented.    - pj ]


I've just started reading this - it seems well presented and I think
you have put much effort into it.  Thank-you for posting it.

I have not yet taken the time to understand it properly, but a couple
of questions come to mind offhand.  I hope these questions will not be
too silly.

 1) What is the relation of this patch set to CKRM?

 2) Would a structure similar to Dinakar's patches to connect
    cpusets and dynamic sched domains (posted to linux-mm)
    work here as well?

Let me describe what I see so far, and hope you will be patient with my
confusions.  Then perhaps I can better explain my question (2) above.

My initial understanding is that subcpusets provide a way to partial
out the proportion of cpu and memory used by various tasks.  A leaf
node cpuset can partition the tasks attached to it into subsets, called
subcpusets, where each subcpuset gets a proportion of cpu and memory
available to the original leaf node cpuset.

These original leaf node cpusets (the parents of the 'subcpusets') form
a non-overlapping and partial covering of the cpus and memory nodes in
a system.  It is a _partial_ covering because not every leaf node
cpuset need be subdivided into 'subcpusets', nor does every cpu or
memory node need to be in such a cpuset.

I'm guessing you do not want such cpusets (the parents of subcpusets)
to overlap, because if they did, it would seem to confuse the meaning
of getting a fixed proportion of available cpu and memory resources.  I
was a little surprised not to see any additional checks that
cpu_exclusive and mem_exclusive must be set true in these cpusets, to
insure non- overlapping cpusets.

Dinakar's patches used cpu_exclusive cpusets to form a complete
non-overlapping covering of the cpus in a system (the cpus not
in cpu_exclusive cpusets got their own separate covers).  Then each
such cover defined a different dynamic sched domain (a separately
scheduled set of tasks).

Your cover elements (your subcpusets) seem to be a somewhat new kind of
cpuset, that can only occur as children of original leaf node cpusets.

Instead of that, I might prefer doing as Dinakar did, and use a single
boolean flag per existing cpuset, to mark a subset of the cpusets that
form the covering.  Dinakar got lucky, and was able to use an existing
cpuset boolean flag - cpu_exclusive, which had not been very useful
until then.  You will have to add a new flag.

On the other hand, Dinakar had more work to do than you might, because
he needed a complete covering (so had to round up cpus in non exclusive
cpusets to form more covering elements).  From what I can tell, you
don't need a complete covering - it seems fine if some cpus are not
managed by this resource control function.

I hope my above remarks are not to far off the mark and do not misrepresent
your work too painfully.  And I hope they make at least a little sense.
Sometimes I have a strange way of describing my thoughts.

Thank-you again for this good work.  I look forward to your further
considerations.  I will make the time soon to read this patch more
closely.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
