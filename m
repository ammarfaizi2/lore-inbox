Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287134AbSALPzM>; Sat, 12 Jan 2002 10:55:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287139AbSALPyx>; Sat, 12 Jan 2002 10:54:53 -0500
Received: from ns.suse.de ([213.95.15.193]:37127 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S287134AbSALPyp>;
	Sat, 12 Jan 2002 10:54:45 -0500
Date: Sat, 12 Jan 2002 16:54:43 +0100
From: Andi Kleen <ak@suse.de>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Andi Kleen <ak@suse.de>, Andrew Morton <akpm@zip.com.au>,
        linux-kernel@vger.kernel.org,
        Manfred Spraul <manfreds@colorfullife.com>
Subject: Re: Q: behaviour of mlockall(MCL_FUTURE) and VM_GROWSDOWN segments
Message-ID: <20020112165443.A13179@wotan.suse.de>
In-Reply-To: <3C3F3C7F.76CCAF76@colorfullife.com.suse.lists.linux.kernel> <3C3F4FC6.97A6A66D@zip.com.au.suse.lists.linux.kernel> <p73r8ow4dd7.fsf@oldwotan.suse.de> <20020112163332.M1482@inspiron.school.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020112163332.M1482@inspiron.school.suse.de>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 12, 2002 at 04:33:32PM +0100, Andrea Arcangeli wrote:
> it doesn't (of course depends "what's the right thing"), and that's why

I think it does. Allocating all possible in future allocated pages
is just not possible for VM_GROWSDOWN, because the stack has really 
no suitable limit (other than rlimits, which are far too big to
mlock them) 

BTW expand_stack seems to have a small bug: it adds to mm->locked_vm
the complete offset from last vm_start; if it covers more than one page
the locked_vm value will be too large. 

> What the current kernel is doing with page faults, is to fault in only
> the touched pages, not the pages in between as well, this isn't a
> security concern because the faulted in pages won't be swapped out, but
> it may matter for some RT app, OTOH the RT apps would better memset the
> whole stack they need before assuming they won't get page faults, first
> of all because of all other kernels out there (this is what I mean with
> a matter of API).

For the stack they can get minor faults anyways when they allocate new
stack space below ESP. There is no good way to fix that from the kernel; the 
application has to preallocate its memory on stack. I think it's reasonable
if it does the same for holes on the stack. 

-Andi
