Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964904AbWFNNDL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964904AbWFNNDL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jun 2006 09:03:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964905AbWFNNDL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jun 2006 09:03:11 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:17361 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S964904AbWFNNDJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jun 2006 09:03:09 -0400
Date: Wed, 14 Jun 2006 08:01:26 -0500
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: linux-pcmcia@lists.infradead.org, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] kthread: convert pcmcia_cs from kernel_thread
Message-ID: <20060614130126.GI15061@sergelap.austin.ibm.com>
References: <20060614120637.GD15061@sergelap.austin.ibm.com> <20060614124535.GA14062@isilmar.linta.de> <20060614125048.GH15061@sergelap.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060614125048.GH15061@sergelap.austin.ibm.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Serge E. Hallyn (serue@us.ibm.com):
> Quoting Dominik Brodowski (linux@dominikbrodowski.net):
> > On Wed, Jun 14, 2006 at 07:06:37AM -0500, Serge E. Hallyn wrote:
> > > Convert pcmcia_cs to use kthread instead of the deprecated
> > > kernel_thread.
> > 
> > Nack.
> > 
> > See
> > http://lists.infradead.org/pipermail/linux-pcmcia/2006-February/003259.html
> > or http://lkml.org/lkml/2006/2/14/395 for details.
> 
> Ok - so if we keep the thread_done completion in front of the main
> loop in pccardd to check for that error, will that be sufficient?

I.e., like so:

Subject: [PATCH] kthread: convert pcmcia_cs from kernel_thread

Convert pcmcia_cs to use kthread instead of the deprecated
kernel_thread.

Signed-off-by: Serge E. Hallyn <serue@us.ibm.com>

---

 drivers/pcmcia/cs.c |   24 +++++++++++++-----------
 1 files changed, 13 insertions(+), 11 deletions(-)

b84aa23a2efeeeef0a53220f93fa36a9f35708f8
diff --git a/drivers/pcmcia/cs.c b/drivers/pcmcia/cs.c
index 3162998..06e2cda 100644
--- a/drivers/pcmcia/cs.c
+++ b/drivers/pcmcia/cs.c
@@ -28,6 +28,7 @@ #include <linux/delay.h>
 #include <linux/pm.h>
 #include <linux/pci.h>
 #include <linux/device.h>
+#include <linux/kthread.h>
 #include <asm/system.h>
 #include <asm/irq.h>
 
@@ -176,6 +177,7 @@ static int pccardd(void *__skt);
  */
 int pcmcia_register_socket(struct pcmcia_socket *socket)
 {
+	struct task_struct *tsk;
 	int ret;
 
 	if (!socket || !socket->ops || !socket->dev.dev || !socket->resource_ops)
@@ -239,15 +241,18 @@ #endif
 	mutex_init(&socket->skt_mutex);
 	spin_lock_init(&socket->thread_lock);
 
-	ret = kernel_thread(pccardd, socket, CLONE_KERNEL);
-	if (ret < 0)
+	tsk = kthread_run(pccardd, socket, "pccardd");
+	if (IS_ERR(tsk)) {
+		ret = PTR_ERR(tsk);
 		goto err;
+	}
 
 	wait_for_completion(&socket->thread_done);
-	if(!socket->thread) {
+	if (!socket->thread) {
 		printk(KERN_WARNING "PCMCIA: warning: socket thread for socket %p did not start\n", socket);
 		return -EIO;
 	}
+
 	pcmcia_parse_events(socket, SS_DETECT);
 
 	return 0;
@@ -272,10 +277,8 @@ void pcmcia_unregister_socket(struct pcm
 	cs_dbg(socket, 0, "pcmcia_unregister_socket(0x%p)\n", socket->ops);
 
 	if (socket->thread) {
-		init_completion(&socket->thread_done);
-		socket->thread = NULL;
 		wake_up(&socket->thread_wait);
-		wait_for_completion(&socket->thread_done);
+		kthread_stop(socket->thread);
 	}
 	release_cis_mem(socket);
 
@@ -630,8 +633,6 @@ static int pccardd(void *__skt)
 	DECLARE_WAITQUEUE(wait, current);
 	int ret;
 
-	daemonize("pccardd");
-
 	skt->thread = current;
 	skt->socket = dead_socket;
 	skt->ops->init(skt);
@@ -643,7 +644,8 @@ static int pccardd(void *__skt)
 		printk(KERN_WARNING "PCMCIA: unable to register socket 0x%p\n",
 			skt);
 		skt->thread = NULL;
-		complete_and_exit(&skt->thread_done, 0);
+		complete(&skt->thread_done);
+		return 0;
 	}
 
 	add_wait_queue(&skt->thread_wait, &wait);
@@ -674,7 +676,7 @@ static int pccardd(void *__skt)
 			continue;
 		}
 
-		if (!skt->thread)
+		if (kthread_should_stop())
 			break;
 
 		schedule();
@@ -688,7 +690,7 @@ static int pccardd(void *__skt)
 	/* remove from the device core */
 	class_device_unregister(&skt->dev);
 
-	complete_and_exit(&skt->thread_done, 0);
+	return 0;
 }
 
 /*
-- 
1.3.3

