Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261181AbVFNNXW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261181AbVFNNXW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Jun 2005 09:23:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261200AbVFNNXW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Jun 2005 09:23:22 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:42226 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S261181AbVFNNWk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Jun 2005 09:22:40 -0400
Subject: Re: [RFD] FS behavior (I/O failure) in kernel summit
From: Dave Kleikamp <shaggy@austin.ibm.com>
To: fs <fs@ercist.iscas.ac.cn>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       viro VFS <viro@parcelfarce.linux.theplanet.co.uk>,
       linux-fsdevel <linux-fsdevel@vger.kernel.org>,
       linux-kernel <linux-kernel@vger.kernel.org>, zhiming@admin.iscas.ac.cn,
       qufuping@ercist.iscas.ac.cn, madsys@ercist.iscas.ac.cn,
       xuh@nttdata.com.cn, koichi@intellilink.co.jp,
       kuroiwaj@intellilink.co.jp, okuyama@intellilink.co.jp,
       matsui_v@valinux.co.jp, kikuchi_v@valinux.co.jp,
       fernando@intellilink.co.jp, kskmori@intellilink.co.jp,
       takenakak@intellilink.co.jp, yamaguchi@intellilink.co.jp,
       ext2-devel@lists.sourceforge.net, sct@redhat.com,
       xfs-masters@oss.sgi.com, reiser@namesys.com
In-Reply-To: <1118692436.2512.157.camel@CoolQ>
References: <1118692436.2512.157.camel@CoolQ>
Content-Type: text/plain
Date: Tue, 14 Jun 2005 08:22:33 -0500
Message-Id: <1118755353.7956.21.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-06-13 at 15:53 -0400, fs wrote:

> 1) When I/O failure occurs(e.g.: unrecoverable media failure - USB
> unplug), FS should
>    a. shutdown the FS right now(XFS does this)
>    b. try to make the media serve as long as possible(EXT3 remounts 
>       read-only, cache is still valid for read)
>    c. do not care, just print some kernel debugging info(EXT2 JFS 
>       ReiserFS)

In practice, JFS will typically do b.  In some cases, an operation may
simply return -EIO (or not even that if the write is asynchronous), but
eventually, a failure to read or write metadata will lead to the file
system being mounted read-only.  Like ext2/3, this behavior is
configurable with the errors= mount option.

It's possible that JFS may behave like c for a short time, or if an I/O
error is isolated.

> 2) When I/O failure occurs, FS should
>    a. give a unified error
>    b. give errors according to the FS type
> 
> 3) the returned errno should be
>    a. real cause of failure, e.g. USB unplug returns EIO
>    b. cause from FS, e.g. USB unplug made FS remount read-only,
>       so open(O_RDONLY) returns ENOENT while open(O_RDWR) returns
>       EROFS
>    c. errno means nothing, you already get -1, that's enough

I'm not sure I understand the difference between 2) & 3).

If 1)b. applies, then 3)b. makes sense.  The initial error causes the
file system to be mounted read-only.  The original error is history, so
any additional errors must make sense in the current context.  Trying to
write to a read-only filesystem should return -EROFS.  Any new I/O
errors may return -EIO.  I'm not sure about -ENOENT, but it probably
makes sense from the context of the code returning the error.

>     Unfortunately, recent kernel FSes give mixed answers to the above
> questions. As an end user/developer, this is really BAD! Also, there's
> no correspondent docs/standard, 'de facto' standard varies for different
> people.
> 
>     So, we propose 1)a 2)a 3)a as the right behavior. We really hope FS
> maintainers can give us a unified answer on this issue, or AT LEAST 
> positive feedback. If possible, have a discussion in the Kernel Summit.

I don't agree.  I think 1)b is the most useful for most purposes.  Most
users would like to be able to recover as much data as possible if a
disk starts failing.  Allowing the volume to remain mounted read-only
allows this without risking further damage to the file system.

-- 
David Kleikamp
IBM Linux Technology Center

