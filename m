Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261603AbUCBLJY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Mar 2004 06:09:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261607AbUCBLJY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Mar 2004 06:09:24 -0500
Received: from mx1.redhat.com ([66.187.233.31]:16358 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261603AbUCBLJL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Mar 2004 06:09:11 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16452.27477.406689.897618@neuro.alephnull.com>
Date: Tue, 2 Mar 2004 06:09:09 -0500
From: Rik Faith <faith@redhat.com>
To: Olaf Kirch <okir@suse.de>
Cc: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][RFC] Light-weight Auditing Framework
In-Reply-To: [Olaf Kirch <okir@suse.de>] Tue  2 Mar 2004 10:44:38 +0100
References: <16451.25789.72815.763592@neuro.alephnull.com>
	<20040301194501.A9080@infradead.org>
	<16451.40189.997259.379123@neuro.alephnull.com>
	<20040302094438.GA13735@suse.de>
X-Key: 7EB57214; 958B 394D AD29 257E 553F  E7C7 9F67 4BE0 7EB5 7214
X-Url: http://www.redhat.com/
X-Mailer: VM 7.17; XEmacs 21.4; Linux 2.4.22-1.2163.nptl (neuro)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue  2 Mar 2004 10:44:38 +0100,
   Olaf Kirch <okir@suse.de> wrote:
> I've looked at your patch.

Hi Olaf.  Thanks for your comments.

> However, I wonder your approach is sufficient to obtain certification.
> The first thing that jumped at me was your comment that "netlink may
> lose packets".  This is an absolute show-stopper for CAPP compliance.

I didn't mean to imply that netlink was unreliable -- the drops aren't
arbitrary: you can detect them and you can decide if and when to drop.
Any logging system will have the problem of consuming kernel memory for
messages that are on their way to user-space.  For those not interested
in CAPP compliance, the drops are tunable based on rate and size
("backlog" in the code).  For those who are interested in CAPP, these
limits would not be in place, and total system memory would be the
limiting factor.

> A better approach may be to have the kernel write audit records
> directly to the audit trail; this solves both the record loss issue
> and improves performance.

This seems like it would solve several problems.  I'll have to think
about it more.  (You still have to worry about what happens when the
drive is too slow for the message rate, how to detect this, and,
perhaps, how to limit its impact on systems where reliable delivery of
messages is not absolutely critical.  With netlink, these worries are
easy to deal with.)

> Another issue is that you have system calls such as link or rename
> that consume two path name arguments, and your system call record
> needs to identify which is which.

In order to keep the kernel-space piece tiny, I think the user-space
daemon should do as much of this work as possible.  For example,
sys_rename always calls getname(oldname) before getname(newname), so it
is possible to tell which is which in user space.

> In general, I wonder how your frame work will audit other, non-pathname
> system call arguments. Is that entirely a decision of the security
> module? If so, then why create a generic audit framework at all?

Yes, that is a decision of the security module.  The security module is
already looking at the arguments it believes to be important, so adding
additional overhead for auditing those arguments seems redundant.  The
generic audit framework is providing more general services, such as the
netlink transport and the syscall entry/exit hooks services that can be
used to audit the syscall that was running when an auditable event
occurred.  I.e., we probably don't want every security module using a
netlink number and patching entry.S.

> In general, there is a question of whether the security framework
> could be sufficient for auditing purposes. As it stands now, I can see
> two shortcomings. The obvious one is that most security operations are
> performed _before_ the operation, while audit records need to include the
> outcome of the system call, so they are performed _after_ the operation.
> That is something that could be solved the way your patch seems to be
> doing it, i.e. flag the ongoing system call "interesting" and intercept
> the syscall return.

Yes, the patch handles this.  The sequence is:
    1) syscall entry: build audit context
    2) security operation detects auditable event and sets flag
    3) syscall exit: if flag is set, syscall-specific record emitted

The audit framework doesn't know enough to do #2 -- that's the role of
the security module.

> The second issue with security operations though is that it is far from
> clear if we cover all "relevant" system calls. CAPP is not very clear
> regarding what is "relevant". For instance it's far from obivous to me
> whether a system that fails with EFAULT or EINVAL needs to be audited
> or not.

I don't have an interpretation of CAPP either, but I will explore ways
to make these two points easier to deal with.

> The motivation behind these two objectives is quite different: audit
> wants to capture security relevant operations, and deliver the events
> reliably. Debugging doesn't care about reliability, but OTOH wants to
> capture as wide a selection of system call events as possible.

In addition to delivering the audit trail to user-space, both objectives
may also require adding hooks to entry.S.  If delivery and hooking is
useful for both, we should provide it only once inside the kernel.  I've
tried to provide a generic framework that can be used as a service for
different objectives, with tuning that can favor one objective over the
other.  It can grow to have more features, but I'm not sure if much can
be taken away (auditsc.c can be eliminated, but then you lose the
entry.S hooks).

