Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262693AbVBCJDZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262693AbVBCJDZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 04:03:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262437AbVBCJDZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 04:03:25 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:20866 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S262840AbVBCJC6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 04:02:58 -0500
To: Itsuro Oda <oda@valinux.co.jp>
Cc: Koichi Suzuki <koichi@intellilink.co.jp>, Vivek Goyal <vgoyal@in.ibm.com>,
       Andrew Morton <akpm@osdl.org>, fastboot <fastboot@lists.osdl.org>,
       lkml <linux-kernel@vger.kernel.org>, Maneesh Soni <maneesh@in.ibm.com>,
       Hariprasad Nellitheertha <hari@in.ibm.com>,
       suparna bhattacharya <suparna@in.ibm.com>
Subject: Re: [Fastboot] [PATCH] Reserving backup region for kexec based crashdumps.
References: <4200861B.7040807@intellilink.co.jp>
	<m1brb39e98.fsf@ebiederm.dsl.xmission.com>
	<20050203154433.18E4.ODA@valinux.co.jp>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 03 Feb 2005 02:00:51 -0700
In-Reply-To: <20050203154433.18E4.ODA@valinux.co.jp>
Message-ID: <m14qgu81bw.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Itsuro Oda <oda@valinux.co.jp> writes:

> Hi,
> 
> On 02 Feb 2005 08:24:03 -0700
> ebiederm@xmission.com (Eric W. Biederman) wrote:
> > 
> > So the kernel+initrd that captures a crash dump will live and execute
> > in a reserved area of memory.  It needs to know which memory regions
> > are valid, and it needs to know small things like the final register
> > state of each cpu. 
> 
> Exactly.
> 
> Please let me clarify what you are going to.
> 1) standard kernel: reserve a small contigous area for a dump kernel
>    (this is not changed as the current code)
> 2) standard kernel: export the information of valid physical memory
>    regions. (/proc/iomem or /proc/cpumem etc.)
> 3) kexec (system call?): store the information of valid physical memory
>    regions as ELF program header to the reserved area (mentioned 1)).

A better description is probably make a list of memory regions
using an ELF header data structure in user space.  
Use sys_kexec_load to put that list the dump kernel and a little
big of glue code in the reserved area.  The glue code includes
a hash of all of everything so it can all be validated before
use.

> 4) standard kernel: when a panic occur, append (ex.) the register
>    information as ELF note after the memory information (if necessary).
>    and jump new kernel

Record the register information as ELF notes in a per cpu data
area.  The per cpu data areas are known and enumerated in
the list of memory regions.  The kernel knows nothing about
the ELF header etc.

> 5) dump kernel: export all valid physical memory (and saved register
>    information) to the user. (as /dev/oldmem /proc/vmcore ?)

Or in user space, by just mmaping /dev/mem. That is part of the
current conversation.   The only real point for putting that code in
the kernel (besides momentum) is it is a cheap way to get the exact
data structures of the kernel you are using.  But since:
(a) it does not look like any primary kernel data structures need to
    be examined.
(b) even simple compile options like SMP/NOSMP are enough to change
    the layout of the data structures.
I think there is a pretty good case for moving all of the work to
user space.  But you still need a kernel that loads and
runs in the reserved area.

> Is this correct ?  one question: how the dump kernel know the saved
> area of ELF headers ?

A command line parameter will be passed.  Probably
elfcorehdr=xxx 

> one more question: I don't understand what the 640K backup area is. 
> Please let me know why it is necessary.

In practice I think we can kill it on x86.  It is necessary (at least
a subset of it is) if we want to boot a SMP kernel.  As cpu must
start running code in the first 1M of the address space.  In addition
some architectures have exceptions vectors and or other data
structures at fixed locations in memory so in the general case a
backup area is required.  So building the infrastructure to handle
backup areas is needed even, even if we later stop using it on
x86.

The other reason for the 640K backup area is the IBM guys were having
problems without it.   The fact that you don't need it is a good
indication that it is unnecessary.

Eric
