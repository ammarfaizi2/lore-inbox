Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266880AbUG1KrF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266880AbUG1KrF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 06:47:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266881AbUG1KrF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 06:47:05 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:43735 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S266880AbUG1Kqu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 06:46:50 -0400
Date: Wed, 28 Jul 2004 16:24:55 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Andrew Morton <akpm@osdl.org>, Keith Owens <kaos@sgi.com>,
       linux-kernel@vger.kernel.org, "Martin J. Bligh" <mbligh@aracnet.com>,
       fastboot@osdl.org
Subject: Re: Announce: dumpfs v0.01 - common RAS output API
Message-ID: <20040728105455.GA11282@in.ibm.com>
Reply-To: suparna@in.ibm.com
References: <16734.1090513167@ocs3.ocs.com.au> <20040725235705.57b804cc.akpm@osdl.org> <m1r7qw7v9e.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1r7qw7v9e.fsf@ebiederm.dsl.xmission.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 27, 2004 at 07:53:01PM -0600, Eric W. Biederman wrote:
> Andrew Morton <akpm@osdl.org> writes:
> 
> > Keith Owens <kaos@sgi.com> wrote:
> > >
> > >  * How do we get a clean API to do polling mode I/O to disk?
> > 
> > We hope to not have to.  The current plan is to use kexec: at boot time, do
> > a kexec preload of a small (16MB) kernel image.  When the main kernel
> > crashes or panics, jump to the kexec kernel.  The kexec kernel will hold a
> > new device driver for /dev/hmem through which applications running under
> > the kexec'ed kernel can access the crashed kernel's memory.
> 
> Hmm.  I think this will require one of the kernels to run at a
> non-default address in physical memory.
> 
> > Write the contents of /dev/hmem to stable storage using whatever device
> > drivers are in the kexeced kernel, then reboot into a real kernel
> > again.
> 
> And at this point I don't quite see why you would need /dev/hmem,
> as opposed to just using /dev/mem.

This differs a little from your earlier suggestion of requiring
a kernel to run from a non-default address. Martin suggested simply
reserving about 16MB of area in advance, so that just before kexecing
the new kernel with mem=16M, we save the first 16MB away into the
reserved space. /dev/hmem (oldmem ?) is a view into the old kernel's
memory, as opposed to /dev/mem.

> 
> Or will the crashing kernel save and compress the core dump to
> somewhere in ram and the dump kernel read it out from there? 
> 
> > That's all pretty simple to do, and the quality of the platform's crash
> > dump feature will depend only upon the quality of the platform's kexec
> > support.
> 
> Which will largely depend on the quality of it's device drivers...
>  
> > People have bits and pieces of this already - I'd hope to see candidate
> > patches within a few weeks.  The main participants are rddunlap, suparna
> > and mbligh.
> 
> I'm sorry I missed you then.  Unfortunately this is my busiest season at work
> so I wasn't able to make it to OLS this year :(
> 
> Does anyone have a proof of concept implementation?  I have been able to find

Yes, Hari has a nice POC implementation - it might make sense for him to post
it rightaway for you to take a look. Basically, in addition to hmem (oldmem),
the upcoming kernel exports an ELF core view of the saved register and memory 
state of the previous kernel as /proc/vmcore.prev (remember your suggestion 
of using an ELF core file format for dump ?), so one can use cp or scp to 
save the core dump to disk. He has a quick demo, where he uses gdb (unmodified) 
to open the dump and show a stack trace of the dumping cpu.

Regards
Suparna

> a little bit of time for this kind of thing lately and have just done
> the x86-64 port.  (You can all give me a hard time about taking a year
> to get back to it :)  I am in the process of breaking everything up
> into their individual change patches and doing a code review so I feel
> comfortable with sending the code to Andrew.  So this would be a very
> good time for me to look at any code for reporting a crash dump with
> a kernel started with kexec.
> 
> Eric

-- 
Suparna Bhattacharya (suparna@in.ibm.com)
Linux Technology Center
IBM Software Lab, India

