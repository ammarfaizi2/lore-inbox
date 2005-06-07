Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261558AbVFGDDO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261558AbVFGDDO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Jun 2005 23:03:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261565AbVFGDDO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Jun 2005 23:03:14 -0400
Received: from pat.uio.no ([129.240.130.16]:54258 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S261558AbVFGDDL convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Jun 2005 23:03:11 -0400
Subject: Re: NFS: NFS3 lookup fails if creating a file with O_EXCL &
	multiple mountpoints in pathname
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: linda.dunaphant@ccur.com
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1118111348.13894.29.camel@lindad>
References: <1112921570.6182.16.camel@lindad>
	 <1112965872.15565.34.camel@lade.trondhjem.org>
	 <1112993686.7459.4.camel@lindad>  <1113009804.7459.9.camel@lindad>
	 <1118104107.13894.20.camel@lindad>  <1118111348.13894.29.camel@lindad>
Content-Type: text/plain; charset=UTF-8
Date: Mon, 06 Jun 2005 23:01:54 -0400
Message-Id: <1118113315.13667.8.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 8BIT
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.609, required 12,
	autolearn=disabled, AWL 1.34, FORGED_RCVD_HELO 0.05,
	UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

må den 06.06.2005 Klokka 22:29 (-0400) skreiv Linda Dunaphant:
> Hi Trond,
> 
> One of our applications was doing an open on a NFS client with the flags
> set for O_WRONLY|O_CREAT|O_EXCL|0x4. There are numerous symlinks in the
> pathname for the file that go into two different NFS filesystems. The
> file create works properly if the filesystems are mounted as NFS2, but
> it fails with NFS3 mounts.
>  
> In nfs_lookup() there is a check to see if it is an exclusive create.
> If it is exclusive, nfs_lookup() bypasses ("optimizes" away) the rest
> of the lookup. When the problem occurs, I see it stop the lookup too
> early. This only occurs when the basename portion of the pathname is
> not currently in the NFS cache from a previous non- O_EXCL pathname lookup.
>  
> The nfs_is_exclusive_create() was returning TRUE, even when the
> search wasn't at the last pathname component. This occurred because
> the LOOKUP_CONTINUE flag is reset when it crosses the second
> mountpoint into the NFS filesystem.  nfs_is_exclusive_create() was
> trying to use this flag to determine if it was at the end point
> of the pathname search. Since it was reset when it crossed the
> mountpoint boundary, it returned TRUE several pathname levels too
> early.

Then the correct fix here is to fix the LOOKUP_CONTINUE flag so that it
is set in the above situations.

> I changed the nfs_is_exclusive_create() to use the LOOKUP_PARENT
> flag instead of the LOOKUP_CONTINUE flag. I found that LOOKUP_PARENT
> stays set until you get to the very last pathname level, which is
> the correct point for it to check whether it is an exclusive create.

Vetoed. LOOKUP_PARENT and LOOKUP_CONTINUE are _very_ different flags.
The former tells you what the goal of the lookup operation is. The
latter tells you about the current state of the lookup operation (namely
whether or not the VFS thinks it is on the last element of the path
lookup).

Cheers,
  Trond

