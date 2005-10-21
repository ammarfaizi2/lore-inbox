Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964975AbVJUPQM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964975AbVJUPQM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Oct 2005 11:16:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964976AbVJUPQM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Oct 2005 11:16:12 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:25790 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S964975AbVJUPQK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Oct 2005 11:16:10 -0400
Date: Fri, 21 Oct 2005 08:15:53 -0700
From: Paul Jackson <pj@sgi.com>
To: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Cc: Simon.Derr@bull.net, clameter@sgi.com, akpm@osdl.org, kravetz@us.ibm.com,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org, magnus.damm@gmail.com,
       marcelo.tosatti@cyclades.com
Subject: Re: [PATCH 4/4] Swap migration V3: sys_migrate_pages interface
Message-Id: <20051021081553.50716b97.pj@sgi.com>
In-Reply-To: <435896CA.1000101@jp.fujitsu.com>
References: <20051020225935.19761.57434.sendpatchset@schroedinger.engr.sgi.com>
	<20051020225955.19761.53060.sendpatchset@schroedinger.engr.sgi.com>
	<4358588D.1080307@jp.fujitsu.com>
	<Pine.LNX.4.61.0510210901380.17098@openx3.frec.bull.fr>
	<435896CA.1000101@jp.fujitsu.com>
Organization: SGI
X-Mailer: Sylpheed version 2.0.0beta5 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kame wrote:
>> How about this ?
>> +cpuset_update_task_mems_allowed(task, new);    (this isn't implemented now

One task cannot directly update anothers mems_allowed.  The locking on
a task's mems_allowed only allows modifying it in the context of its
current task.  This avoids taking a lock to read out the (possibly
multiple word) mems_allowed value when checking it in __alloc_pages().

Grep in kernel/cpuset.c for "mems_generation" to see the mechanism
used to insure that the task mems_allowed is updated, before any
allocation of memory, to match its cpuset.

> *new* is already guaranteed to be the subset of current mem_allowed.
> Is this violate the permission ?

I think that sys_migrate_pages() allows one task to migrate the
pages of another.

 * If task A is going to migrate task B's memory, then it should do
   so within task B's cpuset constraints (or as close as it can, in
   the case of say avoiding ECC soft errors, where the task context
   of the affected pages is not easily available).  If A doesn't like
   B's cpuset constraints, then A should change them first, using the
   appropriate cpuset API's, if A has permission to do so.  In the
   ECC soft correction case, just move the page the nearest place
   one can find free memory - from what I can tell ensuring that cpuset
   constraints are honored is too expensive (walking the task list for
   each page to find which task references that mm struct.)

   So this check ensures that A is not moving B's memory outside of
   the nodes in B's cpuset.

 * Christoph - what is the permissions check on sys_migrate_pages()?
   It would seem inappropriate for 'guest' to be able to move the
   memory of 'root'.

> Simon Derr wrote:
> > Automatically updating the ->mems_allowed field as you suggest would 
> > require that the kernel do the same checks in sys_migrage_pages(). Sounds 
> > not as a very good idea to me.

If I am understanding this correctly, this sys_migrate_pages() call
seems most useful in the situation that the pages are being moved
within the nodes already allowed to the target task (perhaps because
the kernel is configured w/o cpusets).  Otherwise, you should first
change the mems_allowed of the target task to allow these nodes, and in
that case, you can just use the new cpuset 'memory_migrate' flag (in a
patch in my outgoing queue, that I need to send real soon now) to ask
that existing pages be migrated when that cpuset moves, and when tasks
are moved into that cpuset.

I agree with Simon that sys_migrate_pages() does not want to get in
the business of replicating the checks on updating mems_allowed that
are in the cpuset code.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
