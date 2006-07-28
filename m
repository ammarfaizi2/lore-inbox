Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751982AbWG1Iex@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751982AbWG1Iex (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 04:34:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751983AbWG1Iew
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 04:34:52 -0400
Received: from smtp.osdl.org ([65.172.181.4]:40109 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751982AbWG1Iew (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 04:34:52 -0400
Date: Fri, 28 Jul 2006 01:34:42 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
Cc: matthltc@us.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: 2.6.18-rc2-mm1
Message-Id: <20060728013442.6fabae54.akpm@osdl.org>
In-Reply-To: <6bffcb0e0607280117k68184559t531b737815b2c6e9@mail.gmail.com>
References: <20060727015639.9c89db57.akpm@osdl.org>
	<6bffcb0e0607270632i2ae56e21k40fb12c712980de0@mail.gmail.com>
	<6bffcb0e0607280117k68184559t531b737815b2c6e9@mail.gmail.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Jul 2006 10:17:44 +0200
"Michal Piotrowski" <michal.k.k.piotrowski@gmail.com> wrote:

> Matt, can you look at this?
> 
> My hunt file shows me, that this patches are causing oops.
> GOOD
> #
> #
> task-watchers-task-watchers.patch
> task-watchers-register-process-events-task-watcher.patch
> task-watchers-refactor-process-events.patch
> task-watchers-make-process-events-configurable-as.patch
> task-watchers-allow-task-watchers-to-block.patch
> task-watchers-register-audit-task-watcher.patch
> task-watchers-register-per-task-delay-accounting.patch
> task-watchers-register-profile-as-a-task-watcher.patch
> task-watchers-add-support-for-per-task-watchers.patch
> task-watchers-register-semundo-task-watcher.patch
> task-watchers-register-per-task-semundo-watcher.patch
> BAD

Thanks for working that out.

I've actually been thinking that we shouldn't proceed with those patches.

They're a nice cleanup and make the kernel code _look_ better and I really
like them because of this.  But the cost is potentially significant.  We
replace N direct calls with a walk of a notifier chain, more than N
indirect calls, demultiplexing at the other end and then a direct call. 
That's a significant amount of additional overhead to make the kernel
source look nicer.

Plus, ugly though it is, you can look at the current code and see what it's
doing.  With a notifier chain you have to grep around the tree and work out
what might be hooking into the chain, which is harder.

Finally, the consolidation into a notifier chain forces all the
fork/exit/exec hooks into an one-size-fits-all model.  What happens if one
subsystem wants to hook in before exit_mmap() and another one wants to hook
in after exit_mmap() (for example)?


