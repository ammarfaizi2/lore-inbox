Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129538AbQJ2VUz>; Sun, 29 Oct 2000 16:20:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129662AbQJ2VUf>; Sun, 29 Oct 2000 16:20:35 -0500
Received: from 213.237.12.194.adsl.brh.worldonline.dk ([213.237.12.194]:10327
	"HELO firewall.jaquet.dk") by vger.kernel.org with SMTP
	id <S129556AbQJ2VUc>; Sun, 29 Oct 2000 16:20:32 -0500
Date: Sun, 29 Oct 2000 23:12:57 +0100
From: Rasmus Andersen <rasmus@jaquet.dk>
To: Arjan van de Ven <arjan@fenrus.demon.nl>
Cc: linux-kernel@vger.kernel.org, dhinds@zen.stanford.edu, corey@world.std.com
Subject: Re: Compile error in drivers/ide/osb4.c in 240-t10p6
Message-ID: <20001029231257.J625@jaquet.dk>
In-Reply-To: <20001029144822.B622@jaquet.dk> <m13psPR-000OXnC@amadeus.home.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <m13psPR-000OXnC@amadeus.home.nl>; from arjan@fenrus.demon.nl on Sun, Oct 29, 2000 at 02:22:01PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This patch, and a lot of others of a similar nature, are in my test10pre6
> compile patch at 
[snip]

(Added a bit to the cc list)

Hi Arjan.

Thanks for the pointer. However my test build still barfs in the final
link phase because we (in t10p6) morphed drivers/pcmcia/cs.c::pcmcia_
request_irq into (the static) cs_request_irq. The rename part
broke the two other places in cs.c where pcmcia_request_irq was
referenced and the static part made its usage in drivers/net/pcmcia/
ray_cs.c a bit awkward.

Since I won't presume to question the decision to rename the function
the following patch propagates the rename to the rest of the kernel.
Furthermore, I presumed to remove the static part so that the ray_cs
driver was free to use it. I have added David Hinds and Corey Thomas
(the raylink driver maintainer) to the cc on this mail so they can
decide what the proper solution is.

Meanwhile, this patch makes my test kernel build:


--- linux-240-t10p6-clean/drivers/pcmcia/cs.c	Sun Oct 29 09:51:13 2000
+++ linux/drivers/pcmcia/cs.c	Sun Oct 29 22:52:22 2000
@@ -1836,7 +1836,7 @@
     
 ======================================================================*/
 
-static int cs_request_irq(client_handle_t handle, irq_req_t *req)
+int cs_request_irq(client_handle_t handle, irq_req_t *req)
 {
     socket_info_t *s;
     config_t *c;
@@ -2284,7 +2284,7 @@
     case RequestIO:
 	return pcmcia_request_io(a1, a2); break;
     case RequestIRQ:
-	return pcmcia_request_irq(a1, a2); break;
+	return cs_request_irq(a1, a2); break;
     case RequestWindow:
     {
 	window_handle_t w;
@@ -2376,7 +2376,7 @@
 EXPORT_SYMBOL(pcmcia_report_error);
 EXPORT_SYMBOL(pcmcia_request_configuration);
 EXPORT_SYMBOL(pcmcia_request_io);
-EXPORT_SYMBOL(pcmcia_request_irq);
+EXPORT_SYMBOL(cs_request_irq);
 EXPORT_SYMBOL(pcmcia_request_window);
 EXPORT_SYMBOL(pcmcia_reset_card);
 EXPORT_SYMBOL(pcmcia_resume_card);
--- linux-240-t10p6-clean/drivers/net/pcmcia/ray_cs.c	Sun Oct 29 09:49:52 2000
+++ linux/drivers/net/pcmcia/ray_cs.c	Sun Oct 29 22:52:53 2000
@@ -560,7 +560,7 @@
     /* Now allocate an interrupt line.  Note that this does not
        actually assign a handler to the interrupt.
     */
-    CS_CHECK(pcmcia_request_irq, link->handle, &link->irq);
+    CS_CHECK(cs_request_irq, link->handle, &link->irq);
     dev->irq = link->irq.AssignedIRQ;
     
     /* This actually configures the PCMCIA socket -- setting up

-- 
Regards,
        Rasmus(rasmus@jaquet.dk)

"God prevent we should ever be twenty years without a revolution." 
  -- Thomas Jefferson
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
