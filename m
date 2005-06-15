Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261545AbVFOUlz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261545AbVFOUlz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Jun 2005 16:41:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261550AbVFOUlu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Jun 2005 16:41:50 -0400
Received: from thunk.org ([69.25.196.29]:60058 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S261545AbVFOUl2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Jun 2005 16:41:28 -0400
Date: Wed, 15 Jun 2005 16:37:50 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Kenichi Okuyama <okuyamak@dd.iij4u.or.jp>
Cc: reiser@namesys.com, adilger@clusterfs.com, fs@ercist.iscas.ac.cn,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       zhiming@admin.iscas.ac.cn, qufuping@ercist.iscas.ac.cn,
       madsys@ercist.iscas.ac.cn, xuh@nttdata.com.cn, koichi@intellilink.co.jp,
       kuroiwaj@intellilink.co.jp, matsui_v@valinux.co.jp,
       kikuchi_v@valinux.co.jp, fernando@intellilink.co.jp,
       kskmori@intellilink.co.jp, takenakak@intellilink.co.jp,
       yamaguchi@intellilink.co.jp, ext2-devel@lists.sourceforge.net,
       shaggy@austin.ibm.com, xfs-masters@oss.sgi.com,
       Reiserfs-Dev@namesys.com
Subject: Re: [Ext2-devel] Re: [RFD] FS behavior (I/O failure) in kernel summit
Message-ID: <20050615203750.GC7722@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Kenichi Okuyama <okuyamak@dd.iij4u.or.jp>, reiser@namesys.com,
	adilger@clusterfs.com, fs@ercist.iscas.ac.cn,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	zhiming@admin.iscas.ac.cn, qufuping@ercist.iscas.ac.cn,
	madsys@ercist.iscas.ac.cn, xuh@nttdata.com.cn,
	koichi@intellilink.co.jp, kuroiwaj@intellilink.co.jp,
	matsui_v@valinux.co.jp, kikuchi_v@valinux.co.jp,
	fernando@intellilink.co.jp, kskmori@intellilink.co.jp,
	takenakak@intellilink.co.jp, yamaguchi@intellilink.co.jp,
	ext2-devel@lists.sourceforge.net, shaggy@austin.ibm.com,
	xfs-masters@oss.sgi.com, Reiserfs-Dev@namesys.com
References: <42AE1D4A.3030504@namesys.com> <42AE450C.5020908@dd.iij4u.or.jp> <20050615140105.GE4228@thunk.org> <20050616.044045.26507987.okuyamak@dd.iij4u.or.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050616.044045.26507987.okuyamak@dd.iij4u.or.jp>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 16, 2005 at 04:40:45AM +0900, Kenichi Okuyama wrote:
> Ted> And while the write()
> Ted> which causes an I/O error that remounts the filesystem read/only can
> Ted> (and probably does) return EIO
> 
> No. they return EROFS from beginning.
> 

No, trust me, the *first* read/write to a device which is returning
errors is returning EIO.  But it might not be the application which
you are testing.  It might be an attempt to update the inode last
access time that fails, so it might not even be returned to user space
at all.    

But once the filesystem is remounted read-only the reason why EROFS is
being returned is not because of an I/O error, but because the
filesystem is now read-only.  It makes perfect sense, if you think
like a computer....

> The point is pretty easy ( I think ).
> 
> Q1.  Why does file system succeed in re-mounting as r/o, when device
>      is totally lost?

That's because right now there is no way for block devices to inform
the filesystem that device is totally gone.

> But in case of Mr. Qu's test, device is lost. USB cabel is
> unplugged. They are unreachable. How could such device be *MOUNTED*?
> # In other word, why can't I mount device which does not exist,
> # while I can re-mount them?

Because remounting a filesystem means toggling the in-core data
structures that writes are no longer being tolerated.  It doesn't
require reading from the device, which a fresh mount requires.

> 1) devices and file systems are still under control of kernel.
> 2) devices or file systems are not under control of kernel anymore.
> 
> I do agree that, for devices, it is device driver's responsibility
> to identify which type of error have arised. But when file system
> recieved type 2 error, he should not change it to type 1 error
> ( unless fs could really guarantee that ).
> 
> And, therefore, for type 2, I belive they can be standardize, and I
> think we should.

The problem is the filesystem right now can't tell the difference
between type 1 and type 2 errors.  All we know is that an attempt to
read or write from a block as failed.  We don't know why it failed.   

I agree that *if* the filesystem could be told that a block device has
disappeared, then we should do the equivalent of umount -l on the
filesystem, and revoke all open file descriptors, much like the BSD
revoke(2) system call.  

But this isn't matter of "standardizing" error returns, but rather a
feature/enhancement request.

						- Ted
