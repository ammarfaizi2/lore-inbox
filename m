Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262385AbSJVXKD>; Tue, 22 Oct 2002 19:10:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262397AbSJVXKC>; Tue, 22 Oct 2002 19:10:02 -0400
Received: from d06lmsgate-5.uk.ibm.com ([195.212.29.5]:28407 "EHLO
	d06lmsgate-5.uk.ibm.com") by vger.kernel.org with ESMTP
	id <S262385AbSJVXKB>; Tue, 22 Oct 2002 19:10:01 -0400
Subject: Re: 2.4 Ready list - Kernel Hooks
To: Werner Almesberger <wa@almesberger.net>
Cc: Rob Landley <landley@trommello.org>, linux-kernel@vger.kernel.org,
       "S Vamsikrishna" <vamsi_krishna@in.ibm.com>
X-Mailer: Lotus Notes Release 5.0.7  March 21, 2001
Message-ID: <OFD4366ECB.CE549043-ON80256C5A.007614F9@portsmouth.uk.ibm.com>
From: "Richard J Moore" <richardj_moore@uk.ibm.com>
Date: Wed, 23 Oct 2002 00:09:38 +0100
X-MIMETrack: Serialize by Router on D06ML023/06/M/IBM(Release 5.0.9a |January 7, 2002) at
 23/10/2002 00:15:59
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Werner Almesberger wrote:

>Richard J Moore wrote:
>> Kernel Hooks is also ready,
>
>I'm a bit puzzled as to what those hooks accomplish. They look
>like a less flexible but a little faster and more portable
>variant of kprobes.
>
>Is this what they are ? If yes, does it really make sense to
>have two so similar mechanisms for tapping into execution flows
>in the kernel ?
>
>- Werner

Hello Werner, the two things are different:

kprobes
-------

This is kernel interface that allows kernel modules register to register
one or more probes.
A probes comprises a breakpoint location, a breakpoint handler and a post
single-step handler.
Why use the term probes? Because we don't intend to hijack the system,
merely register a location where we can seamlessly gather data and
continue.
The sequence of events that occurs when code containing a probepoint
executes are:
1) The associated probe handler is invoked.
2) The probe handler returns.
3) The probed instruction is single-stepped.
4) The post-single-step handler is called.
5) The post-single-step handler returns.
6) The probed code continues execution.

kprobes confines itself to kernel-space probepoints, which are implemented
using a breakpoint instruction.
There are three incremental patches that Vamsi submitted today which extend
krpobes as follows:
1) debug register management - provides a kernel interface for debug
register allocation and deallocation so debuggers can co-exists e.g
kprobes, ptrace, kdb etc..
2) kwatch points - allows probes to be set using debug registers. This
allows probes to fire on data accesses for example.
3) user space probes - this extends kprobes to be able to set probepoints
in user space. Note probes are tracked by inode and offset so that they are
global and relative to a module. This distinguishes kprobes user-space
probes from ptrace implemented breakpoints.


dprobes
-------
The four kprobes patches is almost equivalent to dprobes. Dprobes provides
a generic RPN interpreter in which to define probe handler actions. We
decided that RPN interpreter should be separated out from the breakpointing
mechanism. It's just an example probe handler and can exist outside the
kernel. Also having a set of callable interfaces is more flexible than just
having an RPN language to define probe handlers. The dprobes project has
evolved in to kprobes + a sample device driver that provide the generic RPN
probe handler.

kernel hooks
------------
This is nothing more than a call-back mechanism such as could be used by
LSM or LTT. The call-backs have to be statically coded into the source
unlike kprobes where the call-back to a probe handler is implemented via a
debug interrupt from a watchpoint or dynamically implanted INT3. We created
kernel hooks for exactly the same reasons that LSM needs hooks - to allow
ancillary function to exist outside the kernel, to avoid kernel bloat, to
allow more than one function to be called from a given call-back (think of
kdb and kprobes - both need to be called from do_debug).

Yes both kprobes and kernel hooks implement call-backs, but using INT3 to
call functions is not the most efficient call mechanism, whereas implanting
call back dynamically for debugging purposes is a tad more difficult if
done by patching in a jmp or call instruction.

It's a case of horses for courses. kprobes is a debugging facility; kernel
hooks is a static call-back mechanism.

Richard

