Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266356AbTBKWD2>; Tue, 11 Feb 2003 17:03:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266379AbTBKWD2>; Tue, 11 Feb 2003 17:03:28 -0500
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.28]:36798 "HELO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S266356AbTBKWDZ>; Tue, 11 Feb 2003 17:03:25 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Oleg Drokin <green@namesys.com>
Date: Wed, 12 Feb 2003 09:12:44 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15945.30044.444455.162630@notabene.cse.unsw.edu.au>
Cc: Trond Myklebust <trond.myklebust@fys.uio.no>,
       David Ford <david+powerix@blue-labs.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Current NFS issues (2.5.59)
In-Reply-To: message from Oleg Drokin on Tuesday February 11
References: <3E46E1D6.20709@blue-labs.org>
	<15944.30340.955911.798377@notabene.cse.unsw.edu.au>
	<20030211100011.A5850@namesys.com>
	<15944.60247.512630.175678@charged.uio.no>
	<20030211163119.A24157@namesys.com>
X-Mailer: VM 7.07 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday February 11, green@namesys.com wrote:
> Hello!
> 
> On Tue, Feb 11, 2003 at 01:23:51PM +0100, Trond Myklebust wrote:
> >     >> this started happening when they upgrade from an earlier 2.5
> >     >> kernel.
> > 
> >      > I think that earlier report was from David too. This is just
> >      > more detailed report it seems.
> > 
> >      > And while you are listening - I want to share my own NFs
> >      > problems in 2.5.59 ;) If I try to mount any NFS exported
> >      > filesystem from the same host (e.g localhost), mount process
> >      > hangs in D state. Server appears to work ok though and serves
> >      > requests from external clients.
> > ...and I am unable to reproduce this 8-)
> 
> Here is how I achieve this:
> 2.5.60 kernel from current bk repository.
> belka:/usr/src/linux-2.5-bk # grep NFS .config
> CONFIG_NFS_FS=y
> CONFIG_NFS_V3=y
> # CONFIG_NFS_V4 is not set
> CONFIG_NFSD=y
> CONFIG_NFSD_V3=y
> # CONFIG_NFSD_V4 is not set
> CONFIG_NFSD_TCP=y
> 
> belka:~ # cat /etc/exports
> /home (ro)
> belka:~ # ps ax | grep portmap
>   421 ?        S      0:00 /sbin/portmap
> belka:~ # mount localhost:/home /mnt -t nfs
> And it hangs here.

Yep, I can reproduce this.
I turn on lots of debuggin:

 # grep . /proc/sys/sunrpc/*
/proc/sys/sunrpc/nfs_debug:16383
/proc/sys/sunrpc/nfsd_debug:16383
/proc/sys/sunrpc/nlm_debug:0
/proc/sys/sunrpc/rpc_debug:16319


and get :

Feb 12 09:11:35 kamen kernel: RPC:      cong 256, cwnd was 256, now 256
Feb 12 09:11:35 kamen kernel: RPC:  411 xprt_timer (pending request)
Feb 12 09:11:35 kamen kernel: RPC:  411 call_status (status -110)
Feb 12 09:11:35 kamen kernel: RPC:  411 call_timeout (minor)
Feb 12 09:11:35 kamen kernel: RPC:  411 call_bind xprt e6219000 is connected
Feb 12 09:11:35 kamen kernel: RPC:  411 call_transmit (status 0)
Feb 12 09:11:35 kamen kernel: RPC:  411 xprt_prepare_transmit
Feb 12 09:11:35 kamen kernel: RPC:  411 xprt_cwnd_limited cong = 0 cwnd = 256
Feb 12 09:11:35 kamen kernel: RPC:  411 call_encode (status 0)
Feb 12 09:11:35 kamen kernel: RPC:  411 marshaling UNIX cred f6044944
Feb 12 09:11:35 kamen kernel: RPC:  411 xprt_transmit(88)
Feb 12 09:11:35 kamen kernel: svc: socket f7775304(inet f6e7f5f8), count=96, busy=0
Feb 12 09:11:35 kamen kernel: svc: socket f6e7f5f8 served by daemon f69ed600
Feb 12 09:11:35 kamen kernel: RPC:      xprt_sendmsg(88) = 88
Feb 12 09:11:35 kamen kernel: RPC:  411 xmit complete
Feb 12 09:11:35 kamen kernel: svc: server f69ed600, socket f7775304, inuse=1
Feb 12 09:11:35 kamen kernel: svc: socket f6e7f5f8 served by daemon f653d400
Feb 12 09:11:35 kamen kernel: svc: got len=88
Feb 12 09:11:35 kamen kernel: svc: svc_authenticate (1)
Feb 12 09:11:35 kamen kernel: svc: socket f6e7f5f8 busy, not enqueued
Feb 12 09:11:35 kamen kernel: svc: calling dispatcher
Feb 12 09:11:35 kamen kernel: nfsd_dispatch: vers 3 proc 1
Feb 12 09:11:35 kamen kernel: nfsd: GETATTR(3)  12: 00000001 01000800 0004358c 00000000 00000000 00000000
Feb 12 09:11:35 kamen kernel: nfsd: fh_verify(12: 00000001 01000800 0004358c 00000000 00000000 00000000)
Feb 12 09:11:35 kamen kernel: svc: service f69ed600, releasing skb f6f690a4
Feb 12 09:11:35 kamen kernel: svc: socket f7775304(inet f6e7f5f8), write_space busy=1
Feb 12 09:11:35 kamen kernel: svc: socket f6e7f5f8 busy, not enqueued
Feb 12 09:11:35 kamen kernel: RPC:      udp_data_ready...
Feb 12 09:11:35 kamen kernel: RPC:      udp_data_ready client e6219000
Feb 12 09:11:35 kamen kernel: svc: socket f7775304 sendto([f69a6000 112... ], 112) = 112 (addr 100007f)
Feb 12 09:11:35 kamen kernel: svc: server f653d400, socket f7775304, inuse=2
Feb 12 09:11:35 kamen kernel: svc: got len=-11
Feb 12 09:11:35 kamen kernel: svc: server f653d400 waiting for data (to = 300000)
Feb 12 09:11:35 kamen kernel: svc: server f69ed600 waiting for data (to = 300000)

which seems to suggest that the reply is coming back from the server
(RPC: udp_data_ready) but there is no sign of the client getting it...

NeilBrown
