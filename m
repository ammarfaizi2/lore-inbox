Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964986AbVITMMr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964986AbVITMMr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 08:12:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964985AbVITMMq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 08:12:46 -0400
Received: from pat.uio.no ([129.240.130.16]:27067 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S964982AbVITMMp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 08:12:45 -0400
Subject: Re: ctime set by truncate even if NOCMTIME requested
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: smfrench@austin.rr.com, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <E1EHf0E-000197-00@dorka.pomaz.szeredi.hu>
References: <432EFAB1.4080406@austin.rr.com>
	 <1127156303.8519.29.camel@lade.trondhjem.org>
	 <432F2684.4040300@austin.rr.com>
	 <1127165311.8519.39.camel@lade.trondhjem.org>
	 <432F5968.1020106@austin.rr.com>
	 <1127180199.26459.17.camel@lade.trondhjem.org>
	 <E1EHdrk-00014N-00@dorka.pomaz.szeredi.hu>
	 <E1EHf0E-000197-00@dorka.pomaz.szeredi.hu>
Content-Type: text/plain
Date: Tue, 20 Sep 2005 08:12:25 -0400
Message-Id: <1127218345.8413.32.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-2.625, required 12,
	autolearn=disabled, AWL 2.19, FORGED_RCVD_HELO 0.05,
	RCVD_IN_SORBS_DUL 0.14, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ty den 20.09.2005 Klokka 12:05 (+0200) skreiv Miklos Szeredi:
> These are othogonal problems.
> 
> IS_NOCMTIME is the filesystem's way of saying that it doesn't need
> ->setattr on truncate(), write(), etc.  Why?  Because it can do the
> [cm]time change implicitly _within_ the operation.

No. IS_NOCMTIME is the filesystem's way of telling the VFS never to
screw around with the values of inode->i_mtime and inode->i_ctime. 

The reason is that crap like inode_update_time() explicitly sets these
values to the local current time instead of using server timestamps.

OTOH, ->setattr with an ATTR_MTIME or ATTR_CTIME argument is telling the
filesystem to update the timestamp. The filesystem then has a choice of
whether or not to use current time, server time, or to just ignore it if
the timestamp is going to be be updated by the other ->setattr arguments
anyway.

> ATTR_MTIME is _only_ set in utime[s], which all filesystems want to
> honor.

ATTR_MTIME is set in both utimes and truncate. In the latter case, CIFS
could optimise it away by noting that ATTR_SIZE will set mtime anyway.
As for ATTR_CTIME, that is also set in chown(), chmod(). It too can be
optimised away for those operations, assuming that CIFS servers
automatically update ctime.

Cheers,
  Trond

