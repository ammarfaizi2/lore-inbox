Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030395AbVIVPKx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030395AbVIVPKx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Sep 2005 11:10:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030397AbVIVPKx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Sep 2005 11:10:53 -0400
Received: from mx1.redhat.com ([66.187.233.31]:10711 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1030395AbVIVPKx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Sep 2005 11:10:53 -0400
Message-ID: <4332C87C.9CE47E8D@redhat.com>
Date: Thu, 22 Sep 2005 11:06:36 -0400
From: Dave Anderson <anderson@redhat.com>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.9-e.57enterprise i686)
X-Accept-Language: en
MIME-Version: 1.0
To: vgoyal@in.ibm.com
CC: "Eric W. Biederman" <ebiederm@xmission.com>,
       Morton Andrew Morton <akpm@osdl.org>,
       Fastboot mailing list <fastboot@lists.osdl.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [Fastboot] [PATCH] Kdump(x86): add note type NT_KDUMPINFO tokernel  
 core dumps
References: <20050921065633.GC3780@in.ibm.com> <m1mzm6ebqn.fsf@ebiederm.dsl.xmission.com> <43317980.D6AEA859@redhat.com> <m1d5n1cw89.fsf@ebiederm.dsl.xmission.com> <20050922140824.GF3753@in.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vivek Goyal wrote:

>
> > Ok.  The point here is to know which task/cpu called panic, rather
> > than to get the task_struct.   That makes a lot of sense, and is
> > cheap to get.  Any note on the crashing cpu that is not captured
> > by another cpu will give us that information.
> >
>
> That makes sense. Sheer presence of a particular note can identify the
> crashing cpu and no need to store "current". Only crashing cpu is going
> to store that note and that too after respective NT_PRSTATUS.
>
> > My primary concern is while the concept of a task_struct is pretty
> > stable who is to know how the kernel will change in the future.  So
> > if we don't need to export a task_struct pointer and merely need
> > to flag the cpu that called panic we can do that much more reliably.

Just flagging the cpu, and then mapping that to the stack pointer found in
the associated NT_PRSTATUS register set should work OK too.  It gets
a little muddy if it crashed while running on an IRQ stack, but it still can be
tracked back from there as well.  (although not if the crashing task overflowed
the IRQ stack)

The task_struct would be ideal though -- if the kernel's use of task_structs
changes in the future, well, then crash is going to need a serious re-write
anyway...  FWIW, netdump and diskdump use the NT_TASKSTRUCT note
note to store just the "current" pointer, and not the whole task_struct itself,
which would just be a waste of space in the ELF header for crash's purposes.
And looking at the gdb sources, it appears to be totally ignored.  Who
uses the NT_TASKSTRUCT note anyway?

>
> > We do need a way that we can test to see if a core dump
> > actually matches the vmlinux we are looking at.  Probably
> > this is capturing all of the information captured by linux/version.h
> > and linux/compile.h both at runtime and at compile time and
> > checking to see if they match.
> >
>
> I quickly browsed through "crash" code and looks like it is already doing
> similiar check (kernel.c, verify_version()). It seems to be retrieving
> "linux_banner" from core image and also retrieving banner string from vmlinux
> and trying to match. So if banner information can be directly read from the
> core image, probably there is no need to export it through notes.
>

That's correct.

Dave


