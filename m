Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030397AbVKPUW2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030397AbVKPUW2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 15:22:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030407AbVKPUW2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 15:22:28 -0500
Received: from opus.cs.columbia.edu ([128.59.20.100]:7584 "EHLO
	opus.cs.columbia.edu") by vger.kernel.org with ESMTP
	id S1030397AbVKPUW1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 15:22:27 -0500
Subject: Re: [PATCH 12/18] shared mount handling: bind and rbind
From: Shaya Potter <spotter@cs.columbia.edu>
To: Al Boldi <a1426z@gawab.com>
Cc: torvalds@osdl.org, linuxram@us.ibm.com, viro@ftp.linux.org.uk,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       rob@landley.net, Miklos Szeredi <miklos@szeredi.hu>
In-Reply-To: <200511162303.33103.a1426z@gawab.com>
References: <E1EZInj-0001Ez-AV@ZenIV.linux.org.uk>
	 <E1EcIVw-0005ZH-00@dorka.pomaz.szeredi.hu>
	 <1132149576.8155.23.camel@localhost.localdomain>
	 <200511162303.33103.a1426z@gawab.com>
Content-Type: text/plain
Date: Wed, 16 Nov 2005 15:21:43 -0500
Message-Id: <1132172504.8037.24.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.2 
Content-Transfer-Encoding: 7bit
X-PMX-Version: 4.7.1.128075, Antispam-Engine: 2.0.3.2, Antispam-Data: 2005.11.16.23
X-PerlMx-Spam: Gauge=IIIIIII, Probability=7%, Report='__CT 0, __CTE 0, __CT_TEXT_PLAIN 0, __HAS_MSGID 0, __HAS_X_MAILER 0, __MIME_TEXT_ONLY 0, __MIME_VERSION 0, __SANE_MSGID 0'
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-11-16 at 23:05 +0300, Al Boldi wrote:
> Shaya Potter wrote:
> > I created a patch years ago that creates a chain of "chroot" points, and
> > any past chroot point would be considered a place that follow_dotdot
> > would consider a root.  There didn't seem much interest in the patch
> > though.
> 
> Could you resubmit this patch for possible inclusion in 2.6.16, and make it a 
> runtime option such that the default behaviour remains unchanged?

resubmit?  It was a long long time ago (middle of 2.4 era)  I'd have to
find it, who knows if its still around.

Conceptually it was pretty simple, basically instead of just overwriting
the fs struct root/rootmnt you create a linked list of them (appending
on every chroot).  I think I might have had a seperate struct to
maintain that linked list (it wasn't the best code in the world).

follow_dotdot is then modified so that the code

if (nd->dentry == current->fs->root &&
	nd->mnt == current->fs->rootmnt) {
	read_unlock(&current->fs->lock);
	break;
}

instead of being just a single test, loops over every element in the
linked list.  Hence, if you are ever at a "chroot" point, you get a
root, so solves the simple problem of breaking out of a chroot by
calling chroot() again.  In the normal case (no chroot), there should be
no real performance hit, as it would hit the loop once.

However, as others have said, if you can make a device node, then you
can break out of it in other ways.

Now, there are other things one has to take care of.  

1) Obvious: cleaning up the list on process termination.
2) Obvious: propagating list to child processes.

and probably some less obvious things that I don't remember or didn't
even consider at the time.

