Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264129AbUDGUoP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Apr 2004 16:44:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264164AbUDGUoO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Apr 2004 16:44:14 -0400
Received: from 208.177.141.226.ptr.us.xo.net ([208.177.141.226]:27446 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S264129AbUDGUmL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Apr 2004 16:42:11 -0400
Subject: Re: [NFS] Linux 2.4.25, nfs client hangs when talking to a MacOS
	nfs server.
From: Chris Worley <cworley@lnxi.com>
To: Charles-Edouard Ruault <ce@idtect.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <22D3DBAA-7833-11D8-97E9-000A95CFFC9C@idtect.com>
References: <22D3DBAA-7833-11D8-97E9-000A95CFFC9C@idtect.com>
Content-Type: text/plain
Organization: 
Message-Id: <1081370270.2557.16320.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 07 Apr 2004 14:37:53 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a similar problem when there's an MTU mismatch between client and
server (i.e. the server is 9K and the client is 1400 bytes)... although
other TCP and UDP connections don't have a problem, NFS does.

The solutions are, on the client side: 1) use TCP instead of UDP for
NFS, or 2) set the rsize/wsize below 1400 bytes.

On Wed, 2004-03-17 at 03:44, Charles-Edouard Ruault wrote:
> Hi all,
> 
> i'm facing a very annoying problem with nfs on linux 2.4.25 ( vanilla  
> kernel ).
> I have a MacOS X server ( tried with version 10.2.8 and 10.3.2 ) acting  
> as an nfs server for a bunch of linux clients ( 2.4.25 vanilla ).
> Whenever i try to copy a file from the server to the client, the  
> process gets stuck after copying a few bytes from the server. This is  
> systematic.
> Looking at the process state gives:
> 
>   PID  PPID WCHAN  S
> 12539 12516 rpc_ex D
> 
> nfs mount options are the following : ro,nosuid,nolock
> I've also tried to add the soft option, it does not change anything.
> 
> After doing some research, i found a patch available for linux nfs to  
> support larger locking cookies ( as used by FreeBsd and MaxOSX ) but as  
> far as i understant, this should not be the cause of my problem since  
> i'm mounting readonly and also i secified the nolock option to mount.
> 
> Does anyone have an idea of what's happening ? Is is a problem specific  
> to interactions between Linux & MacOS ? I could not find any info about  
> this on the net.
> Thanks in advance for any help.
> 
> 
> I've turned on debugging for nfs ( setting /proc/sys/sunrpc/*_debug to  
> 9 ) and i'm getting the following logs:
> 
> Mar 17 10:34:12 monitor kernel: NFS: lookup(//FileStore)
> Mar 17 10:34:12 monitor kernel: RPC: 14022 reserved req f700f074 xid  
> 73f386c2
> Mar 17 10:34:12 monitor kernel: RPC: 14022 xprt_transmit(73f386c2)
> Mar 17 10:34:12 monitor kernel: RPC: 14022 xprt_cwnd_limited cong = 0  
> cwnd = 512
> Mar 17 10:34:12 monitor kernel: RPC:      xprt_sendmsg(0) = 132
> Mar 17 10:34:12 monitor kernel: RPC: 14022 xmit complete
> Mar 17 10:34:12 monitor kernel: RPC:      udp_data_ready...
> Mar 17 10:34:12 monitor kernel: RPC:      udp_data_ready client f700f000
> Mar 17 10:34:12 monitor kernel: RPC: 14022 received reply
> Mar 17 10:34:12 monitor kernel: RPC:      cong 256, cwnd was 512, now  
> 512
> Mar 17 10:34:12 monitor kernel: RPC: 14022 has input (236 bytes)
> Mar 17 10:34:12 monitor kernel: RPC: 14022 release request f700f074
> Mar 17 10:34:12 monitor kernel: NFS: refresh_inode(8/2 ct=1 info=0x6)
> Mar 17 10:34:12 monitor kernel: NFS: nfs_fhget(//FileStore  
> fileid=339704)
> Mar 17 10:34:12 monitor kernel: NFS: refresh_inode(8/339704 ct=1  
> info=0x6)
> Mar 17 10:34:12 monitor kernel: NFS: __nfs_fhget(8/339704 ct=1)
> Mar 17 10:34:12 monitor kernel: NFS: lookup(FileStore/GD)
> Mar 17 10:34:12 monitor kernel: RPC: 14023 reserved req f700f074 xid  
> 73f386c3
> Mar 17 10:34:12 monitor kernel: RPC: 14023 xprt_transmit(73f386c3)
> Mar 17 10:34:12 monitor kernel: RPC: 14023 xprt_cwnd_limited cong = 0  
> cwnd = 512
> Mar 17 10:34:12 monitor kernel: RPC:      xprt_sendmsg(0) = 124
> Mar 17 10:34:12 monitor kernel: RPC: 14023 xmit complete
> Mar 17 10:34:12 monitor kernel: RPC:      udp_data_ready...
> Mar 17 10:34:12 monitor kernel: RPC:      udp_data_ready client f700f000
> Mar 17 10:34:12 monitor kernel: RPC: 14023 received reply
> Mar 17 10:34:12 monitor kernel: RPC:      cong 256, cwnd was 512, now  
> 512
> Mar 17 10:34:12 monitor kernel: RPC: 14023 has input (236 bytes)
> Mar 17 10:34:12 monitor kernel: RPC: 14023 release request f700f074
> Mar 17 10:34:12 monitor kernel: NFS: refresh_inode(8/339704 ct=1  
> info=0x6)
> Mar 17 10:34:12 monitor kernel: NFS: nfs_fhget(FileStore/GD  
> fileid=364017)
> Mar 17 10:34:12 monitor kernel: NFS: refresh_inode(8/364017 ct=1  
> info=0x6)
> Mar 17 10:34:12 monitor kernel: NFS: __nfs_fhget(8/364017 ct=1)
> Mar 17 10:34:12 monitor kernel: NFS: lookup(GD/ETI)
> Mar 17 10:34:12 monitor kernel: RPC: 14024 reserved req f700f074 xid  
> 73f386c4
> Mar 17 10:34:12 monitor kernel: RPC: 14024 xprt_transmit(73f386c4)
> Mar 17 10:34:12 monitor kernel: RPC: 14024 xprt_cwnd_limited cong = 0  
> cwnd = 512
> Mar 17 10:34:12 monitor kernel: RPC:      xprt_sendmsg(0) = 124
> Mar 17 10:34:12 monitor kernel: RPC: 14024 xmit complete
> Mar 17 10:34:12 monitor kernel: RPC:      udp_data_ready...
> Mar 17 10:34:12 monitor kernel: RPC:      udp_data_ready client f700f000
> Mar 17 10:34:12 monitor kernel: RPC: 14024 received reply
> Mar 17 10:34:12 monitor kernel: RPC:      cong 256, cwnd was 512, now  
> 512
> Mar 17 10:34:12 monitor kernel: RPC: 14024 has input (236 bytes)
> Mar 17 10:34:12 monitor kernel: RPC: 14024 release request f700f074
> Mar 17 10:34:12 monitor kernel: NFS: refresh_inode(8/364017 ct=1  
> info=0x6)
> Mar 17 10:34:12 monitor kernel: NFS: nfs_fhget(GD/ETI fileid=364018)
> Mar 17 10:34:12 monitor kernel: NFS: refresh_inode(8/364018 ct=1  
> info=0x6)
> Mar 17 10:34:12 monitor kernel: NFS: __nfs_fhget(8/364018 ct=1)
> Mar 17 10:34:12 monitor kernel: NFS: lookup(ETI/BO)
> Mar 17 10:34:12 monitor kernel: RPC: 14025 reserved req f700f074 xid  
> 73f386c5
> Mar 17 10:34:12 monitor kernel: RPC: 14025 xprt_transmit(73f386c5)
> Mar 17 10:34:12 monitor kernel: RPC: 14025 xprt_cwnd_limited cong = 0  
> cwnd = 512
> Mar 17 10:34:12 monitor kernel: RPC:      xprt_sendmsg(0) = 124
> Mar 17 10:34:12 monitor kernel: RPC: 14025 xmit complete
> Mar 17 10:34:12 monitor kernel: RPC:      udp_data_ready...
> Mar 17 10:34:12 monitor kernel: RPC:      udp_data_ready client f700f000
> Mar 17 10:34:12 monitor kernel: RPC: 14025 received reply
> Mar 17 10:34:12 monitor kernel: RPC:      cong 256, cwnd was 512, now  
> 512
> Mar 17 10:34:12 monitor kernel: RPC: 14025 has input (236 bytes)
> Mar 17 10:34:12 monitor kernel: RPC: 14025 release request f700f074
> Mar 17 10:34:12 monitor kernel: NFS: refresh_inode(8/364018 ct=1  
> info=0x6)
> Mar 17 10:34:12 monitor kernel: NFS: nfs_fhget(ETI/BO fileid=364019)
> Mar 17 10:34:12 monitor kernel: NFS: refresh_inode(8/364019 ct=1  
> info=0x6)
> Mar 17 10:34:12 monitor kernel: NFS: __nfs_fhget(8/364019 ct=1)
> Mar 17 10:34:12 monitor kernel: NFS: lookup(BO/MAKER_AF12)
> Mar 17 10:34:12 monitor kernel: RPC: 14026 reserved req f700f074 xid  
> 73f386c6
> Mar 17 10:34:12 monitor kernel: RPC: 14026 xprt_transmit(73f386c6)
> Mar 17 10:34:12 monitor kernel: RPC: 14026 xprt_cwnd_limited cong = 0  
> cwnd = 512
> Mar 17 10:34:12 monitor kernel: RPC:      xprt_sendmsg(0) = 132
> Mar 17 10:34:12 monitor kernel: RPC: 14026 xmit complete
> Mar 17 10:34:12 monitor kernel: RPC:      udp_data_ready...
> Mar 17 10:34:12 monitor kernel: RPC:      udp_data_ready client f700f000
> Mar 17 10:34:12 monitor kernel: RPC: 14026 received reply
> Mar 17 10:34:12 monitor kernel: RPC:      cong 256, cwnd was 512, now  
> 512
> Mar 17 10:34:12 monitor kernel: RPC: 14026 has input (236 bytes)
> Mar 17 10:34:12 monitor kernel: RPC: 14026 release request f700f074
> Mar 17 10:34:12 monitor kernel: NFS: refresh_inode(8/364019 ct=1  
> info=0x6)
> Mar 17 10:34:12 monitor kernel: NFS: nfs_fhget(BO/MAKER_AF12  
> fileid=364020)
> Mar 17 10:34:12 monitor kernel: NFS: refresh_inode(8/364020 ct=1  
> info=0x6)
> Mar 17 10:34:12 monitor kernel: NFS: __nfs_fhget(8/364020 ct=1)
> Mar 17 10:34:12 monitor kernel: NFS: lookup(MAKER_AF12/C4)
> Mar 17 10:34:12 monitor kernel: RPC: 14027 reserved req f700f074 xid  
> 73f386c7
> Mar 17 10:34:12 monitor kernel: RPC: 14027 xprt_transmit(73f386c7)
> Mar 17 10:34:12 monitor kernel: RPC: 14027 xprt_cwnd_limited cong = 0  
> cwnd = 512
> Mar 17 10:34:12 monitor kernel: RPC:      xprt_sendmsg(0) = 124
> Mar 17 10:34:12 monitor kernel: RPC: 14027 xmit complete
> Mar 17 10:34:12 monitor kernel: RPC:      udp_data_ready...
> Mar 17 10:34:12 monitor kernel: RPC:      udp_data_ready client f700f000
> Mar 17 10:34:12 monitor kernel: RPC: 14027 received reply
> Mar 17 10:34:12 monitor kernel: RPC:      cong 256, cwnd was 512, now  
> 512
> Mar 17 10:34:12 monitor kernel: RPC: 14027 has input (236 bytes)
> Mar 17 10:34:12 monitor kernel: RPC: 14027 release request f700f074
> Mar 17 10:34:12 monitor kernel: NFS: refresh_inode(8/364020 ct=1  
> info=0x6)
> Mar 17 10:34:12 monitor kernel: NFS: nfs_fhget(MAKER_AF12/C4  
> fileid=387307)
> Mar 17 10:34:12 monitor kernel: NFS: refresh_inode(8/387307 ct=1  
> info=0x6)
> Mar 17 10:34:12 monitor kernel: NFS: __nfs_fhget(8/387307 ct=1)
> Mar 17 10:34:12 monitor kernel: NFS: lookup(C4/CUTTER)
> Mar 17 10:34:12 monitor kernel: RPC: 14028 reserved req f700f074 xid  
> 73f386c8
> Mar 17 10:34:12 monitor kernel: RPC: 14028 xprt_transmit(73f386c8)
> Mar 17 10:34:12 monitor kernel: RPC: 14028 xprt_cwnd_limited cong = 0  
> cwnd = 512
> Mar 17 10:34:12 monitor kernel: RPC:      xprt_sendmsg(0) = 128
> Mar 17 10:34:12 monitor kernel: RPC: 14028 xmit complete
> Mar 17 10:34:12 monitor kernel: RPC:      udp_data_ready...
> Mar 17 10:34:12 monitor kernel: RPC:      udp_data_ready client f700f000
> Mar 17 10:34:12 monitor kernel: RPC: 14028 received reply
> Mar 17 10:34:12 monitor kernel: RPC:      cong 256, cwnd was 512, now  
> 512
> Mar 17 10:34:12 monitor kernel: RPC: 14028 has input (236 bytes)
> Mar 17 10:34:12 monitor kernel: RPC: 14028 release request f700f074
> Mar 17 10:34:12 monitor kernel: NFS: refresh_inode(8/387307 ct=1  
> info=0x6)
> Mar 17 10:34:12 monitor kernel: NFS: nfs_fhget(C4/CUTTER fileid=387858)
> Mar 17 10:34:12 monitor kernel: NFS: refresh_inode(8/387858 ct=1  
> info=0x6)
> Mar 17 10:34:12 monitor kernel: NFS: __nfs_fhget(8/387858 ct=1)
> Mar 17 10:34:12 monitor kernel: NFS: lookup(CUTTER/2004)
> Mar 17 10:34:12 monitor kernel: RPC: 14029 reserved req f700f074 xid  
> 73f386c9
> Mar 17 10:34:12 monitor kernel: RPC: 14029 xprt_transmit(73f386c9)
> Mar 17 10:34:12 monitor kernel: RPC: 14029 xprt_cwnd_limited cong = 0  
> cwnd = 512
> Mar 17 10:34:12 monitor kernel: RPC:      xprt_sendmsg(0) = 124
> Mar 17 10:34:12 monitor kernel: RPC: 14029 xmit complete
> Mar 17 10:34:12 monitor kernel: RPC:      udp_data_ready...
> Mar 17 10:34:12 monitor kernel: RPC:      udp_data_ready client f700f000
> Mar 17 10:34:12 monitor kernel: RPC: 14029 received reply
> Mar 17 10:34:12 monitor kernel: RPC:      cong 256, cwnd was 512, now  
> 512
> Mar 17 10:34:12 monitor kernel: RPC: 14029 has input (236 bytes)
> Mar 17 10:34:12 monitor kernel: RPC: 14029 release request f700f074
> Mar 17 10:34:12 monitor kernel: NFS: refresh_inode(8/387858 ct=1  
> info=0x6)
> Mar 17 10:34:12 monitor kernel: NFS: nfs_fhget(CUTTER/2004  
> fileid=5589936)
> Mar 17 10:34:12 monitor kernel: NFS: refresh_inode(8/5589936 ct=1  
> info=0x6)
> Mar 17 10:34:12 monitor kernel: NFS: __nfs_fhget(8/5589936 ct=1)
> Mar 17 10:34:12 monitor kernel: NFS: lookup(2004/02)
> Mar 17 10:34:12 monitor kernel: RPC: 14030 reserved req f700f074 xid  
> 73f386ca
> Mar 17 10:34:12 monitor kernel: RPC: 14030 xprt_transmit(73f386ca)
> Mar 17 10:34:12 monitor kernel: RPC: 14030 xprt_cwnd_limited cong = 0  
> cwnd = 512
> Mar 17 10:34:12 monitor kernel: RPC:      xprt_sendmsg(0) = 124
> Mar 17 10:34:12 monitor kernel: RPC: 14030 xmit complete
> Mar 17 10:34:12 monitor kernel: RPC:      udp_data_ready...
> Mar 17 10:34:12 monitor kernel: RPC:      udp_data_ready client f700f000
> Mar 17 10:34:12 monitor kernel: RPC: 14030 received reply
> Mar 17 10:34:12 monitor kernel: RPC:      cong 256, cwnd was 512, now  
> 512
> Mar 17 10:34:12 monitor kernel: RPC: 14030 has input (236 bytes)
> Mar 17 10:34:12 monitor kernel: RPC: 14030 release request f700f074
> Mar 17 10:34:12 monitor kernel: NFS: refresh_inode(8/5589936 ct=1  
> info=0x6)
> Mar 17 10:34:12 monitor kernel: NFS: nfs_fhget(2004/02 fileid=5738625)
> Mar 17 10:34:12 monitor kernel: NFS: refresh_inode(8/5738625 ct=1  
> info=0x6)
> Mar 17 10:34:12 monitor kernel: NFS: __nfs_fhget(8/5738625 ct=1)
> Mar 17 10:34:12 monitor kernel: NFS: lookup(02/16)
> Mar 17 10:34:12 monitor kernel: RPC: 14031 reserved req f700f074 xid  
> 73f386cb
> Mar 17 10:34:12 monitor kernel: RPC: 14031 xprt_transmit(73f386cb)
> Mar 17 10:34:12 monitor kernel: RPC: 14031 xprt_cwnd_limited cong = 0  
> cwnd = 512
> Mar 17 10:34:12 monitor kernel: RPC:      xprt_sendmsg(0) = 124
> Mar 17 10:34:12 monitor kernel: RPC: 14031 xmit complete
> Mar 17 10:34:12 monitor kernel: RPC:      udp_data_ready...
> Mar 17 10:34:12 monitor kernel: RPC:      udp_data_ready client f700f000
> Mar 17 10:34:12 monitor kernel: RPC: 14031 received reply
> Mar 17 10:34:12 monitor kernel: RPC:      cong 256, cwnd was 512, now  
> 512
> Mar 17 10:34:12 monitor kernel: RPC: 14031 has input (236 bytes)
> Mar 17 10:34:12 monitor kernel: RPC: 14031 release request f700f074
> Mar 17 10:34:12 monitor kernel: NFS: refresh_inode(8/5738625 ct=1  
> info=0x6)
> Mar 17 10:34:12 monitor kernel: NFS: nfs_fhget(02/16 fileid=5871209)
> Mar 17 10:34:12 monitor kernel: NFS: refresh_inode(8/5871209 ct=1  
> info=0x6)
> Mar 17 10:34:12 monitor kernel: NFS: __nfs_fhget(8/5871209 ct=1)
> Mar 17 10:34:12 monitor kernel: NFS: lookup(16/RawData)
> Mar 17 10:34:12 monitor kernel: RPC: 14032 reserved req f700f074 xid  
> 73f386cc
> Mar 17 10:34:12 monitor kernel: RPC: 14032 xprt_transmit(73f386cc)
> Mar 17 10:34:12 monitor kernel: RPC: 14032 xprt_cwnd_limited cong = 0  
> cwnd = 512
> Mar 17 10:34:12 monitor kernel: RPC:      xprt_sendmsg(0) = 128
> Mar 17 10:34:12 monitor kernel: RPC: 14032 xmit complete
> Mar 17 10:34:12 monitor kernel: RPC:      udp_data_ready...
> Mar 17 10:34:12 monitor kernel: RPC:      udp_data_ready client f700f000
> Mar 17 10:34:12 monitor kernel: RPC: 14032 received reply
> Mar 17 10:34:12 monitor kernel: RPC:      cong 256, cwnd was 512, now  
> 512
> Mar 17 10:34:12 monitor kernel: RPC: 14032 has input (236 bytes)
> Mar 17 10:34:12 monitor kernel: RPC: 14032 release request f700f074
> Mar 17 10:34:12 monitor kernel: NFS: refresh_inode(8/5871209 ct=1  
> info=0x6)
> Mar 17 10:34:12 monitor kernel: NFS: nfs_fhget(16/RawData  
> fileid=5873264)
> Mar 17 10:34:12 monitor kernel: NFS: refresh_inode(8/5873264 ct=1  
> info=0x6)
> Mar 17 10:34:12 monitor kernel: NFS: __nfs_fhget(8/5873264 ct=1)
> Mar 17 10:34:12 monitor kernel: NFS:  
> lookup(RawData/ 
> GD=ETI=BO=MAKER_AF12=C4#CUTTER=3#2004=02=16=20=50=14.mat.gz)
> Mar 17 10:34:12 monitor kernel: RPC: 14033 reserved req f700f074 xid  
> 73f386cd
> Mar 17 10:34:12 monitor kernel: RPC: 14033 xprt_transmit(73f386cd)
> Mar 17 10:34:12 monitor kernel: RPC: 14033 xprt_cwnd_limited cong = 0  
> cwnd = 512
> Mar 17 10:34:12 monitor kernel: RPC:      xprt_sendmsg(0) = 180
> Mar 17 10:34:12 monitor kernel: RPC: 14033 xmit complete
> Mar 17 10:34:12 monitor kernel: RPC:      udp_data_ready...
> Mar 17 10:34:12 monitor kernel: RPC:      udp_data_ready client f700f000
> Mar 17 10:34:12 monitor kernel: RPC: 14033 received reply
> Mar 17 10:34:12 monitor kernel: RPC:      cong 256, cwnd was 512, now  
> 512
> Mar 17 10:34:12 monitor kernel: RPC: 14033 has input (236 bytes)
> Mar 17 10:34:12 monitor kernel: RPC: 14033 release request f700f074
> Mar 17 10:34:12 monitor kernel: NFS: refresh_inode(8/5873264 ct=1  
> info=0x6)
> Mar 17 10:34:12 monitor kernel: NFS:  
> nfs_fhget(RawData/ 
> GD=ETI=BO=MAKER_AF12=C4#CUTTER=3#2004=02=16=20=50=14.mat.gz  
> fileid=5873265)
> Mar 17 10:34:12 monitor kernel: NFS: refresh_inode(8/5873265 ct=1  
> info=0x6)
> Mar 17 10:34:12 monitor kernel: NFS: __nfs_fhget(8/5873265 ct=1)
> Mar 17 10:34:12 monitor kernel: NFS:  
> dentry_delete(RawData/ 
> GD=ETI=BO=MAKER_AF12=C4#CUTTER=3#2004=02=16=20=50=14.mat.gz, 0)
> Mar 17 10:34:12 monitor kernel: RPC: 14034 reserved req f700f074 xid  
> 73f386ce
> Mar 17 10:34:12 monitor kernel: RPC: 14034 xprt_transmit(73f386ce)
> Mar 17 10:34:12 monitor kernel: RPC: 14034 xprt_cwnd_limited cong = 0  
> cwnd = 512
> Mar 17 10:34:12 monitor kernel: RPC:      xprt_sendmsg(0) = 124
> Mar 17 10:34:12 monitor kernel: RPC: 14034 xmit complete
> Mar 17 10:34:12 monitor kernel: RPC:      udp_data_ready...
> Mar 17 10:34:12 monitor kernel: RPC:      udp_data_ready client f700f000
> Mar 17 10:34:12 monitor kernel: RPC: 14034 received reply
> Mar 17 10:34:12 monitor kernel: RPC:      cong 256, cwnd was 512, now  
> 512
> Mar 17 10:34:12 monitor kernel: RPC: 14034 has input (236 bytes)
> Mar 17 10:34:12 monitor kernel: RPC: 14034 release request f700f074
> Mar 17 10:34:12 monitor kernel: NFS: refresh_inode(8/339704 ct=1  
> info=0x6)
> Mar 17 10:34:12 monitor kernel: NFS: refresh_inode(8/364017 ct=1  
> info=0x6)
> Mar 17 10:34:12 monitor kernel: RPC: 14035 reserved req f700f074 xid  
> 73f386cf
> Mar 17 10:34:12 monitor kernel: RPC: 14035 xprt_transmit(73f386cf)
> Mar 17 10:34:12 monitor kernel: RPC: 14035 xprt_cwnd_limited cong = 0  
> cwnd = 512
> Mar 17 10:34:12 monitor kernel: RPC:      xprt_sendmsg(0) = 124
> Mar 17 10:34:12 monitor kernel: RPC: 14035 xmit complete
> Mar 17 10:34:12 monitor kernel: RPC:      udp_data_ready...
> Mar 17 10:34:12 monitor kernel: RPC:      udp_data_ready client f700f000
> Mar 17 10:34:12 monitor kernel: RPC: 14035 received reply
> Mar 17 10:34:12 monitor kernel: RPC:      cong 256, cwnd was 512, now  
> 512
> Mar 17 10:34:12 monitor kernel: RPC: 14035 has input (236 bytes)
> Mar 17 10:34:12 monitor kernel: RPC: 14035 release request f700f074
> Mar 17 10:34:12 monitor kernel: NFS: refresh_inode(8/364017 ct=1  
> info=0x6)
> Mar 17 10:34:12 monitor kernel: NFS: refresh_inode(8/364018 ct=1  
> info=0x6)
> Mar 17 10:34:12 monitor kernel: RPC: 14036 reserved req f700f074 xid  
> 73f386d0
> Mar 17 10:34:12 monitor kernel: RPC: 14036 xprt_transmit(73f386d0)
> Mar 17 10:34:12 monitor kernel: RPC: 14036 xprt_cwnd_limited cong = 0  
> cwnd = 512
> Mar 17 10:34:12 monitor kernel: RPC:      xprt_sendmsg(0) = 132
> Mar 17 10:34:12 monitor kernel: RPC: 14036 xmit complete
> Mar 17 10:34:12 monitor kernel: RPC:      udp_data_ready...
> Mar 17 10:34:12 monitor kernel: RPC:      udp_data_ready client f700f000
> Mar 17 10:34:12 monitor kernel: RPC: 14036 received reply
> Mar 17 10:34:12 monitor kernel: RPC:      cong 256, cwnd was 512, now  
> 512
> Mar 17 10:34:12 monitor kernel: RPC: 14036 has input (236 bytes)
> Mar 17 10:34:12 monitor kernel: RPC: 14036 release request f700f074
> Mar 17 10:34:12 monitor kernel: NFS: refresh_inode(8/364019 ct=1  
> info=0x6)
> Mar 17 10:34:12 monitor kernel: NFS: refresh_inode(8/364020 ct=1  
> info=0x6)
> Mar 17 10:34:12 monitor kernel: RPC: 14037 reserved req f700f074 xid  
> 73f386d1
> Mar 17 10:34:12 monitor kernel: RPC: 14037 xprt_transmit(73f386d1)
> Mar 17 10:34:12 monitor kernel: RPC: 14037 xprt_cwnd_limited cong = 0  
> cwnd = 512
> Mar 17 10:34:12 monitor kernel: RPC:      xprt_sendmsg(0) = 124
> Mar 17 10:34:12 monitor kernel: RPC: 14037 xmit complete
> Mar 17 10:34:12 monitor kernel: RPC:      udp_data_ready...
> Mar 17 10:34:12 monitor kernel: RPC:      udp_data_ready client f700f000
> Mar 17 10:34:12 monitor kernel: RPC: 14037 received reply
> Mar 17 10:34:12 monitor kernel: RPC:      cong 256, cwnd was 512, now  
> 512
> Mar 17 10:34:12 monitor kernel: RPC: 14037 has input (236 bytes)
> Mar 17 10:34:12 monitor kernel: RPC: 14037 release request f700f074
> Mar 17 10:34:12 monitor kernel: NFS: refresh_inode(8/364020 ct=1  
> info=0x6)
> Mar 17 10:34:12 monitor kernel: NFS: refresh_inode(8/387307 ct=1  
> info=0x6)
> Mar 17 10:34:12 monitor kernel: RPC: 14038 reserved req f700f074 xid  
> 73f386d2
> Mar 17 10:34:12 monitor kernel: RPC: 14038 xprt_transmit(73f386d2)
> Mar 17 10:34:12 monitor kernel: RPC: 14038 xprt_cwnd_limited cong = 0  
> cwnd = 512
> Mar 17 10:34:12 monitor kernel: RPC:      xprt_sendmsg(0) = 128
> Mar 17 10:34:12 monitor kernel: RPC: 14038 xmit complete
> Mar 17 10:34:12 monitor kernel: RPC:      udp_data_ready...
> Mar 17 10:34:12 monitor kernel: RPC:      udp_data_ready client f700f000
> Mar 17 10:34:12 monitor kernel: RPC: 14038 received reply
> Mar 17 10:34:12 monitor kernel: RPC:      cong 256, cwnd was 512, now  
> 512
> Mar 17 10:34:12 monitor kernel: RPC: 14038 has input (236 bytes)
> Mar 17 10:34:12 monitor kernel: RPC: 14038 release request f700f074
> Mar 17 10:34:12 monitor kernel: NFS: refresh_inode(8/387307 ct=1  
> info=0x6)
> Mar 17 10:34:12 monitor kernel: NFS: refresh_inode(8/387858 ct=1  
> info=0x6)
> Mar 17 10:34:12 monitor kernel: RPC: 14039 reserved req f700f074 xid  
> 73f386d3
> Mar 17 10:34:12 monitor kernel: RPC: 14039 xprt_transmit(73f386d3)
> Mar 17 10:34:12 monitor kernel: RPC: 14039 xprt_cwnd_limited cong = 0  
> cwnd = 512
> Mar 17 10:34:12 monitor kernel: RPC:      xprt_sendmsg(0) = 124
> Mar 17 10:34:12 monitor kernel: RPC: 14039 xmit complete
> Mar 17 10:34:12 monitor kernel: RPC:      udp_data_ready...
> Mar 17 10:34:12 monitor kernel: RPC:      udp_data_ready client f700f000
> Mar 17 10:34:12 monitor kernel: RPC: 14039 received reply
> Mar 17 10:34:12 monitor kernel: RPC:      cong 256, cwnd was 512, now  
> 512
> Mar 17 10:34:12 monitor kernel: RPC: 14039 has input (236 bytes)
> Mar 17 10:34:12 monitor kernel: RPC: 14039 release request f700f074
> Mar 17 10:34:12 monitor kernel: NFS: refresh_inode(8/387858 ct=1  
> info=0x6)
> Mar 17 10:34:12 monitor kernel: NFS: refresh_inode(8/5589936 ct=1  
> info=0x6)
> Mar 17 10:34:12 monitor kernel: RPC: 14040 reserved req f700f074 xid  
> 73f386d4
> Mar 17 10:34:12 monitor kernel: RPC: 14040 xprt_transmit(73f386d4)
> Mar 17 10:34:12 monitor kernel: RPC: 14040 xprt_cwnd_limited cong = 0  
> cwnd = 512
> Mar 17 10:34:12 monitor kernel: RPC:      xprt_sendmsg(0) = 124
> Mar 17 10:34:12 monitor kernel: RPC: 14040 xmit complete
> Mar 17 10:34:12 monitor kernel: RPC:      udp_data_ready...
> Mar 17 10:34:12 monitor kernel: RPC:      udp_data_ready client f700f000
> Mar 17 10:34:12 monitor kernel: RPC: 14040 received reply
> Mar 17 10:34:12 monitor kernel: RPC:      cong 256, cwnd was 512, now  
> 512
> Mar 17 10:34:12 monitor kernel: RPC: 14040 has input (236 bytes)
> Mar 17 10:34:12 monitor kernel: RPC: 14040 release request f700f074
> Mar 17 10:34:12 monitor kernel: NFS: refresh_inode(8/5589936 ct=1  
> info=0x6)
> Mar 17 10:34:12 monitor kernel: NFS: refresh_inode(8/5738625 ct=1  
> info=0x6)
> Mar 17 10:34:12 monitor kernel: RPC: 14041 reserved req f700f074 xid  
> 73f386d5
> Mar 17 10:34:12 monitor kernel: RPC: 14041 xprt_transmit(73f386d5)
> Mar 17 10:34:12 monitor kernel: RPC: 14041 xprt_cwnd_limited cong = 0  
> cwnd = 512
> Mar 17 10:34:12 monitor kernel: RPC:      xprt_sendmsg(0) = 128
> Mar 17 10:34:12 monitor kernel: RPC: 14041 xmit complete
> Mar 17 10:34:12 monitor kernel: RPC:      udp_data_ready...
> Mar 17 10:34:12 monitor kernel: RPC:      udp_data_ready client f700f000
> Mar 17 10:34:12 monitor kernel: RPC: 14041 received reply
> Mar 17 10:34:12 monitor kernel: RPC:      cong 256, cwnd was 512, now  
> 512
> Mar 17 10:34:12 monitor kernel: RPC: 14041 has input (236 bytes)
> Mar 17 10:34:12 monitor kernel: RPC: 14041 release request f700f074
> Mar 17 10:34:12 monitor kernel: NFS: refresh_inode(8/5871209 ct=1  
> info=0x6)
> Mar 17 10:34:12 monitor kernel: NFS: refresh_inode(8/5873264 ct=1  
> info=0x6)
> Mar 17 10:34:12 monitor kernel: RPC: 14042 reserved req f700f074 xid  
> 73f386d6
> Mar 17 10:34:12 monitor kernel: RPC: 14042 xprt_transmit(73f386d6)
> Mar 17 10:34:12 monitor kernel: RPC: 14042 xprt_cwnd_limited cong = 0  
> cwnd = 512
> Mar 17 10:34:12 monitor kernel: RPC:      xprt_sendmsg(0) = 180
> Mar 17 10:34:12 monitor kernel: RPC: 14042 xmit complete
> Mar 17 10:34:12 monitor kernel: RPC:      udp_data_ready...
> Mar 17 10:34:12 monitor kernel: RPC:      udp_data_ready client f700f000
> Mar 17 10:34:12 monitor kernel: RPC: 14042 received reply
> Mar 17 10:34:12 monitor kernel: RPC:      cong 256, cwnd was 512, now  
> 512
> Mar 17 10:34:12 monitor kernel: RPC: 14042 has input (236 bytes)
> Mar 17 10:34:12 monitor kernel: RPC: 14042 release request f700f074
> Mar 17 10:34:12 monitor kernel: NFS: refresh_inode(8/5873264 ct=1  
> info=0x6)
> Mar 17 10:34:12 monitor kernel: NFS: refresh_inode(8/5873265 ct=1  
> info=0x6)
> Mar 17 10:34:12 monitor kernel: NFS:  
> dentry_delete(RawData/ 
> GD=ETI=BO=MAKER_AF12=C4#CUTTER=3#2004=02=16=20=50=14.mat.gz, 0)
> Mar 17 10:34:13 monitor kernel: NFS: lookup(02/18)
> Mar 17 10:34:13 monitor kernel: RPC: 14043 reserved req f700f074 xid  
> 73f386d7
> Mar 17 10:34:13 monitor kernel: RPC: 14043 xprt_transmit(73f386d7)
> Mar 17 10:34:13 monitor kernel: RPC: 14043 xprt_cwnd_limited cong = 0  
> cwnd = 512
> Mar 17 10:34:13 monitor kernel: RPC:      xprt_sendmsg(0) = 124
> Mar 17 10:34:13 monitor kernel: RPC: 14043 xmit complete
> Mar 17 10:34:13 monitor kernel: RPC:      udp_data_ready...
> Mar 17 10:34:13 monitor kernel: RPC:      udp_data_ready client f700f000
> Mar 17 10:34:13 monitor kernel: RPC: 14043 received reply
> Mar 17 10:34:13 monitor kernel: RPC:      cong 256, cwnd was 512, now  
> 512
> Mar 17 10:34:13 monitor kernel: RPC: 14043 has input (236 bytes)
> Mar 17 10:34:13 monitor kernel: RPC: 14043 release request f700f074
> Mar 17 10:34:13 monitor kernel: NFS: refresh_inode(8/5738625 ct=1  
> info=0x6)
> Mar 17 10:34:13 monitor kernel: NFS: nfs_fhget(02/18 fileid=5879055)
> Mar 17 10:34:13 monitor kernel: NFS: refresh_inode(8/5879055 ct=1  
> info=0x6)
> Mar 17 10:34:13 monitor kernel: NFS: __nfs_fhget(8/5879055 ct=1)
> Mar 17 10:34:13 monitor kernel: NFS: lookup(18/RawData)
> Mar 17 10:34:13 monitor kernel: RPC: 14044 reserved req f700f074 xid  
> 73f386d8
> Mar 17 10:34:13 monitor kernel: RPC: 14044 xprt_transmit(73f386d8)
> Mar 17 10:34:13 monitor kernel: RPC: 14044 xprt_cwnd_limited cong = 0  
> cwnd = 512
> Mar 17 10:34:13 monitor kernel: RPC:      xprt_sendmsg(0) = 128
> Mar 17 10:34:13 monitor kernel: RPC: 14044 xmit complete
> Mar 17 10:34:13 monitor kernel: RPC:      udp_data_ready...
> Mar 17 10:34:13 monitor kernel: RPC:      udp_data_ready client f700f000
> Mar 17 10:34:13 monitor kernel: RPC: 14044 received reply
> Mar 17 10:34:13 monitor kernel: RPC:      cong 256, cwnd was 512, now  
> 512
> Mar 17 10:34:13 monitor kernel: RPC: 14044 has input (236 bytes)
> Mar 17 10:34:13 monitor kernel: RPC: 14044 release request f700f074
> Mar 17 10:34:13 monitor kernel: NFS: refresh_inode(8/5879055 ct=1  
> info=0x6)
> Mar 17 10:34:13 monitor kernel: NFS: nfs_fhget(18/RawData  
> fileid=5882956)
> Mar 17 10:34:13 monitor kernel: NFS: refresh_inode(8/5882956 ct=1  
> info=0x6)
> Mar 17 10:34:13 monitor kernel: NFS: __nfs_fhget(8/5882956 ct=1)
> Mar 17 10:34:13 monitor kernel: NFS:  
> lookup(RawData/ 
> GD=ETI=BO=MAKER_AF12=C4#CUTTER=3#2004=02=18=20=00=55.mat.gz)
> Mar 17 10:34:13 monitor kernel: RPC: 14045 reserved req f700f074 xid  
> 73f386d9
> Mar 17 10:34:13 monitor kernel: RPC: 14045 xprt_transmit(73f386d9)
> Mar 17 10:34:13 monitor kernel: RPC: 14045 xprt_cwnd_limited cong = 0  
> cwnd = 512
> Mar 17 10:34:13 monitor kernel: RPC:      xprt_sendmsg(0) = 180
> Mar 17 10:34:13 monitor kernel: RPC: 14045 xmit complete
> Mar 17 10:34:13 monitor kernel: RPC:      udp_data_ready...
> Mar 17 10:34:13 monitor kernel: RPC:      udp_data_ready client f700f000
> Mar 17 10:34:13 monitor kernel: RPC: 14045 received reply
> Mar 17 10:34:13 monitor kernel: RPC:      cong 256, cwnd was 512, now  
> 512
> Mar 17 10:34:13 monitor kernel: RPC: 14045 has input (236 bytes)
> Mar 17 10:34:13 monitor kernel: RPC: 14045 release request f700f074
> Mar 17 10:34:13 monitor kernel: NFS: refresh_inode(8/5882956 ct=1  
> info=0x6)
> Mar 17 10:34:13 monitor kernel: NFS:  
> nfs_fhget(RawData/ 
> GD=ETI=BO=MAKER_AF12=C4#CUTTER=3#2004=02=18=20=00=55.mat.gz  
> fileid=5882957)
> Mar 17 10:34:13 monitor kernel: NFS: refresh_inode(8/5882957 ct=1  
> info=0x6)
> Mar 17 10:34:13 monitor kernel: NFS: __nfs_fhget(8/5882957 ct=1)
> Mar 17 10:34:13 monitor kernel: NFS:  
> dentry_delete(RawData/ 
> GD=ETI=BO=MAKER_AF12=C4#CUTTER=3#2004=02=18=20=00=55.mat.gz, 0)
> Mar 17 10:34:13 monitor kernel: RPC: 14046 reserved req f700f074 xid  
> 73f386da
> Mar 17 10:34:13 monitor kernel: RPC: 14046 xprt_transmit(73f386da)
> Mar 17 10:34:13 monitor kernel: RPC: 14046 xprt_cwnd_limited cong = 0  
> cwnd = 512
> Mar 17 10:34:13 monitor kernel: RPC:      xprt_sendmsg(0) = 128
> Mar 17 10:34:13 monitor kernel: RPC: 14046 xmit complete
> Mar 17 10:34:13 monitor kernel: RPC:      udp_data_ready...
> Mar 17 10:34:13 monitor kernel: RPC:      udp_data_ready client f700f000
> Mar 17 10:34:13 monitor kernel: RPC: 14046 received reply
> Mar 17 10:34:13 monitor kernel: RPC:      cong 256, cwnd was 512, now  
> 512
> Mar 17 10:34:13 monitor kernel: RPC: 14046 has input (236 bytes)
> Mar 17 10:34:13 monitor kernel: RPC: 14046 release request f700f074
> Mar 17 10:34:13 monitor kernel: NFS: refresh_inode(8/5879055 ct=1  
> info=0x6)
> Mar 17 10:34:13 monitor kernel: NFS: refresh_inode(8/5882956 ct=1  
> info=0x6)
> Mar 17 10:34:13 monitor kernel: RPC: 14047 reserved req f700f074 xid  
> 73f386db
> Mar 17 10:34:13 monitor kernel: RPC: 14047 xprt_transmit(73f386db)
> Mar 17 10:34:13 monitor kernel: RPC: 14047 xprt_cwnd_limited cong = 0  
> cwnd = 512
> Mar 17 10:34:13 monitor kernel: RPC:      xprt_sendmsg(0) = 180
> Mar 17 10:34:13 monitor kernel: RPC: 14047 xmit complete
> Mar 17 10:34:13 monitor kernel: RPC:      udp_data_ready...
> Mar 17 10:34:13 monitor kernel: RPC:      udp_data_ready client f700f000
> Mar 17 10:34:13 monitor kernel: RPC: 14047 received reply
> Mar 17 10:34:13 monitor kernel: RPC:      cong 256, cwnd was 512, now  
> 512
> Mar 17 10:34:13 monitor kernel: RPC: 14047 has input (236 bytes)
> Mar 17 10:34:13 monitor kernel: RPC: 14047 release request f700f074
> Mar 17 10:34:13 monitor kernel: NFS: refresh_inode(8/5882956 ct=1  
> info=0x6)
> Mar 17 10:34:13 monitor kernel: NFS: refresh_inode(8/5882957 ct=1  
> info=0x6)
> Mar 17 10:34:13 monitor kernel: NFS:  
> dentry_delete(RawData/ 
> GD=ETI=BO=MAKER_AF12=C4#CUTTER=3#2004=02=18=20=00=55.mat.gz, 0)
> Mar 17 10:34:13 monitor kernel: NFS: lookup(02/19)
> Mar 17 10:34:13 monitor kernel: RPC: 14048 reserved req f700f074 xid  
> 73f386dc
> Mar 17 10:34:13 monitor kernel: RPC: 14048 xprt_transmit(73f386dc)
> Mar 17 10:34:13 monitor kernel: RPC: 14048 xprt_cwnd_limited cong = 0  
> cwnd = 512
> Mar 17 10:34:13 monitor kernel: RPC:      xprt_sendmsg(0) = 124
> Mar 17 10:34:13 monitor kernel: RPC: 14048 xmit complete
> Mar 17 10:34:13 monitor kernel: RPC:      udp_data_ready...
> Mar 17 10:34:13 monitor kernel: RPC:      udp_data_ready client f700f000
> Mar 17 10:34:13 monitor kernel: RPC: 14048 received reply
> Mar 17 10:34:13 monitor kernel: RPC:      cong 256, cwnd was 512, now  
> 512
> Mar 17 10:34:13 monitor kernel: RPC: 14048 has input (236 bytes)
> Mar 17 10:34:13 monitor kernel: RPC: 14048 release request f700f074
> Mar 17 10:34:13 monitor kernel: NFS: refresh_inode(8/5738625 ct=1  
> info=0x6)
> Mar 17 10:34:13 monitor kernel: NFS: nfs_fhget(02/19 fileid=5883365)
> Mar 17 10:34:13 monitor kernel: NFS: refresh_inode(8/5883365 ct=1  
> info=0x6)
> Mar 17 10:34:13 monitor kernel: NFS: __nfs_fhget(8/5883365 ct=1)
> Mar 17 10:34:13 monitor kernel: NFS: lookup(19/RawData)
> Mar 17 10:34:13 monitor kernel: RPC: 14049 reserved req f700f074 xid  
> 73f386dd
> Mar 17 10:34:13 monitor kernel: RPC: 14049 xprt_transmit(73f386dd)
> Mar 17 10:34:13 monitor kernel: RPC: 14049 xprt_cwnd_limited cong = 0  
> cwnd = 512
> Mar 17 10:34:13 monitor kernel: RPC:      xprt_sendmsg(0) = 128
> Mar 17 10:34:13 monitor kernel: RPC: 14049 xmit complete
> Mar 17 10:34:13 monitor kernel: RPC:      udp_data_ready...
> Mar 17 10:34:13 monitor kernel: RPC:      udp_data_ready client f700f000
> Mar 17 10:34:13 monitor kernel: RPC: 14049 received reply
> Mar 17 10:34:13 monitor kernel: RPC:      cong 256, cwnd was 512, now  
> 512
> Mar 17 10:34:13 monitor kernel: RPC: 14049 has input (236 bytes)
> Mar 17 10:34:13 monitor kernel: RPC: 14049 release request f700f074
> Mar 17 10:34:13 monitor kernel: NFS: refresh_inode(8/5883365 ct=1  
> info=0x6)
> Mar 17 10:34:13 monitor kernel: NFS: nfs_fhget(19/RawData  
> fileid=5888079)
> Mar 17 10:34:13 monitor kernel: NFS: refresh_inode(8/5888079 ct=1  
> info=0x6)
> Mar 17 10:34:13 monitor kernel: NFS: __nfs_fhget(8/5888079 ct=1)
> Mar 17 10:34:13 monitor kernel: NFS:  
> lookup(RawData/ 
> GD=ETI=BO=MAKER_AF12=C4#CUTTER=3#2004=02=19=20=15=21.mat.gz)
> Mar 17 10:34:13 monitor kernel: RPC: 14050 reserved req f700f074 xid  
> 73f386de
> Mar 17 10:34:13 monitor kernel: RPC: 14050 xprt_transmit(73f386de)
> Mar 17 10:34:13 monitor kernel: RPC: 14050 xprt_cwnd_limited cong = 0  
> cwnd = 512
> Mar 17 10:34:13 monitor kernel: RPC:      xprt_sendmsg(0) = 180
> Mar 17 10:34:13 monitor kernel: RPC: 14050 xmit complete
> Mar 17 10:34:13 monitor kernel: RPC:      udp_data_ready...
> Mar 17 10:34:13 monitor kernel: RPC:      udp_data_ready client f700f000
> Mar 17 10:34:13 monitor kernel: RPC: 14050 received reply
> Mar 17 10:34:13 monitor kernel: RPC:      cong 256, cwnd was 512, now  
> 512
> Mar 17 10:34:13 monitor kernel: RPC: 14050 has input (236 bytes)
> Mar 17 10:34:13 monitor kernel: RPC: 14050 release request f700f074
> Mar 17 10:34:13 monitor kernel: NFS: refresh_inode(8/5888079 ct=1  
> info=0x6)
> Mar 17 10:34:13 monitor kernel: NFS:  
> nfs_fhget(RawData/ 
> GD=ETI=BO=MAKER_AF12=C4#CUTTER=3#2004=02=19=20=15=21.mat.gz  
> fileid=5888080)
> Mar 17 10:34:13 monitor kernel: NFS: refresh_inode(8/5888080 ct=1  
> info=0x6)
> Mar 17 10:34:13 monitor kernel: NFS: __nfs_fhget(8/5888080 ct=1)
> Mar 17 10:34:13 monitor kernel: NFS:  
> dentry_delete(RawData/ 
> GD=ETI=BO=MAKER_AF12=C4#CUTTER=3#2004=02=19=20=15=21.mat.gz, 0)
> Mar 17 10:34:13 monitor kernel: RPC: 14051 reserved req f700f074 xid  
> 73f386df
> Mar 17 10:34:13 monitor kernel: RPC: 14051 xprt_transmit(73f386df)
> Mar 17 10:34:13 monitor kernel: RPC: 14051 xprt_cwnd_limited cong = 0  
> cwnd = 512
> Mar 17 10:34:13 monitor kernel: RPC:      xprt_sendmsg(0) = 180
> Mar 17 10:34:13 monitor kernel: RPC: 14051 xmit complete
> Mar 17 10:34:13 monitor kernel: RPC:      udp_data_ready...
> Mar 17 10:34:13 monitor kernel: RPC:      udp_data_ready client f700f000
> Mar 17 10:34:13 monitor kernel: RPC: 14051 received reply
> Mar 17 10:34:13 monitor kernel: RPC:      cong 256, cwnd was 512, now  
> 512
> Mar 17 10:34:13 monitor kernel: RPC: 14051 has input (236 bytes)
> Mar 17 10:34:13 monitor kernel: RPC: 14051 release request f700f074
> Mar 17 10:34:13 monitor kernel: NFS: refresh_inode(8/5888079 ct=1  
> info=0x6)
> Mar 17 10:34:13 monitor kernel: NFS: refresh_inode(8/5888080 ct=1  
> info=0x6)
> Mar 17 10:34:13 monitor kernel: NFS:  
> dentry_delete(RawData/ 
> GD=ETI=BO=MAKER_AF12=C4#CUTTER=3#2004=02=19=20=15=21.mat.gz, 0)
> Mar 17 10:34:13 monitor kernel: NFS:  
> lookup(RawData/ 
> GD=ETI=BO=MAKER_AF12=C4#CUTTER=3#2004=02=19=12=32=10.mat.gz)
> Mar 17 10:34:13 monitor kernel: RPC: 14052 reserved req f700f074 xid  
> 73f386e0
> Mar 17 10:34:13 monitor kernel: RPC: 14052 xprt_transmit(73f386e0)
> Mar 17 10:34:13 monitor kernel: RPC: 14052 xprt_cwnd_limited cong = 0  
> cwnd = 512
> Mar 17 10:34:13 monitor kernel: RPC:      xprt_sendmsg(0) = 180
> Mar 17 10:34:13 monitor kernel: RPC: 14052 xmit complete
> Mar 17 10:34:13 monitor kernel: RPC:      udp_data_ready...
> Mar 17 10:34:13 monitor kernel: RPC:      udp_data_ready client f700f000
> Mar 17 10:34:13 monitor kernel: RPC: 14052 received reply
> Mar 17 10:34:13 monitor kernel: RPC:      cong 256, cwnd was 512, now  
> 512
> Mar 17 10:34:13 monitor kernel: RPC: 14052 has input (236 bytes)
> Mar 17 10:34:13 monitor kernel: RPC: 14052 release request f700f074
> Mar 17 10:34:13 monitor kernel: NFS: refresh_inode(8/5888079 ct=1  
> info=0x6)
> Mar 17 10:34:13 monitor kernel: NFS:  
> nfs_fhget(RawData/ 
> GD=ETI=BO=MAKER_AF12=C4#CUTTER=3#2004=02=19=12=32=10.mat.gz  
> fileid=5888085)
> Mar 17 10:34:13 monitor kernel: NFS: refresh_inode(8/5888085 ct=1  
> info=0x6)
> Mar 17 10:34:13 monitor kernel: NFS: __nfs_fhget(8/5888085 ct=1)
> Mar 17 10:34:13 monitor kernel: NFS:  
> dentry_delete(RawData/ 
> GD=ETI=BO=MAKER_AF12=C4#CUTTER=3#2004=02=19=12=32=10.mat.gz, 0)
> Mar 17 10:34:13 monitor kernel: NFS: revalidating (8/5888085)
> Mar 17 10:34:13 monitor kernel: RPC: 14053 reserved req f700f074 xid  
> 73f386e1
> Mar 17 10:34:13 monitor kernel: RPC: 14053 xprt_transmit(73f386e1)
> Mar 17 10:34:13 monitor kernel: RPC: 14053 xprt_cwnd_limited cong = 0  
> cwnd = 512
> Mar 17 10:34:13 monitor kernel: RPC:      xprt_sendmsg(0) = 116
> Mar 17 10:34:13 monitor kernel: RPC: 14053 xmit complete
> Mar 17 10:34:13 monitor kernel: RPC:      udp_data_ready...
> Mar 17 10:34:13 monitor kernel: RPC:      udp_data_ready client f700f000
> Mar 17 10:34:13 monitor kernel: RPC: 14053 received reply
> Mar 17 10:34:13 monitor kernel: RPC:      cong 256, cwnd was 512, now  
> 512
> Mar 17 10:34:13 monitor kernel: RPC: 14053 has input (112 bytes)
> Mar 17 10:34:13 monitor kernel: RPC: 14053 release request f700f074
> Mar 17 10:34:13 monitor kernel: NFS: refresh_inode(8/5888085 ct=1  
> info=0x6)
> Mar 17 10:34:13 monitor kernel: NFS: (8/5888085) revalidation complete
> Mar 17 10:34:13 monitor kernel: NFS:  
> dentry_delete(RawData/ 
> GD=ETI=BO=MAKER_AF12=C4#CUTTER=3#2004=02=19=12=32=10.mat.gz, 0)
> Mar 17 10:34:13 monitor kernel: NFS: lookup(02/20)
> Mar 17 10:34:13 monitor kernel: RPC: 14054 reserved req f700f074 xid  
> 73f386e2
> Mar 17 10:34:13 monitor kernel: RPC: 14054 xprt_transmit(73f386e2)
> Mar 17 10:34:13 monitor kernel: RPC: 14054 xprt_cwnd_limited cong = 0  
> cwnd = 512
> Mar 17 10:34:13 monitor kernel: RPC:      xprt_sendmsg(0) = 124
> Mar 17 10:34:13 monitor kernel: RPC: 14054 xmit complete
> Mar 17 10:34:13 monitor kernel: RPC:      udp_data_ready...
> Mar 17 10:34:13 monitor kernel: RPC:      udp_data_ready client f700f000
> Mar 17 10:34:13 monitor kernel: RPC: 14054 received reply
> Mar 17 10:34:13 monitor kernel: RPC:      cong 256, cwnd was 512, now  
> 512
> Mar 17 10:34:13 monitor kernel: RPC: 14054 has input (236 bytes)
> Mar 17 10:34:13 monitor kernel: RPC: 14054 release request f700f074
> Mar 17 10:34:13 monitor kernel: NFS: refresh_inode(8/5738625 ct=1  
> info=0x6)
> Mar 17 10:34:13 monitor kernel: NFS: nfs_fhget(02/20 fileid=5888576)
> Mar 17 10:34:13 monitor kernel: NFS: refresh_inode(8/5888576 ct=1  
> info=0x6)
> Mar 17 10:34:13 monitor kernel: NFS: __nfs_fhget(8/5888576 ct=1)
> Mar 17 10:34:13 monitor kernel: NFS: lookup(20/RawData)
> Mar 17 10:34:13 monitor kernel: RPC: 14055 reserved req f700f074 xid  
> 73f386e3
> Mar 17 10:34:13 monitor kernel: RPC: 14055 xprt_transmit(73f386e3)
> Mar 17 10:34:13 monitor kernel: RPC: 14055 xprt_cwnd_limited cong = 0  
> cwnd = 512
> Mar 17 10:34:13 monitor kernel: RPC:      xprt_sendmsg(0) = 128
> Mar 17 10:34:13 monitor kernel: RPC: 14055 xmit complete
> Mar 17 10:34:13 monitor kernel: RPC:      udp_data_ready...
> Mar 17 10:34:13 monitor kernel: RPC:      udp_data_ready client f700f000
> Mar 17 10:34:13 monitor kernel: RPC: 14055 received reply
> Mar 17 10:34:13 monitor kernel: RPC:      cong 256, cwnd was 512, now  
> 512
> Mar 17 10:34:13 monitor kernel: RPC: 14055 has input (236 bytes)
> Mar 17 10:34:13 monitor kernel: RPC: 14055 release request f700f074
> Mar 17 10:34:13 monitor kernel: NFS: refresh_inode(8/5888576 ct=1  
> info=0x6)
> Mar 17 10:34:13 monitor kernel: NFS: nfs_fhget(20/RawData  
> fileid=5893483)
> Mar 17 10:34:13 monitor kernel: NFS: refresh_inode(8/5893483 ct=1  
> info=0x6)
> Mar 17 10:34:13 monitor kernel: NFS: __nfs_fhget(8/5893483 ct=1)
> Mar 17 10:34:13 monitor kernel: NFS:  
> lookup(RawData/ 
> GD=ETI=BO=MAKER_AF12=C4#CUTTER=3#2004=02=20=11=30=42.mat.gz)
> Mar 17 10:34:13 monitor kernel: RPC: 14056 reserved req f700f074 xid  
> 73f386e4
> Mar 17 10:34:13 monitor kernel: RPC: 14056 xprt_transmit(73f386e4)
> Mar 17 10:34:13 monitor kernel: RPC: 14056 xprt_cwnd_limited cong = 0  
> cwnd = 512
> Mar 17 10:34:13 monitor kernel: RPC:      xprt_sendmsg(0) = 180
> Mar 17 10:34:13 monitor kernel: RPC: 14056 xmit complete
> Mar 17 10:34:13 monitor kernel: RPC:      udp_data_ready...
> Mar 17 10:34:13 monitor kernel: RPC:      udp_data_ready client f700f000
> Mar 17 10:34:13 monitor kernel: RPC: 14056 received reply
> Mar 17 10:34:13 monitor kernel: RPC:      cong 256, cwnd was 512, now  
> 512
> Mar 17 10:34:13 monitor kernel: RPC: 14056 has input (236 bytes)
> Mar 17 10:34:13 monitor kernel: RPC: 14056 release request f700f074
> Mar 17 10:34:13 monitor kernel: NFS: refresh_inode(8/5893483 ct=1  
> info=0x6)
> Mar 17 10:34:13 monitor kernel: NFS:  
> nfs_fhget(RawData/ 
> GD=ETI=BO=MAKER_AF12=C4#CUTTER=3#2004=02=20=11=30=42.mat.gz  
> fileid=5893484)
> Mar 17 10:34:13 monitor kernel: NFS: refresh_inode(8/5893484 ct=1  
> info=0x6)
> Mar 17 10:34:13 monitor kernel: NFS: __nfs_fhget(8/5893484 ct=1)
> Mar 17 10:34:13 monitor kernel: NFS:  
> dentry_delete(RawData/ 
> GD=ETI=BO=MAKER_AF12=C4#CUTTER=3#2004=02=20=11=30=42.mat.gz, 0)
> Mar 17 10:34:13 monitor kernel: RPC: 14057 reserved req f700f074 xid  
> 73f386e5
> Mar 17 10:34:13 monitor kernel: RPC: 14057 xprt_transmit(73f386e5)
> Mar 17 10:34:13 monitor kernel: RPC: 14057 xprt_cwnd_limited cong = 0  
> cwnd = 512
> Mar 17 10:34:13 monitor kernel: RPC:      xprt_sendmsg(0) = 128
> Mar 17 10:34:13 monitor kernel: RPC: 14057 xmit complete
> Mar 17 10:34:13 monitor kernel: RPC:      udp_data_ready...
> Mar 17 10:34:13 monitor kernel: RPC:      udp_data_ready client f700f000
> Mar 17 10:34:13 monitor kernel: RPC: 14057 received reply
> Mar 17 10:34:13 monitor kernel: RPC:      cong 256, cwnd was 512, now  
> 512
> Mar 17 10:34:13 monitor kernel: RPC: 14057 has input (236 bytes)
> Mar 17 10:34:13 monitor kernel: RPC: 14057 release request f700f074
> Mar 17 10:34:13 monitor kernel: NFS: refresh_inode(8/5888576 ct=1  
> info=0x6)
> Mar 17 10:34:13 monitor kernel: NFS: refresh_inode(8/5893483 ct=1  
> info=0x6)
> Mar 17 10:34:13 monitor kernel: NFS: revalidating (8/5893484)
> Mar 17 10:34:13 monitor kernel: RPC: 14058 reserved req f700f074 xid  
> 73f386e6
> Mar 17 10:34:13 monitor kernel: RPC: 14058 xprt_transmit(73f386e6)
> Mar 17 10:34:13 monitor kernel: RPC: 14058 xprt_cwnd_limited cong = 0  
> cwnd = 512
> Mar 17 10:34:13 monitor kernel: RPC:      xprt_sendmsg(0) = 116
> Mar 17 10:34:13 monitor kernel: RPC: 14058 xmit complete
> Mar 17 10:34:13 monitor kernel: RPC:      udp_data_ready...
> Mar 17 10:34:13 monitor kernel: RPC:      udp_data_ready client f700f000
> Mar 17 10:34:13 monitor kernel: RPC: 14058 received reply
> Mar 17 10:34:13 monitor kernel: RPC:      cong 256, cwnd was 512, now  
> 512
> Mar 17 10:34:13 monitor kernel: RPC: 14058 has input (112 bytes)
> Mar 17 10:34:13 monitor kernel: RPC: 14058 release request f700f074
> Mar 17 10:34:13 monitor kernel: NFS: refresh_inode(8/5893484 ct=1  
> info=0x6)
> Mar 17 10:34:13 monitor kernel: NFS: (8/5893484) revalidation complete
> Mar 17 10:34:13 monitor kernel: NFS:  
> dentry_delete(RawData/ 
> GD=ETI=BO=MAKER_AF12=C4#CUTTER=3#2004=02=20=11=30=42.mat.gz, 0)
> Mar 17 10:34:13 monitor kernel: NFS:  
> lookup(RawData/ 
> GD=ETI=BO=MAKER_AF12=C4#CUTTER=3#2004=02=20=13=10=48.mat.gz)
> Mar 17 10:34:13 monitor kernel: RPC: 14059 reserved req f700f074 xid  
> 73f386e7
> Mar 17 10:34:13 monitor kernel: RPC: 14059 xprt_transmit(73f386e7)
> Mar 17 10:34:13 monitor kernel: RPC: 14059 xprt_cwnd_limited cong = 0  
> cwnd = 512
> Mar 17 10:34:13 monitor kernel: RPC:      xprt_sendmsg(0) = 180
> Mar 17 10:34:13 monitor kernel: RPC: 14059 xmit complete
> Mar 17 10:34:13 monitor kernel: RPC:      udp_data_ready...
> Mar 17 10:34:13 monitor kernel: RPC:      udp_data_ready client f700f000
> Mar 17 10:34:13 monitor kernel: RPC: 14059 received reply
> Mar 17 10:34:13 monitor kernel: RPC:      cong 256, cwnd was 512, now  
> 512
> Mar 17 10:34:13 monitor kernel: RPC: 14059 has input (236 bytes)
> Mar 17 10:34:13 monitor kernel: RPC: 14059 release request f700f074
> Mar 17 10:34:13 monitor kernel: NFS: refresh_inode(8/5893483 ct=1  
> info=0x6)
> Mar 17 10:34:13 monitor kernel: NFS:  
> nfs_fhget(RawData/ 
> GD=ETI=BO=MAKER_AF12=C4#CUTTER=3#2004=02=20=13=10=48.mat.gz  
> fileid=5893515)
> Mar 17 10:34:13 monitor kernel: NFS: refresh_inode(8/5893515 ct=1  
> info=0x6)
> Mar 17 10:34:13 monitor kernel: NFS: __nfs_fhget(8/5893515 ct=1)
> Mar 17 10:34:13 monitor kernel: NFS:  
> dentry_delete(RawData/ 
> GD=ETI=BO=MAKER_AF12=C4#CUTTER=3#2004=02=20=13=10=48.mat.gz, 0)
> Mar 17 10:34:13 monitor kernel: NFS: revalidating (8/5893515)
> Mar 17 10:34:13 monitor kernel: RPC: 14060 reserved req f700f074 xid  
> 73f386e8
> Mar 17 10:34:13 monitor kernel: RPC: 14060 xprt_transmit(73f386e8)
> Mar 17 10:34:13 monitor kernel: RPC: 14060 xprt_cwnd_limited cong = 0  
> cwnd = 512
> Mar 17 10:34:13 monitor kernel: RPC:      xprt_sendmsg(0) = 116
> Mar 17 10:34:13 monitor kernel: RPC: 14060 xmit complete
> Mar 17 10:34:13 monitor kernel: RPC:      udp_data_ready...
> Mar 17 10:34:13 monitor kernel: RPC:      udp_data_ready client f700f000
> Mar 17 10:34:13 monitor kernel: RPC: 14060 received reply
> Mar 17 10:34:13 monitor kernel: RPC:      cong 256, cwnd was 512, now  
> 512
> Mar 17 10:34:13 monitor kernel: RPC: 14060 has input (112 bytes)
> Mar 17 10:34:13 monitor kernel: RPC: 14060 release request f700f074
> Mar 17 10:34:13 monitor kernel: NFS: refresh_inode(8/5893515 ct=1  
> info=0x6)
> Mar 17 10:34:13 monitor kernel: NFS: (8/5893515) revalidation complete
> Mar 17 10:34:13 monitor kernel: NFS:  
> dentry_delete(RawData/ 
> GD=ETI=BO=MAKER_AF12=C4#CUTTER=3#2004=02=20=13=10=48.mat.gz, 0)
> Mar 17 10:34:13 monitor kernel: NFS: lookup(02/23)
> Mar 17 10:34:13 monitor kernel: RPC: 14061 reserved req f700f074 xid  
> 73f386e9
> Mar 17 10:34:13 monitor kernel: RPC: 14061 xprt_transmit(73f386e9)
> Mar 17 10:34:13 monitor kernel: RPC: 14061 xprt_cwnd_limited cong = 0  
> cwnd = 512
> Mar 17 10:34:13 monitor kernel: RPC:      xprt_sendmsg(0) = 124
> Mar 17 10:34:13 monitor kernel: RPC: 14061 xmit complete
> Mar 17 10:34:13 monitor kernel: RPC:      udp_data_ready...
> Mar 17 10:34:13 monitor kernel: RPC:      udp_data_ready client f700f000
> Mar 17 10:34:13 monitor kernel: RPC: 14061 received reply
> Mar 17 10:34:13 monitor kernel: RPC:      cong 256, cwnd was 512, now  
> 512
> Mar 17 10:34:13 monitor kernel: RPC: 14061 has input (236 bytes)
> Mar 17 10:34:13 monitor kernel: RPC: 14061 release request f700f074
> Mar 17 10:34:13 monitor kernel: NFS: refresh_inode(8/5738625 ct=1  
> info=0x6)
> Mar 17 10:34:13 monitor kernel: NFS: nfs_fhget(02/23 fileid=5900240)
> Mar 17 10:34:13 monitor kernel: NFS: refresh_inode(8/5900240 ct=1  
> info=0x6)
> Mar 17 10:34:13 monitor kernel: NFS: __nfs_fhget(8/5900240 ct=1)
> Mar 17 10:34:13 monitor kernel: NFS: lookup(23/RawData)
> Mar 17 10:34:13 monitor kernel: RPC: 14062 reserved req f700f074 xid  
> 73f386ea
> Mar 17 10:34:13 monitor kernel: RPC: 14062 xprt_transmit(73f386ea)
> Mar 17 10:34:13 monitor kernel: RPC: 14062 xprt_cwnd_limited cong = 0  
> cwnd = 512
> Mar 17 10:34:13 monitor kernel: RPC:      xprt_sendmsg(0) = 128
> Mar 17 10:34:13 monitor kernel: RPC: 14062 xmit complete
> Mar 17 10:34:13 monitor kernel: RPC:      udp_data_ready...
> Mar 17 10:34:13 monitor kernel: RPC:      udp_data_ready client f700f000
> Mar 17 10:34:13 monitor kernel: RPC: 14062 received reply
> Mar 17 10:34:13 monitor kernel: RPC:      cong 256, cwnd was 512, now  
> 512
> Mar 17 10:34:13 monitor kernel: RPC: 14062 has input (236 bytes)
> Mar 17 10:34:13 monitor kernel: RPC: 14062 release request f700f074
> Mar 17 10:34:13 monitor kernel: NFS: refresh_inode(8/5900240 ct=1  
> info=0x6)
> Mar 17 10:34:13 monitor kernel: NFS: nfs_fhget(23/RawData  
> fileid=5907368)
> Mar 17 10:34:13 monitor kernel: NFS: refresh_inode(8/5907368 ct=1  
> info=0x6)
> Mar 17 10:34:13 monitor kernel: NFS: __nfs_fhget(8/5907368 ct=1)
> Mar 17 10:34:13 monitor kernel: NFS:  
> lookup(RawData/ 
> GD=ETI=BO=MAKER_AF12=C4#CUTTER=3#2004=02=23=10=50=52.mat.gz)
> Mar 17 10:34:13 monitor kernel: RPC: 14063 reserved req f700f074 xid  
> 73f386eb
> Mar 17 10:34:13 monitor kernel: RPC: 14063 xprt_transmit(73f386eb)
> Mar 17 10:34:13 monitor kernel: RPC: 14063 xprt_cwnd_limited cong = 0  
> cwnd = 512
> Mar 17 10:34:13 monitor kernel: RPC:      xprt_sendmsg(0) = 180
> Mar 17 10:34:13 monitor kernel: RPC: 14063 xmit complete
> Mar 17 10:34:13 monitor kernel: RPC:      udp_data_ready...
> Mar 17 10:34:13 monitor kernel: RPC:      udp_data_ready client f700f000
> Mar 17 10:34:13 monitor kernel: RPC: 14063 received reply
> Mar 17 10:34:13 monitor kernel: RPC:      cong 256, cwnd was 512, now  
> 512
> Mar 17 10:34:13 monitor kernel: RPC: 14063 has input (236 bytes)
> Mar 17 10:34:13 monitor kernel: RPC: 14063 release request f700f074
> Mar 17 10:34:13 monitor kernel: NFS: refresh_inode(8/5907368 ct=1  
> info=0x6)
> Mar 17 10:34:13 monitor kernel: NFS:  
> nfs_fhget(RawData/ 
> GD=ETI=BO=MAKER_AF12=C4#CUTTER=3#2004=02=23=10=50=52.mat.gz  
> fileid=5907369)
> Mar 17 10:34:13 monitor kernel: NFS: refresh_inode(8/5907369 ct=1  
> info=0x6)
> Mar 17 10:34:13 monitor kernel: NFS: __nfs_fhget(8/5907369 ct=1)
> Mar 17 10:34:13 monitor kernel: NFS:  
> dentry_delete(RawData/ 
> GD=ETI=BO=MAKER_AF12=C4#CUTTER=3#2004=02=23=10=50=52.mat.gz, 0)
> Mar 17 10:34:13 monitor kernel: RPC: 14064 reserved req f700f074 xid  
> 73f386ec
> Mar 17 10:34:13 monitor kernel: RPC: 14064 xprt_transmit(73f386ec)
> Mar 17 10:34:13 monitor kernel: RPC: 14064 xprt_cwnd_limited cong = 0  
> cwnd = 512
> Mar 17 10:34:13 monitor kernel: RPC:      xprt_sendmsg(0) = 128
> Mar 17 10:34:13 monitor kernel: RPC: 14064 xmit complete
> Mar 17 10:34:13 monitor kernel: RPC:      udp_data_ready...
> Mar 17 10:34:13 monitor kernel: RPC:      udp_data_ready client f700f000
> Mar 17 10:34:13 monitor kernel: RPC: 14064 received reply
> Mar 17 10:34:13 monitor kernel: RPC:      cong 256, cwnd was 512, now  
> 512
> Mar 17 10:34:13 monitor kernel: RPC: 14064 has input (236 bytes)
> Mar 17 10:34:13 monitor kernel: RPC: 14064 release request f700f074
> Mar 17 10:34:13 monitor kernel: NFS: refresh_inode(8/5900240 ct=1  
> info=0x6)
> Mar 17 10:34:13 monitor kernel: NFS: refresh_inode(8/5907368 ct=1  
> info=0x6)
> Mar 17 10:34:13 monitor kernel: RPC: 14065 reserved req f700f074 xid  
> 73f386ed
> Mar 17 10:34:13 monitor kernel: RPC: 14065 xprt_transmit(73f386ed)
> Mar 17 10:34:13 monitor kernel: RPC: 14065 xprt_cwnd_limited cong = 0  
> cwnd = 512
> Mar 17 10:34:13 monitor kernel: RPC:      xprt_sendmsg(0) = 180
> Mar 17 10:34:13 monitor kernel: RPC: 14065 xmit complete
> Mar 17 10:34:13 monitor kernel: RPC:      udp_data_ready...
> Mar 17 10:34:13 monitor kernel: RPC:      udp_data_ready client f700f000
> Mar 17 10:34:13 monitor kernel: RPC: 14065 received reply
> Mar 17 10:34:13 monitor kernel: RPC:      cong 256, cwnd was 512, now  
> 512
> Mar 17 10:34:13 monitor kernel: RPC: 14065 has input (236 bytes)
> Mar 17 10:34:13 monitor kernel: RPC: 14065 release request f700f074
> Mar 17 10:34:13 monitor kernel: NFS: refresh_inode(8/5907368 ct=1  
> info=0x6)
> Mar 17 10:34:13 monitor kernel: NFS: refresh_inode(8/5907369 ct=1  
> info=0x6)
> Mar 17 10:34:13 monitor kernel: NFS:  
> dentry_delete(RawData/ 
> GD=ETI=BO=MAKER_AF12=C4#CUTTER=3#2004=02=23=10=50=52.mat.gz, 0)
> Mar 17 10:34:13 monitor kernel: RPC: 14066 reserved req f700f074 xid  
> 73f386ee
> Mar 17 10:34:13 monitor kernel: RPC: 14066 xprt_transmit(73f386ee)
> Mar 17 10:34:13 monitor kernel: RPC: 14066 xprt_cwnd_limited cong = 0  
> cwnd = 512
> Mar 17 10:34:13 monitor kernel: RPC:      xprt_sendmsg(0) = 128
> Mar 17 10:34:13 monitor kernel: RPC: 14066 xmit complete
> Mar 17 10:34:13 monitor kernel: RPC:      udp_data_ready...
> Mar 17 10:34:13 monitor kernel: RPC:      udp_data_ready client f700f000
> Mar 17 10:34:13 monitor kernel: RPC: 14066 received reply
> Mar 17 10:34:13 monitor kernel: RPC:      cong 256, cwnd was 512, now  
> 512
> Mar 17 10:34:13 monitor kernel: RPC: 14066 has input (236 bytes)
> Mar 17 10:34:13 monitor kernel: RPC: 14066 release request f700f074
> Mar 17 10:34:13 monitor kernel: NFS: refresh_inode(8/5900240 ct=1  
> info=0x6)
> Mar 17 10:34:13 monitor kernel: NFS: refresh_inode(8/5907368 ct=1  
> info=0x6)
> Mar 17 10:34:13 monitor kernel: NFS:  
> lookup(RawData/ 
> GD=ETI=BO=MAKER_AF12=C4#CUTTER=3#2004=02=23=19=51=12.mat.gz)
> Mar 17 10:34:13 monitor kernel: RPC: 14067 reserved req f700f074 xid  
> 73f386ef
> Mar 17 10:34:13 monitor kernel: RPC: 14067 xprt_transmit(73f386ef)
> Mar 17 10:34:13 monitor kernel: RPC: 14067 xprt_cwnd_limited cong = 0  
> cwnd = 512
> Mar 17 10:34:13 monitor kernel: RPC:      xprt_sendmsg(0) = 180
> Mar 17 10:34:13 monitor kernel: RPC: 14067 xmit complete
> Mar 17 10:34:13 monitor kernel: RPC:      udp_data_ready...
> Mar 17 10:34:13 monitor kernel: RPC:      udp_data_ready client f700f000
> Mar 17 10:34:13 monitor kernel: RPC: 14067 received reply
> Mar 17 10:34:13 monitor kernel: RPC:      cong 256, cwnd was 512, now  
> 512
> Mar 17 10:34:13 monitor kernel: RPC: 14067 has input (236 bytes)
> Mar 17 10:34:13 monitor kernel: RPC: 14067 release request f700f074
> Mar 17 10:34:13 monitor kernel: NFS: refresh_inode(8/5907368 ct=1  
> info=0x6)
> Mar 17 10:34:13 monitor kernel: NFS:  
> nfs_fhget(RawData/ 
> GD=ETI=BO=MAKER_AF12=C4#CUTTER=3#2004=02=23=19=51=12.mat.gz  
> fileid=5907374)
> Mar 17 10:34:13 monitor kernel: NFS: refresh_inode(8/5907374 ct=1  
> info=0x6)
> Mar 17 10:34:13 monitor kernel: NFS: __nfs_fhget(8/5907374 ct=1)
> Mar 17 10:34:13 monitor kernel: NFS:  
> dentry_delete(RawData/ 
> GD=ETI=BO=MAKER_AF12=C4#CUTTER=3#2004=02=23=19=51=12.mat.gz, 0)
> Mar 17 10:34:13 monitor kernel: NFS: revalidating (8/5907374)
> Mar 17 10:34:13 monitor kernel: RPC: 14068 reserved req f700f074 xid  
> 73f386f0
> Mar 17 10:34:13 monitor kernel: RPC: 14068 xprt_transmit(73f386f0)
> Mar 17 10:34:13 monitor kernel: RPC: 14068 xprt_cwnd_limited cong = 0  
> cwnd = 512
> Mar 17 10:34:13 monitor kernel: RPC:      xprt_sendmsg(0) = 116
> Mar 17 10:34:13 monitor kernel: RPC: 14068 xmit complete
> Mar 17 10:34:13 monitor kernel: RPC:      udp_data_ready...
> Mar 17 10:34:13 monitor kernel: RPC:      udp_data_ready client f700f000
> Mar 17 10:34:13 monitor kernel: RPC: 14068 received reply
> Mar 17 10:34:13 monitor kernel: RPC:      cong 256, cwnd was 512, now  
> 512
> Mar 17 10:34:13 monitor kernel: RPC: 14068 has input (112 bytes)
> Mar 17 10:34:13 monitor kernel: RPC: 14068 release request f700f074
> Mar 17 10:34:13 monitor kernel: NFS: refresh_inode(8/5907374 ct=1  
> info=0x6)
> Mar 17 10:34:13 monitor kernel: NFS: (8/5907374) revalidation complete
> Mar 17 10:34:13 monitor kernel: NFS:  
> dentry_delete(RawData/ 
> GD=ETI=BO=MAKER_AF12=C4#CUTTER=3#2004=02=23=19=51=12.mat.gz, 0)
> Mar 17 10:34:20 monitor kernel: NFS: revalidating (8/5873265)
> Mar 17 10:34:20 monitor kernel: RPC: 14069 reserved req f700f074 xid  
> 73f386f1
> Mar 17 10:34:20 monitor kernel: RPC: 14069 xprt_transmit(73f386f1)
> Mar 17 10:34:20 monitor kernel: RPC: 14069 xprt_cwnd_limited cong = 0  
> cwnd = 512
> Mar 17 10:34:20 monitor kernel: RPC:      xprt_sendmsg(0) = 116
> Mar 17 10:34:20 monitor kernel: RPC: 14069 xmit complete
> Mar 17 10:34:20 monitor kernel: RPC:      udp_data_ready...
> Mar 17 10:34:20 monitor kernel: RPC:      udp_data_ready client f700f000
> Mar 17 10:34:20 monitor kernel: RPC: 14069 received reply
> Mar 17 10:34:20 monitor kernel: RPC:      cong 256, cwnd was 512, now  
> 512
> Mar 17 10:34:20 monitor kernel: RPC: 14069 has input (112 bytes)
> Mar 17 10:34:20 monitor kernel: RPC: 14069 release request f700f074
> Mar 17 10:34:20 monitor kernel: NFS: refresh_inode(8/5873265 ct=1  
> info=0x6)
> Mar 17 10:34:20 monitor kernel: NFS: (8/5873265) revalidation complete
> Mar 17 10:34:20 monitor kernel: NFS:  
> dentry_delete(RawData/ 
> GD=ETI=BO=MAKER_AF12=C4#CUTTER=3#2004=02=16=20=50=14.mat.gz, 0)
> Mar 17 10:34:20 monitor kernel: NFS: revalidating (8/5873265)
> Mar 17 10:34:20 monitor kernel: RPC: 14070 reserved req f700f074 xid  
> 73f386f2
> Mar 17 10:34:20 monitor kernel: RPC: 14070 xprt_transmit(73f386f2)
> Mar 17 10:34:20 monitor kernel: RPC: 14070 xprt_cwnd_limited cong = 0  
> cwnd = 512
> Mar 17 10:34:20 monitor kernel: RPC:      xprt_sendmsg(0) = 116
> Mar 17 10:34:20 monitor kernel: RPC: 14070 xmit complete
> Mar 17 10:34:20 monitor kernel: RPC:      udp_data_ready...
> Mar 17 10:34:20 monitor kernel: RPC:      udp_data_ready client f700f000
> Mar 17 10:34:20 monitor kernel: RPC: 14070 received reply
> Mar 17 10:34:20 monitor kernel: RPC:      cong 256, cwnd was 512, now  
> 512
> Mar 17 10:34:20 monitor kernel: RPC: 14070 has input (112 bytes)
> Mar 17 10:34:20 monitor kernel: RPC: 14070 release request f700f074
> Mar 17 10:34:20 monitor kernel: NFS: refresh_inode(8/5873265 ct=1  
> info=0x6)
> Mar 17 10:34:20 monitor kernel: NFS: (8/5873265) revalidation complete
> Mar 17 10:34:20 monitor kernel: NFS:  
> dentry_delete(RawData/ 
> GD=ETI=BO=MAKER_AF12=C4#CUTTER=3#2004=02=16=20=50=14.mat.gz, 0)
> Mar 17 10:34:20 monitor kernel: NFS: revalidating (8/5873265)
> Mar 17 10:34:20 monitor kernel: RPC: 14071 reserved req f700f074 xid  
> 73f386f3
> Mar 17 10:34:20 monitor kernel: RPC: 14071 xprt_transmit(73f386f3)
> Mar 17 10:34:20 monitor kernel: RPC: 14071 xprt_cwnd_limited cong = 0  
> cwnd = 512
> Mar 17 10:34:20 monitor kernel: RPC:      xprt_sendmsg(0) = 116
> Mar 17 10:34:20 monitor kernel: RPC: 14071 xmit complete
> Mar 17 10:34:20 monitor kernel: RPC:      udp_data_ready...
> Mar 17 10:34:20 monitor kernel: RPC:      udp_data_ready client f700f000
> Mar 17 10:34:20 monitor kernel: RPC: 14071 received reply
> Mar 17 10:34:20 monitor kernel: RPC:      cong 256, cwnd was 512, now  
> 512
> Mar 17 10:34:20 monitor kernel: RPC: 14071 has input (112 bytes)
> Mar 17 10:34:20 monitor kernel: RPC: 14071 release request f700f074
> Mar 17 10:34:20 monitor kernel: NFS: refresh_inode(8/5873265 ct=1  
> info=0x6)
> Mar 17 10:34:20 monitor kernel: NFS: (8/5873265) revalidation complete
> Mar 17 10:34:20 monitor kernel: NFS: revalidating (8/5873265)
> Mar 17 10:34:20 monitor kernel: RPC: 14072 reserved req f700f074 xid  
> 73f386f4
> Mar 17 10:34:20 monitor kernel: RPC: 14072 xprt_transmit(73f386f4)
> Mar 17 10:34:20 monitor kernel: RPC: 14072 xprt_cwnd_limited cong = 0  
> cwnd = 512
> Mar 17 10:34:20 monitor kernel: RPC:      xprt_sendmsg(0) = 116
> Mar 17 10:34:20 monitor kernel: RPC: 14072 xmit complete
> Mar 17 10:34:20 monitor kernel: RPC:      udp_data_ready...
> Mar 17 10:34:20 monitor kernel: RPC:      udp_data_ready client f700f000
> Mar 17 10:34:20 monitor kernel: RPC: 14072 received reply
> Mar 17 10:34:20 monitor kernel: RPC:      cong 256, cwnd was 512, now  
> 512
> Mar 17 10:34:20 monitor kernel: RPC: 14072 has input (112 bytes)
> Mar 17 10:34:20 monitor kernel: RPC: 14072 release request f700f074
> Mar 17 10:34:20 monitor kernel: NFS: refresh_inode(8/5873265 ct=1  
> info=0x6)
> Mar 17 10:34:20 monitor kernel: NFS: (8/5873265) revalidation complete
> Mar 17 10:34:20 monitor kernel: nfs:  
> read(RawData/ 
> GD=ETI=BO=MAKER_AF12=C4#CUTTER=3#2004=02=16=20=50=14.mat.gz, 4096@0)
> Mar 17 10:34:20 monitor kernel: NFS: nfs_readpage (c146432c 4096@0)
> Mar 17 10:34:20 monitor kernel: NFS: nfs_readpage (c161fd70 4096@1)
> Mar 17 10:34:20 monitor kernel: NFS: nfs_readpage (c1713134 4096@2)
> Mar 17 10:34:20 monitor kernel: NFS: nfs_readpage (c17ee424 4096@3)
> Mar 17 10:34:20 monitor kernel: NFS: 14073 initiated read call (req  
> 8/5873265 count 16384.
> Mar 17 10:34:20 monitor kernel: RPC: 14073 reserved req f700f074 xid  
> 73f386f5
> Mar 17 10:34:20 monitor kernel: RPC: 14073 xprt_transmit(73f386f5)
> Mar 17 10:34:20 monitor kernel: RPC: 14073 xprt_cwnd_limited cong = 0  
> cwnd = 512
> Mar 17 10:34:20 monitor kernel: RPC:      xprt_sendmsg(0) = 128
> Mar 17 10:34:20 monitor kernel: RPC: 14073 xmit complete
> Mar 17 10:34:20 monitor kernel: RPC:      udp_data_ready...
> Mar 17 10:34:20 monitor kernel: RPC:      udp_data_ready client f700f000
> Mar 17 10:34:20 monitor kernel: RPC: 14073 received reply
> Mar 17 10:34:20 monitor kernel: RPC:      cong 256, cwnd was 512, now  
> 512
> Mar 17 10:34:20 monitor kernel: RPC: 14073 has input (16512 bytes)
> Mar 17 10:34:20 monitor kernel: NFS: 14073 nfs_readpage_result, (status  
> 16384)
> Mar 17 10:34:20 monitor kernel: NFS: refresh_inode(8/5873265 ct=1  
> info=0x6)
> Mar 17 10:34:20 monitor kernel: NFS: read (8/5873265 4096@0)
> Mar 17 10:34:20 monitor kernel: NFS: read (8/5873265 4096@4096)
> Mar 17 10:34:20 monitor kernel: NFS: read (8/5873265 4096@8192)
> Mar 17 10:34:20 monitor kernel: NFS: read (8/5873265 4096@12288)
> Mar 17 10:34:20 monitor kernel: RPC: 14073 release request f700f074
> Mar 17 10:34:20 monitor kernel: nfs:  
> read(RawData/ 
> GD=ETI=BO=MAKER_AF12=C4#CUTTER=3#2004=02=16=20=50=14.mat.gz, 4096@4096)
> Mar 17 10:34:20 monitor kernel: NFS: nfs_readpage (c12b01e8 4096@4)
> Mar 17 10:34:20 monitor kernel: NFS: nfs_readpage (c142c8b0 4096@5)
> Mar 17 10:34:20 monitor kernel: NFS: nfs_readpage (c16728b4 4096@6)
> Mar 17 10:34:20 monitor kernel: NFS: nfs_readpage (c1430d18 4096@7)
> Mar 17 10:34:20 monitor kernel: NFS: 14074 initiated read call (req  
> 8/5873265 count 16384.
> Mar 17 10:34:20 monitor kernel: RPC: 14074 reserved req f700f074 xid  
> 73f386f6
> Mar 17 10:34:20 monitor kernel: RPC: 14074 xprt_transmit(73f386f6)
> Mar 17 10:34:20 monitor kernel: RPC: 14074 xprt_cwnd_limited cong = 0  
> cwnd = 512
> Mar 17 10:34:20 monitor kernel: RPC:      xprt_sendmsg(0) = 128
> Mar 17 10:34:20 monitor kernel: RPC: 14074 xmit complete
> Mar 17 10:34:20 monitor kernel: NFS: nfs_readpage (c1092e80 4096@8)
> Mar 17 10:34:20 monitor kernel: NFS: nfs_readpage (c15879cc 4096@9)
> Mar 17 10:34:20 monitor kernel: NFS: nfs_readpage (c185da50 4096@10)
> Mar 17 10:34:20 monitor kernel: nfs:  
> read(RawData/ 
> GD=ETI=BO=MAKER_AF12=C4#CUTTER=3#2004=02=16=20=50=14.mat.gz, 4096@8192)
> Mar 17 10:34:20 monitor kernel: nfs:  
> read(RawData/ 
> GD=ETI=BO=MAKER_AF12=C4#CUTTER=3#2004=02=16=20=50=14.mat.gz,  
> 4096@12288)
> Mar 17 10:34:20 monitor kernel: nfs:  
> read(RawData/ 
> GD=ETI=BO=MAKER_AF12=C4#CUTTER=3#2004=02=16=20=50=14.mat.gz,  
> 4096@16384)
> Mar 17 10:34:21 monitor kernel: RPC:      cong 256, cwnd was 512, now  
> 256
> Mar 17 10:34:21 monitor kernel: RPC: 14074 xprt_timer (pending request)
> Mar 17 10:34:21 monitor kernel: RPC: 14074 xprt_transmit(73f386f6)
> Mar 17 10:34:21 monitor kernel: RPC: 14074 xprt_cwnd_limited cong = 0  
> cwnd = 256
> Mar 17 10:34:21 monitor kernel: RPC:      xprt_sendmsg(0) = 128
> Mar 17 10:34:21 monitor kernel: RPC: 14074 xmit complete
> Mar 17 10:34:23 monitor kernel: RPC:      cong 256, cwnd was 256, now  
> 256
> Mar 17 10:34:23 monitor kernel: RPC: 14074 xprt_timer (pending request)
> Mar 17 10:34:23 monitor kernel: RPC: 14074 xprt_transmit(73f386f6)
> Mar 17 10:34:23 monitor kernel: RPC: 14074 xprt_cwnd_limited cong = 0  
> cwnd = 256
> Mar 17 10:34:23 monitor kernel: RPC:      xprt_sendmsg(0) = 128
> Mar 17 10:34:23 monitor kernel: RPC: 14074 xmit complete
> Mar 17 10:34:26 monitor kernel: NFS: 14018 flushd starting
> Mar 17 10:34:26 monitor kernel: NFS: 14075 initiated read call (req  
> 8/5873265 count 12288.
> Mar 17 10:34:26 monitor kernel: RPC: 14075 reserved req f700f120 xid  
> 73f386f7
> Mar 17 10:34:26 monitor kernel: RPC: 14075 xprt_transmit(73f386f7)
> Mar 17 10:34:26 monitor kernel: RPC: 14075 xprt_cwnd_limited cong = 256  
> cwnd = 256
> Mar 17 10:34:26 monitor kernel: RPC: 14075 TCP write queue full
> Mar 17 10:34:26 monitor kernel: NFS: 14018 flushd back to sleep
> Mar 17 10:34:27 monitor kernel: RPC:      cong 256, cwnd was 256, now  
> 256
> Mar 17 10:34:27 monitor kernel: RPC: 14075 xprt_cwnd_limited cong = 0  
> cwnd = 256
> Mar 17 10:34:27 monitor kernel: RPC: 14074 xprt_timer (pending request)
> Mar 17 10:34:27 monitor kernel: RPC: 14075 xprt_transmit(73f386f7)
> Mar 17 10:34:27 monitor kernel: RPC:      xprt_sendmsg(0) = 128
> Mar 17 10:34:27 monitor kernel: RPC: 14075 xmit complete
> Mar 17 10:34:27 monitor kernel: RPC: 14074 xprt_transmit(73f386f6)
> Mar 17 10:34:27 monitor kernel: RPC: 14074 xprt_cwnd_limited cong = 256  
> cwnd = 256
> Mar 17 10:34:27 monitor kernel: RPC: 14074 TCP write queue full
> Mar 17 10:34:27 monitor kernel: RPC:      udp_data_ready...
> Mar 17 10:34:27 monitor kernel: RPC:      udp_data_ready client f700f000
> Mar 17 10:34:27 monitor kernel: RPC: 14075 received reply
> Mar 17 10:34:27 monitor kernel: RPC: 14074 xprt_cwnd_limited cong = 256  
> cwnd = 256
> Mar 17 10:34:27 monitor kernel: RPC:      cong 256, cwnd was 256, now  
> 512
> Mar 17 10:34:27 monitor kernel: RPC: 14075 has input (12416 bytes)
> Mar 17 10:34:27 monitor kernel: RPC: 14074 xprt_transmit(73f386f6)
> Mar 17 10:34:27 monitor kernel: RPC: 14074 xprt_cwnd_limited cong = 0  
> cwnd = 512
> Mar 17 10:34:27 monitor kernel: RPC:      xprt_sendmsg(0) = 128
> Mar 17 10:34:27 monitor kernel: RPC: 14074 xmit complete
> Mar 17 10:34:27 monitor kernel: NFS: 14075 nfs_readpage_result, (status  
> 12288)
> Mar 17 10:34:27 monitor kernel: NFS: refresh_inode(8/5873265 ct=1  
> info=0x6)
> Mar 17 10:34:27 monitor kernel: NFS: read (8/5873265 4096@32768)
> Mar 17 10:34:27 monitor kernel: NFS: read (8/5873265 4096@36864)
> Mar 17 10:34:27 monitor kernel: NFS: read (8/5873265 4096@40960)
> Mar 17 10:34:27 monitor kernel: RPC: 14075 release request f700f120
> Mar 17 10:34:38 monitor kernel: RPC:      cong 256, cwnd was 512, now  
> 256
> Mar 17 10:34:38 monitor kernel: RPC: 14074 xprt_timer (pending request)
> Mar 17 10:34:38 monitor kernel: nfs: server p59 not responding, still  
> trying
> Mar 17 10:34:38 monitor kernel: RPC: 14074 xprt_transmit(73f386f6)
> Mar 17 10:34:38 monitor kernel: RPC: 14074 xprt_cwnd_limited cong = 0  
> cwnd = 256
> Mar 17 10:34:38 monitor kernel: RPC:      xprt_sendmsg(0) = 128
> Mar 17 10:34:38 monitor kernel: RPC: 14074 xmit complete
> Mar 17 10:34:39 monitor kernel: RPC:      cong 256, cwnd was 256, now  
> 256
> Mar 17 10:34:39 monitor kernel: RPC: 14074 xprt_timer (pending request)
> Mar 17 10:34:39 monitor kernel: RPC: 14074 xprt_transmit(73f386f6)
> Mar 17 10:34:39 monitor kernel: RPC: 14074 xprt_cwnd_limited cong = 0  
> cwnd = 256
> Mar 17 10:34:39 monitor kernel: RPC:      xprt_sendmsg(0) = 128
> Mar 17 10:34:39 monitor kernel: RPC: 14074 xmit complete
> Mar 17 10:34:41 monitor kernel: RPC:      cong 256, cwnd was 256, now  
> 256
> Mar 17 10:34:41 monitor kernel: RPC: 14074 xprt_timer (pending request)
> Mar 17 10:34:41 monitor kernel: RPC: 14074 xprt_transmit(73f386f6)
> Mar 17 10:34:41 monitor kernel: RPC: 14074 xprt_cwnd_limited cong = 0  
> cwnd = 256
> Mar 17 10:34:41 monitor kernel: RPC:      xprt_sendmsg(0) = 128
> Mar 17 10:34:41 monitor kernel: RPC: 14074 xmit complete
> Mar 17 10:34:47 monitor kernel: RPC:      cong 256, cwnd was 256, now  
> 256
> Mar 17 10:34:47 monitor kernel: RPC: 14074 xprt_timer (pending request)
> Mar 17 10:34:47 monitor kernel: RPC: 14074 xprt_transmit(73f386f6)
> Mar 17 10:34:47 monitor kernel: RPC: 14074 xprt_cwnd_limited cong = 0  
> cwnd = 256
> Mar 17 10:34:47 monitor kernel: RPC:      xprt_sendmsg(0) = 128
> Mar 17 10:34:47 monitor kernel: RPC: 14074 xmit complete
> Mar 17 10:34:56 monitor kernel: NFS: 14018 flushd starting
> Mar 17 10:34:56 monitor kernel: NFS: 14018 flushd back to sleep
> Mar 17 10:34:57 monitor kernel: RPC:      cong 256, cwnd was 256, now  
> 256
> Mar 17 10:34:57 monitor kernel: RPC: 14074 xprt_timer (pending request)
> Mar 17 10:34:57 monitor kernel: RPC: 14074 xprt_transmit(73f386f6)
> Mar 17 10:34:57 monitor kernel: RPC: 14074 xprt_cwnd_limited cong = 0  
> cwnd = 256
> Mar 17 10:34:57 monitor kernel: RPC:      xprt_sendmsg(0) = 128
> Mar 17 10:34:57 monitor kernel: RPC: 14074 xmit complete
> Mar 17 10:34:57 monitor kernel: RPC:      udp_data_ready...
> Mar 17 10:34:57 monitor kernel: RPC:      udp_data_ready client f700f000
> Mar 17 10:34:57 monitor kernel: RPC: 14074 received reply
> Mar 17 10:34:57 monitor kernel: RPC:      cong 256, cwnd was 256, now  
> 512
> Mar 17 10:34:57 monitor kernel: RPC: 14074 has input (16512 bytes)
> Mar 17 10:34:57 monitor kernel: nfs: server p59 OK
> Mar 17 10:34:57 monitor kernel: NFS: 14074 nfs_readpage_result, (status  
> 16384)
> Mar 17 10:34:57 monitor kernel: NFS: refresh_inode(8/5873265 ct=1  
> info=0x6)
> Mar 17 10:34:57 monitor kernel: NFS: read (8/5873265 4096@16384)
> Mar 17 10:34:57 monitor kernel: NFS: read (8/5873265 4096@20480)
> Mar 17 10:34:57 monitor kernel: NFS: read (8/5873265 4096@24576)
> Mar 17 10:34:57 monitor kernel: NFS: read (8/5873265 4096@28672)
> Mar 17 10:34:57 monitor kernel: RPC: 14074 release request f700f074
> Mar 17 10:34:57 monitor kernel: nfs:  
> read(RawData/ 
> GD=ETI=BO=MAKER_AF12=C4#CUTTER=3#2004=02=16=20=50=14.mat.gz,  
> 4096@20480)
> Mar 17 10:34:57 monitor kernel: NFS: nfs_readpage (c15f2928 4096@11)
> Mar 17 10:34:57 monitor kernel: NFS: nfs_readpage (c1615214 4096@12)
> Mar 17 10:34:57 monitor kernel: NFS: nfs_readpage (c190b110 4096@13)
> Mar 17 10:34:57 monitor kernel: NFS: nfs_readpage (c16bf4c0 4096@14)
> Mar 17 10:34:57 monitor kernel: NFS: 14076 initiated read call (req  
> 8/5873265 count 16384.
> Mar 17 10:34:57 monitor kernel: RPC: 14076 reserved req f700f074 xid  
> 73f386f8
> Mar 17 10:34:57 monitor kernel: RPC: 14076 xprt_transmit(73f386f8)
> Mar 17 10:34:57 monitor kernel: RPC: 14076 xprt_cwnd_limited cong = 0  
> cwnd = 512
> Mar 17 10:34:57 monitor kernel: RPC:      xprt_sendmsg(0) = 128
> Mar 17 10:34:57 monitor kernel: RPC: 14076 xmit complete
> Mar 17 10:34:57 monitor kernel: NFS: nfs_readpage (c157d7b8 4096@15)
> Mar 17 10:34:57 monitor kernel: NFS: nfs_readpage (c10e8bc8 4096@16)
> Mar 17 10:34:57 monitor kernel: NFS: nfs_readpage (c1271f70 4096@17)
> Mar 17 10:34:57 monitor kernel: NFS: nfs_readpage (c154e13c 4096@18)
> Mar 17 10:34:57 monitor kernel: NFS: 14077 initiated read call (req  
> 8/5873265 count 16384.
> Mar 17 10:34:57 monitor kernel: RPC: 14077 reserved req f700f120 xid  
> 73f386f9
> Mar 17 10:34:57 monitor kernel: RPC: 14077 xprt_transmit(73f386f9)
> Mar 17 10:34:57 monitor kernel: RPC: 14077 xprt_cwnd_limited cong = 256  
> cwnd = 512
> Mar 17 10:34:57 monitor kernel: RPC:      xprt_sendmsg(0) = 128
> Mar 17 10:34:57 monitor kernel: RPC: 14077 xmit complete
> Mar 17 10:34:57 monitor kernel: NFS: nfs_readpage (c1456758 4096@19)
> Mar 17 10:34:57 monitor kernel: NFS: nfs_readpage (c15589d8 4096@20)
> Mar 17 10:34:57 monitor kernel: NFS: nfs_readpage (c1663d68 4096@21)
> Mar 17 10:34:57 monitor kernel: NFS: nfs_readpage (c176a6b8 4096@22)
> Mar 17 10:34:57 monitor kernel: NFS: 14078 initiated read call (req  
> 8/5873265 count 16384.
> Mar 17 10:34:57 monitor kernel: RPC: 14078 reserved req f700f1cc xid  
> 73f386fa
> Mar 17 10:34:57 monitor kernel: RPC: 14078 xprt_transmit(73f386fa)
> Mar 17 10:34:57 monitor kernel: RPC: 14078 xprt_cwnd_limited cong = 512  
> cwnd = 512
> Mar 17 10:34:57 monitor kernel: RPC: 14078 TCP write queue full
> Mar 17 10:34:57 monitor kernel: NFS: nfs_readpage (c113dcb0 4096@23)
> Mar 17 10:34:57 monitor kernel: nfs:  
> read(RawData/ 
> GD=ETI=BO=MAKER_AF12=C4#CUTTER=3#2004=02=16=20=50=14.mat.gz,  
> 4096@24576)
> Mar 17 10:34:57 monitor kernel: nfs:  
> read(RawData/ 
> GD=ETI=BO=MAKER_AF12=C4#CUTTER=3#2004=02=16=20=50=14.mat.gz,  
> 4096@28672)
> Mar 17 10:34:57 monitor kernel: nfs: flush(8/5873265)
> Mar 17 10:34:57 monitor kernel: NFS: 14079 initiated read call (req  
> 8/5873265 count 4096.
> Mar 17 10:34:57 monitor kernel: RPC: 14079 reserved req f700f278 xid  
> 73f386fb
> Mar 17 10:34:57 monitor kernel: RPC: 14079 xprt_transmit(73f386fb)
> Mar 17 10:34:57 monitor kernel: RPC: 14079 xprt_cwnd_limited cong = 512  
> cwnd = 512
> Mar 17 10:34:57 monitor kernel: RPC: 14079 TCP write queue full
> Mar 17 10:34:57 monitor kernel: NFS:  
> dentry_delete(RawData/ 
> GD=ETI=BO=MAKER_AF12=C4#CUTTER=3#2004=02=16=20=50=14.mat.gz, 0)
> 
> Charles-Edouard Ruault
> Idtect SA
> tel: +33-1-42-81-81-84
> fax: +33-1-42-81-82-21
> http://www.idtect.com
> 
> 
> 
> -------------------------------------------------------
> This SF.Net email is sponsored by: IBM Linux Tutorials
> Free Linux tutorial presented by Daniel Robbins, President and CEO of
> GenToo technologies. Learn everything from fundamentals to system
> administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
> _______________________________________________
> NFS maillist  -  NFS@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/nfs

