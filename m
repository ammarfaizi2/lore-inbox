Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261786AbVA3VRa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261786AbVA3VRa (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jan 2005 16:17:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261787AbVA3VRa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jan 2005 16:17:30 -0500
Received: from fw.osdl.org ([65.172.181.6]:6529 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261786AbVA3VRZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jan 2005 16:17:25 -0500
Date: Sun, 30 Jan 2005 13:17:23 -0800
From: Andrew Morton <akpm@osdl.org>
To: Parag Warudkar <kernel-stuff@comcast.net>
Cc: bcollins@debian.org, linux-kernel@vger.kernel.org,
       linux1394-devel@lists.sourceforge.net
Subject: Re: [PATCH] ohci1394: dma_pool_destroy while in_atomic() &&
 irqs_disabled()
Message-Id: <20050130131723.781991d3.akpm@osdl.org>
In-Reply-To: <41FD498C.9000708@comcast.net>
References: <41FD498C.9000708@comcast.net>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Parag Warudkar <kernel-stuff@comcast.net> wrote:
>
> Problem - ohci1394.c:ohci_devctl ends up calling dma_pool_destroy from 
> invalid context. Below is the dmesg output when I exit Kino after video 
> capture -
> 
> Debug: sleeping function called from invalid context at 
> include/asm/semaphore.h:107
> in_atomic():1, irqs_disabled():1
>  [<c0104c2e>] dump_stack+0x1e/0x20
>  [<c011f8a2>] __might_sleep+0xa2/0xc0
>  [<c028c660>] dma_pool_destroy+0x20/0x140
>  [<f0b7affe>] free_dma_rcv_ctx+0x8e/0x150 [ohci1394]
>  [<f0b774a4>] ohci_devctl+0x214/0x9b0 [ohci1394]
>  [<f0e7aa99>] handle_iso_listen+0x2d9/0x310 [raw1394]
>  [<f0e7f22b>] state_connected+0x29b/0x2b0 [raw1394]
>  [<f0e7f2de>] raw1394_write+0x9e/0xd0 [raw1394]
>  [<c0183ef2>] vfs_write+0xc2/0x170
>  [<c018406b>] sys_write+0x4b/0x80
>  [<c0103cb1>] sysenter_past_esp+0x52/0x75

Yes, that's certainly wrong.

> Attached patch against 2.6.11-rc2 (tested to work normally with a  
> camcorder device) enables ohci_devctl to defer the work of destroying 
> the dma pool by using a work queue, so the dma pool is destroyed in a 
> valid context and we no longer get an error in dmesg (duh :)

yup.  But what happens if someone removes the module while
ohci_free_dma_work_fn() is still pending?

Suggestions:

- The work_struct cannot be on the stack.  The code as you have it will
  read gunk from the stack when the delayed work executes.  The work_struct
  needs to be placed into some ohci data structure which has the appropriate
  lifetime.  That might be struct ti_ohci.  Or not.

- We'll need a flush_workqueue() in the teardown function for that data
  structure to ensure that any pending callbacks have completed before we
  free the storage.

  Care needs to be taken to ensure that the work_struct is suitably
  initialised so that the flush_workqueue() will work OK even if the
  callback has never been scheduled.

- You have several typecasts between struct pci_pool* and void*.  These
  defeat typechecking.  It's better to leave these casts out.
