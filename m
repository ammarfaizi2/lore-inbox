Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932574AbVISS6l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932574AbVISS6l (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Sep 2005 14:58:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932577AbVISS6l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Sep 2005 14:58:41 -0400
Received: from pat.uio.no ([129.240.130.16]:12449 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S932574AbVISS6k convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Sep 2005 14:58:40 -0400
Subject: Re: ctime set by truncate even if NOCMTIME requested
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Steve French <smfrench@austin.rr.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
In-Reply-To: <432EFAB1.4080406@austin.rr.com>
References: <432EFAB1.4080406@austin.rr.com>
Content-Type: text/plain; charset=utf-8
Date: Mon, 19 Sep 2005 14:58:23 -0400
Message-Id: <1127156303.8519.29.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 8BIT
X-UiO-Spam-info: not spam, SpamAssassin (score=-3.948, required 12,
	autolearn=disabled, AWL 1.05, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

må den 19.09.2005 Klokka 12:51 (-0500) skreiv Steve French:
> I am seeing requests to set ctime on truncate which does not make any 
> sense to me as I was testing with the flag that should have turned that 
> off.  ie my inodes having S_NOCMTIME set, as NFS does.
> 
> do_truncate (line 206 of open.c) sets
>       newattrs.ia_valid = ATTR_SIZE | ATTR_CTIME
> instead of
>        newattrs.ia_valid = ATTR_SIZE;
>       if(!IS_NOCMTIME(inode))
>            newattrs.ia_valid |= ATTR_CTIME;
> 
> I thought that the correct way to handle this for network filesystems, 
> is to let the server set the mtime and ctime unless the application 
> explicitly sets the attributes (in the case of the sys call truncate or 
> ftruncate the application is not explicitly setting the ctime/mtime as 
> it would on a backup/restore so they should be ignored for the network 
> fs so the server will set it correctl to its time, reducing traffic and 
> more accurately representing the time it got updated).
> 
> Shouldn't there be a IS_NOCMTIME check in the truncate path in fs/open.c?

See the discussion on this a couple of weeks back.

It is quite correct for the kernel to request that the filesystem set
ctime/mtime on successful calls to open(O_TRUNC).
  http://www.opengroup.org/onlinepubs/009695399/toc.htm

It is _incorrect_ for it to request that ctime/mtime be set (or that the
suid/sgid mode bit be cleared) if a truncate()/ftruncate() call results
in no size change.
  http://www.opengroup.org/onlinepubs/009695399/toc.htm

So the current do_truncate() does have to be changed. Adding a check for
IS_NOCMTIME would be wrong, though.

Cheers,
  Trond

