Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267833AbUHRVrN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267833AbUHRVrN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Aug 2004 17:47:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267838AbUHRVrM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Aug 2004 17:47:12 -0400
Received: from chaos.analogic.com ([204.178.40.224]:50562 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S267833AbUHRVrE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Aug 2004 17:47:04 -0400
Date: Wed, 18 Aug 2004 17:46:39 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Robert White <rwhite@casabyte.com>
cc: "'William Lee Irwin III'" <wli@holomorphy.com>,
       "'DervishD'" <disposable1@telefonica.net>,
       "'Linux-kernel'" <linux-kernel@vger.kernel.org>
Subject: RE: setproctitle
In-Reply-To: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAA2ZSI4XW+fk25FhAf9BqjtMKAAAAQAAAAvgXAGuUD20CaadqFIQ1OWQEAAAAA@casabyte.com>
Message-ID: <Pine.LNX.4.53.0408181738120.17296@chaos>
References: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAA2ZSI4XW+fk25FhAf9BqjtMKAAAAQAAAAvgXAGuUD20CaadqFIQ1OWQEAAAAA@casabyte.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Aug 2004, Robert White wrote:

> -----Original Message-----
> From: linux-kernel-owner@vger.kernel.org [mailto:linux-kernel-owner@vger.kernel.org]
> On Behalf Of William Lee Irwin III
> Sent: Wednesday, August 18, 2004 1:59 AM
> To: DervishD
> Cc: Linux-kernel
> Subject: Re: setproctitle
>
> > The command-line arguments are being fetched from the process address
> > space, i.e. simply editing argv[] in userspace will have the desired
> > effect. Though this code is butt ugly.
>
> What prevents overrun when updating arg[]?
>
> What happens to all the little ps (etc.) programs when I munge together a *really*
> *long* title?
>
> Can the entirety of arg[] be moved to a newly allocated region, if so how?  (e.g.
> wouldn't I have to have access to overwrite mm->arg_start etc?
>
> I'd prefer a setthreadtitle(char * new_title) such that the individual threads in a
> process (including the master thread, and so setproctitle() function is covered)
> could be re-titled to declare their purposes.  It would make debugging and logging a
> lot easier and/or more meaningful sometimes. 8-)
>
> It would also let the system preserve the original invocation and args for the
> lifetime of the process to prevent masquerading.  You know, by default the title is
> the args, but the set operation would build the new title in a new kernel-controlled
> place and move the pointer.
>
> I'd be willing to work on this if there is interest.
>
> Rob.
>

Currently the *argv[], the args themselves, and the environment
are on the stack when _start is called.

#
#	This is the entry point, usually the first thing in the text
#	segment. The SVR4/i386 ABI (pages 3-31, 3-32) says that upon
#	entry most registers' values are unspecified, except for:
#
#   %edx	Contains a function pointer to be registered with `atexit'.
#   		This is how the dynamic linker arranges to have DT_FINI
#		functions called for shared libraries that have been loaded
#		before this code runs.
#
#   %esp	The stack contains the arguments and environment:
#   		(%esp)			argc
#		4(%esp)			argv[0]
#		...
#		(4*argc)(%esp)		NULL
#		(4*(argc+1))(%esp)	envp[0]
#		...
#					NULL

So, overwriting the arguments will destroy the task's copy of
the environment. Fortunately _start code doesn't execute
a return. If it did, the destroyed stack would not contain
anything like a return address. Instead, _start executes the
"exit" system-call after executing any 'atexit' procedures.


Cheers,
Dick Johnson
Penguin : Linux version 2.4.26 on an i686 machine (5570.56 BogoMips).
            Note 96.31% of all statistics are fiction.


