Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932105AbWGRNPN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932105AbWGRNPN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jul 2006 09:15:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932191AbWGRNPM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jul 2006 09:15:12 -0400
Received: from mail.cs.umn.edu ([128.101.34.202]:34198 "EHLO mail.cs.umn.edu")
	by vger.kernel.org with ESMTP id S932105AbWGRNPK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jul 2006 09:15:10 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17596.56260.541661.919437@hound.rchland.ibm.com>
Date: Tue, 18 Jul 2006 08:01:56 -0500
To: Chris Wright <chrisw@sous-sol.org>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.osdl.org,
       xen-devel@lists.xensource.com, Jeremy Fitzhardinge <jeremy@goop.org>,
       Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>,
       Rusty Russell <rusty@rustcorp.com.au>, Zachary Amsden <zach@vmware.com>,
       Ian Pratt <ian.pratt@xensource.com>,
       Christian Limpach <Christian.Limpach@cl.cam.ac.uk>
Subject: [RFC PATCH 33/33] Add Xen virtual block device driver.
In-Reply-To: <20060718091958.657332000@sous-sol.org>
References: <20060718091807.467468000@sous-sol.org>
	<20060718091958.657332000@sous-sol.org>
X-Mailer: VM 7.19 under Emacs 21.4.1
From: boutcher@cs.umn.edu (Dave Boutcher)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Jul 2006 00:00:33 -0700, Chris Wright <chrisw@sous-sol.org> said:
> 
> The block device frontend driver allows the kernel to access block
> devices exported exported by a virtual machine containing a physical
> block device driver.

First, I think this belongs in drivers/block (and the network driver
belongs in drivers/net).  If we're going to bring xen to the party,
lets not leave it hiding out in a corner.

> +static void connect(struct blkfront_info *);
> +static void blkfront_closing(struct xenbus_device *);
> +static int blkfront_remove(struct xenbus_device *);
> +static int talk_to_backend(struct xenbus_device *, struct blkfront_info *);
> +static int setup_blkring(struct xenbus_device *, struct blkfront_info *);
> +
> +static void kick_pending_request_queues(struct blkfront_info *);
> +
> +static irqreturn_t blkif_int(int irq, void *dev_id, struct pt_regs *ptregs);
> +static void blkif_restart_queue(void *arg);
> +static void blkif_recover(struct blkfront_info *);
> +static void blkif_completion(struct blk_shadow *);
> +static void blkif_free(struct blkfront_info *, int);

I'm pretty sure you can rearrange the code to get rid of the forward
references. 

> +/**
> + * We are reconnecting to the backend, due to a suspend/resume, or a backend
> + * driver restart.  We tear down our blkif structure and recreate it, but
> + * leave the device-layer structures intact so that this is transparent to the
> + * rest of the kernel.
> + */
> +static int blkfront_resume(struct xenbus_device *dev)
> +{
> +	struct blkfront_info *info = dev->dev.driver_data;
> +	int err;
> +
> +	DPRINTK("blkfront_resume: %s\n", dev->nodename);
> +
> +	blkif_free(info, 1);
> +
> +	err = talk_to_backend(dev, info);
> +	if (!err)
> +		blkif_recover(info);
> +
> +	return err;
> +}
Should blkfront_resume grab blkif_io_lock?

> +	switch (backend_state) {
> +	case XenbusStateUnknown:
> +	case XenbusStateInitialising:
> +	case XenbusStateInitWait:
> +	case XenbusStateInitialised:
> +	case XenbusStateClosed:

This actually should get fixed elsewhere, but SillyCaps???

> +static inline int GET_ID_FROM_FREELIST(
> +	struct blkfront_info *info)
> +{
> +	unsigned long free = info->shadow_free;
> +	BUG_ON(free > BLK_RING_SIZE);
> +	info->shadow_free = info->shadow[free].req.id;
> +	info->shadow[free].req.id = 0x0fffffee; /* debug */
> +	return free;
> +}
> +
> +static inline void ADD_ID_TO_FREELIST(
> +	struct blkfront_info *info, unsigned long id)
> +{
> +	info->shadow[id].req.id  = info->shadow_free;
> +	info->shadow[id].request = 0;
> +	info->shadow_free = id;
> +}

A real nit..but why are these routines SHOUTING?

> +int blkif_release(struct inode *inode, struct file *filep)
> +{
> +	struct blkfront_info *info = inode->i_bdev->bd_disk->private_data;
> +	info->users--;
> +	if (info->users == 0) {

Hrm...this strikes me as racey.  Don't you need at least a memory
barrier here to handle SMP?


> +static struct xlbd_major_info xvd_major_info = {
> +	.major = 201,
> +	.type = &xvd_type_info
> +};

I've forgotten what the current policy is around new major numbers. 


Dave B
