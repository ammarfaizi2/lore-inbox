Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932398AbVHKMtd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932398AbVHKMtd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 08:49:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030293AbVHKMtd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 08:49:33 -0400
Received: from pat.uio.no ([129.240.130.16]:16336 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S932398AbVHKMtc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 08:49:32 -0400
Subject: Re: fcntl(F GETLEASE) semantics??
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Michael Kerrisk <mtk-lkml@gmx.net>
Cc: peterc@gelato.unsw.edu.au, linux-kernel@vger.kernel.org,
       sfr@canb.auug.org.au, matthew@wil.cx, michael.kerrisk@gmx.net
In-Reply-To: <24699.1123763244@www9.gmx.net>
References: <1123761105.8251.10.camel@lade.trondhjem.org>
	 <24699.1123763244@www9.gmx.net>
Content-Type: text/plain
Date: Thu, 11 Aug 2005 08:49:12 -0400
Message-Id: <1123764552.8251.43.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-2.545, required 12,
	autolearn=disabled, AWL 2.27, FORGED_RCVD_HELO 0.05,
	RCVD_IN_SORBS_DUL 0.14, UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

to den 11.08.2005 Klokka 14:27 (+0200) skreiv Michael Kerrisk:
> And I pointed out that the existing behaviour (which is 
> still current in 2.6.13-rc4) is inconsistent:
> 
> http://marc.theaimsgroup.com/?l=linux-kernel&m=111511455406623&w=2
> 
>     Some further testing showed the following (both open() 
>     and fcntl(F_SETLEASE) from same process):
> 
>      open()  |  lease requested
>       flag   | F_RDLCK  | F_WRLCK
>     ---------+----------+----------
>     O_RDONLY | okay     |  okay
>     O_WRONLY | EAGAIN   |  okay
>     O_RDWR   | EAGAIN   |  okay
> 
> In other words, a process can open a file read-write, and
> can't place a read lease, but can place a write lease!  
> That does not seem to make any sense to me.

Then what do you think that leases are supposed to do, and why?

AFAIK, the whole point here is to provide a method to allow CIFS and
NFSv4 clients to be notified if there is some behaviour on the server
that screws with the ability to cache data.

An exclusive (i.e. write) lease should mean that _nothing_ other than
your process is accessing the file. A client may cache the file data,
metadata and read/write locks because nobody else can change that
information, and nobody else holds locks on the file. It may also cache
file acl/access information, and hence cache new OPEN calls.

A shared (i.e. read) lease means that there are currently no processes
that can change the data or metadata (including your own). A client may
cache data, metadata and read locks since there are no writers, and
there is nobody holding write locks. The client may again cache OPEN
calls as long as they are read-only.

Note that the kernel is still incomplete w.r.t. notification of changes.
Holders of the oplocks/delegations need to be notified if the file is
renamed, or if the acl/access information changes, say.

Cheers,
  Trond

