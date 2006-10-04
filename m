Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030408AbWJDGlL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030408AbWJDGlL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 02:41:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030399AbWJDGlK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 02:41:10 -0400
Received: from mx10.go2.pl ([193.17.41.74]:11172 "EHLO poczta.o2.pl")
	by vger.kernel.org with ESMTP id S1030408AbWJDGlJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 02:41:09 -0400
Date: Wed, 4 Oct 2006 08:45:43 +0200
From: Jarek Poplawski <jarkao2@o2.pl>
To: Greg KH <gregkh@suse.de>
Cc: "Axel C\. Voigt" <Axel.Voigt@qosmotec.com>, linux-kernel@vger.kernel.org,
       David Kubicek <dave@awk.cz>
Subject: Re: Problems with hard irq? (inconsistent lock state)
Message-ID: <20061004064542.GA2649@ff.dom.local>
Mail-Followup-To: Jarek Poplawski <jarkao2@o2.pl>, Greg KH <gregkh@suse.de>,
	"Axel C. Voigt" <Axel.Voigt@qosmotec.com>,
	linux-kernel@vger.kernel.org, David Kubicek <dave@awk.cz>
References: <46E81D405FFAC240826E54028B3B02953B13@aixlac.qosmotec.com> <20061004054308.GA994@ff.dom.local> <20061004054309.GA387@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061004054309.GA387@suse.de>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 03, 2006 at 10:43:09PM -0700, Greg KH wrote:
> On Wed, Oct 04, 2006 at 07:43:08AM +0200, Jarek Poplawski wrote:
> > On 29-09-2006 13:45, Axel C. Voigt wrote:
...
> > > Sep 29 13:29:53 mcs70 kernel: =================================
> > > Sep 29 13:29:53 mcs70 kernel: [ INFO: inconsistent lock state ]
> > > Sep 29 13:29:53 mcs70 kernel: ---------------------------------
> > > Sep 29 13:29:53 mcs70 kernel: inconsistent {hardirq-on-W} -> {in-hardirq-W} usage.
> > > Sep 29 13:29:53 mcs70 kernel: startDV24/3864 [HC1[1]:SC0[0]:HE0:SE1] takes:
> > > Sep 29 13:29:53 mcs70 kernel: (&acm->read_lock){++..}, at: [<e08952d8>] acm_read_bulk+0x60/0xde [cdc_acm]
> > > Sep 29 13:29:53 mcs70 kernel: {hardirq-on-W} state was registered at:
...
> > It looks in drivers/usb/class/cdc-acm.c acm_rx_tasklet could be preempted
> > with acm->read_lock by acm_read_bulk which uses the same lock from hardirq
> > context.
> > 
> > So probably spin_lock_irqsave is needed.  
> 
> Yup.  Care to send a patch?

If it could help?

Jarek P.


diff -Nurp linux-2.6-18-git20-/drivers/usb/class/cdc-acm.c linux-2.6-18-git20/drivers/usb/class/cdc-acm.c
--- linux-2.6-18-git20-/drivers/usb/class/cdc-acm.c	2006-10-04 07:59:46.000000000 +0200
+++ linux-2.6-18-git20/drivers/usb/class/cdc-acm.c	2006-10-04 08:16:03.000000000 +0200
@@ -325,7 +325,7 @@ static void acm_rx_tasklet(unsigned long
 	struct acm_rb *buf;
 	struct tty_struct *tty = acm->tty;
 	struct acm_ru *rcv;
-	//unsigned long flags;
+	unsigned long flags;
 	int i = 0;
 	dbg("Entering acm_rx_tasklet");
 
@@ -333,15 +333,15 @@ static void acm_rx_tasklet(unsigned long
 		return;
 
 next_buffer:
-	spin_lock(&acm->read_lock);
+	spin_lock_irqsave(&acm->read_lock, flags);
 	if (list_empty(&acm->filled_read_bufs)) {
-		spin_unlock(&acm->read_lock);
+		spin_unlock_irqrestore(&acm->read_lock, flags);
 		goto urbs;
 	}
 	buf = list_entry(acm->filled_read_bufs.next,
 			 struct acm_rb, list);
 	list_del(&buf->list);
-	spin_unlock(&acm->read_lock);
+	spin_unlock_irqrestore(&acm->read_lock, flags);
 
 	dbg("acm_rx_tasklet: procesing buf 0x%p, size = %d", buf, buf->size);
 
@@ -356,29 +356,29 @@ next_buffer:
 		memmove(buf->base, buf->base + i, buf->size - i);
 		buf->size -= i;
 		spin_unlock(&acm->throttle_lock);
-		spin_lock(&acm->read_lock);
+		spin_lock_irqsave(&acm->read_lock, flags);
 		list_add(&buf->list, &acm->filled_read_bufs);
-		spin_unlock(&acm->read_lock);
+		spin_unlock_irqrestore(&acm->read_lock, flags);
 		return;
 	}
 	spin_unlock(&acm->throttle_lock);
 
-	spin_lock(&acm->read_lock);
+	spin_lock_irqsave(&acm->read_lock, flags);
 	list_add(&buf->list, &acm->spare_read_bufs);
-	spin_unlock(&acm->read_lock);
+	spin_unlock_irqrestore(&acm->read_lock, flags);
 	goto next_buffer;
 
 urbs:
 	while (!list_empty(&acm->spare_read_bufs)) {
-		spin_lock(&acm->read_lock);
+		spin_lock_irqsave(&acm->read_lock, flags);
 		if (list_empty(&acm->spare_read_urbs)) {
-			spin_unlock(&acm->read_lock);
+			spin_unlock_irqrestore(&acm->read_lock, flags);
 			return;
 		}
 		rcv = list_entry(acm->spare_read_urbs.next,
 				 struct acm_ru, list);
 		list_del(&rcv->list);
-		spin_unlock(&acm->read_lock);
+		spin_unlock_irqrestore(&acm->read_lock, flags);
 
 		buf = list_entry(acm->spare_read_bufs.next,
 				 struct acm_rb, list);
@@ -400,9 +400,9 @@ urbs:
 		   free-urbs-pool and resubmited ASAP */
 		if (usb_submit_urb(rcv->urb, GFP_ATOMIC) < 0) {
 			list_add(&buf->list, &acm->spare_read_bufs);
-			spin_lock(&acm->read_lock);
+			spin_lock_irqsave(&acm->read_lock, flags);
 			list_add(&rcv->list, &acm->spare_read_urbs);
-			spin_unlock(&acm->read_lock);
+			spin_unlock_irqrestore(&acm->read_lock, flags);
 			return;
 		}
 	}
