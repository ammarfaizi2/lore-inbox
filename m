Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261221AbVALPX1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261221AbVALPX1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 10:23:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261216AbVALPX1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 10:23:27 -0500
Received: from penguin.cohaesio.net ([212.97.129.34]:28616 "EHLO
	mail.cohaesio.net") by vger.kernel.org with ESMTP id S261221AbVALPWi convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 10:22:38 -0500
From: Anders Saaby <as@cohaesio.com>
Organization: Cohaesio A/S
To: trond.myklebust@fys.uio.no
Subject: 2.6.10 - VFS is out of sync with lock manager!
Date: Wed, 12 Jan 2005 16:23:10 +0100
User-Agent: KMail/1.7.2
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200501121623.10287.as@cohaesio.com>
X-OriginalArrivalTime: 12 Jan 2005 15:22:37.0883 (UTC) FILETIME=[8C8C58B0:01C4F8BA]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Trond,

Yesterday i posted this to LKML (but my mailreader theated me, and didn't keep 
thread info):

(I am very sorry if you have already seen my previous mail - I don't want to 
bother you unnessary!)

->

I have seen the exact same error on one of my webservers which is serving
from an NFS export and under heavy load. ~2 hours uptime before panic'ing.
I then tried Trond's patch which seems to work. 14 hours of uptime now. :)

Anyways, I have a couple of issues you might be able to clear up for me:

First issue:
New strange message in the kernel log:

"nlmclnt_lock: VFS is out of sync with lock manager!"

- What does this mean? - Is it bad?, What can i do?


Second issue:
my fs/nfs/file.c doesn't look like yours (Vanilla 2.6.10):

<fs/nfs/file.c SNIP>
        status = NFS_PROTO(inode)->lock(filp, cmd, fl);
        /* If we were signalled we still need to ensure that
         * we clean up any state on the server. We therefore
         * record the lock call as having succeeded in order to
         * ensure that locks_remove_posix() cleans it out when
         * the process exits.
         */
        if (status == -EINTR || status == -ERESTARTSYS)
                posix_lock_file_wait(filp, fl);
        unlock_kernel();
        if (status < 0)
                return status;
        /*
         * Make sure we clear the cache whenever we try to get the lock.
         * This makes locking act as a cache coherency point.
         */
        filemap_fdatawrite(filp->f_mapping);
        down(&inode->i_sem);
        nfs_wb_all(inode);      /* we may have slept */
        up(&inode->i_sem);
        filemap_fdatawait(filp->f_mapping);
        nfs_zap_caches(inode);
        return 0;
</SNIP>

So... Am I missing another patch or something else?

Jan-Frode Myklebust wrote:

> On Wed, Jan 05, 2005 at 10:54:03PM +0100, Trond Myklebust wrote:
>> 
>> Looking at the NFS code, I can attempt a wild guess about what may be
>> happening: there may be a race when pressing ^C in the middle of a
>> blocking NFS lock RPC call, and if so, the following patch will fix it.
> 
> 
> A whopping 9 hours of uptime now :) So the one-liner patch seems to have
> fixed it.
> 
> Thanks!
> 
>> -   posix_lock_file(filp, fl);
>> +   posix_lock_file_wait(filp, fl);
> 
> 
>   -jf

-- 
Med venlig hilsen - Best regards - Meilleures salutations

Anders Saaby
Systems Engineer
------------------------------------------------
Cohaesio A/S - Maglebjergvej 5D - DK-2800 Lyngby
Phone: +45 45 880 888 - Fax: +45 45 880 777
Mail: as@cohaesio.com - http://www.cohaesio.com
------------------------------------------------
