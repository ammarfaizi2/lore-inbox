Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030266AbWBTO4D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030266AbWBTO4D (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 09:56:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030268AbWBTO4D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 09:56:03 -0500
Received: from mailhub.sw.ru ([195.214.233.200]:39087 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S1030266AbWBTO4A (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 09:56:00 -0500
Message-ID: <43F9D8CB.8000908@sw.ru>
Date: Mon, 20 Feb 2006 17:57:15 +0300
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; ru-RU; rv:1.2.1) Gecko/20030426
X-Accept-Language: ru-ru, en
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederm@xmission.com>
CC: Kirill Korotaev <dev@openvz.org>, serue@us.ibm.com, arjan@infradead.org,
       frankeh@watson.ibm.com, clg@fr.ibm.com, haveblue@us.ibm.com,
       mrmacman_g4@mac.com, alan@lxorguk.ukuu.org.uk,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>, devel@openvz.org
Subject: Re: [RFC][PATCH 2/7] VPIDs: pid/vpid conversions
References: <43E22B2D.1040607@openvz.org> <43E23179.5010009@sw.ru> <m1irrpsifp.fsf@ebiederm.dsl.xmission.com>
In-Reply-To: <m1irrpsifp.fsf@ebiederm.dsl.xmission.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Do you know how incomplete this patch is?
> You missed drivers/char/drm, and in your shipping OpenVZ patch.
> You missed get_xpid() on alpha.
> You missed nfs.
DRM/NFS code is correct.

The only correct thing you noticed is get_xpid on alpha. But this is in
fact a simple bug and half a year before we didn't care much for archs
others than i386/x86-64/ia64. That's it.

> I suspect the tagging of the VPIDS and the WARN_ON's help so you have
> a chance of catching things if someone uses a code path you haven't
> caught.  But I don't see how you can possibly get full kernel
> coverage.
simple, the same way as you did, i.e. by renaming pid to tid or
something like this.

> Is there a plan to catch all of the in-kernel use of pids that I am
> being to dense to see?
if Linus will be ready to take it into mainstream, it will be caught
all. Actually only asm files should be investigated due to optimizations
similar to those on IA64/Alpha. Everything else I suppose is correct and
can be rechecked only.

And now a bit of contstructive ideas/things:

I propose to stop VPIDs discussion and switch to virtualization of
networking, IPC and so on, which is essentially the same in yours and
our solutions (openvz).

I took a look to your patch, it does actually the same things as openvz,
almost thing by thing. But it is BUGGY! You have broken IPC/networking, 
many things to these subsytems are not virtualized etc. We need to
get Linus comment about which approach is the best for him, with
namespace pointers on task_struct involved by you or with effective
container pointer. It is only a matter of his taste, but the result is
effectively the same. Agree?

Actually we don't care whether virtualization introduces one container
pointer on the task struct or as you proposed many pointers to
namespaces. But you are WRONG IMHO thinking that this namespaces are
independent and this allows you more fine grained virtualization. All
these namespaces are tightly intergrated with each other(sic!).
For example, networking is coupled with sysctl, which in turn are
coupled with proc filesystem. And sysfs! You even added a piece of code
in net/core/net-sysfs.c in your patch, which is a dirty hack.
Another example, mqueues and other subsystems which use netlinks and 
also depend on network context.
shmem/IPC is dependand on file system context and so on.
So it won't work when one have networking from one container and proc
from another. So I really see no much reasons to have separate
namespaces, but it is ok for me if someone really wants it this way.

We also don't care whether yours or our network virtualization will go
upstream. They do _exactly_ the same. You also virtualized IPv6 which is
good, since we have only IPv4, but you totally missed netfilters, which
is bad :) So again the only difference is that we have effective
container on the task, while you prefer to take it from sk/netdev or
bypass as an additional function argument.

So I propose the following:
1. ask Linus about the preffered approach. I prepared an email for him
with a description of approaches.
2. start from networking/netfilters/IPC which are essentially the same
in both projects and help each other.

Kirill


