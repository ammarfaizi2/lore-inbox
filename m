Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750935AbVKCLaZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750935AbVKCLaZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 06:30:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751213AbVKCLaY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 06:30:24 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:39598 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1750935AbVKCLaY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 06:30:24 -0500
Date: Thu, 3 Nov 2005 11:30:23 +0000
From: Al Viro <viro@ftp.linux.org.uk>
To: Sergey Vlasov <vsu@altlinux.ru>
Cc: Kay Sievers <kay.sievers@vrfy.org>, Roderich.Schupp.extern@mch.siemens.de,
       linux-kernel@vger.kernel.org, linux-hotplug-devel@lists.sourceforge.net,
       Greg KH <greg@kroah.com>
Subject: Re: Race between "mount" uevent and /proc/mounts?
Message-ID: <20051103113023.GE7992@ftp.linux.org.uk>
References: <20051026111506.GQ7992@ftp.linux.org.uk> <20051026143417.GA18949@vrfy.org> <20051026192858.GR7992@ftp.linux.org.uk> <20051101002846.GA5097@vrfy.org> <20051101035816.GA7788@vrfy.org> <20051101195449.GA9162@procyon.home> <20051101213525.GA17207@vrfy.org> <20051102130118.GA23142@master.mivlgu.local> <20051103080713.GD7992@ftp.linux.org.uk> <20051103105235.GB23142@master.mivlgu.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051103105235.GB23142@master.mivlgu.local>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 03, 2005 at 01:52:35PM +0300, Sergey Vlasov wrote:
> > Ugh...  So umount -l gives one hell of a spew for no good reason.
> 
> umount -l will change contents of /proc/mounts, so waking up poll() on
> that file seems to be right in this case (even if the filesystem is still
> mounted internally, it is no longer accessible).

Yes, but that's a single change.
 
> > Bad idea - copy_tree() will spew *and* we get bogus events on CLONE_NEWNS
> > (i.e. current->namespace is not even the namespace being modified).
> 
> IMHO it's not spew, but real changes in the mount tree.

Again, mount --rbind is a single change.  And fsckloads of attach_mnt().
IOW, you are doing that on too low level.  Right ones:

	* graft_tree()
	* do_move_mount()
	* sys_pivot_root()
	* expire_mount() (BTW, again wrong namespace touched in your variant)
	* lazy one in umount_tree() (single update of event in do_umount(),
then touch ->mnt_namespace for each vfsmount - with shared-subtree it may
affect more than one namespace)
	* couple of extra places introduced by shared-subtree patchset
