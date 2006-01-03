Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932463AbWACTZn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932463AbWACTZn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 14:25:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932488AbWACTZm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 14:25:42 -0500
Received: from solarneutrino.net ([66.199.224.43]:57607 "EHLO
	tau.solarneutrino.net") by vger.kernel.org with ESMTP
	id S932463AbWACTZl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 14:25:41 -0500
Date: Tue, 3 Jan 2006 14:01:39 -0500
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: nfs@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       ryan@tau.solarneutrino.net
Subject: Re: lockd: couldn't create RPC handle for (host)
Message-ID: <20060103190138.GA6782@tau.solarneutrino.net>
References: <20051217055907.GC20539@tau.solarneutrino.net> <1134801822.7946.4.camel@lade.trondhjem.org> <20051217070222.GD20539@tau.solarneutrino.net> <1134847699.7950.25.camel@lade.trondhjem.org> <20051217194553.GE20539@tau.solarneutrino.net> <1134894836.7931.17.camel@lade.trondhjem.org> <20051218180150.GF20539@tau.solarneutrino.net> <1134934267.7966.37.camel@lade.trondhjem.org> <20051218200052.GA21665@tau.solarneutrino.net> <1134944665.11596.9.camel@lade.trondhjem.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1134944665.11596.9.camel@lade.trondhjem.org>
User-Agent: Mutt/1.5.9i
From: Ryan Richter <ryan@tau.solarneutrino.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 18, 2005 at 05:24:24PM -0500, Trond Myklebust wrote:
> On Sun, 2005-12-18 at 15:00 -0500, Ryan Richter wrote:
> > On Sun, Dec 18, 2005 at 02:31:07PM -0500, Trond Myklebust wrote:
> > > On Sun, 2005-12-18 at 13:01 -0500, Ryan Richter wrote:
> > > > Code: 48 39 78 18 75 1c 8b 86 8c 00 00 00 a8 01 74 12 83 c8 02 89 
> > > > RIP <ffffffff801dbd9e>{nlmclnt_mark_reclaim+62} RSP <ffff81007dfade70>
> > > > CR2: 0000000000000018
> > > 
> > > Looks like the global lock list is corrupted. Could you cat the contents
> > > of /proc/locks?
> > 
> > $ cat /proc/locks
> > 1: POSIX  ADVISORY  WRITE 1657 00:0e:1771273 0 EOF
> > 2: FLOCK  ADVISORY  WRITE 1486 00:0e:1770759 0 EOF
> > 3: FLOCK  ADVISORY  WRITE 1478 00:0e:1770399 0 EOF
> 
> OK. I think this client patch ought to fix the Oopses. It should apply
> to a 2.6.14 kernel as well as 2.6.15-rc5.

I applied this patch to 2.6.14.3 and booted it before I left in
December.  Now that I'm back, I see that the problem has returned -
lockd is no longer running, and

general protection fault: 0000 [1] 
CPU 0 
Modules linked in:
Pid: 1174, comm: lockd Not tainted 2.6.14.3 #1
RIP: 0010:[<ffffffff801dbda3>] <ffffffff801dbda3>{nlmclnt_mark_reclaim+67}
RSP: 0018:ffff81007dfade70  EFLAGS: 00010206
RAX: 3168647300000000 RBX: ffff81007ec1cb40 RCX: ffffffff803e4650
RDX: ffff81007f31b0a0 RSI: ffff81007f31b098 RDI: ffff81007ec1cb40
RBP: ffff81000327e200 R08: 00000000fffffffa R09: 0000000000000001
R10: 00000000ffffffff R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: ffffffff803ec460 R15: ffff81007df5f014
FS:  00002aaaab00c4a0(0000) GS:ffffffff804b6800(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
CR2: 0000000000512000 CR3: 000000007c8d0000 CR4: 00000000000006e0
Process lockd (pid: 1174, threadinfo ffff81007dfac000, task ffff81007eea61c0)
Stack: ffffffff801dbe6b ffff81007ec1cb40 ffffffff801e3d8c 3256cc8445030002 
       0000000000000000 ffff81007df5bc68 ffff81007df5bc00 ffffffff803ed4e0 
       ffff81007df5bca0 ffff81007df5bc68 
Call Trace:<ffffffff801dbe6b>{nlmclnt_recovery+139} <ffffffff801e3d8c>{nlm4svc_proc_sm_notify+188}
       <ffffffff8034c5e4>{svc_process+884} <ffffffff8012ab40>{default_wake_function+0}
       <ffffffff801dde00>{lockd+352} <ffffffff801ddca0>{lockd+0}
       <ffffffff8010e352>{child_rip+8} <ffffffff801ddca0>{lockd+0}
       <ffffffff801ddca0>{lockd+0} <ffffffff8010e34a>{child_rip+0}
       

Code: 48 39 78 18 75 17 8b 86 8c 00 00 00 a8 01 74 0d 83 c8 02 89 
RIP <ffffffff801dbda3>{nlmclnt_mark_reclaim+67} RSP <ffff81007dfade70>

-ryan
