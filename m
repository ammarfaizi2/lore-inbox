Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261936AbVBUJv2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261936AbVBUJv2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Feb 2005 04:51:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261935AbVBUJvV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Feb 2005 04:51:21 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:48816 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S261934AbVBUJvG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Feb 2005 04:51:06 -0500
Date: Mon, 21 Feb 2005 01:47:28 -0800
From: Paul Jackson <pj@sgi.com>
To: Guillaume Thouvenin <guillaume.thouvenin@bull.net>
Cc: johnpol@2ka.mipt.ru, akpm@osdl.org, greg@kroah.com,
       linux-kernel@vger.kernel.org, elsa-devel@lists.sourceforge.net,
       gh@us.ibm.com, efocht@hpce.nec.com
Subject: Re: [PATCH 2.6.11-rc3-mm2] connector: Add a fork connector
Message-Id: <20050221014728.6106c7e1.pj@sgi.com>
In-Reply-To: <1108969656.8418.59.camel@frecb000711.frec.bull.fr>
References: <1108652114.21392.144.camel@frecb000711.frec.bull.fr>
	<1108655454.14089.105.camel@uganda>
	<1108969656.8418.59.camel@frecb000711.frec.bull.fr>
Organization: SGI
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Guillaume wrote:
> The problem is the following: I have a user space daemon that manages
> group of processes. The main idea is, if a parent belongs to a group
> then its child belongs to the same group.  To achieve this I need to know
> when a fork occurs and which processes are involved. I don't see how to
> do this without a hook in the do_fork() routine...

How is what you need, for process grouping, any more complex than
another sort of {bank, job, aggregate, session, group, ...} integer id
field in the task struct, that is copied on fork, and can be queried and
manipulated from user space, in accordance with whatever rules you
implement?

When I look at the elsacct_process_copy() routine, which is called from
fork, in your patch-2.6.8.1-elsa, I'm not sure what it does, but it sure
looks like it could cause scaling and performance problems.  Linux works
really hard to keep fork costs low.  Copying another integer field, as
part of the block copy of the task struct at fork, sure would be cheaper
than this.  Not only does this hook look too expensive, I don't even see
the need for any such explicit code hook in fork for accounting at all.

Does your user space daemon require to know about each task as it is
forked, in near real time? Is it trying to do something with this
accounting information while the tasks being accounted for are
necessarily still alive?  The classic accounting that I am familiar
with, from years ago, only did post-mortem analysis.  So long as enough
entrails were left around so that it could piece together the story, it
didn't require any immediate notice of anything.  You need to clear a
couple of accounting accumulators directly in the task struct at fork,
and write a record to a specified open file at exit.  That's about it.

The main problems I was aware of with that classic accounting (which
is probably what is now known as BSD accounting) are:
  1) The fixed length accounting record didn't allow for added or
     longer fields.  A little bit more flexible and extensible format
     is desired, but some effort should be made to keep the format
     still reasonably tight and compressed.  No full spec XML.
     The format should allow for some form of resyncronization after
     a chunk of data is lost.
  2) An additional bank/job/aggregate/session/group/... id seems desired.
     I have yet to understand why this need be anything fancier than
     another integer field in the task struct.
  3) Probably some more data items are worth collecting -- which could
     be placed in the outgoing compressed data stream, along with the
     existing records written on task exit.  Over time, appropriate
     hooks should be proposed to collect such data as seems needed.
  4) The current mechanism of collecting per-task data only on exit
     makes it difficult to account for long running jobs.  Perhaps we
     could use a leisurely background task that slowly scans the tasks
     looking for those that have been present since the last scan, and
     causes an intermediate accounting record to be written for them.

What other essential deficiencies are there that you need to address?

I don't see any need for explicit hooks in fork to resolve the above
deficiencies.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.650.933.1373, 1.925.600.0401
