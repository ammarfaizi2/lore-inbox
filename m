Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751143AbWDSSdo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751143AbWDSSdo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 14:33:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751142AbWDSSdo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 14:33:44 -0400
Received: from victor.provo.novell.com ([137.65.250.26]:37323 "EHLO
	victor.provo.novell.com") by vger.kernel.org with ESMTP
	id S1751141AbWDSSdn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 14:33:43 -0400
Message-ID: <44468258.1020608@novell.com>
Date: Wed, 19 Apr 2006 11:32:56 -0700
From: Crispin Cowan <crispin@novell.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050715)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
CC: Karl MacMillan <kmacmillan@tresys.com>, Gerrit Huizenga <gh@us.ibm.com>,
       Christoph Hellwig <hch@infradead.org>, James Morris <jmorris@namei.org>,
       "Serge E. Hallyn" <serue@us.ibm.com>,
       Stephen Smalley <sds@tycho.nsa.gov>, casey@schaufler-ca.com,
       linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
       fireflier-devel@lists.sourceforge.net
Subject: Re: [RESEND][RFC][PATCH 2/7] implementation of LSM hooks
References: <E1FVtPV-0005zu-00@w-gerrit.beaverton.ibm.com>	 <1145381250.19997.23.camel@jackjack.columbia.tresys.com>	 <44453E7B.1090009@novell.com> <1145389813.2976.47.camel@laptopd505.fenrus.org>
In-Reply-To: <1145389813.2976.47.camel@laptopd505.fenrus.org>
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
> On Tue, 2006-04-18 at 12:31 -0700, Crispin Cowan wrote:
>   
>> AppArmor (then called "SubDomain") showed how this worked in practice
>> years before the Targeted Policy came along. The Targeted Policy
>> implements an approximation to the AppArmor security model, but does it
>> with domains and types instead of path names, imposing a substantial
>> cost in ease-of-use on the user.
>>     
> I would suspect that the "filename" thing will be the biggest achilles
> heel...
>   
The filename thing is the core point of AppArmor that distinguishes it
from SELinux. We argue that the work required to make pathname-based
access controls work in the Linux kernel is worth the effort, and we are
putting up the effort to achieve it.

> after all what does filename mean in a linux world with
> * hardlinks
>   
If the policy lets you access /foo/bar/baz then you get to access
/foo/bar/baz, even if it is a hard link to /foo/bif.

Some allege that this is a security hole in AppArmor. However,
AppArmor's design is that you only get to create that hard link if you
are either unconfined or your profile says you get to create it.
AppArmor implicitly trusts all non-confined processes, so anything they
do is ok, by definition. Confined processes can create hard links, but
only if the policy allows them to, and you need access rights greater
than or equal to the access rights of the link source. In order to
create the source, you need to have write access, so in principal you
need write access to the target of your link. So, if you've subverted
the process and you can create the link, you already had write access
*anyway*.

> * chroot
>   
In the currently shipping AppArmor, the names AppArmor sees are
chroot-relative. The patch we are about to submit fixes that and the
names AppArmor sees are now absolute, regardless of chroot jailing.

> * namespaces
> * bind mounts
>   
As far as we know, our namespace support is fine; we mediate attempts to
modify namespaces (such as denying mount and umount) and requiring
cap_sys_chroot to modify the root of the namespace. If there are
instances where we are incorrect we would greatly appreciate a detailed
description of the issue (or better a testcase) so we can look at
resolving it.

> * unlink of open files
> * fd passing over unix sockets
>   
AppArmor initially validates your access at open time, and there after
you can read&write to it without mediation. AppArmor re-validates your
access if policy is reloaded, you exec() a new program, you get passed
the fd from another process, or you call our change_hat() API.

So, if the file is unlinked or renamed while you have it open, and
policy says you don't have access to the new name, then:

    * within the same process you get to keep accessing it until
          o policy is reloaded by the administrator
          o you call the change_hat() API
    * in some other process, either a child or some process you passed
      an fd to, you don't get to access it because your access gets
      revalidated

Note that d_path still returns pathnames for files that have been
removed from the filesystem (that are open)
> * relative pathnames
>   
If you access "../hosts.allow" AppArmor will canonicalize your path name
to /etc/hosts.allow before checking the policy.

> * multiple threads (where one can unlink+replace file while the other is
> in the validation code)
>   
I'm not sure what your getting at here. For fine grained concurrency, we
believe that AppArmor gets its kernel locks right; if you see a problem,
please point it out. For coarser grained concurrency, your threads can
mangle each other to the extent that your policy allows them to.
Generally speaking, highly concurrent threads are likely to be living in
very similar or identical policies anyway.

Crispin
-- 
Crispin Cowan, Ph.D.                      http://crispincowan.com/~crispin/
Director of Software Engineering, Novell  http://novell.com

