Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269634AbUJGBxY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269634AbUJGBxY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 21:53:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269640AbUJGBxX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 21:53:23 -0400
Received: from mx1.redhat.com ([66.187.233.31]:48824 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S269634AbUJGBxS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 21:53:18 -0400
Date: Wed, 6 Oct 2004 18:53:05 -0700
From: Pete Zaitcev <zaitcev@redhat.com>
To: Soeren Sonnenburg <kernel@nn7.de>, linux-kernel@vger.kernel.org
Subject: Re: linux 2.6.9-rc3: ub oops on device removal
Message-ID: <20041006185305.3c8bbb29@lembas.zaitcev.lan>
In-Reply-To: <mailman.1097092751.17005.linux-kernel2news@redhat.com>
References: <mailman.1097092751.17005.linux-kernel2news@redhat.com>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed-Claws 0.9.12cvs119.1 (GTK+ 2.4.7; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 06 Oct 2004 21:50:06 +0200
Soeren Sonnenburg <kernel@nn7.de> wrote:

> I get this oops on kernel 2.6.9-rc3 on a 15" powerbook.
> 
> xmon trace screenshot is at:
> http://fortknox.dyndns.org/pics/oopses/ub.jpg

First you need to use -rc3-mm2 (it has some fixes), and then
add the appended patch which fixes your problem specifically.
The ub in 2.6.9-rc3 is not useable without these fixes.

-- Pete

--- linux-2.6.9-rc3-mm2/drivers/block/ub.c	2004-10-04 16:59:35.000000000 -0700
+++ linux-2.6.9-rc3-mm2-ub/drivers/block/ub.c	2004-10-04 17:01:08.000000000 -0700
@@ -842,7 +842,6 @@
 {
 	struct ub_dev *sc = urb->context;
 
-	del_timer(&sc->work_timer);
 	ub_complete(&sc->work_done);
 	tasklet_schedule(&sc->tasklet);
 }
@@ -853,6 +852,7 @@
 	unsigned long flags;
 
 	spin_lock_irqsave(&sc->lock, flags);
+	del_timer(&sc->work_timer);
 	ub_scsi_dispatch(sc);
 	spin_unlock_irqrestore(&sc->lock, flags);
 }
