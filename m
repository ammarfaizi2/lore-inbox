Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262253AbVBKPnM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262253AbVBKPnM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Feb 2005 10:43:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262258AbVBKPnM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Feb 2005 10:43:12 -0500
Received: from smtp.nuvox.net ([64.89.70.9]:13427 "EHLO
	smtp03.gnvlscdb.sys.nuvox.net") by vger.kernel.org with ESMTP
	id S262253AbVBKPnG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Feb 2005 10:43:06 -0500
Subject: Re: [PATCH] ohci1394: dma_pool_destroy while in_atomic() &&
	irqs_disabled()
From: Dan Dennedy <dan@dennedy.org>
To: Parag Warudkar <kernel-stuff@comcast.net>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Linux1394-Devel <linux1394-devel@lists.sourceforge.net>
In-Reply-To: <41FD8796.2020509@comcast.net>
References: <41FD498C.9000708@comcast.net>
	 <20050130131723.781991d3.akpm@osdl.org>	<41FD6478.9040404@comcast.net>
	 <20050130150224.33299170.akpm@osdl.org>  <41FD8796.2020509@comcast.net>
Content-Type: text/plain
Date: Fri, 11 Feb 2005 10:35:33 -0500
Message-Id: <1108136133.4149.3.camel@kino.dennedy.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-01-30 at 20:19 -0500, Parag Warudkar wrote:
> Attached is the reworked patch to take care of Andrew's suggestions -
> 
> 1) Allocate the work struct dynamically in struct ti_ohci during  device 
> probe, free it during device remove
> 2) In ohci1394_pci_remove, ensure queued work, if any, is flushed before 
> the device is removed (As I understand, this should work for both device 
> removal cases as well as module removal - correct?)
> 3) Rework the free_dma_rcv_ctx  - It is called in multiple contexts by 
> different callers - teach it to free the dma according to caller's wish 
> - either direct free where caller determines the context is safe to 
> sleep OR delayed via schedule_work when caller wants to call it from a 
> context where it cannot sleep.  So it now takes 2 extra arguments - 
> method to free - direct or delayed and if it is to be  freed delayed, an 
> appropriate work_struct.
> 
> Andrew - flush_scheduled_work does not touch work which isn't shceduled 
> - so I don't think INIT_WORK in setup is necessary. Let me know if I am 
> missing something here. (I tried INIT_WORK in ochi1394_pci_probe and 
> putting flush_scheduled_work in ohci1394_pci_remove - It did not result 
> in calling the work function after I did rmmod, since it wasn't scheduled.)
> 

I am testing this patch in the same manner as you: exiting Kino capture.
I am getting a similar error in a different location. Can you look into
it, please?

Debug: sleeping function called from invalid context at mm/slab.c:2082
in_atomic():1, irqs_disabled():1
 [<c0119eb1>] __might_sleep+0xa1/0xc0
 [<c0144914>] kmem_cache_alloc+0x64/0x80
 [<c037f07b>] dma_pool_create+0x7b/0x190
 [<e09ede32>] alloc_dma_rcv_ctx+0x1a2/0x400 [ohci1394]
 [<e09eb239>] ohci_devctl+0x3d9/0x640 [ohci1394]
 [<e0bc5d4e>] handle_iso_listen+0xee/0x160 [raw1394]
 [<e0bc878e>] state_connected+0x2de/0x2f0 [raw1394]
 [<e0bc884e>] raw1394_write+0xae/0xe0 [raw1394]
 [<c015c80c>] vfs_write+0x14c/0x160
 [<c015c8f1>] sys_write+0x51/0x80
 [<c0102a39>] sysenter_past_esp+0x52/0x75


