Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262340AbVAULP3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262340AbVAULP3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 06:15:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262342AbVAULP3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 06:15:29 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:20421 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S262340AbVAULPE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 06:15:04 -0500
To: Vivek Goyal <vgoyal@in.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, fastboot <fastboot@lists.osdl.org>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [Fastboot] [PATCH] Reserving backup region for kexec based crashdumps.
References: <overview-11061198973484@ebiederm.dsl.xmission.com>
	<1106294155.26219.26.camel@2fwv946.in.ibm.com>
	<m1sm4v2p5t.fsf@ebiederm.dsl.xmission.com>
	<1106305073.26219.46.camel@2fwv946.in.ibm.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 21 Jan 2005 04:13:10 -0700
In-Reply-To: <1106305073.26219.46.camel@2fwv946.in.ibm.com>
Message-ID: <m17jm72fy1.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On deeper review your patch as it stands is incomplete.  In particular
you don't provide a way to either hardcode or dynamically set
the area you are attempt to reserve to hold the backup region.

Vivek Goyal <vgoyal@in.ibm.com> writes:

> On Fri, 2005-01-21 at 13:24, Eric W. Biederman wrote:
> > Why do we need a separate region for this?
> > 
> > It should be simple enough to take 640 out of the area kexec reserves
> > for the crash dump kernel.  That is what the previous code implemented.
> 
> Previous code also reserved the backup memory region after crash kernel
> region. It is just a matter of interpretation. What I understand that
> crash kernel reserved region represents something where one can load the
> panic kernel directly and new kernel can use this memory region for
> memory allocation.

Yes the reservation is a hunk of memory reserved for use by the crashdump
process, or whatever happens after panic.  It is up to the loaded code
to define how that memory is used.  purgatory.ro is a legitimate part
of that loaded code.

> I don't want to steal the backup region from crash kernel region
> otherwise, I shall have to boot the crash kernel with some strange
> values like memmap=(32M-640k)@16M (symbolically) to prevent crash kernel
> overwriting backup region. Why to make user aware of location of backup
> region.

Making the user aware of the region makes it one more thing for the user
to be aware of and to manually manage.  Based on what was passed as
crashkernel=...  We should be able to automate all of the rest of it.
So a weird memmap= line should not be hard.

I will have to wait and see but it would not surprise me if we settled
on a fixed address per architecture for the reservation to make it
easier for various users.

On that note we probably want to move the magic that we are doing
for crashdumps into the linux loader (i.e. x86-linux-setup.c ) in
kexec-tools, as most of these pieces are specific to taking a
crashdump with linux.  Not that I expect we will be doing it with
anything else but...

 > Alternatively, this can be managed by reserving this backup region again
> in crash kernel to avoid any stomping. May be pass backup region
> location to new kernel through parameter segment or through command line
> but don't see a strong reason for doing that.

Probably the biggest reason for doing it in one reservation is that
it happens to be an implementation detail of the crashdump capture
kernel.  If that kernel is not SMP I believe you can safely leave the
first 640k alone.  I know at least one other effort has had success in
that area.

In general it is not good to make unnecessary implementation details
between two pieces of software be part of their interface.

Eric
