Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261371AbVEXRrt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261371AbVEXRrt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 May 2005 13:47:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261369AbVEXRrs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 May 2005 13:47:48 -0400
Received: from rev.193.226.233.9.euroweb.hu ([193.226.233.9]:13070 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S261259AbVEXRr2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 May 2005 13:47:28 -0400
To: mikew@google.com
CC: miklos@szeredi.hu, jamie@shareable.org, linuxram@us.ibm.com,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       akpm@osdl.org, viro@parcelfarce.linux.theplanet.co.uk
In-reply-to: <4293612F.3000708@google.com> (message from Mike Waychison on
	Tue, 24 May 2005 10:15:27 -0700)
Subject: Re: [RFC][PATCH] rbind across namespaces
References: <1116627099.4397.43.camel@localhost> <E1DZNSN-0006cU-00@dorka.pomaz.szeredi.hu> <1116660380.4397.66.camel@localhost> <E1DZP37-0006hH-00@dorka.pomaz.szeredi.hu> <20050521134615.GB4274@mail.shareable.org> <E1DZlVn-0007a6-00@dorka.pomaz.szeredi.hu> <429277CA.9050300@google.com> <E1DaSCb-0003Tw-00@dorka.pomaz.szeredi.hu> <4292D416.5070001@waychison.com> <E1DaVYK-0003ko-00@dorka.pomaz.szeredi.hu> <4293612F.3000708@google.com>
Message-Id: <E1DadUS-0004Vl-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 24 May 2005 19:46:52 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > What's more you don't even need /proc, just pass a file descriptor
> > (with reference to mount in different namespace, etc.) to another
> > process with SCM_RIGHTS, do fchrdir(fd), and then do mount --bind,
> > etc.  This actually works with an unmodified kernel.
> 
> It shouldn't.  An unmodified kernel has check_mnt to keep you from doing 
> this.

Common misconception.  Even Al Viro fell for it, even though it was he
who wrote the code :)

What is not allowed is that the _new_ mountpoint is in a different
namespace.  The _old_ mount can actually come from a different
namespace or a detached mount in a bind (not an rbind though).

Again experimentally verified.

The check_mnt() function is not a security measure, rather a locking
measure.  Current code in namespace protects modification of the mount
tree with current->namespace->sem.  The check_mnt() calls are needed,
so that the namespace to be modified is really the current namespace.

This limitation can actually be removed.  See patch by Ram Pai posted
earlier in this thread:

  http://marc.theaimsgroup.com/?l=linux-kernel&m=111683338801090&w=2

The code can be generalized for other types of mounts, not just bind.

With that and allowing access to /proc/self/fd/*, I think we'll have a
proper interface for passing mounts between namespaces.

The mount groups idea is orthogonal to this I think, and I'll send
comments in a separate mail.

Miklos
