Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262104AbVCHTas@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262104AbVCHTas (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 14:30:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262098AbVCHTas
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 14:30:48 -0500
Received: from mx1.redhat.com ([66.187.233.31]:30407 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262083AbVCHT2X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 14:28:23 -0500
Message-ID: <422DFC52.D0F12E0B@redhat.com>
Date: Tue, 08 Mar 2005 14:26:10 -0500
From: Dave Anderson <anderson@redhat.com>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.9-e.49.4nmi_enterprise i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederm@xmission.com>
CC: vivek goyal <vgoyal@in.ibm.com>, Andrew Morton <akpm@osdl.org>,
       fastboot <fastboot@lists.osdl.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: Query: Kdump: Core Image ELF Format
References: <1110286210.4195.27.camel@wks126478wss.in.ibm.com>
		<422DC166.BFFF3CC0@redhat.com> <m13bv6m2hy.fsf_-_@ebiederm.dsl.xmission.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Eric W. Biederman" wrote:

> Dave Anderson <anderson@redhat.com> writes:
>
> > vivek goyal wrote:
> >
> > > Hi,
> > >
> > > Kdump (A kexec based crash dumping mechanism) is going to export the
> > > kernel core image in ELF format. ELF was chosen as a format, keeping in
> > > mind that gdb can be used for limited debugging and "Crash" can be used
> > > for advanced debugging.
> > >
> > > Core image ELF headers are prepared before crash and stored at a safe
> > > place in memory. These headers are retrieved over a kexec boot and final
> > > elf core image is prepared for analysis.
> > >
> > > Given the fact physical memory can be dis-contiguous, One program header
> > > of type PT_LOAD is created for every contiguous memory chunk present in
> > > the system. Other information like register states etc. is captured in
> > > notes section.
> > >
> > > Now the issue is, on i386, whether to prepare core headers in ELF32 or
> > > ELF64 format. gdb can not analyze ELF64 core image for i386 system. I
> > > don't know about "crash". Can "crash" support ELF64 core image file for
> > > i386 system?
> > >
> >
> > Not in its current state, but it can certainly be modified to do so.
> > The embedded gdb module never is even aware of the vmcore file.
> > (It is essentially executed as "gdb vmlinux").
> >
> > And currently crash only expects a single PT_LOAD section, but
> > that's due for a change.  It's been OK for its current set of supported
> > processors to use sparse file space for non-existent memory,
> > but it's kind of a pain with ia64's 256GB holes.
>
> Weird.  A sparse file.  I can almost see that but that looks like
> a really bad format to transport from one system to another.
>

Exactly.  Although the -S tar flag helps, and when uncompressed
it actually makes a smaller file on the receiving end because of
"real" zero-filled pages.

>
> > The point is that adapting crash to handle whatever format
> > you come up with is the easy part of the whole equation.
>
> Good.  Then the concentration should be a simple well understood
> format that we don't need to change all of the time.
>
> > > Given the limitation of analysis tools, if core headers are prepared in
> > > ELF32 format then how to handle PAE systems?
> > >
> >
> > Are you asking about what would be the p_vaddr values for the higher
> > memory segments?   FWIW, with the single-PT_LOAD segment currently
> > supported by crash, there's only one p_vaddr, but in any case, crash doesn't
> > use it, so PAE is not a problem.
>
> PAE (physical address extension) are 64bit addresses on a 32bit box.  So
> vivek real question was where do we put the bytes.

> Do I understand it correctly that crash currently just gets raw
> memory data and the register state from the core file?  Then it
> figures out the virtual to physical mapping by looking at vmlinux?
>
> Eric

Pretty much...

The register set is there, but it's been primarily used to figure out
the panic task from the kernel stack address there, although in later
dump versions, the NT_TASKSTRUCT notes section gives us the same thing.
Because of the various dump formats it's supported over time, yes, it
tries to glean the vast majority of the information it needs by using
the vmlinux file and raw data, and not rely on stuff in the various
different header formats.

In any case, I totally agree with your aims:

> What I aimed at was a simple picture of memory decorated with the
> register state.  We should be able to derive everything beyond that.
> And the fact that it is all in user space should make it straight
> forward to change if needed.
>

Dave Anderson


