Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750757AbVKCIHS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750757AbVKCIHS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 03:07:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750953AbVKCIHS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 03:07:18 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:3310 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1750757AbVKCIHQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 03:07:16 -0500
Date: Thu, 3 Nov 2005 08:07:13 +0000
From: Al Viro <viro@ftp.linux.org.uk>
To: Sergey Vlasov <vsu@altlinux.ru>
Cc: Kay Sievers <kay.sievers@vrfy.org>, Roderich.Schupp.extern@mch.siemens.de,
       linux-kernel@vger.kernel.org, linux-hotplug-devel@lists.sourceforge.net,
       Greg KH <greg@kroah.com>
Subject: Re: Race between "mount" uevent and /proc/mounts?
Message-ID: <20051103080713.GD7992@ftp.linux.org.uk>
References: <20051025140041.GO7992@ftp.linux.org.uk> <20051026142710.1c3fa2da.vsu@altlinux.ru> <20051026111506.GQ7992@ftp.linux.org.uk> <20051026143417.GA18949@vrfy.org> <20051026192858.GR7992@ftp.linux.org.uk> <20051101002846.GA5097@vrfy.org> <20051101035816.GA7788@vrfy.org> <20051101195449.GA9162@procyon.home> <20051101213525.GA17207@vrfy.org> <20051102130118.GA23142@master.mivlgu.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051102130118.GA23142@master.mivlgu.local>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 02, 2005 at 04:01:18PM +0300, Sergey Vlasov wrote:
> @@ -120,6 +122,10 @@ static void detach_mnt(struct vfsmount *
>  	list_del_init(&mnt->mnt_child);
>  	list_del_init(&mnt->mnt_hash);
>  	old_nd->dentry->d_mounted--;
> +	if (current->namespace) {
> +		current->namespace->event++;
> +		wake_up_interruptible(&mounts_wait);
> +	}
>  }
>  
>  static void attach_mnt(struct vfsmount *mnt, struct nameidata *nd)

Ugh...  So umount -l gives one hell of a spew for no good reason.

> @@ -129,6 +135,8 @@ static void attach_mnt(struct vfsmount *
>  	list_add(&mnt->mnt_hash, mount_hashtable+hash(nd->mnt, nd->dentry));
>  	list_add_tail(&mnt->mnt_child, &nd->mnt->mnt_mounts);
>  	nd->dentry->d_mounted++;
> +	current->namespace->event++;
> +	wake_up_interruptible(&mounts_wait);
>  }

Bad idea - copy_tree() will spew *and* we get bogus events on CLONE_NEWNS
(i.e. current->namespace is not even the namespace being modified).

> @@ -1093,6 +1104,7 @@ int copy_namespace(int flags, struct tas
>  	atomic_set(&new_ns->count, 1);
>  	init_rwsem(&new_ns->sem);
>  	INIT_LIST_HEAD(&new_ns->list);
> +	new_ns->event = 0;

BTW, I'd rather make that queue per-namespace...

> +	down_read(&namespace->sem);
> +	if (private->last_event != namespace->event) {
> +		private->last_event = namespace->event;
> +		ret = POLLIN | POLLRDNORM;

Umm...  I'd rather use POLLERR, since POLLIN doesn't apply here - it's not
a stream of data that gives blocking read() when reached the end.


IMO the right approach is to have global event counter and do the following:
	if (namespace->event != event) {
		namespace->event = event;
		wake...
	}
in tree modifications and bump the event counter as soon as we decide
to do something.  I'll see how well that works with shared-subtree stuff
and post the patch if it turns out to be usable...
