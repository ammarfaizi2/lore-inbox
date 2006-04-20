Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750942AbWDTT1t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750942AbWDTT1t (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 15:27:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750964AbWDTT1s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 15:27:48 -0400
Received: from victor.provo.novell.com ([137.65.250.26]:30888 "EHLO
	victor.provo.novell.com") by vger.kernel.org with ESMTP
	id S1750942AbWDTT1r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 15:27:47 -0400
Message-ID: <4447E081.4020404@novell.com>
Date: Thu, 20 Apr 2006 12:26:57 -0700
From: Crispin Cowan <crispin@novell.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050715)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
CC: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org, chrisw@sous-sol.org,
       linux-security-module@vger.kernel.org
Subject: Re: [RFC][PATCH 0/11] security: AppArmor - Overview
References: <20060419174905.29149.67649.sendpatchset@ermintrude.int.wirex.com>	 <1145470463.3085.86.camel@laptopd505.fenrus.org>	 <p73mzeh2o38.fsf@bragg.suse.de> <1145522524.3023.12.camel@laptopd505.fenrus.org>
In-Reply-To: <1145522524.3023.12.camel@laptopd505.fenrus.org>
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
> I actually posted a list of 10 things that I made up in 3 minutes; just
> going over those 10 would be a good start already since they're the most
> obvious ones..
>   
I had actually posted a response to those 10 questions in the previous
"remove LSM" thread. Here it is again.

> after all what does filename mean in a linux world with
> * hardlinks
If the policy lets you access /foo/bar/baz then you get to access
/foo/bar/baz, even if it is a hard link to /foo/bif.

Some would allege that this is a security "hole" in AppArmor. However,
AppArmor's design is that you only get to *create* that hard link if you
are either unconfined or your profile says you get to create it.
AppArmor implicitly trusts all non-confined processes, so anything they
do is ok, by definition.

> * chroot
In the currently shipping AppArmor that comes with SUSE Linux, the names
AppArmor sees are chroot-relative. The patch just posted fixes that and
the names AppArmor sees are now absolute, regardless of chroot jailing.

> * namespaces
> * bind mounts
As far as we know, our namespace support is fine; we mediate attempts to
modify namespaces (such as denying mount and umount) and requiring
cap_sys_chroot to modify the root of the namespace. If there are
instances where we are incorrect we would greatly appreciate a detailed
description of the issue (or better a testcase) so we can look at
resolving it.

> * unlink of open files
> * fd passing over unix sockets
AppArmor initially validates your access at open time, and there after
you can read&write to it without mediation. AppArmor re-validates your
access if policy is reloaded, you exec() a new program, you get passed
the fd from another process, or you call our change_hat() API.

So, if the file is unlinked or renamed while you have it open, and
policy says you don't have access to the new name, then:

    *  within the same process you get to keep accessing it until
          o  policy is reloaded by the administrator
          o  you call the change_hat() API
    *  in some other process, either a child or some process you passed
      an fd to, you don't get to access it because your access gets
      revalidated

Note that d_path still returns pathnames for files that have been
removed from the filesystem (that are open)
> * relative pathnames
If you access "../hosts.allow" AppArmor will canonicalize your path name
to /etc/hosts.allow before checking the policy.

> * multiple threads (where one can unlink+replace file while the other
> is in the validation code)
Can you show a specific case that you think would be a problem? Security
is the problem of allowing "good stuff" and blocking "bad stuff", and
that is hard to argue for complex cases that are not specific.

Crispin
-- 
Crispin Cowan, Ph.D.                      http://crispincowan.com/~crispin/
Director of Software Engineering, Novell  http://novell.com


