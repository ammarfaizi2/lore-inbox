Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267799AbTBKNVe>; Tue, 11 Feb 2003 08:21:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267808AbTBKNVe>; Tue, 11 Feb 2003 08:21:34 -0500
Received: from angband.namesys.com ([212.16.7.85]:42628 "HELO
	angband.namesys.com") by vger.kernel.org with SMTP
	id <S267799AbTBKNVc>; Tue, 11 Feb 2003 08:21:32 -0500
Date: Tue, 11 Feb 2003 16:31:19 +0300
From: Oleg Drokin <green@namesys.com>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Neil Brown <neilb@cse.unsw.edu.au>,
       David Ford <david+powerix@blue-labs.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Current NFS issues (2.5.59)
Message-ID: <20030211163119.A24157@namesys.com>
References: <3E46E1D6.20709@blue-labs.org> <15944.30340.955911.798377@notabene.cse.unsw.edu.au> <20030211100011.A5850@namesys.com> <15944.60247.512630.175678@charged.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15944.60247.512630.175678@charged.uio.no>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Tue, Feb 11, 2003 at 01:23:51PM +0100, Trond Myklebust wrote:
>     >> this started happening when they upgrade from an earlier 2.5
>     >> kernel.
> 
>      > I think that earlier report was from David too. This is just
>      > more detailed report it seems.
> 
>      > And while you are listening - I want to share my own NFs
>      > problems in 2.5.59 ;) If I try to mount any NFS exported
>      > filesystem from the same host (e.g localhost), mount process
>      > hangs in D state. Server appears to work ok though and serves
>      > requests from external clients.
> ...and I am unable to reproduce this 8-)

Here is how I achieve this:
2.5.60 kernel from current bk repository.
belka:/usr/src/linux-2.5-bk # grep NFS .config
CONFIG_NFS_FS=y
CONFIG_NFS_V3=y
# CONFIG_NFS_V4 is not set
CONFIG_NFSD=y
CONFIG_NFSD_V3=y
# CONFIG_NFSD_V4 is not set
CONFIG_NFSD_TCP=y

belka:~ # cat /etc/exports
/home (ro)
belka:~ # ps ax | grep portmap
  421 ?        S      0:00 /sbin/portmap
belka:~ # mount localhost:/home /mnt -t nfs
And it hangs here.
(Actually I found it does not hang, it just cannot connect to something,
as it emits "nfs: server localhost not responding, still trying"
messages from time to time, but I see no way to interrupt the process)
This is on SMP box. Distro is based on SuSE 8.1

Sysrt-T gives me this:
mount         D 00000086 4293700280   761    755                     (NOTLB)
Call Trace:
 [<c0301760>] call_transmit+0x48/0x9c
 [<c0305f72>] __rpc_execute+0x23e/0x3ee
 [<c011890a>] default_wake_function+0x0/0x12
 [<c0301003>] rpc_call_sync+0xbd/0xf2
 [<c030350e>] xprt_timer+0x0/0x15a
 [<c03017b4>] call_status+0x0/0xf8
 [<c0304fd0>] rpc_run_timer+0x0/0xec
 [<c01b9dee>] nfs3_rpc_wrapper+0x3a/0x82
 [<c01b9f71>] nfs3_proc_get_root+0x53/0x84
 [<c01b0894>] nfs_get_root+0x44/0x8a
 [<c016d018>] inode_init_once+0x20/0x17c
 [<c020ba61>] vsnprintf+0x20d/0x460
 [<c020bcdb>] snprintf+0x27/0x2c
 [<c01b09a9>] nfs_sb_init+0xcf/0x4d8
 [<c013d47b>] cache_alloc_debugcheck_after+0xcd/0xd8
 [<c013c3b9>] kmalloc+0xa1/0xdc
 [<c030870c>] unx_create+0x50/0x70
 [<c0307b2b>] rpcauth_create+0x35/0x48
 [<c0300b80>] rpc_create_client+0x160/0x1f0
 [<c0307154>] rpciod_up+0x26/0x120
 [<c01b10c3>] nfs_fill_super+0x311/0x3c2
 [<c0158e86>] sget+0x162/0x188
 [<c01b2f1d>] nfs_get_sb+0x1a9/0x238
 [<c0159b39>] do_kern_mount+0x5f/0xd4
 [<c01717a9>] do_add_mount+0x9d/0x19e
 [<c0171adf>] do_mount+0x155/0x1a2
 [<c01721bb>] sys_mount+0x113/0x18c
 [<c01096b3>] syscall_call+0x7/0xb

Hope this helps.

Bye,
    Oleg
