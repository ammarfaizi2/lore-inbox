Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261446AbVFOOBw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261446AbVFOOBw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Jun 2005 10:01:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261442AbVFOOBw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Jun 2005 10:01:52 -0400
Received: from thunk.org ([69.25.196.29]:57751 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S261438AbVFOOBn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Jun 2005 10:01:43 -0400
Date: Wed, 15 Jun 2005 10:01:05 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Kenichi Okuyama <okuyamak@dd.iij4u.or.jp>
Cc: Hans Reiser <reiser@namesys.com>, Andreas Dilger <adilger@clusterfs.com>,
       fs <fs@ercist.iscas.ac.cn>,
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
Message-ID: <20050615140105.GE4228@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Kenichi Okuyama <okuyamak@dd.iij4u.or.jp>,
	Hans Reiser <reiser@namesys.com>,
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
References: <1118692436.2512.157.camel@CoolQ> <42ADC99D.5000801@namesys.com> <20050613201315.GC19319@moraine.clusterfs.com> <42AE1D4A.3030504@namesys.com> <42AE450C.5020908@dd.iij4u.or.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42AE450C.5020908@dd.iij4u.or.jp>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 14, 2005 at 11:46:36AM +0900, Kenichi Okuyama wrote:
> I agree that kernel can not directly influence user.
> But, application may have better chance.
> 
> Think about case of editor (vi, emacs, almost any text editors are ok ).
> 
> If you try to save file, and recieve no error, user will believe they 
> have been written on disk they believe to be existing.
> Even log yells for error, user will not notice.
> 
> If editor recieve error, then user can know something is wrong. Though 
> he is still wondering, if he recieve the message
> like "Input Output Error: may be HW error?", he definitely will start 
> from looking at cable.

Kenichi-San,

Part of the problem is that we are limited by the constraints of the
POSIX specification for error handling.  For example, we don't have a
way of telling the application, "the reason why you the filesystem was
remounted-read-only was in reaction to an I/O error that appears to be
caused by the multiple CRC checksum errors reported by the SCSI
controller".  We can only return EIO or EROFS.  And while the write()
which causes an I/O error that remounts the filesystem read/only can
(and probably does) return EIO, any subsequent writes will return
EROFS, and changing this would be hard, hackish, and probably wouldn't
be accepted.

Also, there is not neccesarily one right answer to how to respond to a
underlying I/O error in the filesystem.  So for ext2/3 filesystem, it
is configurable.  In case of an underlying error detected in the
filesystem metadata, the filesystem can be set to either (a) panic and
force a reboot, so that hopefully fsck can resolve the issue, (b)
remount the filesystem read/only, to prevent further damage, or (c)
continue and do nothing (the don't worry, be happy approach).
Different users will want different approaches, and so trying to
standardize what applications will see at the user level doesn't seem
like the right approach, since we want to allow system administrators
some flexibility about how they wish to configure their systems.

(For example, an embedded system or a system where there is higher
levels of redundancy, the right answer might be to panic and either
reboot or halt --- continuing and possibly returning wrong answers
might be completely unacceptable, and it may be that the once the
system goes down hard, the adjacent backup blade can pick up
operations.)

So instead of trying to standardize the existing error returns, which
are they way they are and for which trying to standardize them would
probably be not worth the effort, since they don't return enough
context to the application anyway ---- I would suggest the better
thing to do is to design a new mechanism for returning block device
errors via either some kind of notifcation mechanism (pick your choice
of hotplug, dbus, or netlink --- dbus may make the most amount of
sense, since multiple applications may want to subscribe to such
notifications) of problems at the filesystem level, so that
applications can take corrective action as necessary.  

This is a better approach, since it far more flexible and returns much
more information to the user.  For example, in a desktop environment,
the desktop can pop up a warning dialog to the user of a failure of a
block device or filesystem corruption, without having to modify every
single application.  In the case of an embedded system, the
notification can trigger an appropriate failover or recovery process.  

Regards,

						- Ted
