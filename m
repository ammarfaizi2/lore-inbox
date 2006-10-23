Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751878AbWJWKek@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751878AbWJWKek (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 06:34:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751884AbWJWKek
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 06:34:40 -0400
Received: from pat.uio.no ([129.240.10.4]:12279 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S1751878AbWJWKej (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 06:34:39 -0400
Subject: Re: mkdir on read-only NFS is broken in 2.6.18
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Thomas Zeitlhofer <tzeitlho+lkml@nt.tuwien.ac.at>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20061023092329.GA5231@swan.nt.tuwien.ac.at>
References: <20061023092329.GA5231@swan.nt.tuwien.ac.at>
Content-Type: text/plain
Date: Mon, 23 Oct 2006 06:33:42 -0400
Message-Id: <1161599622.5755.16.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.312, required 12,
	autolearn=disabled, AWL 1.55, RCVD_IN_SORBS_DUL 0.14,
	UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-10-23 at 11:23 +0200, Thomas Zeitlhofer wrote:
> Hello,
> 
> there is a problem in 2.6.18/.1 when mkdir is called for an existing
> directory on a read-only mounted NFS filesystem.
> 
> Lets consider a server that exports the directory /export which contains
> the directory-tree a/b/c:
> 
> 1) If /export is mounted ro and the first access to a, b, or c  is
> mkdir, then this directory and all directories underneath become
> inaccessible:
> 
>   client:# mount server:/export /mnt -o ro
>   client:# mkdir /mnt/a/b
>   mkdir: cannot create directory `/mnt/a/b': Read-only file system
>   client:# find /mnt
>   /mnt
>   /mnt/a
>   find: /mnt/a/b: No such file or directory
> 
> 2) If /export is mounted ro and the first access to a, b, or c  is _not_
> by calling mkdir, then a following mkdir does not destroy the directory
> structure (and mkdir now returns EEXIST):
> 
>   client:# mount server:/export /mnt -o ro
>   client:# find /mnt
>   /mnt
>   /mnt/a
>   /mnt/a/b
>   /mnt/a/b/c
>   client:# mkdir /mnt/a/b
>   mkdir: cannot create directory `/mnt/a/b': File exists
>   client:# find /mnt
>   /mnt
>   /mnt/a
>   /mnt/a/b
>   /mnt/a/b/c
> 
> 3) If /export is mounted rw (although exported ro), then mkdir does not
> destroy the directory structure:
> 
>   client:# mount server:/export /mnt -o rw
>   client:# mkdir /mnt/a/b
>   mkdir: cannot create directory `/mnt/a/b': Read-only file system
>   client:# find /mnt
>   /mnt
>   /mnt/a
>   /mnt/a/b
>   /mnt/a/b/c
> 
> As a consequence of 1), autofs does not work with mountpoints on NFS
> (ro) because the automount daemon calls mkdir for all directories in the
> path to the mountpoint. This seems related to the discussion [1], and,
> as suggested in [1], the issue is fixed by reverting the patch:

There should already be a fix for this issue in 2.6.19-rc1. See

  http://kernel.org/git/gitweb.cgi?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=fd6840714d9cf6e93f1d42b904860a94df316b85

Note, though, that the autofs behaviour that you describe above is
seriously broken (mkdir as root on an NFS partition is _not_
acceptable).

Cheers,
  Trond

