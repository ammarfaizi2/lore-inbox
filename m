Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261587AbUCBKLt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Mar 2004 05:11:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261595AbUCBKLs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Mar 2004 05:11:48 -0500
Received: from ns.suse.de ([195.135.220.2]:27042 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261587AbUCBKLn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Mar 2004 05:11:43 -0500
Date: Tue, 2 Mar 2004 10:44:38 +0100
From: Olaf Kirch <okir@suse.de>
To: Rik Faith <faith@redhat.com>
Cc: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][RFC] Light-weight Auditing Framework
Message-ID: <20040302094438.GA13735@suse.de>
References: <16451.25789.72815.763592@neuro.alephnull.com> <20040301194501.A9080@infradead.org> <16451.40189.997259.379123@neuro.alephnull.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <16451.40189.997259.379123@neuro.alephnull.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rik,

On Mon, Mar 01, 2004 at 03:28:45PM -0500, Rik Faith wrote:
> Different goals.  My goals are to provide a generic very-low-overhead
> auditing framework that can be used as a service by more complex systems
> (e.g., SELinux).  In contrast to Olaf's work, for example, my patch does
> not have intimate knowledge of system call parameters and semantics.
> This decreases the invasiveness of the patch and the work required for
> long-term maintainability.

I've looked at your patch. The idea to intercept path name arguments etc
inside getname and path_lookup is interesting. I had to jump through a lot
of hoops to prevent the caller from messing with the syscall arguments
inbetween the syscall and the audit intercept, and that made the code
a lot uglier than I had wanted.

This type of race condition is the major reason why I now believe
intercepting syscall entry/exit is not a good choice for auditing.
For debugging yes, but not for auditing.

However, I wonder your approach is sufficient to obtain certification.
The first thing that jumped at me was your comment that "netlink may
lose packets". This is an absolute show-stopper for CAPP compliance.
In general, during testing we noticed that passing audit from kernel to
a user land daemon can become a serious bottleneck. A better approach may
be to have the kernel write audit records directly to the audit trail;
this solves both the record loss issue and improves performance.

Another issue is that you have system calls such as link or rename
that consume two path name arguments, and your system call record
needs to identify which is which.

In general, I wonder how your frame work will audit other, non-pathname
system call arguments. Is that entirely a decision of the security
module? If so, then why create a generic audit framework at all?

In general, there is a question of whether the security framework
could be sufficient for auditing purposes. As it stands now, I can see
two shortcomings. The obvious one is that most security operations are
performed _before_ the operation, while audit records need to include the
outcome of the system call, so they are performed _after_ the operation.
That is something that could be solved the way your patch seems to be
doing it, i.e. flag the ongoing system call "interesting" and intercept
the syscall return.

The second issue with security operations though is that it is far from
clear if we cover all "relevant" system calls. CAPP is not very clear
regarding what is "relevant". For instance it's far from obivous to me
whether a system that fails with EFAULT or EINVAL needs to be audited
or not.

> I believe we need a light-weight, maintainable framework that is
> versatile enough to be used for non-security purposes (e.g., debugging).

I'd be happy if you could prove me wrong, but I believe that debugging and
(certifiable) system call auditing don't mix very well. They might be able
to share a minimal framework (e.g. for delivering an audit trail to user
land and/or a file).

The motivation behind these two objectives is quite different: audit
wants to capture security relevant operations, and deliver the events
reliably. Debugging doesn't care about reliability, but OTOH wants to
capture as wide a selection of system call events as possible.

Olaf
-- 
Olaf Kirch     |  Stop wasting entropy - start using predictable
okir@suse.de   |  tempfile names today!
---------------+ 
