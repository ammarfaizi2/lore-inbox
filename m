Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261948AbUCBVtb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Mar 2004 16:49:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261923AbUCBVtb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Mar 2004 16:49:31 -0500
Received: from mx1.redhat.com ([66.187.233.31]:3994 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261815AbUCBVt0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Mar 2004 16:49:26 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16453.354.904646.836231@neuro.alephnull.com>
Date: Tue, 2 Mar 2004 16:49:22 -0500
From: Rik Faith <faith@redhat.com>
To: Chris Wright <chrisw@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][RFC] Light-weight Auditing Framework
In-Reply-To: [Chris Wright <chrisw@osdl.org>] Mon  1 Mar 2004 12:26:18 -0800
References: <16451.25789.72815.763592@neuro.alephnull.com>
	<20040301122618.O22989@build.pdx.osdl.net>
X-Key: 7EB57214; 958B 394D AD29 257E 553F  E7C7 9F67 4BE0 7EB5 7214
X-Url: http://www.redhat.com/
X-Mailer: VM 7.17; XEmacs 21.4; Linux 2.4.22-1.2163.nptl (neuro)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon  1 Mar 2004 12:26:18 -0800,
   Chris Wright <chrisw@osdl.org> wrote:
> * Rik Faith (faith@redhat.com) wrote:
> > This note describes a patch against 2.6.4-rc1-bk2 that provides a
> > low-overhead system-call auditing framework for Linux that is usable by
> > LSM components (e.g., SELinux).  Comments will be appreciated.
> 
> Do you have an perf numbers for simply enabling the auditint framework?

Comparing no patch with the patch applied and booted with audit=1 (so
the audit context is allocated for each task and filled in for every
syscall, but not sent to user-space), using lmbench 2.0.4:

Processor, Processes - times in microseconds - smaller is better
----------------------------------------------------------------
Host                 OS  Mhz null null      open selct sig  sig  fork exec sh  
                             call  I/O stat clos TCP   inst hndl proc proc proc
--------- ------------- ---- ---- ---- ---- ---- ----- ---- ---- ---- ---- ----
1bk8stock Linux 2.6.3-b 2004 0.08 0.26 14.7 16.4 5.797 0.23 2.00 143. 443. 1804
4aon-nos  Linux 2.6.3-b 2004 0.21 0.40 14.5 16.7  12.0 0.40 2.19 136. 441. 1717



At a  higher level, I compiled the kernel three times with:
    export CCACHE_DISABLE=1
    make mrproper >& /dev/null
    cp arch/x86_64/defconfig .config
    yes '' | make oldconfig >& /dev/null
    time make > /dev/null


Situation                        Best time (of 3)                Factor

No output to user-space:
audit=0 (no audit context)       3:23.04u 34.560s 4:00.76 98%    1.000
audit=1 (audit context built)    3:23.47u 33.810s 4:01.02 98%    0.999
audit=1 (10 rules, no records)   3:28.39u 35.670s 4:07.48 98%    0.97

Output to user-space for _every_ syscall:
audit=1 (* all to /dev/null)     3:34.96u 1:16.98s 5:06.40 95%   0.79
audit=1 (** all to file)         4:22.82u 1:45.67s 7:11.51 85%   0.56

*  Every syscall for the whole compile was audited and logged to
   user-space.  The user-space daemon sent all messages to /dev/null.
** Every syscall for the whole compile was audited and logged to
   user-space.  The user-space daemon sent all messages to a file (which
   grew to 1.4GB on an IDE drive).  This is the worst case scenario.

> Seems to be a lot of use of likely/unlikely.  Are these actually useful
> optimizations?

The goal is for the non-auditing case to be as fast as possible, so all
of the likely/unlikely notations favor that case.

> Doesn't seem like CONFIG_AUDIT=n disables all the code.

The bit tests in entry.S are still there, but those are the same tests
that are used for ptrace, and there is nothing that sets the bits.  So,
aside from that test, all of the code should be disabled.

> Some basic CodingStyle bits:

Except where noted below, I have either incorporated all your
suggestions or made notes in the code to do so later.  The new patch is
at: http://people.redhat.com/faith/audit/audit-20040302.1632.patch

> +               ab = kmalloc(sizeof(*ab), GFP_ATOMIC);
> 
> need atomic allocations here?

These functions can be called in any context, so sleeping is not an
option.

> also, i wasn't clear on what makes sure the audit_buffers can't be
> overflown, the bits in vformat talking about 1024 bytes?

Yes, and the vsnprintf in audit_log_vformat.

