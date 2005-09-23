Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751291AbVIWFKM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751291AbVIWFKM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Sep 2005 01:10:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751295AbVIWFKM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Sep 2005 01:10:12 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:2792 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751291AbVIWFKK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Sep 2005 01:10:10 -0400
Date: Fri, 23 Sep 2005 10:39:50 +0530
From: Vivek Goyal <vgoyal@in.ibm.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Dave Anderson <anderson@redhat.com>, Morton Andrew Morton <akpm@osdl.org>,
       Fastboot mailing list <fastboot@lists.osdl.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [Fastboot] [PATCH] Kdump(x86): add note type NT_KDUMPINFO tokernel   core dumps
Message-ID: <20050923050950.GC3736@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
References: <20050921065633.GC3780@in.ibm.com> <m1mzm6ebqn.fsf@ebiederm.dsl.xmission.com> <43317980.D6AEA859@redhat.com> <m1d5n1cw89.fsf@ebiederm.dsl.xmission.com> <20050922140824.GF3753@in.ibm.com> <4332C87C.9CE47E8D@redhat.com> <m1zmq5awsn.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1zmq5awsn.fsf@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 22, 2005 at 10:31:52AM -0600, Eric W. Biederman wrote:
> Dave Anderson <anderson@redhat.com> writes:
> 
> > Just flagging the cpu, and then mapping that to the stack pointer found in
> > the associated NT_PRSTATUS register set should work OK too.  It gets
> > a little muddy if it crashed while running on an IRQ stack, but it still can be
> > tracked back from there as well.  (although not if the crashing task overflowed
> > the IRQ stack)
> 
> You can't track it back from the crashing cpu if the IRQ stack overflows
> either.  So I would rather have crash confused when trying to find the
> task_struct.  Then to have the kernel fail avoidably while attempting
> to capture a core dump.  
> 
> Even if you overflow the stack wit a bit of detective work it should still
> be possible to show the stack overflowed and correct for it when analyzing
> the crash dump.  Doing anything like that from a crashing cpu (in a
> reliable way) is very hard. 
> 
> > The task_struct would be ideal though -- if the kernel's use of task_structs
> > changes in the future, well, then crash is going to need a serious re-write
> > anyway...  FWIW, netdump and diskdump use the NT_TASKSTRUCT note
> > note to store just the "current" pointer, and not the whole task_struct itself,
> > which would just be a waste of space in the ELF header for crash's purposes.
> > And looking at the gdb sources, it appears to be totally ignored.  Who
> > uses the NT_TASKSTRUCT note anyway?
> 
> Good question, especially as the kernel exports whatever we have for
> a task struct today in the ELF note.  No ABI compatibility is
> maintained.
> 
> Given all of that I recommend an empty NT_TASKSTRUCT to flag the
> crashing cpu, for now.
>

I got a concern here. Are we not breaking the convention. NT_TASKSTRUCT note
type represents that task_sturct is stored in note data. elf_core_dump()
and /proc/kcore already do that (That's a different story that it might not 
be needed at all). Now if we store a null NT_TASKSTURCT, same note type will
carry two meanings.

IMHO, introducing a null NT_KDUMPINFO will help in that sense, at least 
there are no two interpretations of same note type. Also it provides the
scope to add more elements to it if need be.

Thanks
Vivek
