Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261401AbVEPGzm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261401AbVEPGzm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 May 2005 02:55:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261405AbVEPGzl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 May 2005 02:55:41 -0400
Received: from ercist.iscas.ac.cn ([159.226.5.94]:43789 "EHLO
	ercist.iscas.ac.cn") by vger.kernel.org with ESMTP id S261401AbVEPGz2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 May 2005 02:55:28 -0400
Subject: Re: [RFD] What error should FS return when I/O failure occurs?
From: fs <fs@ercist.iscas.ac.cn>
To: Valdis.Kletnieks@vt.edu
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Kenichi Okuyama <okuyama@intellilink.co.jp>
In-Reply-To: <200505160635.j4G6ZUcX023810@turing-police.cc.vt.edu>
References: <1116263665.2434.69.camel@CoolQ>
	 <200505160635.j4G6ZUcX023810@turing-police.cc.vt.edu>
Content-Type: text/plain
Organization: iscas
Message-Id: <1116266644.2434.86.camel@CoolQ>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 16 May 2005 14:04:04 -0400
Content-Transfer-Encoding: 7bit
X-ArGoMail-Authenticated: fs@ercist.iscas.ac.cn
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-05-16 at 02:35, Valdis.Kletnieks@vt.edu wrote:
> On Mon, 16 May 2005 13:14:25 EDT, fs said:
> 
> > 1. For EXT3 partition , we mount it as RW, but when I/O occurs, the
> >    I/O related functions return EROFS(ReadOnly?), while other FSes
> >    return EIO.
> 
> Only the request that actually caused the I/O error (and thus causing the
> system to re-mount the ext3 partition R/O) should get EIO.  EROFS is
> the proper error for subsequent requests - because they're being rejected
> because the filesystem is R/O.  EIO would be incorrect, because the I/O
> wasn't even tried, much less errored - and there's a good chance that
> subsequent I/O requests *wouldn't* pull an error. Manwhile, subsequent
> requests don't even *know* whether the filesystem was remounted R/O due to
> an error, or if some root user said 'mount -o remount,ro'.
The point is(from the user's perspective, not FS developer's):
If you open a file with O_RDWR, and sys_open returns success,
next, call sys_write, but returns EROFS? The two return values are
paradox/self-contradictory.
> > 2. Assume a program doing the following: open - write(async) - close
> >    When user-mode app calls sys_write, for EXT2/JFS, no error 
> >    returns, for EXT3, EROFS returns, for XFS/ReiserFS, EIO returns.
> 
> Remember that the request that actually hits an error could be from a
> process that isn't even in existence anymore, if the page has been sitting
> in the cache for a while and we're finally sending it to disk.  If you don't
> believe me, try this on a machine with lots (1G or 2G or so) memory:
> 
> 1) cd /usr/src/linux
> 2) tar cf - . | cat > /dev/null    # just to prime the disk cache
> 3) make                    # wait a few minutes for it to complete.
> 4) Now that the 'make' is done, type 'sync' and watch the disk lights blink.
> 
> Notice you're syncing the disk blocks written by the various sub-processes
> of 'make', all of which are done and long gone.  Who do you report the EIO
> to, on what write() request?
> 
> (For even more fun - what happens if it's kjournald pushing the blocks out,
> not the 'sync' command? ;)

Thanks for your example, but it seems you misunderstand my point.
I just use async write as an example, which shows different FS
returns different error. Here is another example:
stat(2) - open(2) - read(2) -close(2)
When I/O failure occurs between stat(2) and open(2),
EXT2/JFS/XFS/ReiserFS returns EIO, but EXT3 returns ENOENT

The purpose of this RFD, is to get the community to understand,
all I/O related syscalls should return VFS error, not FS error.
User mode app should not care about the FS they are using. 
So, the community should define the ONLY VFS error first.

regards,
---
Qu Fuping


