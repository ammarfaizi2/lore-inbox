Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262438AbVBBP0U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262438AbVBBP0U (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Feb 2005 10:26:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262567AbVBBP0U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Feb 2005 10:26:20 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:6381 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S262438AbVBBP0A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Feb 2005 10:26:00 -0500
To: Koichi Suzuki <koichi@intellilink.co.jp>
Cc: Itsuro Oda <oda@valinux.co.jp>, Vivek Goyal <vgoyal@in.ibm.com>,
       Andrew Morton <akpm@osdl.org>, fastboot <fastboot@lists.osdl.org>,
       lkml <linux-kernel@vger.kernel.org>, Maneesh Soni <maneesh@in.ibm.com>,
       Hariprasad Nellitheertha <hari@in.ibm.com>,
       suparna bhattacharya <suparna@in.ibm.com>
Subject: Re: [Fastboot] [PATCH] Reserving backup region for kexec based crashdumps.
References: <1107271039.15652.839.camel@2fwv946.in.ibm.com>
	<m13bwgb8tb.fsf@ebiederm.dsl.xmission.com>
	<20050202154926.18D4.ODA@valinux.co.jp>
	<4200861B.7040807@intellilink.co.jp>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 02 Feb 2005 08:24:03 -0700
In-Reply-To: <4200861B.7040807@intellilink.co.jp>
Message-ID: <m1brb39e98.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Koichi Suzuki <koichi@intellilink.co.jp> writes:

> Itsuro Oda wrote:
> > Hi,
> > I can't understand why ELF format is necessary.
> > I think the only necessary information is "what physical address regions are
> > valid to read". This information is necessary for any
> > sort of dump tools. (and must get it while the system is normal.)
> > The Eric's /proc/cpumem idea sounds nice to me.
> 
> I agree.  Format conversion should be done in healthy system separately and we
> should restrict what to do while taking the dump as few as possible.  Conversion
> from just memory image to crash/lcrash format will be very useful to use
> existing tools and experiences.   I already have such tool and (if my
> administration allows) I can make such tool open. Let me do some paperwork.

The big part of the conversation that is happening right now is how
do we uncouple dependencies between the various parts as much as
possible.  There is nothing here about format conversions except
as to convert weird kernel formats into a stable interface.

There are 3 pieces of code interacting.
1) The primary kernel that will call panic.
2) The kernel+initrd that takes over.
3) The user space that sets it all up (/sbin/kexec) while the primary
   kernel is still in a sane state.

The goal is to make those 3 pieces as independent of each other as
reasonably possible.

So the kernel+initrd that captures a crash dump will live and execute
in a reserved area of memory.  It needs to know which memory regions
are valid, and it needs to know small things like the final register
state of each cpu.  For the set of valid memory regions it is the
intention to encode that as an array of ELF program headers.  The
information of what the final register contents were will be encoded
as ELF notes.  There will be one PT_NOTE segment per cpu that holds
the notes needed to encode a given cpu's final state.  It really
does not matter to implementation that captures each cpu's final
register state which format we record the data in so using a format
designed not to change is not a problem.  So all that needs
to be communicated to the kernel+initrd that captures a crash
dump is the location of an ELF header and it can figure out all of
the rest.

For the primary kernel except for remembering it's final cpu
register state as it dies it does nothing except jump to the 
crash recover kernel.  All of the interesting information will
be exported to user space.

/sbin/kexec is the glue that fills in the cracks.  While
the primary kernel is in a sane state it sets everything up including
finding out which memory areas need to be looked at.  And it stashes
it all in a reserved area of memory, that has never been the target
of DMA transfers.

The goal is to reduce the dependencies as much as possible.  So
an old stable kernel can take a crash dump of a new buggy kernel.
And so that you don't have to be running the latest and greatest
user space simply to set everything up.  Although it is still
better to require a user-space upgrade to cope with new
kernels than to require the crash capture kernel+initrd to
be upgraded.

Eric
