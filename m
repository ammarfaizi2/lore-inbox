Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263496AbTLJLHf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Dec 2003 06:07:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263500AbTLJLHf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Dec 2003 06:07:35 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.105]:13483 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263496AbTLJLHb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Dec 2003 06:07:31 -0500
Date: Wed, 10 Dec 2003 16:36:33 +0530
From: Maneesh Soni <maneesh@in.ibm.com>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: Matthew Reppert <repp0017@tc.umn.edu>,
       Guennadi Liakhovetski <gl@dsa-ac.de>,
       LKML <linux-kernel@vger.kernel.org>, Patrick Mochel <mochel@osdl.org>
Subject: Re: [OOPS] 2.6.0-test11 sysfs
Message-ID: <20031210110632.GA1314@in.ibm.com>
Reply-To: maneesh@in.ibm.com
References: <Pine.LNX.4.33.0312091826090.1130-100000@pcgl.dsa-ac.de> <1070992648.27231.7.camel@minerva> <20031209211440.A16651@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031209211440.A16651@flint.arm.linux.org.uk>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 09, 2003 at 09:19:52PM +0000, Russell King wrote:
> On Tue, Dec 09, 2003 at 11:57:28AM -0600, Matthew Reppert wrote:
> > Try this patch. (Patrick, is this the sane thing to do? And is it worth
> > it? If so, I can do similar things to the other sysfs_create_* functions
> > if you would like.)
> 
> Actually the "right" thing to do is to drop the file creation stuff from
> i82365; due to an interaction between sysfs and pcmcia, we can't register
> class device files in the initialisation path.
> 

Hi Russell,

How is the following patch? It moves the complete() call in the "pccardd" 
thread after class_device_register(), so that in init_i82365() when
pcmcia_register_socket() is done we are sure that class device is 
registered before creating the attribute files.

I must be missing lots of things as I could not understand the interaction
you mentioned, but still after seeing the code I did this patch. 

IMHO we should propogate the error code if returned by class_device_register(), 
back to pcmcia_register_socket() so that in case of error we can fail the 
pcmcia_registera_socket(). For this purpose, I used socket->driver_data() in
pccardd() and also checking it in pcmcia_register_socket(). 


Thanks
Maneesh



o pcmcia_register_socket() should be woken up only after registering the
  class device so that it doesnot create attribute files before registering
  the class device.

o The error, if returned from class_device_register() is propogated back
  to pcmcia_register_socket() using the ->driver_data field in the
  pcmcia_socket. pcmcia_register_socket() is failed if socket->driver_data
  has error in it, so that the driver init routine can process the failuer
  properly.



 drivers/pcmcia/cs.c |   16 +++++++++++-----
 1 files changed, 11 insertions(+), 5 deletions(-)

diff -puN drivers/pcmcia/cs.c~pcmcia-sysfs-initialisation-fix drivers/pcmcia/cs.c
--- linux-2.6.0-test11/drivers/pcmcia/cs.c~pcmcia-sysfs-initialisation-fix	2003-12-10 15:27:41.000000000 +0530
+++ linux-2.6.0-test11-maneesh/drivers/pcmcia/cs.c	2003-12-10 16:27:33.000000000 +0530
@@ -356,6 +356,10 @@ int pcmcia_register_socket(struct pcmcia
 
 	wait_for_completion(&socket->thread_done);
 	BUG_ON(!socket->thread);
+	if (IS_ERR(socket->driver_data)) {
+		ret = PTR_ERR(socket->driver_data);
+		goto err;
+	}
 	pcmcia_parse_events(socket, SS_DETECT);
 
 	return 0;
@@ -772,19 +776,21 @@ static int pccardd(void *__skt)
 
 	daemonize("pccardd");
 	skt->thread = current;
-	complete(&skt->thread_done);
-
-	skt->socket = dead_socket;
-	skt->ops->init(skt);
-	skt->ops->set_socket(skt, &skt->socket);
 
 	/* register with the device core */
 	ret = class_device_register(&skt->dev);
 	if (ret) {
 		printk(KERN_WARNING "PCMCIA: unable to register socket 0x%p\n",
 			skt);
+		skt->driver_data = ERR_PTR(ret);
 	}
 
+	complete(&skt->thread_done);
+
+	skt->socket = dead_socket;
+	skt->ops->init(skt);
+	skt->ops->set_socket(skt, &skt->socket);
+
 	add_wait_queue(&skt->thread_wait, &wait);
 	for (;;) {
 		unsigned long flags;

_

-- 
Maneesh Soni
Linux Technology Center, 
IBM Software Lab, Bangalore, India
email: maneesh@in.ibm.com
Phone: 91-80-5044999 Fax: 91-80-5268553
T/L : 9243696
