Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422755AbWJLDyK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422755AbWJLDyK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Oct 2006 23:54:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422762AbWJLDyJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Oct 2006 23:54:09 -0400
Received: from gateway.insightbb.com ([74.128.0.19]:41871 "EHLO
	asav07.insightbb.com") by vger.kernel.org with ESMTP
	id S1422755AbWJLDyI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Oct 2006 23:54:08 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AR4FAEhZLUWBSopPLA
From: Dmitry Torokhov <dtor@insightbb.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] PNP: handle sysfs errors
Date: Wed, 11 Oct 2006 23:54:04 -0400
User-Agent: KMail/1.9.3
Cc: Jeff Garzik <jeff@garzik.org>, ambx1@neo.rr.com,
       LKML <linux-kernel@vger.kernel.org>
References: <20061011215109.GA22264@havoc.gtf.org> <20061011154501.7ae43d56.akpm@osdl.org>
In-Reply-To: <20061011154501.7ae43d56.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610112354.06813.dtor@insightbb.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 11 October 2006 18:45, Andrew Morton wrote:
> On Wed, 11 Oct 2006 17:51:09 -0400
> Jeff Garzik <jeff@garzik.org> wrote:
> 
> > +	int rc = device_create_file(&dev->dev,&dev_attr_options);
> > +	if (rc) goto err;
> > +	rc = device_create_file(&dev->dev,&dev_attr_resources);
> > +	if (rc) goto err_opt;
> > +	rc = device_create_file(&dev->dev,&dev_attr_id);
> > +	if (rc) goto err_res;
> > +
> >  	return 0;
> > +
> > +err_res:
> > +	device_remove_file(&dev->dev,&dev_attr_resources);
> > +err_opt:
> > +	device_remove_file(&dev->dev,&dev_attr_options);
> > +err:
> > +	return rc;
> 
> That's a common pattern, isn't it?
> 
> I wonder if we could create some sort of automatic-unwinding engine:
> 
> int pnp_interface_attach_device(struct pnp_dev *dev)
> {
> 	struct unwind_engine *u = NULL;
> 	int err;
> 
> 	u = UNWINDABLE(u, err, device_create_file(&dev->dev,&dev_attr_options),
> 			device_remove_file, &dev->dev, &dev_attr_options);
> 	u = UNWINDABLE(u, err, device_create_file(&dev->dev,&dev_attr_id)
> 			device_remove_file, &dev->dev, &dev_attr_options);
> 	u = UNWINDABLE(u, err, device_create_file(&dev->dev,&dev_attr_id),
> 			device_remove_file, &dev->dev, &dev_attr_id);
> 	err = unwind(err, u);
> 	return err;
> }
> 
> and, umm,
> 
> #define UNWINDABLE(u, err, expr, undo_fn, arg1, arg2)
> 	if (err == 0) {
> 		err = (expr);
> 		if (err == 0)
> 			u = add_unwind(u, undo_fn, arg1, arg2);
> 	}
> 	u;
> 
> int unwind(int err, struct unwind_engine *u)
> {
> 	if (err == 0)
> 		return 0;
> 	for (all entries in u in opposite order) {
> 		u->fn(u->arg0, u>arg1);
> 		kfree(u);
> 	}
> 	return err;
> }
> 
> 
> I dunno - probably too crappy to live, but it'd encourage/help people to
> dtrt.

The best solution is to switch drivers with more than 2 attributes
to use arribute groups which collapses unwinding nicely.

-- 
Dmitry
