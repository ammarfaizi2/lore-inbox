Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423478AbWJaPI4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423478AbWJaPI4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 10:08:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423479AbWJaPI4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 10:08:56 -0500
Received: from mx1.redhat.com ([66.187.233.31]:30672 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1423478AbWJaPIz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 10:08:55 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <45474E94.7030506@sw.ru> 
References: <45474E94.7030506@sw.ru>  <453F58FB.4050407@sw.ru> 
To: Vasily Averin <vvs@sw.ru>, viro@ftp.linux.org.uk
Cc: devel@openvz.org, David Howells <dhowells@redhat.com>,
       Neil Brown <neilb@suse.de>, Jan Blunck <jblunck@suse.de>,
       Olaf Hering <olh@suse.de>, Balbir Singh <balbir@in.ibm.com>,
       Kirill Korotaev <dev@openvz.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [Q] missing ->d_delete() in shrink_dcache_for_umount()? 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Tue, 31 Oct 2006 15:06:57 +0000
Message-ID: <6860.1162307217@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Vasily Averin <vvs@sw.ru> wrote:

> It looks like I've noticed yet one suspicious place in your patch. As far as I
> see you have removed dput(root) call in shrink_dcache_for_umount() function.
> However I would note that dput contains ->d_delete() call that is missing in
> your function:
> 
> if (dentry->d_op && dentry->d_op->d_delete) {
> 	if (dentry->d_op->d_delete(dentry))
> 		goto unhash_it;
> 
> I'm not sure but it seems to me some (probably out-of-tree) filesystems can do
> something useful in this place.

Can they though?  I'm not so sure.  I've added Al to the To list to get his
opinion.

It seems to me that d_op->d_delete() is asking a question of whether the dentry
should be discarded immediately upon dput() reducing the usage count to 0.  The
documentation in vfs.txt isn't entirely clear on this point, but what it does
say is that that op isn't allowed to sleep, so there's a limit as to what it
can do.

Furthermore, d_op->d_delete() is probably the wrong hook to call.  It returns
an indication of whether the dentry should be retained or not, but we aren't
interested in that at this point: we have to get rid of the dentry anyway, so
the fs's opinion is irrelevant.

Finally, we do still call d_op->d_release() by way of d_free(), so it's not as
if the fs doesn't get a chance to clean up the dentry.

David
