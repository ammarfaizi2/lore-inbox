Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262683AbTJJA5N (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Oct 2003 20:57:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262718AbTJJA5N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Oct 2003 20:57:13 -0400
Received: from nat-pool-bos.redhat.com ([66.187.230.200]:37181 "EHLO
	pasta.boston.redhat.com") by vger.kernel.org with ESMTP
	id S262683AbTJJA45 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Oct 2003 20:56:57 -0400
Message-Id: <200310100101.h9A11BeD011819@pasta.boston.redhat.com>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
cc: Mika Penttila <mika.penttila@kolumbus.fi>,
       Dave Kleikamp <shaggy@austin.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] BUG() in exec_mmap()
In-Reply-To: Your message of "Thu, 09 Oct 2003 17:47:19 -0300."
Date: Thu, 09 Oct 2003 21:01:11 -0400
From: Ernie Petrides <petrides@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, 9-Oct-2003 at 17:47 -0300, Marcelo Tosatti wrote:

> On Thu, 9 Oct 2003, Mika Penttilä wrote:
>
> > Hmm.. you still need to mmput(old_mm) etc, just remove the mm_users == 1
> > optimization from the beginning of exec_mmap, so this patch is wrong!
>
> Right. Ill fix it up by hand.

Mika is correct that the exit_mmap(old_mm) still needs to happen on the
last use of the "mm_struct".  But whether it's called directly from
exec_mmap() or indirectly from mmput() still needs to depend on the
value of "mm_users".

The original logic avoided the mmdrop(active_mm) call if there was an
old_mm, so I'd infer that the mm_struct reference count is not bumped
twice for both references from the task_struct (mm and active_mm).  So
the patch would need to be reworked to avoid the double decrement, too.

Sorry I missed the discussion on the original changes.  Was there a
race condition with another cpu gaining a reference in proc_pid_status()
or access_process_vm() or something like that?  Is it possible to just
use down_read(&old_mm->mmap_sem) and up_read(&old_mm->mmap_sem) inside
exec_mmap() around the optimized call to exit_mmap() instead?

Cheers.  -ernie
