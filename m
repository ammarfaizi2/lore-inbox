Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261328AbVELDHY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261328AbVELDHY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 May 2005 23:07:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261325AbVELDHY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 May 2005 23:07:24 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:11703 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261321AbVELDHP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 May 2005 23:07:15 -0400
Date: Wed, 11 May 2005 22:05:34 -0500
From: serue@us.ibm.com
To: Jamie Lokier <jamie@shareable.org>
Cc: serue@us.ibm.com, Miklos Szeredi <miklos@szeredi.hu>, 7eggert@gmx.de,
       ericvh@gmail.com, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, smfrench@austin.rr.com, hch@infradead.org
Subject: Re: [RCF] [PATCH] unprivileged mount/umount
Message-ID: <20050512030534.GA6401@sergelap.austin.ibm.com>
References: <406SQ-5P9-5@gated-at.bofh.it> <40rNB-6p8-3@gated-at.bofh.it> <40t37-7ol-5@gated-at.bofh.it> <42VeB-8hG-3@gated-at.bofh.it> <42WNo-1eJ-17@gated-at.bofh.it> <E1DVuHG-0006YJ-Q7@be1.7eggert.dyndns.org> <20050511170700.GC2141@mail.shareable.org> <E1DVwGn-0002BB-00@dorka.pomaz.szeredi.hu> <20050511190545.GB14646@serge.austin.ibm.com> <20050511211134.GB5093@mail.shareable.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050511211134.GB5093@mail.shareable.org>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jamie Lokier (jamie@shareable.org):
> serue@us.ibm.com wrote:
> > Right, sys_unshare(), as per Janak's patch.  Does it lack anything which
> > you would need?
> 
> For creating new namespaces to be held by a daemon for handing out to
> user processes on demand, it's no more convenient than clone().

I see.

My use for namespaces is to simply customize the fs view on login, so
sys_unshare is more convenient than clone because it now allows a pam
library to switch namespaces, which was either impossible or hard to do
using clone.  Making namespaces first-class objects should also work,
since the namespaces can just be set up in advance and then entered from
inside a pam library.

Still I'd agree with Eric.  It'd be good to see just how much we can do
with the ability to clone a namespace outside of clone().  Going back to
the daemon handing out namespaces...  why can't you just take your
earlier example of /var/namespaces/NS1, etc, where you just create a
bunch of fs trees under the /var/namespaces directory using bind mounts,
and then login or pam does

	sys_unshare(CLONE_NEWNS);
	chdir(/var/namespaces/NS3)
	pivot_root(/var/namespaces/NS3, tmp)
	umount(tmp, MNT_DETACH)
	chroot .
?

No daemon needed...

thanks,
-serge
