Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261512AbUL0Ar0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261512AbUL0Ar0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Dec 2004 19:47:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261535AbUL0Ar0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Dec 2004 19:47:26 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:39322 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261512AbUL0ArJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Dec 2004 19:47:09 -0500
Subject: Re: [patch] copy_to_user check and whitespace cleanups in
	fs/cifs/file.c
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jesper Juhl <juhl-lkml@dif.dk>
Cc: Steve French <sfrench@samba.org>, Steve French <sfrench@us.ibm.com>,
       samba-technical <samba-technical@lists.samba.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.61.0412270019370.3552@dragon.hygekrogen.localhost>
References: <Pine.LNX.4.61.0412270019370.3552@dragon.hygekrogen.localhost>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1104104286.16545.7.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sun, 26 Dec 2004 23:38:07 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2004-12-26 at 23:24, Jesper Juhl wrote:
> Hi,
> 
> Patch below adds a check for the copy_to_user return value and makes a few 
> whitespace cleanups in  fs/cifs/file.c::cifs_user_read()
> I hope bundling two different things together in one patch is OK when the 
> change is as small as this, but if you want it spplit in two patches, then 
> just say so.

Corrupts the stats
Fails to free smb_read_data where in some cases it was freed before

I'm not sure the stats matter but I think you need something more like


residue = copy_to_user(....)
if(smb_read_data) {
   cifs_buf_release(...)
  ...
}

Then

if(residue) {
    total_read += bytes_read - residue;
    FreeXid(xid);
    return total_read ? total_read: -EFAULT;
}


