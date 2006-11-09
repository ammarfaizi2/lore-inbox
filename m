Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965513AbWKIQIV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965513AbWKIQIV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Nov 2006 11:08:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966013AbWKIQIV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Nov 2006 11:08:21 -0500
Received: from nf-out-0910.google.com ([64.233.182.189]:26759 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S965513AbWKIQIU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Nov 2006 11:08:20 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=JavwJFdMvsqxWZWn6i7+OKLan66gwynNCuE6fPruyvPWIbkkmjIkHgDg1twwielNH2WcvsDvnyRmUqgUFUtE9Kp4iLawG2aiu/5QWZ83P36bv0iYAVnowXzUQb9oAUx8WCQXiftbM2Rh5psbWnnoA9MBOAD2T0c/cxpen3xwqR0=
Message-ID: <eb97335b0611090808q4738d29ai88da69aab97a84aa@mail.gmail.com>
Date: Thu, 9 Nov 2006 08:08:17 -0800
From: "Zack Weinberg" <zackw@panix.com>
To: "Stephen Smalley" <sds@tycho.nsa.gov>
Subject: Re: RFC PATCH: apply security_syslog() only to the syslog() syscall, not to /proc/kmsg
Cc: "Chris Wright" <chrisw@sous-sol.org>, "Sergey Vlasov" <vsu@altlinux.ru>,
       linux-kernel@vger.kernel.org, jmorris@namei.org
In-Reply-To: <1163083837.12241.282.camel@moss-spartans.epoch.ncsc.mil>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <eb97335b0611072016y51e1625hcd6504fddfe9aa6c@mail.gmail.com>
	 <20061108102037.GA6602@sequoia.sous-sol.org>
	 <20061108154229.eb6d4626.vsu@altlinux.ru>
	 <20061109041400.GB6602@sequoia.sous-sol.org>
	 <1163083837.12241.282.camel@moss-spartans.epoch.ncsc.mil>
X-Google-Sender-Auth: 6d69b6d6a677b28a
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[some of you have seen this already in off-list discussion, but it
really should have gone to the list, apologies for the noise]

On 11/9/06, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> On Wed, 2006-11-08 at 20:14 -0800, Chris Wright wrote:
> > * Sergey Vlasov (vsu@altlinux.ru) wrote:
> > > Then what would you think about another solution:
> > >
> > >  1) When sys_syslog() is called with commands 2 (read) or 9 (get unread
> > >     count), additionally call security_syslog(1) to check that the
> > >     process has permissions to open the kernel log.  This change by
> > >     itself will not make any difference, because all existing
> > >     implementations of the security_ops->syslog hook treat the operation
> > >     codes 1, 2 and 9 the same way.
> > >
> > >  2) Change cap_syslog() and dummy_syslog() to permit commands 2 and 9
> > >     for unprivileged users, in addition to 3 and 10 which are currently
> > >     permitted.  This will not really permit access through sys_syslog()
> > >     due to the added security_syslog(1) check, but if a process somehow
> > >     got access to an open file descriptor for /proc/kmsg, it would be
> > >     able to read from it.  Also, because selinux_syslog() is not
> > >     changed, under SELinux the process will still need to have
> > >     additional privileges even if it has /proc/kmsg open.
> >
> > It's a bit clumsy in the extra caveats for sys_syslog and cap_syslog,
> > but does achieve what you're after.  We lose default checking on the
> > actual read access, but perhaps this is a fair tradeoff.  Stephen,
> > James do you have any issues with this for SELinux?
>
> It makes the already unfortunate coupling between the security modules
> and the core syslog code even worse, by making assumptions about how the
> security modules treat different type codes.  If you were to go down
> this route, I think you would want to map the type codes to abstract
> permissions in the core syslog code and only pass the abstract
> permissions to the security modules (so that they no longer see 2, 9,
> and 1 separately but as a single permission).  Might be nice to have
> actual #define's for the type codes too.
>
> We wouldn't want the SELinux checking changed; we can already run klogd
> confined by policy, and decomposition into privileged and unprivileged
> components is preferable to privilege bracketing within a single
> component.

I've been working on an alternate patch.  It is not ready yet, but
tell me how this sounds:

1) Move the security check from do_syslog to sys_syslog, as in my
original patch.
2) Add a call to security_syslog() to kmsg_open.
3) sys_syslog() operations 0 and 1 ("close" and "open" respectively -
both do precisely nothing) cease to call the security hook.  (This
part is so that a security module knows that a call of its ->syslog
hook with code 1 is an attempt to open /proc/kmsg, not a no-op
syslog(1, 0, 0).  Security modules never see code 0, on the principle
that close shouldn't ever fail.)

-- At this point the user visible semantics (in the default security
framework) are that a process without CAP_SYS_ADMIN cannot open
/proc/kmsg and cannot call any of the syslog() interfaces that
actually do stuff [except the one "dmesg" uses].  However, a process
without CAP_SYS_ADMIN will be able to issue a read() on a fd open on
/proc/kmsg if it somehow gets hold of one.  (This is a tidier way of
getting the semantics that Sergey's patches provide.)

Then I also want to have:

4) Change the default security policy modules (commoncap.c and
dummy.c) so that a process without CAP_SYS_ADMIN is allowed to open
/proc/kmsg provided that DAC allows it (i.e. provided that root has
gone and chowned it to the appropriate uid).  No change to SELinux is
required.

Part 4 allows me to run an *unmodified* klogd as an unprivileged user,
and just chown /proc/kmsg in the init script, rather than having to
modify klogd to open /proc/kmsg and then drop privileges.  (A SELinux
environment still requires modifications to klogd, but we were going
to have to do that anyway.)

[Possibly as long as we are futzing with syslog(), we ought to
consider renaming it to match glibc [which calls it klogctl()] and
defining some symbolic constants for all those opcode numbers.  Also I
really don't like the looks of the code for operations 3 and 4.  But
this is all tangential.]

[re Stephen's comment: I don't like the idea of mapping type codes to
abstract permissions in the core; that seems like more of a layering
violation than what we have now.  Surely it is the core's business to
say _what_ it is about to do, and the security module's to decide what
that means in terms of its privilege model.  I don't propose to change
SELinux, except insofar as (in my above plan) it would no longer see
certain operations on the syscall interface that don't do anything
anyway.]

zw
