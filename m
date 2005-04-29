Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261962AbVD2Prz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261962AbVD2Prz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Apr 2005 11:47:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262054AbVD2Prx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Apr 2005 11:47:53 -0400
Received: from mail.kroah.org ([69.55.234.183]:41185 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261962AbVD2Prd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Apr 2005 11:47:33 -0400
Date: Fri, 29 Apr 2005 08:43:13 -0700
From: Greg KH <greg@kroah.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Tomasz K__oczko <kloczek@rudy.mif.pg.gda.pl>, linux-kernel@vger.kernel.org,
       fedora-list@redhat.com, linux-scsi@vger.kernel.org,
       andrew.vasquez@qlogic.com, Patrick Mochel <mochel@digitalimplant.org>
Subject: Re: [QLA2300] Call Trace: sleeping function called from invalid context
Message-ID: <20050429154312.GC31834@kroah.com>
References: <Pine.BSO.4.62.0504281742290.10166@rudy.mif.pg.gda.pl> <20050429060718.0722b5a4.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050429060718.0722b5a4.akpm@osdl.org>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 29, 2005 at 06:07:18AM -0700, Andrew Morton wrote:
> Tomasz K__oczko <kloczek@rudy.mif.pg.gda.pl> wrote:
> >
> > Configuration:
> >  Sun v20z directly connected to Sun 3511 FC array. HBA:
> >  03:01.0 Fibre Channel: QLogic Corp. QLA2300 64-bit Fibre Channel Adapter (rev 01)
> > 
> >  On begining on FC port aren't avalaible any luns for this host.
> >  Change on array controler configuration for map SCSI channel to port 
> >  connected to this host causes on this computer:
> > 
> >  qla2300 0000:03:01.0: LIP reset occured (f8f7).
> >  Debug: sleeping function called from invalid context at include/linux/rwsem.h:43
> >  in_atomic():1, irqs_disabled():1
> > 
> >  Call Trace: <IRQ> <ffffffff80277156>{device_for_each_child+54}
> >          <ffffffff880317c5>{:scsi_transport_fc:fc_remote_port_block+53}
> >          <ffffffff8803c284>{:qla2xxx:qla2x00_mark_all_devices_lost+68}
> >          <ffffffff8804570f>{:qla2xxx:qla2x00_async_event+2127}
> >          <ffffffff88045f30>{:qla2xxx:qla2300_intr_handler+384}
> >          <ffffffff8016135c>{handle_IRQ_event+44} <ffffffff8016148d>{__do_IRQ+253}
> >          <ffffffff80111678>{do_IRQ+72} <ffffffff8010f027>{ret_from_intr+0}
> >           <EOI> <ffffffff8010d390>{default_idle+0} <ffffffff8010d3b2>{default_idle+34}
> >          <ffffffff8010d407>{cpu_idle+71} <ffffffff8050685a>{start_kernel+474}
> >          <ffffffff80506266>{_sinittext+614}
> >  qla2300 0000:03:01.0: LIP occured (f7f7).
> > 
> >  System it is Fedora devel version (2.6.11-1.1275_FC4smp).
> 
> fc_remote_port_block() calls scsi_target_block() calls device_for_each_child().
> 
> In Linus's tree, device_for_each_child() does down_read().  In -mm that
> down_read() has been taken out, but device_for_each_child() is still doing
> spin_lock() and hence still cannot be called from interrupts.
> 
> Now, possibly we could make that locking in the new device_for_each_child()
> (klist_iter->i_klist->k_lock) be IRQ-safe.  That'd be for Pat and Greg to
> decide.

No, we will not do this, don't call that function from irq context
please.

> I suspect they'll say no, and the qlogic driver (or scsi) need to stop
> calling device_for_each_child() from IRQ context.
> 
> (Locking in the new device_for_each_child() looks funny to me.  Are we sure
> it's safe?)

I think so, but others had some questions about it.  Pat has disappeared
again, so I'm going to be taking next week to address all of the pending
issues with the new klist code and go over the locking again.

thanks,

greg k-h
