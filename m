Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030426AbVIVQdU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030426AbVIVQdU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Sep 2005 12:33:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030436AbVIVQdU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Sep 2005 12:33:20 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:48802 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1030427AbVIVQdU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Sep 2005 12:33:20 -0400
To: Dave Anderson <anderson@redhat.com>
Cc: vgoyal@in.ibm.com, Morton Andrew Morton <akpm@osdl.org>,
       Fastboot mailing list <fastboot@lists.osdl.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [Fastboot] [PATCH] Kdump(x86): add note type NT_KDUMPINFO
 tokernel   core dumps
References: <20050921065633.GC3780@in.ibm.com>
	<m1mzm6ebqn.fsf@ebiederm.dsl.xmission.com>
	<43317980.D6AEA859@redhat.com>
	<m1d5n1cw89.fsf@ebiederm.dsl.xmission.com>
	<20050922140824.GF3753@in.ibm.com> <4332C87C.9CE47E8D@redhat.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Thu, 22 Sep 2005 10:31:52 -0600
In-Reply-To: <4332C87C.9CE47E8D@redhat.com> (Dave Anderson's message of
 "Thu, 22 Sep 2005 11:06:36 -0400")
Message-ID: <m1zmq5awsn.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Anderson <anderson@redhat.com> writes:

> Just flagging the cpu, and then mapping that to the stack pointer found in
> the associated NT_PRSTATUS register set should work OK too.  It gets
> a little muddy if it crashed while running on an IRQ stack, but it still can be
> tracked back from there as well.  (although not if the crashing task overflowed
> the IRQ stack)

You can't track it back from the crashing cpu if the IRQ stack overflows
either.  So I would rather have crash confused when trying to find the
task_struct.  Then to have the kernel fail avoidably while attempting
to capture a core dump.  

Even if you overflow the stack wit a bit of detective work it should still
be possible to show the stack overflowed and correct for it when analyzing
the crash dump.  Doing anything like that from a crashing cpu (in a
reliable way) is very hard. 

> The task_struct would be ideal though -- if the kernel's use of task_structs
> changes in the future, well, then crash is going to need a serious re-write
> anyway...  FWIW, netdump and diskdump use the NT_TASKSTRUCT note
> note to store just the "current" pointer, and not the whole task_struct itself,
> which would just be a waste of space in the ELF header for crash's purposes.
> And looking at the gdb sources, it appears to be totally ignored.  Who
> uses the NT_TASKSTRUCT note anyway?

Good question, especially as the kernel exports whatever we have for
a task struct today in the ELF note.  No ABI compatibility is
maintained.

Given all of that I recommend an empty NT_TASKSTRUCT to flag the
crashing cpu, for now.

Eric
