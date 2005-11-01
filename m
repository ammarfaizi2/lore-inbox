Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751265AbVKAVfc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751265AbVKAVfc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 16:35:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751267AbVKAVfc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 16:35:32 -0500
Received: from soundwarez.org ([217.160.171.123]:60846 "EHLO soundwarez.org")
	by vger.kernel.org with ESMTP id S1751265AbVKAVfc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 16:35:32 -0500
Date: Tue, 1 Nov 2005 22:35:25 +0100
From: Kay Sievers <kay.sievers@vrfy.org>
To: Sergey Vlasov <vsu@altlinux.ru>
Cc: Al Viro <viro@ftp.linux.org.uk>, Roderich.Schupp.extern@mch.siemens.de,
       linux-kernel@vger.kernel.org, linux-hotplug-devel@lists.sourceforge.net,
       Greg KH <greg@kroah.com>
Subject: Re: Race between "mount" uevent and /proc/mounts?
Message-ID: <20051101213525.GA17207@vrfy.org>
References: <0AD07C7729CA42458B22AFA9C72E7011C8EF@mhha22kc.mchh.siemens.de> <20051025140041.GO7992@ftp.linux.org.uk> <20051026142710.1c3fa2da.vsu@altlinux.ru> <20051026111506.GQ7992@ftp.linux.org.uk> <20051026143417.GA18949@vrfy.org> <20051026192858.GR7992@ftp.linux.org.uk> <20051101002846.GA5097@vrfy.org> <20051101035816.GA7788@vrfy.org> <20051101195449.GA9162@procyon.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051101195449.GA9162@procyon.home>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 01, 2005 at 10:54:49PM +0300, Sergey Vlasov wrote:
> On Tue, Nov 01, 2005 at 04:58:16AM +0100, Kay Sievers wrote:
> > On Tue, Nov 01, 2005 at 01:28:46AM +0100, Kay Sievers wrote:
> > > Ok, makes sense. The attached seems to work for me. If we can get
> > > something like this, we can remove the superblock claim/release events
> > > completely and just read the events from the /proc/mounts file itself.
> 
> No, we need both events.  When you need to tell the user when it is
> safe to disconnect the storage device, the event from detach_mnt() is
> useless - it happens too early.  In fact, even the current way of
> sending the event from kill_block_super() is broken, because the event
> is generated before generic_shutdown_super() and sync_blockdev(), and
> writing out cached data may take some time.
> 
> We could try to emit busy/free events from bd_claim() and
> bd_release(); this would be triggered by most "interesting" users
> (even opens with O_EXCL), but not by things like volume_id.

Hmm, HAL polls optical drives every 2 seconds with O_EXCL to detect media
changes. You need to do it EXCL, cause otherwise some cd burners fail.

> > New patch. Missed a check for namespace == NULL in detach_mnt().
> [skip]
> > +static unsigned int mounts_poll(struct file *file, poll_table *wait)
> > +{
> > +	struct task_struct *task = proc_task(file->f_dentry->d_inode);
> > +	struct namespace *namespace;
> > +	int ret = 0;
> > +
> > +	task_lock(task);
> > +	namespace = task->namespace;
> > +	if (namespace)
> > +		get_namespace(namespace);
> > +	task_unlock(task);
> > +
> > +	if (!namespace)
> > +		return -EINVAL;
> > +
> > +	poll_wait(file, &mounts_wait, wait);
> > +	if (namespace->mounts_poll_pending) {
> > +		namespace->mounts_poll_pending = 0;
> > +		ret = POLLIN | POLLRDNORM;
> > +	}
> 
> This assumes that there will be only one process per namespace which
> will call poll() on /proc/mounts.  Even though someone may argue that
> it is the right approach (have a single process which watches
> /proc/mounts and broadcasts updates to other interested processes,
> e.g., over dbus), with the above implementation any unprivileged user
> can call poll() and interfere with the operation of that designated
> process.

Sure, capable(CAP_SYS_ADMIN) could prevent this.

Thanks,
Kay

