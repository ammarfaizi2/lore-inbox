Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263163AbVBDAqp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263163AbVBDAqp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 19:46:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263144AbVBDAqn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 19:46:43 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:39044 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S262699AbVBDAoW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 19:44:22 -0500
To: Itsuro Oda <oda@valinux.co.jp>
Cc: Koichi Suzuki <koichi@intellilink.co.jp>, Vivek Goyal <vgoyal@in.ibm.com>,
       Andrew Morton <akpm@osdl.org>, fastboot <fastboot@lists.osdl.org>,
       lkml <linux-kernel@vger.kernel.org>, Maneesh Soni <maneesh@in.ibm.com>,
       Hariprasad Nellitheertha <hari@in.ibm.com>,
       suparna bhattacharya <suparna@in.ibm.com>
Subject: Re: [Fastboot] [PATCH] Reserving backup region for kexec based crashdumps.
References: <20050203154433.18E4.ODA@valinux.co.jp>
	<m14qgu81bw.fsf@ebiederm.dsl.xmission.com>
	<20050204074755.18EA.ODA@valinux.co.jp>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 03 Feb 2005 17:41:48 -0700
In-Reply-To: <20050204074755.18EA.ODA@valinux.co.jp>
Message-ID: <m1k6pp9mwj.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Itsuro Oda <oda@valinux.co.jp> writes:

> Hi,
> 
> On 03 Feb 2005 02:00:51 -0700
> ebiederm@xmission.com (Eric W. Biederman) wrote:
> 
> > > 5) dump kernel: export all valid physical memory (and saved register
> > >    information) to the user. (as /dev/oldmem /proc/vmcore ?)
> > 
> > Or in user space, by just mmaping /dev/mem. That is part of the
> > current conversation.   The only real point for putting that code in
> > the kernel (besides momentum) is it is a cheap way to get the exact
> > data structures of the kernel you are using.  But since:
> > (a) it does not look like any primary kernel data structures need to
> >     be examined.
> > (b) even simple compile options like SMP/NOSMP are enough to change
> >     the layout of the data structures.
> > I think there is a pretty good case for moving all of the work to
> > user space.  But you still need a kernel that loads and
> > runs in the reserved area.
> > 
> I don't make sense. what do you mean ?
> 
> What we want to do when the system is crashed is storing the whole
> physical memory (and saved register information for x86 arch) to
> some place (ex. a disk partition) for later analysis. 
> So the basic requirments to the dump kernel is that:
>  * supply a method to access whole (valid) physical memory.
>  * supply a method to access the saved register information.
> 
> Does the kdump meet this requirment ? 

Yes, the discussion in this area is what is the best way to implement
this requirement.   How much should be in the kernel and how much
should be in user space.

At the moment things are broken but should be fixed shortly.
So what has been implemented are /dev/oldmem which provides access
to the old memory.  And /proc/vmcore which provides both the old
memory and the register information.

> (I am not interesting to /proc/vmcore. Constructing the vmcore
>  image is area of analysis tools. not kernel's task.)

There is a fine line there, as a simple ELF core dump has just enough
information to describe discontiguous memory, and to have an out of
band channel for register information.  Adding anything extra like
virtual addresses that match the kernel should be left for the
crash dump analysis tools.

In code that is currently in the mainstream kernel /dev/mem can
mmap any area of memory that is not used by the kernel as ram.
So what I believe we will end up is that /sbin/kexec (user space)
will prepare an ELF header (data) that describes the memory regions
and details where to find the kernels register information.  The
address of that ELF header will be passed to the crash dump
capture kernel and user space combination.  The something
(probably a user space program reading /dev/mem) will look
at the ELF header and save the already prepared ELF core
dump to disk.  Possibly doing little things like merging
the MAX_NR_CPUS note segments into one so it actually conforms
to the ELF spec.

This thread started as the design discussion before finishing
that part of the implementation.   The proof of concept
implementations have happened.  We have all seen this kind
of functionality implemented.  Now is the time to come up
with a good solid design that can be maintained and merged
into the mainline kernel and distros.    

So thank you for ask questions, it means we have a better chance 
of getting a solid design and a design that those people who
care about this functionality can use.  And with a little luck
we can all wind up on agreeing on the general principles.  You came in
a little late to this conversation so a lot of details have been
settled, but if you have a good argument for doing something another
way we can certainly look at that. 

Eric
