Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277708AbRKAC5M>; Wed, 31 Oct 2001 21:57:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277713AbRKAC5C>; Wed, 31 Oct 2001 21:57:02 -0500
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.28]:49824 "HELO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S277708AbRKAC4y>; Wed, 31 Oct 2001 21:56:54 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Date: Thu, 1 Nov 2001 13:57:10 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15328.47622.389369.705259@notabene.cse.unsw.edu.au>
Subject: PATCH: missing unlock in ipconfig - and question: appletalk delays
X-Mailer: VM 6.72 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,
 I compiled a new (2.4.13) kernel for my notebook which included
 appletalk support (just in case...) and found that I started getting
 lots of processes hanging in 'D' state.

 They were trying to down(&rtnl_sem);

 I did an audit of rtnl_sem usage and found an obscure case where an
 unlock was missing:

--- ./net/ipv4/ipconfig.c	2001/11/01 01:51:16	1.1
+++ ./net/ipv4/ipconfig.c	2001/11/01 02:42:26
@@ -194,8 +194,10 @@
 				printk(KERN_ERR "IP-Config: Failed to open %s\n", dev->name);
 				continue;
 			}
-			if (!(d = kmalloc(sizeof(struct ic_device), GFP_KERNEL)))
+			if (!(d = kmalloc(sizeof(struct ic_device), GFP_KERNEL))) {
+				rtnl_shunlock();
 				return -1;
+			}
 			d->dev = dev;
 			*last = d;
 			last = &d->next;


 But that wasn't the problem.  The problem was that atalkd was doing
 atif_probe_device under some sock_ioctl/atalk_ioctl/atif_ioctl and it
 was taking a long time, and holding the rtnl_sem semaphore the whole
 time. 
 The code suggests what it could try for some multiple of 253
 seconds,  which is several minutes.  During this time such simple
 commands as "netstat -i" wont work.

 It's probably OK for it to take a long time probing the network, but
 it is really fair that it hold the semaphore for the whole time??

 Fortunately it does interruptible waits so I can just kill atalkd (or
 maybe even not run it).

NeilBrown
