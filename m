Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261413AbVATSNf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261413AbVATSNf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jan 2005 13:13:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261392AbVATSKz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jan 2005 13:10:55 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:14531 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S261484AbVATSI1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jan 2005 13:08:27 -0500
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, fastboot@lists.osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [Fastboot] Re: [PATCH 19/29] x86_64-kexec
References: <x86-64-vmlinux-fix-physical-addrs-11061198972723@ebiederm.dsl.xmission.com>
	<x86-64-entry64-1106119897218@ebiederm.dsl.xmission.com>
	<x86-config-kernel-start-1106119897152@ebiederm.dsl.xmission.com>
	<x86-64-config-kernel-start-11061198972987@ebiederm.dsl.xmission.com>
	<kexec-kexec-generic-11061198974111@ebiederm.dsl.xmission.com>
	<x86-machine-shutdown-1106119897775@ebiederm.dsl.xmission.com>
	<x86-kexec-11061198971773@ebiederm.dsl.xmission.com>
	<x86-crashkernel-1106119897532@ebiederm.dsl.xmission.com>
	<x86-64-machine-shutdown-11061198972282@ebiederm.dsl.xmission.com>
	<x86-64-kexec-11061198973999@ebiederm.dsl.xmission.com>
	<20050120155054.GD3170@stusta.de>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 20 Jan 2005 11:06:40 -0700
In-Reply-To: <20050120155054.GD3170@stusta.de>
Message-ID: <m14qhc561b.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk <bunk@stusta.de> writes:

> On Wed, Jan 19, 2005 at 12:31:37AM -0700, Eric W. Biederman wrote:
> >...
> > ---
> linux-2.6.11-rc1-mm1-nokexec-x86_64-machine_shutdown/arch/x86_64/kernel/crash.c
> Wed Dec 31 17:00:00 1969
> 
> > +++ linux-2.6.11-rc1-mm1-nokexec-x86_64-kexec/arch/x86_64/kernel/crash.c Tue
> Jan 18 23:14:06 2005
> 
> >...
> > +note_buf_t crash_notes[NR_CPUS];
> >...
> 
> After your patches, this global variable stays completely unused
> on x86_64 (for the i386 version, you added a usage).
>
> cu
> Adrian
> 
> BTW: Is external usage for crash_notes planned, or can it become static 
>      on both architectures?

A sharp eye.  That array is a key part of an ongoing conversation.

To analyze why a kernel crashed you need some information, beyond
simply the contents of memory at the time of the crash.

If that information is not static and obtainable at the time of the crash
machine_crash_shutdown() needs to capture that information.  

For the format of the information that crashed we can either use some
random structure, that you need to know to read kernel debug information
to interpret.  Or we can use a standard format, reducing the need
for magic in the interpretation process.  The introduction of
crash_notes is the first step is switching to using a standard format,
for the data to remove unnecessary dependencies between a kernel
and the tools that analyze it after it has crashed.

crash_notes is designed to be a set of per cpu buffers that hold
information captured just after a kernel has crashed.  So the usage
is expected to be very external.  How we communicate the address of
these per cpu buffers to analysis tools still needs to be addressed.
/proc/kallsyms?

As for internal users those will come when machine_crash_shutdown
becomes more than a noop on x86_64.

Eric
