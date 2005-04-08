Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262953AbVDHUyu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262953AbVDHUyu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Apr 2005 16:54:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262955AbVDHUyu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Apr 2005 16:54:50 -0400
Received: from mail.ccur.com ([208.248.32.212]:41281 "EHLO flmx.iccur.com")
	by vger.kernel.org with ESMTP id S262953AbVDHUyr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Apr 2005 16:54:47 -0400
Subject: Re: [PATCH] mtime attribute is not being updated on client
From: Linda Dunaphant <linda.dunaphant@ccur.com>
Reply-To: linda.dunaphant@ccur.com
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1112965872.15565.34.camel@lade.trondhjem.org>
References: <1112921570.6182.16.camel@lindad>
	 <1112965872.15565.34.camel@lade.trondhjem.org>
Content-Type: text/plain
Organization: CCUR
Message-Id: <1112993686.7459.4.camel@lindad>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-1) 
Date: Fri, 08 Apr 2005 16:54:47 -0400
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 08 Apr 2005 20:54:47.0400 (UTC) FILETIME=[32FDCE80:01C53C7D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-04-08 at 09:11, Trond Myklebust wrote:

> I'm a bit unclear as to what your end-goal is here. Is it basically to
>ensure that fstat() always return the correct value for the mtime?
>
> The reason I ask is that I think your change is likely to have nasty
>consequences for the general performance in a lot of other syscalls that
>use nfs_revalidate_inode(). I would expect a particularly nasty hit in
>the of the write() syscalls themselves, and they really shouldn't have
>to worry about the value of mtime in the close-to-open cache consistency
>model.
>I therefore think we should look for a more fine-grained solution that
>addresses more precisely the issues you see.
>
>Cheers,
>  Trond

Hi Trond,

The goal wasn't to ensure that fstat() always return the correct value for
mtime. The goal is to update the mtime within the bounds of the min and max
attribute cache timeouts, which was not happening before if the test ran
for more than a minute.

nfs_refresh_inode() was already being called after every write to the server
and fattr->mtime was already set to the server's updated mtime value. However,
it didn't check for an updated mtime value if data_unstable was set. Since
nfs_refresh_inode() always resets the attribute timer (even when it skipped
the mtime check), and the calls to it occurred more frequently than the
attribute timer could expire, nfs_update_inode() was never being called
again to update the inode's mtime.

With the change I proposed, the test shows an mtime change every ~32 secs
which corresponds to when the client writes the data to the server. Before
this change, the test only showed one mtime change, even when it was run
for > 10 mins. I did not see any increase in the calls to either
nfs_revalidate_inode() or __nfs_revalidate_inode().

Do you think it would be better for nfs_refresh_inode() to check the mtime,
perform the mtime update if needed, and not set the NFS_INO_INVALID_ATTR
flag if the data_unstable flag is set? This is how nfs_update_inode()
handles its mtime check.

Regards,
Linda


