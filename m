Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751790AbWCLW6M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751790AbWCLW6M (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Mar 2006 17:58:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751789AbWCLW6L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Mar 2006 17:58:11 -0500
Received: from smtp.osdl.org ([65.172.181.4]:46044 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751853AbWCLW6J (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Mar 2006 17:58:09 -0500
Date: Sun, 12 Mar 2006 14:55:43 -0800
From: Andrew Morton <akpm@osdl.org>
To: Kay Sievers <kay.sievers@vrfy.org>
Cc: drzeus-list@drzeus.cx, ambx1@neo.rr.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [PNP] 'modalias' sysfs export
Message-Id: <20060312145543.194f4dc7.akpm@osdl.org>
In-Reply-To: <20060312172332.GA10278@vrfy.org>
References: <20060227214018.3937.14572.stgit@poseidon.drzeus.cx>
	<20060301194532.GB25907@vrfy.org>
	<4406AF27.9040700@drzeus.cx>
	<20060302165816.GA13127@vrfy.org>
	<44082E14.5010201@drzeus.cx>
	<4412F53B.5010309@drzeus.cx>
	<20060311173847.23838981.akpm@osdl.org>
	<4414033F.2000205@drzeus.cx>
	<20060312172332.GA10278@vrfy.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kay Sievers <kay.sievers@vrfy.org> wrote:
>
> On Sun, Mar 12, 2006 at 12:17:19PM +0100, Pierre Ossman wrote:
> > Andrew Morton wrote:
> > > I assume you mean that the drivers/pnp/card.c patch of
> > > pnp-modalias-sysfs-export.patch needs to be removed and this patch applies
> > > on top of the result.
> > >
> > > But I don't want to break udev.
> > >   
> > 
> > I suppose I wasn't entirely clear there. I'd like you to do the first
> > part (remove the card.c part), but not apply this second patch. I just
> > sent that in as a means of getting the ball rolling again.
> 
> Again, multiline sysfs modalias files are not going to happen. Find a
> sane way to encode the list of devices into a single string, or don't do
> it at all. And it must be available in the event environment too.
> 
> > The reason I'm pushing this issue is that Red Hat decided to drop all
> > magical scripts that figured out what modules to load and instead only
> > use the modalias attribute. They consider the right way to go is to get
> > the PNP layer to export modalias, so that's what I'm trying to do.
> 
> There is no need to rush out with this half-baken solution. This simple
> udev rule does the job for you, if you want pnp module autoloading with
> the current kernel:
>   SUBSYSTEM=="pnp", RUN+="/bin/sh -c 'while read id; do /sbin/modprobe pnp:d$$id; done < /sys$devpath/id'"
> 
> Andrew, please make sure, that this patch does not hit mainline until
> there is a _sane_ solution to the multiple id's exported for a single
> device problem.
> 

The only patch I presently have is:

--- devel/drivers/pnp/interface.c~pnp-modalias-sysfs-export	2006-03-12 03:27:01.000000000 -0800
+++ devel-akpm/drivers/pnp/interface.c	2006-03-12 03:27:01.000000000 -0800
@@ -459,10 +459,22 @@ static ssize_t pnp_show_current_ids(stru
 
 static DEVICE_ATTR(id,S_IRUGO,pnp_show_current_ids,NULL);
 
+static ssize_t pnp_modalias_show(struct device *dmdev, struct device_attribute *attr, char *buf)
+{
+	struct pnp_dev *dev = to_pnp_dev(dmdev);
+	struct pnp_id * pos = dev->id;
+
+	/* FIXME: modalias can only do one alias */
+	return sprintf(buf, "pnp:d%s\n", pos->id);
+}
+
+static DEVICE_ATTR(modalias,S_IRUGO,pnp_modalias_show,NULL);
+
 int pnp_interface_attach_device(struct pnp_dev *dev)
 {
 	device_create_file(&dev->dev,&dev_attr_options);
 	device_create_file(&dev->dev,&dev_attr_resources);
 	device_create_file(&dev->dev,&dev_attr_id);
+	device_create_file(&dev->dev,&dev_attr_modalias);
 	return 0;
 }
_

Is that OK?
