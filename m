Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262458AbTESNIZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 May 2003 09:08:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262459AbTESNIZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 May 2003 09:08:25 -0400
Received: from navigator.sw.com.sg ([213.247.162.11]:61057 "EHLO
	navigator.sw.com.sg") by vger.kernel.org with ESMTP id S262458AbTESNIU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 May 2003 09:08:20 -0400
From: Vladimir Serov <vserov@infratel.com>
To: trond.myklebust@fys.uio.no, linux-kernel <linux-kernel@vger.kernel.org>,
       Russell King <rmk@arm.linux.org.uk>
Message-ID: <3EC8DA1B.50304@infratel.com>
Date: Mon, 19 May 2003 17:20:27 +0400
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
Subject: Re: [BUG] nfs client stuck in D state in linux 2.4.17 - 2.4.21-pre5
References: <20030318155731.1f60a55a.skraw@ithnet.com>	<3E79EAA8.4000907@infratel.com>	<15993.60520.439204.267818@charged.uio.no>	<3E7ADBFD.4060202@infratel.com>	<shsof45nf58.fsf@charged.uio.no>	<3E7B0051.8060603@infratel.com>	<15995.578.341176.325238@charged.uio.no>	<3E7B10DF.5070005@infratel.com>	<15995.5996.446164.746224@charged.uio.no>	<3E7B1DF9.2090401@infratel.com> <15995.10797.983569.410234@charged.uio.no>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Trond , Hi Russell,

I have some new info on this long standing and obscure problem with ARM 
nfs client. I found the initial place of nfs failure. Sometimes 'ls -lR 
/home' command sleeps inside __rpc_execute() function and doesn't get 
really woken up. While everything looks like going correctly and 
wake_up(&task->tk_wait) is called (with rpc_clear_sleeping(task) 
previously done) in rpc_make_runnable() function, and the address of 
wait queue ( &task->tk_wait ) used in __wait_event(task->tk_wait, 
!RPC_IS_SLEEPING(task)) and wake_up(&task->tk_wait) is the same. But for 
some reason task doesn't get woken up !!!

I'm not shure which layer of kernel code could be responsible for this, 
and where to look in now.
Help, please !!!

My current kernel is 2.4.21-pre6 based with patches from 2.4.19-rmk7 
applied (well partially, except ide and pci cause i don't have them, 
board is mostly brutus). I'm using HARD mounted nfs
volume now !!! The tail of dmesg is following.

NFS: lookup(LC_MESSAGES/kmid.mo)
NFS: lookup nfs_cached_lookup()
NFS: lookup nfs_fhget()
NFS: nfs_fhget(LC_MESSAGES/kmid.mo fileid=3227729)
NFS: refresh_inode(9/3227729 ct=1 info=0x6)
NFS: __nfs_fhget(9/3227729 ct=1)
NFS: lookup nfs_renew_times()
NFS: lookup out:
NFS: revalidating (9/3227729/3227729 count=1)
NFS: lock_kernel()
NFS: exit while (NFS_REVALIDATING(inode))
NFS call  getattr
RPC: 3871 new task procpid 171
RPC: 3871 looking up UNIX cred
RPC: 3871 rpc_execute flgs 0
RPC: 3871 deleting timer
RPC: 3871 call_start nfs3 proc 1 (sync)
RPC: 3871 deleting timer
RPC: 3871 call_reserve
RPC: 3871 reserved req c0e0f074 xid 00032f1d
RPC: 3871 deleting timer
RPC: 3871 call_reserveresult (status 0)
RPC: 3871 deleting timer
RPC: 3871 call_allocate (status 0)
RPC:      allocated buffer c0dd1000
RPC: 3871 deleting timer
RPC: 3871 call_encode (status 0)
RPC: 3871 marshaling UNIX cred c8f3a0a0
RPC: 3871 deleting timer
RPC: 3871 call_bind xprt c0e0f000 is connected
RPC: 3871 deleting timer
RPC: 3871 call_transmit (status 0)
RPC: 3871 xprt_transmit(32f1d)
RPC: 3871 xprt_cwnd_limited cong = 0 cwnd = 512
RPC:      xprt_sendmsg(0) = 104
RPC: 3871 xmit complete
RPC: 3871 sleep_on(queue "xprt_pending" time 1248461)
RPC: 3871 added to queue c0e0f058 "xprt_pending"
RPC: 3871 setting alarm for 4 ms
RPC:      wake_up_next(c0e0f04c "xprt_resend")
RPC:      wake_up_next(c0e0f040 "xprt_sending")
RPC: 3871 sync task going to sleep on c0e83e70
RPC:      udp_data_ready...
RPC:      udp_data_ready client c0e0f000
RPC: 3871 received reply
RPC:      cong 256, cwnd was 512, now 512
RPC:      wake_up_next(c0e0f04c "xprt_resend")
RPC:      wake_up_next(c0e0f040 "xprt_sending")
RPC: 3871 has input (112 bytes)
RPC: 3871 __rpc_wake_up_task (now 1248462 inh 0)
RPC: 3871 disabling timer
RPC: 3871 removed from queue c0e0f058 "xprt_pending"
RPC: 3871 sync task was woken up on c0e83e70 in rpc_make_runnable() !!!
RPC:      __rpc_wake_up_task done
NFS: dentry_delete(hu/LC_MESSAGES, 0)
NFS: dentry_delete(il/LC_MESSAGES, 0)
NFS: dentry_delete(locale/br, 0)
NFS: dentry_delete(locale/ca, 0)
NFS: dentry_delete(locale/cs, 0)
NFS: dentry_delete(locale/da, 0)
NFS: dentry_delete(share/ghostscript, 0)
NFS: dentry_delete(licq/qt-gui, 0)
NFS: dentry_delete(locale/de, 0)
NFS: dentry_delete(is/LC_MESSAGES, 0)
NFS: dentry_delete(it/LC_MESSAGES, 0)
NFS: dentry_delete(ja/LC_MESSAGES, 0)
NFS: dentry_delete(ko/LC_MESSAGES, 0)
NFS: dentry_delete(mk/LC_MESSAGES, 0)
NFS: dentry_delete(nl/LC_MESSAGES, 0)
RPC:  656 running timer
RPC: 656 timeout (default timer)
RPC:  656 __rpc_wake_up_task (now 1256944 inh 0)
RPC:  656 disabling timer
RPC:  656 removed from queue c0138a1c "nfs_flushd"
RPC:  656 added to queue c013e6e8 "schedq"
RPC:      __rpc_wake_up_task done
RPC: switch to rpciod
RPC:      rpc_schedule enter
RPC:  656 removed from queue c013e6e8 "schedq"
RPC:  656 rpc_execute flgs 81
RPC:  656 deleting timer
NFS:  656 flushd starting
NFS:  656 flushd back to sleep
RPC:  656 sleep_on(queue "nfs_flushd" time 1256944)
RPC:  656 added to queue c0138a1c "nfs_flushd"
RPC:  656 setting alarm for 30000 ms
RPC:      rpc_schedule leave
RPC: rpciod back to sleep
RPC:    2 running timer
RPC: 2 timeout (default timer)
RPC:    2 __rpc_wake_up_task (now 1278435 inh 0)
RPC:    2 disabling timer
RPC:    2 removed from queue c0138a1c "nfs_flushd"
RPC:    2 added to queue c013e6e8 "schedq"
RPC:      __rpc_wake_up_task done
RPC: switch to rpciod
RPC:      rpc_schedule enter
RPC:    2 removed from queue c013e6e8 "schedq"
RPC:    2 rpc_execute flgs 81
RPC:    2 deleting timer
NFS:    2 flushd starting
NFS:    2 flushd back to sleep
RPC:    2 sleep_on(queue "nfs_flushd" time 1278435)
RPC:    2 added to queue c0138a1c "nfs_flushd"
RPC:    2 setting alarm for 30000 ms
RPC:      rpc_schedule leave
RPC: rpciod back to sleep
-pid- proc flgs status -client- -prog- --rqstp- -timeout -rpcwait 
-action- --exit--
03871 0001 0000 000000 c8f5fa80 100003 c0e0f074 00000000  <NULL> 
c00f17ac        0
00656 0000 0081 -00110 c8f5fa80 100003        0 00030000 nfs_flushd 
c0066c08 c0066d40
00002 0000 0081 -00110 c0e15d80 100003        0 00030000 nfs_flushd 
c0066c08 c0066d40



Cheers, Vladimir.
