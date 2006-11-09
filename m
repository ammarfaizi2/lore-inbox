Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423819AbWKIOwb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423819AbWKIOwb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Nov 2006 09:52:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423822AbWKIOwb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Nov 2006 09:52:31 -0500
Received: from mummy.ncsc.mil ([144.51.88.129]:62349 "EHLO jazzhorn.ncsc.mil")
	by vger.kernel.org with ESMTP id S1423819AbWKIOwb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Nov 2006 09:52:31 -0500
Subject: Re: RFC PATCH: apply security_syslog() only to the syslog()
	syscall, not to /proc/kmsg
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Chris Wright <chrisw@sous-sol.org>
Cc: Sergey Vlasov <vsu@altlinux.ru>, Zack Weinberg <zackw@panix.com>,
       linux-kernel@vger.kernel.org, jmorris@namei.org
In-Reply-To: <20061109041400.GB6602@sequoia.sous-sol.org>
References: <eb97335b0611072016y51e1625hcd6504fddfe9aa6c@mail.gmail.com>
	 <20061108102037.GA6602@sequoia.sous-sol.org>
	 <20061108154229.eb6d4626.vsu@altlinux.ru>
	 <20061109041400.GB6602@sequoia.sous-sol.org>
Content-Type: text/plain
Organization: National Security Agency
Date: Thu, 09 Nov 2006 09:50:36 -0500
Message-Id: <1163083837.12241.282.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1.1 (2.8.1.1-3.fc6) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-11-08 at 20:14 -0800, Chris Wright wrote:
> * Sergey Vlasov (vsu@altlinux.ru) wrote:
> > Then what would you think about another solution:
> > 
> >  1) When sys_syslog() is called with commands 2 (read) or 9 (get unread
> >     count), additionally call security_syslog(1) to check that the
> >     process has permissions to open the kernel log.  This change by
> >     itself will not make any difference, because all existing
> >     implementations of the security_ops->syslog hook treat the operation
> >     codes 1, 2 and 9 the same way.
> > 
> >  2) Change cap_syslog() and dummy_syslog() to permit commands 2 and 9
> >     for unprivileged users, in addition to 3 and 10 which are currently
> >     permitted.  This will not really permit access through sys_syslog()
> >     due to the added security_syslog(1) check, but if a process somehow
> >     got access to an open file descriptor for /proc/kmsg, it would be
> >     able to read from it.  Also, because selinux_syslog() is not
> >     changed, under SELinux the process will still need to have
> >     additional privileges even if it has /proc/kmsg open.
> 
> It's a bit clumsy in the extra caveats for sys_syslog and cap_syslog,
> but does achieve what you're after.  We lose default checking on the
> actual read access, but perhaps this is a fair tradeoff.  Stephen,
> James do you have any issues with this for SELinux?

It makes the already unfortunate coupling between the security modules
and the core syslog code even worse, by making assumptions about how the
security modules treat different type codes.  If you were to go down
this route, I think you would want to map the type codes to abstract
permissions in the core syslog code and only pass the abstract
permissions to the security modules (so that they no longer see 2, 9,
and 1 separately but as a single permission).  Might be nice to have
actual #define's for the type codes too.

We wouldn't want the SELinux checking changed; we can already run klogd
confined by policy, and decomposition into privileged and unprivileged
components is preferable to privilege bracketing within a single
component.

-- 
Stephen Smalley
National Security Agency

