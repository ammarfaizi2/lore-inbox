Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267091AbTAUOfb>; Tue, 21 Jan 2003 09:35:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267094AbTAUOfb>; Tue, 21 Jan 2003 09:35:31 -0500
Received: from facesaver.epoch.ncsc.mil ([144.51.25.10]:9163 "EHLO
	epoch.ncsc.mil") by vger.kernel.org with ESMTP id <S267091AbTAUOfa>;
	Tue, 21 Jan 2003 09:35:30 -0500
Message-Id: <200301211451.JAA02187@moss-shockers.ncsc.mil>
Date: Tue, 21 Jan 2003 09:51:43 -0500 (EST)
From: "Stephen D. Smalley" <sds@epoch.ncsc.mil>
Reply-To: "Stephen D. Smalley" <sds@epoch.ncsc.mil>
Subject: Re: [RFC][PATCH] Add LSM sysctl hook to 2.5.59
To: hch@infradead.org
Cc: linux-kernel@vger.kernel.org, linux-security-module@wirex.com,
       sds@epoch.ncsc.mil
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Content-MD5: An7ga72saic+/xx2Gtnt2Q==
X-Mailer: dtmail 1.2.0 CDE Version 1.2 SunOS 5.6 sun4u sparc 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Christoph Hellwig writes:
> I'm not very happy with this hook.  This means every single security
> module needs a list of all sensitive sysctl variables, i.e. we duplicate
> information in (possible a large number of) different places.
> 
> What's the reason you can't just live with DAC for sysctls?

For the same reason that we can't just live with DAC for file
permissions, signal permissions, etc. DAC mechanisms are fundamentally
inadequate for strong security.  They do not take into account
security-relevant information such as the role of the user, the
function and trustworthiness of the program, and the sensitivity and
integrity of the data.  They do not permit enforcement of a consistent
system-wide security policy.  They do not provide any protection
against malicious software.  These issues are discussed in the paper
available from http://www.nsa.gov/selinux/freenix01-abs.html.

Exempting sysctl variables from control by the mandatory security
policy leaves a rather significant vulnerability in your base system
security.  Do you truly want every process that runs with the root euid
to have access to your sysctl variables?  Even the Linux capabilities
would be too coarse-grained to be useful, but I don't think they are
relevant here, as neither ctl_perm nor proc_sys_permission check
capabilities (they both call test_perm, which is hardcoded to evaluate
the sysctl variable mode with a fixed notion of a root owner and group
attribute).

The sysctl hook does not mandate that a security module writer maintain
a list of sensitive sysctls.  Some security modules may simply choose
to implement a process-based restriction (e.g. only processes in the
FOO domain can modify sysctl variables).  But the hook does allow a
security module writer to optionally provide finer-grained control
based on the individual sysctl, e.g. to protect the modprobe variable
more carefully.  SELinux uses this finer-grained support.  The sysctl
variables can be mapped into equivalence classes based on the hierarchy
in the security policy configuration, so you don't have to maintain a
list of every individual sysctl variable.

It might be helpful to security module writers if the kernel gave a
hint as to its view of the "sensitivity" of a given sysctl variable,
but the actual protection of the sysctl variables is likely to vary
somewhat depending on the particular security policy/module.

--
Stephen Smalley, NSA
sds@epoch.ncsc.mil

