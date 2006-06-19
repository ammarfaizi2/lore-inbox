Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932384AbWFSLBp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932384AbWFSLBp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 07:01:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932382AbWFSLBp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 07:01:45 -0400
Received: from smtp.osdl.org ([65.172.181.4]:35257 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932373AbWFSLBo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 07:01:44 -0400
Date: Mon, 19 Jun 2006 04:01:10 -0700
From: Andrew Morton <akpm@osdl.org>
To: tglx@linutronix.de, Ravinandan Arakali <ravinandan.arakali@neterion.com>
Cc: dgc@sgi.com, mingo@elte.hu, neilb@suse.de, jblunck@suse.de,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       viro@zeniv.linux.org.uk, balbir@in.ibm.com
Subject: Re: [patch 0/5] [PATCH,RFC] vfs: per-superblock unused dentries
 list (2nd version)
Message-Id: <20060619040110.03b39673.akpm@osdl.org>
In-Reply-To: <1150714124.27073.67.camel@localhost.localdomain>
References: <20060601095125.773684000@hasse.suse.de>
	<17539.35118.103025.716435@cse.unsw.edu.au>
	<20060616155120.GA6824@hasse.suse.de>
	<17555.12234.347353.670918@cse.unsw.edu.au>
	<20060618235654.GB2114946@melbourne.sgi.com>
	<17557.61307.364404.640539@cse.unsw.edu.au>
	<20060619010013.GC2114946@melbourne.sgi.com>
	<17557.64512.496195.714144@cse.unsw.edu.au>
	<20060619055523.GS2795448@melbourne.sgi.com>
	<20060618233339.dba0fc86.akpm@osdl.org>
	<1150714124.27073.67.camel@localhost.localdomain>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Jun 2006 12:48:44 +0200
Thomas Gleixner <tglx@linutronix.de> wrote:

> On Sun, 2006-06-18 at 23:33 -0700, Andrew Morton wrote:
> > > ....
> > >     eth3      device: S2io Inc. Xframe 10 Gigabit Ethernet PCI-X (rev 03)
> > >     eth3      configuration: eth-id-00:0c:fc:00:02:c8
> > > irq 60, desc: a0000001009a2d00, depth: 1, count: 0, unhandled: 0
> > > ->handle_irq():  0000000000000000, 0x0
> > > ->chip(): a000000100a0fe40, irq_type_sn+0x0/0x80
> > > ->action(): e00000b007471b80
> > > ->action->handler(): a0000002059373d0, s2io_msi_handle+0x1510/0x660 [s2io]    eth3
> > > IP address: 192.168.1.248/24
> > > Unexpected irq vector 0x3c on CPU 3!
> > 
> > I guess that's where things start to go bad.  genirq changes?
> 
> Hmm, The extra noisy printout is from geirq. The unhandled interrupt
> should be unrelated. 
> 
> The s2io driver enables interrupts in the card in start_nic() before
> requesting the interrupt itself with request_irq(). So I suspect thats a
> problem which has been there already, just the noisy printout makes it
> more visible

OK, that's not good.  It would be strange for the NIC to be aserting an
interrupt in that window though - the machine would end up taking a zillion
interrupts and would disable the whole IRQ line.

Still.  Ravinandan, could you take a look at fixing that up, please?  Wire
up the IRQ handler before enabling interrupts?

We still don't know why these things happened.
