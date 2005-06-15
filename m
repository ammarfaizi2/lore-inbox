Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261644AbVFOW7A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261644AbVFOW7A (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Jun 2005 18:59:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261643AbVFOW67
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Jun 2005 18:58:59 -0400
Received: from thunk.org ([69.25.196.29]:11422 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S261621AbVFOW43 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Jun 2005 18:56:29 -0400
Date: Wed, 15 Jun 2005 18:53:22 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Hans Reiser <reiser@namesys.com>
Cc: Kenichi Okuyama <okuyamak@dd.iij4u.or.jp>,
       Andreas Dilger <adilger@clusterfs.com>, fs <fs@ercist.iscas.ac.cn>,
       linux-fsdevel <linux-fsdevel@vger.kernel.org>,
       linux-kernel <linux-kernel@vger.kernel.org>, zhiming@admin.iscas.ac.cn,
       qufuping@ercist.iscas.ac.cn, madsys@ercist.iscas.ac.cn,
       xuh@nttdata.com.cn, koichi@intellilink.co.jp,
       kuroiwaj@intellilink.co.jp, okuyama@intellilink.co.jp,
       matsui_v@valinux.co.jp, kikuchi_v@valinux.co.jp,
       fernando@intellilink.co.jp, kskmori@intellilink.co.jp,
       takenakak@intellilink.co.jp, yamaguchi@intellilink.co.jp,
       ext2-devel@lists.sourceforge.net, shaggy@austin.ibm.com,
       xfs-masters@oss.sgi.com,
       Reiserfs developers mail-list <Reiserfs-Dev@namesys.com>
Subject: Re: [Ext2-devel] Re: [RFD] FS behavior (I/O failure) in kernel summit
Message-ID: <20050615225322.GB8584@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Hans Reiser <reiser@namesys.com>,
	Kenichi Okuyama <okuyamak@dd.iij4u.or.jp>,
	Andreas Dilger <adilger@clusterfs.com>, fs <fs@ercist.iscas.ac.cn>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	zhiming@admin.iscas.ac.cn, qufuping@ercist.iscas.ac.cn,
	madsys@ercist.iscas.ac.cn, xuh@nttdata.com.cn,
	koichi@intellilink.co.jp, kuroiwaj@intellilink.co.jp,
	okuyama@intellilink.co.jp, matsui_v@valinux.co.jp,
	kikuchi_v@valinux.co.jp, fernando@intellilink.co.jp,
	kskmori@intellilink.co.jp, takenakak@intellilink.co.jp,
	yamaguchi@intellilink.co.jp, ext2-devel@lists.sourceforge.net,
	shaggy@austin.ibm.com, xfs-masters@oss.sgi.com,
	Reiserfs developers mail-list <Reiserfs-Dev@namesys.com>
References: <1118692436.2512.157.camel@CoolQ> <42ADC99D.5000801@namesys.com> <20050613201315.GC19319@moraine.clusterfs.com> <42AE1D4A.3030504@namesys.com> <42AE450C.5020908@dd.iij4u.or.jp> <20050615140105.GE4228@thunk.org> <42B091E3.3010908@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42B091E3.3010908@namesys.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 15, 2005 at 01:38:59PM -0700, Hans Reiser wrote:
> Ted, if I understand you correctly, I agree with you.  ;-)
> 
> What users need is for a window to pop up saying "the usb drive is
> turned off" or "we are getting checksum errors from XXX, this may
> indicate hardware problems that require your attention".

Yes, and as I suggested, this is best done via out-of-band
notification system, such as hotplug or dbus.  

> Now that GUIs exist, and now that more errors are possible because the
> kernel is more complex, perhaps kernel error handling should be
> reconsidered.  I don't have the feeling that anyone has felt themselves
> authorized to take a deep look at how this ought to be designed.  I mean
> sure, there are sometimes console windows that things get printed into,
> but unsophisticated users basically want to be prompted if something is
> wrong that needs their attention and to not have their experience
> cluttered by a console window otherwise.  Also, it has long been
> irritating having to make error codes conform to one of the existing
> error codes when there is often no good connection between the name of
> an existing error code and the new error condition one has just coded,
> and there is no space left for new error codes.

We could try to add some complicated exception system into system
calls, but it's not productive in my opnion.  First of all, backwards
compatibility is an absolute and unconditional requirement (we can't
break POSIX compatibility, and more importantly, we don't want to
change the number of applications that Linux can run from being
Linux-like to being BeOS-like).  This adds enough of a constraint that
I doubt trying to add changes to the system call error handling
mechanism is likely to work well.  

Secondly, if the goal is to have a pop-up show when there is some
major hardware problem, changing the system call error handling
doesn't really help us unless we want to require every single
application in existence to be modified to use this new exception
handling system.  Having seen how well this BeOS-like approach has
worked for BeOS, I believe this is a Really Bad Idea.  It's better to
have a separate, out-of-band notification scheme --- it's what dbus is
really designed to be for.

> >Also, there is not neccesarily one right answer to how to respond to a
> >underlying I/O error in the filesystem.  So for ext2/3 filesystem, it
> >is configurable.  
> >  
> >
> Perhaps these policy choices should be mount options, what do you think?

We put these policy options as options in the superblock, but there
are some advantages in being able to override them at mount-time with
mount options.  For example, one such advantage is that we can
standardize them across different filesystems.

However, even if we do have standardized mount options, it is a real
pain to have to type a very long mount option when doing manual
mounts.  So having defaults that can be stored in the superblock seems
to be a good idea, in my opinion.

						- Ted
