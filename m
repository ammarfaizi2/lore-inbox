Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161575AbWJKWqJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161575AbWJKWqJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 18:46:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161574AbWJKWqJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 18:46:09 -0400
Received: from smtp.osdl.org ([65.172.181.4]:45444 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161575AbWJKWqH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 18:46:07 -0400
Date: Wed, 11 Oct 2006 15:45:01 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jeff Garzik <jeff@garzik.org>
Cc: ambx1@neo.rr.com, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] PNP: handle sysfs errors
Message-Id: <20061011154501.7ae43d56.akpm@osdl.org>
In-Reply-To: <20061011215109.GA22264@havoc.gtf.org>
References: <20061011215109.GA22264@havoc.gtf.org>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Oct 2006 17:51:09 -0400
Jeff Garzik <jeff@garzik.org> wrote:

> +	int rc = device_create_file(&dev->dev,&dev_attr_options);
> +	if (rc) goto err;
> +	rc = device_create_file(&dev->dev,&dev_attr_resources);
> +	if (rc) goto err_opt;
> +	rc = device_create_file(&dev->dev,&dev_attr_id);
> +	if (rc) goto err_res;
> +
>  	return 0;
> +
> +err_res:
> +	device_remove_file(&dev->dev,&dev_attr_resources);
> +err_opt:
> +	device_remove_file(&dev->dev,&dev_attr_options);
> +err:
> +	return rc;

That's a common pattern, isn't it?

I wonder if we could create some sort of automatic-unwinding engine:

int pnp_interface_attach_device(struct pnp_dev *dev)
{
	struct unwind_engine *u = NULL;
	int err;

	u = UNWINDABLE(u, err, device_create_file(&dev->dev,&dev_attr_options),
			device_remove_file, &dev->dev, &dev_attr_options);
	u = UNWINDABLE(u, err, device_create_file(&dev->dev,&dev_attr_id)
			device_remove_file, &dev->dev, &dev_attr_options);
	u = UNWINDABLE(u, err, device_create_file(&dev->dev,&dev_attr_id),
			device_remove_file, &dev->dev, &dev_attr_id);
	err = unwind(err, u);
	return err;
}

and, umm,

#define UNWINDABLE(u, err, expr, undo_fn, arg1, arg2)
	if (err == 0) {
		err = (expr);
		if (err == 0)
			u = add_unwind(u, undo_fn, arg1, arg2);
	}
	u;

int unwind(int err, struct unwind_engine *u)
{
	if (err == 0)
		return 0;
	for (all entries in u in opposite order) {
		u->fn(u->arg0, u>arg1);
		kfree(u);
	}
	return err;
}


I dunno - probably too crappy to live, but it'd encourage/help people to
dtrt.
