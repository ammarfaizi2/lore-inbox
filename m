Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262052AbTJJKya (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Oct 2003 06:54:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262054AbTJJKya
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Oct 2003 06:54:30 -0400
Received: from intra.cyclades.com ([64.186.161.6]:56979 "EHLO
	intra.cyclades.com") by vger.kernel.org with ESMTP id S262052AbTJJKyV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Oct 2003 06:54:21 -0400
Date: Fri, 10 Oct 2003 07:57:16 -0300 (BRT)
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
X-X-Sender: marcelo@logos.cnet
To: Ernie Petrides <petrides@redhat.com>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Mika Penttila <mika.penttila@kolumbus.fi>,
       Dave Kleikamp <shaggy@austin.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] BUG() in exec_mmap()
In-Reply-To: <200310100101.h9A11BeD011819@pasta.boston.redhat.com>
Message-ID: <Pine.LNX.4.44.0310100752190.1370-100000@logos.cnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 9 Oct 2003, Ernie Petrides wrote:

> On Thursday, 9-Oct-2003 at 17:47 -0300, Marcelo Tosatti wrote:
> 
> > On Thu, 9 Oct 2003, Mika Penttilä wrote:
> >
> > > Hmm.. you still need to mmput(old_mm) etc, just remove the mm_users == 1
> > > optimization from the beginning of exec_mmap, so this patch is wrong!
> >
> > Right. Ill fix it up by hand.
> 
> Mika is correct that the exit_mmap(old_mm) still needs to happen on the
> last use of the "mm_struct".  But whether it's called directly from
> exec_mmap() or indirectly from mmput() still needs to depend on the
> value of "mm_users".
> 
> The original logic avoided the mmdrop(active_mm) call if there was an
> old_mm, so I'd infer that the mm_struct reference count is not bumped
> twice for both references from the task_struct (mm and active_mm).  So
> the patch would need to be reworked to avoid the double decrement, too.

I dont get you, sorry (I'm not a real expert on that piece of code, 
so...).

>From what I understand the "if (old_mm && mm_users == 1)" if case is just 
an optimization to avoid the allocation of a new mm structure.

The functionality will be the same without that piece of code, it will 
just be slower. 

> Sorry I missed the discussion on the original changes.  Was there a
> race condition with another cpu gaining a reference in proc_pid_status()
> or access_process_vm() or something like that?  

Exactly.

> Is it possible to just use down_read(&old_mm->mmap_sem) and
> up_read(&old_mm->mmap_sem) inside exec_mmap() around the optimized call
> to exit_mmap() instead?

Doing that locking inside exit_mmap() not feasible IMO... it might be too 
expensive. 

