Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261259AbVFNGoR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261259AbVFNGoR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Jun 2005 02:44:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261261AbVFNGoR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Jun 2005 02:44:17 -0400
Received: from ercist.iscas.ac.cn ([159.226.5.94]:11534 "EHLO
	ercist.iscas.ac.cn") by vger.kernel.org with ESMTP id S261259AbVFNGnq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Jun 2005 02:43:46 -0400
Subject: Re: [Ext2-devel] Re: [RFD] FS behavior (I/O failure) in kernel
	summit
From: fs <fs@ercist.iscas.ac.cn>
To: Andreas Dilger <adilger@clusterfs.com>
Cc: Hans Reiser <reiser@namesys.com>,
       linux-fsdevel <linux-fsdevel@vger.kernel.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       zhiming <zhiming@admin.iscas.ac.cn>, madsys <madsys@ercist.iscas.ac.cn>,
       xuh <xuh@nttdata.com.cn>, koichi@intellilink.co.jp,
       kuroiwaj@intellilink.co.jp, Kenichi Okuyama <okuyama@intellilink.co.jp>,
       matsui_v@valinux.co.jp, kikuchi_v@valinux.co.jp,
       fernando@intellilink.co.jp, kskmori@intellilink.co.jp,
       takenakak@intellilink.co.jp, yamaguchi@intellilink.co.jp,
       ext2-devel@lists.sourceforge.net, shaggy@austin.ibm.com,
       xfs-masters@oss.sgi.com,
       Reiserfs developers mail-list <Reiserfs-Dev@namesys.com>
In-Reply-To: <20050613201315.GC19319@moraine.clusterfs.com>
References: <1118692436.2512.157.camel@CoolQ> <42ADC99D.5000801@namesys.com>
	 <20050613201315.GC19319@moraine.clusterfs.com>
Content-Type: text/plain
Organization: iscas
Message-Id: <1118770916.2516.14.camel@CoolQ>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 14 Jun 2005 13:41:56 -0400
Content-Transfer-Encoding: 7bit
X-ArGoMail-Authenticated: fs@ercist.iscas.ac.cn
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-06-13 at 16:13, Andreas Dilger wrote:

> > fs wrote:
> > >Dear Linus, Andrew Morton, and all FS maintainers,
> > >1) When I/O failure occurs(e.g.: unrecoverable media failure - USB
> > >unplug), FS should
> > >   a. shutdown the FS right now(XFS does this)
> > >   b. try to make the media serve as long as possible(EXT3 remounts 
> > >      read-only, cache is still valid for read)
> > >   c. do not care, just print some kernel debugging info(EXT2 JFS 
> > >      ReiserFS)
> 
> Actually, 1b is just the default behaviour for ext3 (because of journal
> errors).  It is also possible to mount the filesystem with error=panic,
> which will implement 1a, and it is also possible to mount ext2 with
> error=remount-ro (which is default on Debian for ext2) which implements
> 1b.  I don't think it is possible to get 1c behaviour for journal
> errors on ext3.
> 
> > >2) When I/O failure occurs, FS should
> > >   a. give a unified error
> > >   b. give errors according to the FS type

Of coz EIO is not always right. But suppose the same unplug action 
results different errors, just because of FS type? You think both EIO
and EROFS are right, what if new FS return EXXX? Even it's correct, the
community should AT LEAST define a set of error values which are 
considered right. So, the application user can handle these errors one
by one. If not, that means errno can't provide enough info, that's the
case of 3)c

Well, I give question 1) 2) and 3), they're just examples. FS developers
use 'de facto' standard, it's ambiguous. We need an accurate one.

> What is "unified error"?  Does this mean "-EIO" for all cases?  I also
> don't understand why this is so important to your application...  If
> you get an error back from the filesystem that isn't expected, that is
> generally a problem regardless of what the error is...
> 
> > >3) the returned errno should be
> > >   a. real cause of failure, e.g. USB unplug returns EIO
> > >   b. cause from FS, e.g. USB unplug made FS remount read-only,
> > >      so open(O_RDONLY) returns ENOENT while open(O_RDWR) returns
> > >      EROFS
> > >   c. errno means nothing, you already get -1, that's enough

> This doesn't make sense.  If the "real cause of failure" is that the
> journal code detected an inconsistency (it might not be an IO error at
> the time, just some structure that is not what it should be, maybe the
> user tried to format their partition while in use ;-) then the real
> error is that the journal turned the filesystem read-only.  In any case,
> you can't expect to get more information that "EIO", regardless of the
> root cause (e.g. ENOMEM causes async buffer read to not complete, caller
> checks buffer_uptodate() and it isn't uptodate, returns EIO).
> 
> Cheers, Andreas
> --
> Andreas Dilger
> Principal Software Engineer
> Cluster File Systems, Inc.

yours,
----
Qu Fuping


