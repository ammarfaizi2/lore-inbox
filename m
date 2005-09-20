Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964930AbVITIuO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964930AbVITIuO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 04:50:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964936AbVITIuO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 04:50:14 -0400
Received: from 223-177.adsl.pool.ew.hu ([193.226.223.177]:58118 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S964930AbVITIuM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 04:50:12 -0400
To: trond.myklebust@fys.uio.no
CC: smfrench@austin.rr.com, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org
In-reply-to: <1127156303.8519.29.camel@lade.trondhjem.org> (message from Trond
	Myklebust on Mon, 19 Sep 2005 14:58:23 -0400)
Subject: Re: ctime set by truncate even if NOCMTIME requested
References: <432EFAB1.4080406@austin.rr.com> <1127156303.8519.29.camel@lade.trondhjem.org>
Message-Id: <E1EHdnX-00013H-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 20 Sep 2005 10:48:19 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> See the discussion on this a couple of weeks back.
> 
> It is quite correct for the kernel to request that the filesystem set
> ctime/mtime on successful calls to open(O_TRUNC).
>   http://www.opengroup.org/onlinepubs/009695399/toc.htm
> 
> It is _incorrect_ for it to request that ctime/mtime be set (or that the
> suid/sgid mode bit be cleared) if a truncate()/ftruncate() call results
> in no size change.
>   http://www.opengroup.org/onlinepubs/009695399/toc.htm
> 
> So the current do_truncate() does have to be changed. Adding a check for
> IS_NOCMTIME would be wrong, though.

These are othogonal problems.

IS_NOCMTIME is the filesystem's way of saying that it doesn't need
->setattr on truncate(), write(), etc.  Why?  Because it can do the
[cm]time change implicitly _within_ the operation.

If IS_NOCMTIME is set, the only place where the filesystem should get
ATTR_MTIME or ATTR_CTIME (and for that matter ATTR_MTIME_SET) is from
sys_utime[s].

Miklos
