Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268185AbUILFgw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268185AbUILFgw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Sep 2004 01:36:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268458AbUILFgw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Sep 2004 01:36:52 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:39587 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S268185AbUILFgj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Sep 2004 01:36:39 -0400
Date: Sat, 11 Sep 2004 22:35:05 -0700
From: Paul Jackson <pj@sgi.com>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: anton@samba.org, akpm@osdl.org, Simon.Derr@bull.net,
       linux-kernel@vger.kernel.org, ak@suse.de, iwamoto@valinux.co.jp
Subject: Re: [Patch 4/4] cpusets top mask just online, not all possible
Message-Id: <20040911223505.5bfe6138.pj@sgi.com>
In-Reply-To: <1094964209.16406.22.camel@localhost>
References: <20040911082810.10372.86008.84920@sam.engr.sgi.com>
	<20040911082834.10372.51697.75658@sam.engr.sgi.com>
	<20040911141001.GD32755@krispykreme>
	<20040911100731.2f400271.pj@sgi.com>
	<1094923728.3997.10.camel@localhost>
	<20040911192156.1da7c636.pj@sgi.com>
	<1094964209.16406.22.camel@localhost>
Organization: SGI
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave wrote:
> Is it easy to tell if a given page was influenced by a cpusets
> allocation?  How would the memory removal code know which task[s] to go
> and update?

It is not nearly as easy as for cpus to know which tasks to update,
because cpus have a list of tasks on them.

And it is not nearly as easy as for cpus to _do_ the update, because a
tasks memory placement, unlike its cpu placement, can not be changed by
a third party.  So one has to leave a hint laying in wait for the task
to be changed, which the task can trip over and use to trigger its own
memory placement update.  Grep for 'generation' in kernel/cpuset.c for
the cpuset version of this hint.

We will need two pieces:

 1) We will need some user space code, that walks through
    all cpusets, and for each cpuset that includes the node
    in question, updates that cpuset to not have that node
    (which will bump that cpusets generation).

 2) Then each task that is attached to that cpuset, the next
    time that task is about to ask for memory (in one of the
    mm/mempolicy routines, just before entering __alloc_pages())
    will notice the generation number on its cpuset has changed,
    and the cpuset_update_current_mems_allowed() code will
    update the tasks mems_allowed to the correct, online, value.

With what I expect to submit to lkml for *-mm in a few hours,
piece (2) will be complete and ready to go.  Piece (1) can wait.

> We'll fix it when we get there :)

Yup.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
