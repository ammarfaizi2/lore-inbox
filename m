Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261586AbUL0BKs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261586AbUL0BKs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Dec 2004 20:10:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261603AbUL0BKs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Dec 2004 20:10:48 -0500
Received: from mail.dif.dk ([193.138.115.101]:38562 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S261586AbUL0BKj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Dec 2004 20:10:39 -0500
Date: Mon, 27 Dec 2004 02:21:36 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jesper Juhl <juhl-lkml@dif.dk>, Steve French <sfrench@samba.org>,
       Steve French <sfrench@us.ibm.com>,
       samba-technical <samba-technical@lists.samba.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] copy_to_user check and whitespace cleanups in fs/cifs/file.c
In-Reply-To: <1104104286.16545.7.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.61.0412270218560.3552@dragon.hygekrogen.localhost>
References: <Pine.LNX.4.61.0412270019370.3552@dragon.hygekrogen.localhost>
 <1104104286.16545.7.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 26 Dec 2004, Alan Cox wrote:

> On Sul, 2004-12-26 at 23:24, Jesper Juhl wrote:
> > Hi,
> > 
> > Patch below adds a check for the copy_to_user return value and makes a few 
> > whitespace cleanups in  fs/cifs/file.c::cifs_user_read()
> > I hope bundling two different things together in one patch is OK when the 
> > change is as small as this, but if you want it spplit in two patches, then 
> > just say so.
> 
> Corrupts the stats
> Fails to free smb_read_data where in some cases it was freed before
> 
Whoops, I'll take care of that - thanks for pointing that out.

> I'm not sure the stats matter but I think you need something more like
> 
> 
> residue = copy_to_user(....)
> if(smb_read_data) {
>    cifs_buf_release(...)
>   ...
> }
> 
> Then
> 
> if(residue) {
>     total_read += bytes_read - residue;
>     FreeXid(xid);
>     return total_read ? total_read: -EFAULT;
> }
> 
> 

I take that to mean that if we do manage to read something before we run 
into the fault it's better to return what we have read than the fact that 
we ran into a fault... that makes sense. Sure, I'll cook up a patch to do 
that instead (tomorrow - I need some sleep).


-- 
Jesper Juhl

