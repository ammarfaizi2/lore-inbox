Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751797AbWJMSwy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751797AbWJMSwy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Oct 2006 14:52:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751807AbWJMSwy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Oct 2006 14:52:54 -0400
Received: from smtp.osdl.org ([65.172.181.4]:37547 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751797AbWJMSwx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Oct 2006 14:52:53 -0400
Date: Fri, 13 Oct 2006 11:52:42 -0700
From: Andrew Morton <akpm@osdl.org>
To: Don Mullis <dwm@meer.net>
Cc: Akinobu Mita <akinobu.mita@gmail.com>, linux-kernel@vger.kernel.org,
       ak@suse.de
Subject: Re: [patch 6/7] process filtering for fault-injection capabilities
Message-Id: <20061013115242.9c4c19b8.akpm@osdl.org>
In-Reply-To: <1160760534.31851.58.camel@localhost.localdomain>
References: <20061012074305.047696736@gmail.com>
	<452df238.04819267.55ff.ffffd8a2@mx.google.com>
	<1160760534.31851.58.camel@localhost.localdomain>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Oct 2006 10:28:54 -0700
Don Mullis <dwm@meer.net> wrote:

> On Thu, 2006-10-12 at 16:43 +0900, Akinobu Mita wrote:
> > This patch provides process filtering feature.
> > The process filter allows failing only permitted processes
> > by /proc/<pid>/make-it-fail
> 
> Akinobu: Toward the end of the previous round of review, we had 
> the following exchange:
>         
>         On Tue, 2006-09-19 at 17:05 +0800, Akinobu Mita wrote:
>         On Mon, Sep 18, 2006 at 10:54:51PM -0700, Don Mullis wrote:
>         > > Add functionality to the process_filter variable: A negative argument
>         > > injects failures for only for pid==-process_filter, thereby permitting
>         > > per-process failures from boot time.
>         > > 
>         > 
>         > Is it better to add new filter for this purpose?
>         > Because someone may want to filter by tgid instead of pid.
>         > 
>         > - positive value is for task->pid
>         > - nevative value is for task->tgid
>         
>         Your idea sounds good to me.
> 
> 
> So naturally I'm wondering why the functionality was dropped.
> An application I had in mind was to identify which of the boot-time
> calls to the slab allocator must not fail but are not yet marked
> __GFP_NOFAIL (some experimentation showed that for pid 1 there are
> lots of these).
> 
> Andrew: Would such an exercise would be worth the effort?
> 

If we're looking for unchecked boot-time allocation failures then I'd say
no, there's not much point in adding code to check for these.  We tend to
assume that the machine has enough memory to boot the kernel and initial
userspace.

That being said, some boot-time allocations are in code which could also
have been compiled into a module, so we do want to be checking those,
because we do care about memory-allocation failures at modprobe time.  But
we can check for these by building the relevant driver as a module and then
testing it.



And the "if it's positive it's a pid, if it's negative it's a tgid"
interface is rather unpleasant - if we're going to do this we should use
separate control files, or use something like

	echo "pid=1234" > /proc/process_filter
	echo "tgid=4321" > /proc/process_filter

