Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932413AbVJLRT1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932413AbVJLRT1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Oct 2005 13:19:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932434AbVJLRT0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Oct 2005 13:19:26 -0400
Received: from mail.shareable.org ([81.29.64.88]:51169 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S932413AbVJLRT0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Oct 2005 13:19:26 -0400
Date: Wed, 12 Oct 2005 18:19:14 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Janak Desai <janak@us.ibm.com>
Cc: chrisw@osdl.org, viro@ZenIV.linux.org.uk, nickpiggin@yahoo.com.au,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       akpm@osdl.org
Subject: Re: [PATCH] New System call unshare (try 2)
Message-ID: <20051012171914.GA8622@mail.shareable.org>
References: <Pine.WNT.4.63.0510121201540.1316@IBM-AIP3070F3AM>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.WNT.4.63.0510121201540.1316@IBM-AIP3070F3AM>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Janak Desai wrote:
> 	Don't allow namespace unsharing, if sharing fs (CLONE_FS)

Makes sense.  clone() has the same test at the start.  (I think
namespace should be a property of fs, not task, anyway.  Or completely
eliminated because it's implied by the task's root dentry+vfsmnt).

> 	Don't allow sighand unsharing if not unsharing vm

Why not?  It's permitted to clone with unshared sighand and shared vm,
and it's useful too.

It's the combination shared sighand + unshared vm which is not
allowed by clone - so I think that's what you should refuse.

> 	Don't allow vm unsharing if task cloned with CLONE_THREAD

It would be better to do what clone does, and say "don't allow sighand
unsharing if task cloned with CLONE_THREAD".  This is because
CLONE_THREAD tasks must have shared signals.

In combination with the rule above for sighand (my rule, not yours),
that implies "don't allow vm unsharing.." as a consequence.

> 	Don't allow vm unsharing if the task is performing async io

Why not?

Async ios are tied to an mm (see lookup_ioctx in fs/aio.c), which may
be shared among tasks.  I see no reason why the async ios can't
continue and be waited in on in other tasks that may be using the old mm.

The new mm, if vm is unshared, would simply not see the outstanding
aios - in the same way as if a vm was unshared by fork().

-- Jamie
