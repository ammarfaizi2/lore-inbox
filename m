Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161837AbWKIUz2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161837AbWKIUz2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Nov 2006 15:55:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161838AbWKIUz2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Nov 2006 15:55:28 -0500
Received: from zombie.ncsc.mil ([144.51.88.131]:61085 "EHLO jazzdrum.ncsc.mil")
	by vger.kernel.org with ESMTP id S1161837AbWKIUz1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Nov 2006 15:55:27 -0500
Subject: Re: RFC PATCH: apply security_syslog() only to the syslog()
	syscall, not to /proc/kmsg
From: Stephen Smalley <sds@tycho.nsa.gov>
To: Zack Weinberg <zackw@panix.com>
Cc: Chris Wright <chrisw@sous-sol.org>, Sergey Vlasov <vsu@altlinux.ru>,
       linux-kernel@vger.kernel.org, jmorris@namei.org
In-Reply-To: <eb97335b0611090939x7afbca7fkb5da56a15f0895c0@mail.gmail.com>
References: <eb97335b0611072016y51e1625hcd6504fddfe9aa6c@mail.gmail.com>
	 <20061108102037.GA6602@sequoia.sous-sol.org>
	 <20061108154229.eb6d4626.vsu@altlinux.ru>
	 <20061109041400.GB6602@sequoia.sous-sol.org>
	 <1163083837.12241.282.camel@moss-spartans.epoch.ncsc.mil>
	 <eb97335b0611090808q4738d29ai88da69aab97a84aa@mail.gmail.com>
	 <1163090431.12241.358.camel@moss-spartans.epoch.ncsc.mil>
	 <eb97335b0611090939x7afbca7fkb5da56a15f0895c0@mail.gmail.com>
Content-Type: text/plain
Organization: National Security Agency
Date: Thu, 09 Nov 2006 15:53:28 -0500
Message-Id: <1163105609.12241.395.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1.1 (2.8.1.1-3.fc6) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-11-09 at 09:39 -0800, Zack Weinberg wrote:
> On 11/9/06, Stephen Smalley <sds@tycho.nsa.gov> wrote:
> > Unless I missed something, your plan above would disable SELinux
> > syslog-related permission checking upon reads of a previously opened
> > file descriptor to /proc/kmsg.  So it would change SELinux behavior in a
> > way that is directly contrary to the notion of mandatory access control.
> 
> Yes, it would do that; no, I don't see why that change is contrary to
> the notion of mandatory access control.  An open fd on /proc/kmsg
> (with my changes applied) offers strictly fewer privileges than
> SYSTEM__SYSLOG_MOD (no access to opcodes 4 and 5), and with SELinux
> active, you can't get that open fd without having had
> SYSTEM__SYSLOG_MOD at some prior time.

Sure you can.  You can inherit or receive a descriptor opened by another
process that had that permission (and even accidental descriptor leakage
isn't as uncommon as you might think; SELinux has turned up numerous
cases of it).

>   SELinux does not (as far as I
> can tell) do MAC checks for access to normal files at read() time,
> only open().

Look for security_file_permission() calls in the core code, and its
implementation in SELinux (selinux_file_permission).  That is just a
revalidation of access to help with relabeling and policy changes,
albeit necessarily incomplete in coverage.  More crucially, SELinux
rechecks descriptors on inheritance across execve
(flush_unauthorized_files) and transfer across local IPC
(selinux_file_receive) to prevent unauthorized propagation of access
rights in the first place.  

> I see this as bringing /proc/kmsg in line with standard Unix file
> permission semantics, overall.

It may fit with Linux DAC checking, but it isn't what we want for MAC.
You also have to be careful about drawing an analogy to typical Linux
permission checking, since this is proc rather than a normal filesystem.

> > But having a mapping in the core to a much
> > smaller set of permissions would be even better, and help with
> > maintenance; the next time someone added a new code, they would more
> > likely see the mapping table in the core and update it than go digging
> > into the individual security modules.
> 
> But that mapping is itself a security policy decision, and could
> plausibly need to be done differently in different security modules...

Even the set of security hook interfaces and placements impose some
limits on security policies that can be implemented.  But just as those
hooks can be adjusted over time for the needs of new modules, the
mapping can be adjusted over time as needed.  No harm done, and some
benefit. 

-- 
Stephen Smalley
National Security Agency

