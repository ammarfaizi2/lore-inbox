Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264815AbUFGPWw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264815AbUFGPWw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jun 2004 11:22:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263100AbUFGPWu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jun 2004 11:22:50 -0400
Received: from mail.ccur.com ([208.248.32.212]:38672 "EHLO exchange.ccur.com")
	by vger.kernel.org with ESMTP id S264811AbUFGPVl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jun 2004 11:21:41 -0400
Date: Mon, 7 Jun 2004 11:21:39 -0400
From: Joe Korty <joe.korty@ccur.com>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: linux-kernel@vger.kernel.org, Ronny.Lampert@telecasystems.de,
       ioe-lkml@rameria.de
Subject: Re: [BUG] NFS no longer updates file modification times appropriately
Message-ID: <20040607152139.GA21926@tsunami.ccur.com>
Reply-To: joe.korty@ccur.com
References: <1086297112.3659.3.camel@lade.trondhjem.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1086297112.3659.3.camel@lade.trondhjem.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 03, 2004 at 05:11:52PM -0400, Trond Myklebust wrote:
> P? to , 03/06/2004 klokka 13:28, skreiv Joe Korty:
>>  Paraphrased from one of my inhouse customers: "The timestamp of an
>> NFS-mounted file does not change when written to, when the below test is
>> run on a 2.6.6-rc1 to 2.6.7-rc2 kernel.  The timestamp is appropriately
>> updated when the test is run on a 2.6.5 kernel.  This is with NFSv3.
>> The type of system serving up the files does not seem to be a factor."
> 
> NFS is only guaranteed to flush the file to disk when you do the
> close(). Your program will just result in a lot of cached writes right
> up until the moment it exits...
> 
> ...and no - we do not update timestamps on the client side when we cache
> the write, 'cos NFS does not provide any device for ensuring that clocks
> on client and server are synchronized.

Hi Trond,
 For those interested, this patch reverts NFS to the old behavior of
a timestamp-for-each-write.

I see no harm in it.  After all, timestamps have to be updated on file
creation and close, which are also initiated from the client, just as
writes are.  So allowing timestamp update on create/close but not writes
does not make much sense to me.

Unless the real reason is reducing ethernet traffic.  In which case we
could defer a timestamp-on-write only when it is still in the same second
as the previous write, but don't defer when a new second rolls around
on the client.  That would reduce timestamp updates to at most one per
second per inode per client, while preserving old NFS behavior.

Regards,
Joe


--- base/fs/nfs/write.c	2004-06-07 10:25:33.861224586 -0400
+++ new/fs/nfs/write.c	2004-06-07 11:06:22.044853102 -0400
@@ -417,7 +417,7 @@
 	nfsi->npages--;
 	if (!nfsi->npages) {
 		spin_unlock(&nfs_wreq_lock);
-		nfs_end_data_update_defer(inode);
+		nfs_end_data_update(inode);
 		iput(inode);
 	} else
 		spin_unlock(&nfs_wreq_lock);

