Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263233AbTEGOa3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 10:30:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263381AbTEGOa3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 10:30:29 -0400
Received: from navigator.sw.com.sg ([213.247.162.11]:63190 "EHLO
	navigator.sw.com.sg") by vger.kernel.org with ESMTP id S263233AbTEGOaZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 10:30:25 -0400
From: Vladimir Serov <vserov@infratel.com>
To: trond.myklebust@fys.uio.no, linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <3EB91B6F.9020204@infratel.com>
Date: Wed, 07 May 2003 18:42:55 +0400
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
Subject: Re: [BUG] nfs client stuck in D state in linux 2.4.17 - 2.4.21-pre5
References: <20030318155731.1f60a55a.skraw@ithnet.com>	<3E79EAA8.4000907@infratel.com>	<15993.60520.439204.267818@charged.uio.no>	<3E7ADBFD.4060202@infratel.com>	<shsof45nf58.fsf@charged.uio.no>	<3E7B0051.8060603@infratel.com>	<15995.578.341176.325238@charged.uio.no>	<3E7B10DF.5070005@infratel.com>	<15995.5996.446164.746224@charged.uio.no>	<3E7B1DF9.2090401@infratel.com> <15995.10797.983569.410234@charged.uio.no>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Trond ,

I'm calling you again, to the ask for the help with the same problem on 
ARM nfs client.
I've managed to trace this problem down to the the specific routine 
where control reaches uninterruptible sleep.
It's in 'fs/nfs/inode.c' : __nfs_revalidate_inode(struct nfs_server 
*server, struct inode *inode):

    while (NFS_REVALIDATING(inode)) {
      dfprintk(PAGECACHE, "NFS: nfs_wait_on_inode()\n");
        status = nfs_wait_on_inode(inode, NFS_INO_REVALIDATING);
        if (status < 0)
            goto out_nowait;
        if (time_before(jiffies,NFS_READTIME(inode)+NFS_ATTRTIMEO(inode))) {
            status = NFS_STALE(inode) ? -ESTALE : 0;
            goto out_nowait;
        }
    }

control sleeps forever in nfs_wait_on_inode(). I can't bet, but as far 
as i broused dmesg output every call to nfs_wait_on_inode() in this 
place leads to uninterruptible sleep forever. I like to notice that 
inode->i_count i'm printing is 2 when this problem happens instead of 1 
when things are OK. Also the rpc client in this request is c0d75060 
which is mentioned in rpc queue status:

-pid- proc flgs status -client- -prog- --rqstp- -timeout -rpcwait 
-action- --exit--
09150 0001 0000 000000 c0d75060 100003 c8f99074 00000000  <NULL>  
c00f17b8        0
00683 0000 0081 -00110 c0d75060 100003        0 00030000 nfs_flushd 
c0066c04 c0066d3c
00002 0000 0081 -00110 c8f93c80 100003        0 00030000 nfs_flushd 
c0066c04 c0066d3c

my current kernel is 2.4.21-pre6 based. I'm using HARD mounted nfs 
volume now !!!

here is the tail of last dmesg output:

NFS: revalidating (9/1246183/1246183 count=1)
NFS: lock_kernel()
NFS: exit while (NFS_REVALIDATING(inode))
NFS call  getattr
RPC: 25429 new task procpid 179
RPC: 25429 looking up UNIX cred
RPC: 25429 rpc_execute flgs 0
RPC: 25429 deleting timer
RPC: 25429 call_start nfs3 proc 1 (sync)
RPC: 25429 deleting timer
RPC: 25429 call_reserve
RPC: 25429 reserved req c8f99100 xid 00011353
RPC: 25429 deleting timer
RPC: 25429 call_reserveresult (status 0)
RPC: 25429 deleting timer
RPC: 25429 call_allocate (status 0)
RPC:      allocated buffer c8e70800
RPC: 25429 deleting timer
RPC: 25429 call_encode (status 0)
RPC: 25429 marshaling UNIX cred c0db30a0
RPC: 25429 deleting timer
RPC: 25429 call_bind xprt c8f99000 is connected
RPC: 25429 deleting timer
RPC: 25429 call_transmit (status 0)
RPC: 25429 xprt_transmit(11353)
RPC: 25429 xprt_cwnd_limited cong = 0 cwnd = 512
RPC:      udp_data_ready...
RPC:      udp_data_ready client c8f99000
RPC: 25429 received reply
RPC:      cong 256, cwnd was 512, now 512
RPC: 25429 has input (112 bytes)
RPC:      xprt_sendmsg(0) = 104
RPC: 25429 xmit complete
RPC:      wake_up_next(c8f9904c "xprt_resend")
RPC:      wake_up_next(c8f99040 "xprt_sending")
RPC: 25429 deleting timer
RPC: 25429 call_status (status 112)
RPC: 25429 deleting timer
RPC: 25429 call_decode (status 112)
RPC: 25429 validating UNIX cred c0db30a0
RPC: 25429 call_decode result 0 decode 0xc0071920
RPC: 25429 deleting timer
RPC: 25429 exit() = 0
RPC: 25429 release task
RPC: 25429 disabling timer
RPC: 25429 deleting timer
RPC:      wake_up_next(c8f9904c "xprt_resend")
RPC:      wake_up_next(c8f99040 "xprt_sending")
RPC: 25429 release request c8f99100
RPC:      wake_up_next(c8f99064 "xprt_backlog")
RPC: 25429 releasing UNIX cred c0db30a0
RPC:      rpc_release_client(c0d75060, 3)
NFS reply getattr
NFS: nfs_refresh_inode(inode, &fattr)
NFS: refresh_inode(9/1246183 ct=1 info=0x6)
NFS: (9/1246183) revalidation complete
NFS: out:
NFS: out_nowait:
NFS: unlock_kernel()
NFS: dentry_delete(linux/802_11.h, 0)
RPC:     looking up UNIX cred
RPC:     looking up UNIX cred
RPC:     looking up UNIX cred
RPC:     looking up UNIX cred
RPC:     looking up UNIX cred
RPC:     looking up UNIX cred
RPC:     looking up UNIX cred
NFS: revalidating (9/1246184/1246184 count=2)
NFS: lock_kernel()
NFS: nfs_wait_on_inode()
NFS: nfs_wait_on_inode: clnt=c0d75060 nfs_wait_event() UN interruptible


Cheers, Vladimir.
