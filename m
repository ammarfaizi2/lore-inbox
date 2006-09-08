Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752022AbWIHBII@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752022AbWIHBII (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Sep 2006 21:08:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752021AbWIHBII
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Sep 2006 21:08:08 -0400
Received: from nef2.ens.fr ([129.199.96.40]:30995 "EHLO nef2.ens.fr")
	by vger.kernel.org with ESMTP id S1752022AbWIHBIF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Sep 2006 21:08:05 -0400
Date: Fri, 8 Sep 2006 03:08:02 +0200
From: David Madore <david.madore@ens.fr>
To: Linux Kernel mailing-list <linux-kernel@vger.kernel.org>
Cc: "Serge E. Hallyn" <serue@us.ibm.com>
Subject: Re: patch to make Linux capabilities into something useful (v 0.3.1)
Message-ID: <20060908010802.GA14770@clipper.ens.fr>
References: <20060905212643.GA13613@clipper.ens.fr> <20060906182531.GA24670@sergelap.austin.ibm.com> <20060906222731.GA10675@clipper.ens.fr> <20060907230245.GB21124@sergelap.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060907230245.GB21124@sergelap.austin.ibm.com>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.5.10 (nef2.ens.fr [129.199.96.32]); Fri, 08 Sep 2006 03:08:03 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 07, 2006 at 06:02:45PM -0500, Serge E. Hallyn wrote:
> Ok, so to be clear, in terms of inheritability of capabilities, your
> three main changes are:

Yes, this is a fair description:

> 	1. When creating a bprm, it's inheritable and effective
> 	capability sets are set full on, whereas they used to be
> 	cleared.  The permitted set is treated as before (always
> 	cleared)

- This is to make capabilities inheritable but don't add any others
except when executing suid root.

> 	2. When computing a process' new capabilities, the new
> 	inheritable come from the new permitted, rather than the old
> 	inheritable.

- The reason for that is the necessity to preserve Unix semantics (see
below).

> 	3. You change half the computation of p'E to replace fE by
> 	pE in one half.

- Again, to preserve Unix semantics (if a process with {r,s}uid=0 and
euid!=0 does an exec(), the resulting process also has euid!=0, that
is, no effective capabilities).

> Here is one apparent change in behavior:
> 
> If I currently do
> 
> 	cp /bin/sh /bin/shsetuid
> 	chmod u+s /bin/shsetuid
> 
> then log in as uid 1000 and run
> 
> 	/bin/shsetuid
> 	# whoami
> 	hallyn
> 	# ls /root
> 	ls: /root: Permission denied

What does "currently" mean"?  On an unpatched Linux, I believe (and
observe) the following:

* if your /bin/sh is bash, it purposely drops privileges (by doing
something like setresuid(getuid(),getuid(),getuid()), I haven't
checked the source), and this is the reason you get "Permission
denied",

* if your /bin/sh is something else, it keeps euid==0 and you have
root privileges all the way, including in children processes - this is
traditional Unix behavior.

My patch doesn't change any of this (I've checked), since it uses
inheritance rules for capabilities which are closely modeled upon
those of {r,s,e}uid (in fact, that's my very reason for "changing"
things), and since the bash method of dropping privileges is also kept
woring.

(I don't know *why* bash tries to drop privileges.  It's probably an
attempt at avoiding certain security problems, but I think it's a
rather bad one.)

> With your patch I believe it will succeed, since the sh process'
> inheritable set will be set to it's permitted set.

My patch doesn't change this behavior.  Evidently, if it did, it would
be very bad...

> Put another way:

I'm not sure why what follows is a restatement of what precedes, so
I'll answer differently.

> 	cap_set_proc("=i");
> 	execve("/bin/shsetuid");
> 
> I obviously wanted my inheritable set to be cleared, but running the
> setuid binary will end up resetting my inheritable set to a larger
> set.  Your goal of allowing the inheritable caps to be truly
> inheritable may make sense, but this part of it feels wrong, and
> changes current setuid behavior.

In the current (unpatched) Linux kernel, the inheritable set is
completely ignored anyway. :-( So certainly any attempt to make
something of it must change the behavior.

I agree that the above code snippet exhibits a difference of my patch
w.r.t. the capabilities(7)-documented behavior (or at least, might,
according to the way suid programs are interpreted), but this
difference is

(a) necessary in order not to break traditional Unix semantics
(children of a program with euid==0 also have euid==0, and the father
process can't avoid that), and

(b) necessary for security reasons (it is imperative that the parent
of a suid root process cannot prevent that process from keeping
privileges, otherwise we get the sendmail bug again).


To summarize my answer: as far as I know, my patch does not change
suid behavior: I've taken great care not to let that happen.  It does
change the documented inheritance behavior of capabilities, but that
is unavoidable.

PS: I should be releasing a new version of my patch, along with a
merged version of yours, very shortly.

-- 
     David A. Madore
    (david.madore@ens.fr,
     http://www.madore.org/~david/ )
