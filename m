Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932235AbVHHVMp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932235AbVHHVMp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 17:12:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932236AbVHHVMp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 17:12:45 -0400
Received: from nef2.ens.fr ([129.199.96.40]:28678 "EHLO nef2.ens.fr")
	by vger.kernel.org with ESMTP id S932235AbVHHVMp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 17:12:45 -0400
Date: Mon, 8 Aug 2005 23:12:41 +0200
From: David Madore <david.madore@ens.fr>
To: Linux Kernel mailing-list <linux-kernel@vger.kernel.org>
Subject: understanding Linux capabilities brokenness
Message-ID: <20050808211241.GA22446@clipper.ens.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.5.10 (nef2.ens.fr [129.199.96.32]); Mon, 08 Aug 2005 23:12:42 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

Like many people[#1][#2], I have found out that the Linux capability
handling utilities are non-functional, and cannot be repaired because
the kernel deliberately cripples capabilities (they are reset on every
call to execve()).  I have found that various people[#1][#2] have
proposed patches to restore working capabilities.  However, the matter
seems rather complicted and I would like to understand the full story.
Hours of Google-grepping through the lkml archives has not helped me
very much, so I hope someone can get the history straight.

I understand that Linux capabilities first appared seven or eight
years ago, and in 2000-06 there was a serious fault discovered which
caused a local root exploit through the use of the sendmail problem.
Rading [#3] and [#4], I understand that the problem was this:

  When sendmail is invoked by a non-root user, it attempts to drop its
  root privileges (which it has because the binary is installed suid)
  by calling setuid(getuid()), which, due to the stupidity of
  traditional Unix semantics enshrined in the POSIX/SUS standards,
  operates differently according to whether the process has
  "appropriate privileges" (in which case it sets all its UIDs to its
  real UID) or not (in which case it preserves the saved UID); now
  under Linux, "appropriate privileges" is defined[#5] as possessing
  the CAP_SETUID capability.  So if a non-root user manages to execute
  sendmail without the CAP_SETUID capability, the setuid(getuid())
  call will fail (or rather, not perform as expected), and the genie
  is out of the bottle.

However, what I do not understand is precisely _how_ one gets a
sendmail process without CAP_SETUID: for that is the heart of the
problem, and that is where the bug really was.  But [#3] and [#4] are
very obscure (and I found nothing conclusive in lkml archives).  I
understand that the problem lies in some combination of the
inheritable capability set and the CAP_SETPCAP capability, but I don't
see what that combination is.  Certainly removing capabilities from
the inheritable set should not prevent suid root programs from having
them reinstated (in the language of [#6], the suid root bit should
correspond to a full forced set of capabilities), so I don't see what
that has to do with it, and CAP_SETPCAP indeed allows to remove
capabilities from a given process but I don't see how the user could
gain that capability (and indeed if he can then we can expect him to
gain all capabilities very rapidly).

Can someone describe very accurately what the problem was?  And why
was it "fixed"[#7] by completely disabling capability inheritance and
also by disabling the CAP_SETPCAP capability?  In other words, suppose
I restore CAP_SETPCAP on my system and/or make capabilities fully
inheritable on execve() (that is, just take the logical AND of the
permitted set with the inheritable set, except if the executed program
is suid root, in which case all three sets - permitted, effective and
inheritable - are set to full): what is the security problem in this?

Assuming I want to make capabilities inheritable, is there a
recommended patch for doing so?  Alexander Nyberg's patch in [#1]
looks good to me (at least, it seems to do exactly what I want), but
how well has it been tested?  Is this something that might eventually
make its way into the official kernel, or is this a no-goer?  Also, if
the author happens to read this, I'd like an explanation on the "Is
this a root task that did seteuid before execve? if so it wanted its
effective permissions dropped" comment in cap_bprm_apply_creds().

Thanks!

-- 
     David A. Madore
    (david.madore@ens.fr,
     http://www.madore.org/~david/ )

[#1] <URL: http://groups-beta.google.com/group/fa.linux.kernel/browse_thread/thread/f76dcb9447a77c34 >

[#2] <URL: http://groups-beta.google.com/group/fa.linux.kernel/browse_thread/thread/4366e557a75a933d >

[#3] <URL: http://www.cs.berkeley.edu/~daw/papers/setuid-usenix02.pdf >

[#4] <URL: http://www.sendmail.org/sendmail.8.10.1.LINUX-SECURITY.txt >

[#5] I tend to think that the behavior of setuid() is wrong in the
first place, that is, setuid(getuid()) should also change the saved
UID as soon as the effective UID is zero, even if CAP_SETUID is not
set, to make sure that traditional Unix semantics are observed.  (More
recent, capability-aware, programs will use setresuid() anyway.)  But
that is rather beside the point.

[#6] <URL: http://ftp.kernel.org/pub/linux/libs/security/linux-privs/kernel-2.4/capfaq-0.2.txt >

[#7] I wanted to find exactly on which kernel version the changes took
place.  Unfortunately, <URL: http://lxr.linux.no/ > only has major
versions, the 2.2.15->2.2.16 patch is very hard to read, and I have
neither the patience nor the bandwidth to unpack entire kernel trees
on my PC to unravel the full history...
