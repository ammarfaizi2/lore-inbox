Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262513AbVBBPpJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262513AbVBBPpJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Feb 2005 10:45:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262314AbVBBPpI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Feb 2005 10:45:08 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:9197 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S262585AbVBBPoS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Feb 2005 10:44:18 -0500
To: Vivek Goyal <vgoyal@in.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, fastboot <fastboot@lists.osdl.org>,
       lkml <linux-kernel@vger.kernel.org>, Maneesh Soni <maneesh@in.ibm.com>,
       Hariprasad Nellitheertha <hari@in.ibm.com>,
       suparna bhattacharya <suparna@in.ibm.com>
Subject: Re: [Fastboot] [PATCH] Reserving backup region for kexec based crashdumps.
References: <overview-11061198973484@ebiederm.dsl.xmission.com>
	<1106294155.26219.26.camel@2fwv946.in.ibm.com>
	<m1sm4v2p5t.fsf@ebiederm.dsl.xmission.com>
	<1106305073.26219.46.camel@2fwv946.in.ibm.com>
	<m17jm72fy1.fsf@ebiederm.dsl.xmission.com>
	<1106475280.26219.125.camel@2fwv946.in.ibm.com>
	<m18y6gf6mj.fsf@ebiederm.dsl.xmission.com>
	<1106833527.15652.146.camel@2fwv946.in.ibm.com>
	<m1zmyueh4c.fsf@ebiederm.dsl.xmission.com>
	<1106917583.15652.234.camel@2fwv946.in.ibm.com>
	<m1r7k5e1ql.fsf@ebiederm.dsl.xmission.com>
	<1107271039.15652.839.camel@2fwv946.in.ibm.com>
	<m13bwgb8tb.fsf@ebiederm.dsl.xmission.com>
	<1107338864.11609.35.camel@2fwv946.in.ibm.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 02 Feb 2005 08:42:20 -0700
In-Reply-To: <1107338864.11609.35.camel@2fwv946.in.ibm.com>
Message-ID: <m17jlr9der.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vivek Goyal <vgoyal@in.ibm.com> writes:

> On Tue, 2005-02-01 at 20:56, Eric W. Biederman wrote:
> > Vivek Goyal <vgoyal@in.ibm.com> writes:
> 
> "elfcorehdr=" also looks good.

Then let's go with that for now.  It is not perfect but it seems
a little more self explanatory at first glance.

> > A clarification on terminology we are talking about struct Elf64_Phdr
> > here.  There is only one Elf header.  That seems to be clear farther
> > down.
> > 
> 
> 
> Exactly. There shall be one Elf header for whole of the image. In
> addition there will be one struct Elf64_Phdr, per contiguous physical
> memory area. One Elf64_Phdr of PT_NOTE type for notes section and one
> Elf64_Phdr for backup region.

Actually if we are just pointing a kernel data structures we will
need multiple Elf64_Phdr of PT_NOTE.  Each cpu has it's own
notes section and until the smoke clears we can't be confident
about what is going to wind up there or how densely those will
be packed.  So collapsing everything into a single notes segment
needs to happen after we have switched to the crash capture kernel.

> > I have serious concerns about the kernel generating the ELF headers
> > and only delivering them after the kernel has crashed.  Because
> > then we run into questions of what information can be trusted.  If we
> > avoid that issue I am not too concerned.
> 
> 
> I hope, all elf headers once prepared by kexec-tools need not to change
> later (Cannot think of any piece of information which shall change
> later). These shall be put in separate segment. And SHA-256 shall take
> care of authenticity of information after crash.

That should work fine.  We need to consider through throwing in an
extra note section with information like kernel version that
we can capture while the system is running.

> For notes section program header, virtual = physical = 0 and "offset"
> shall point to crash_notes[], so that notes can directly be read by the
> capture kernel (or user space).

I agree.  But see my caveat.  I think we should have one PT_NOTE
segment point at each element of the crash_notes[] array.  I know
it is technically a violation of the ELF spec.  But in this case
it makes sense.   Since we can't guarantee that crash_notes will
be packed properly I don't know that we could reliably see more
than one cpu if we pointed a PT_NOTE header at the whole thing.

If it turns out that we can reliably point a single PT_NOTE header
at crash_notes so much the better but things are likely to be
more robust if we don't start with that assumption.  That
at least allows us the freedom to capture some notes (like NT_UTSNAME)
before the kernel crashes.

Eric
