Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932600AbVJCVsG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932600AbVJCVsG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Oct 2005 17:48:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932696AbVJCVsF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Oct 2005 17:48:05 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:12474 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932600AbVJCVsE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Oct 2005 17:48:04 -0400
Date: Mon, 3 Oct 2005 23:45:42 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@osdl.org>, rpurdie@rpsys.net, lenz@cs.wisc.edu,
       kernel list <linux-kernel@vger.kernel.org>,
       Russell King <rmk@arm.linux.org.uk>
Subject: [zaurus] fix soc_common.c
Message-ID: <20051003214542.GA7501@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes wrong comments, non-working debug subsystem, and some
potentially dangerous macros.

Signed-off-by: Pavel Machek <pavel@suse.cz>

diff --git a/drivers/pcmcia/soc_common.c b/drivers/pcmcia/soc_common.c
--- a/drivers/pcmcia/soc_common.c
+++ b/drivers/pcmcia/soc_common.c
@@ -66,7 +67,7 @@ void soc_pcmcia_debug(struct soc_pcmcia_
 	if (pc_debug > lvl) {
 		printk(KERN_DEBUG "skt%u: %s: ", skt->nr, func);
 		va_start(args, fmt);
-		printk(fmt, args);
+		vprintk(fmt, args);
 		va_end(args);
 	}
 }
@@ -321,8 +322,6 @@ soc_common_pcmcia_get_socket(struct pcmc
  * less punt all of this work and let the kernel handle the details
  * of power configuration, reset, &c. We also record the value of
  * `state' in order to regurgitate it to the PCMCIA core later.
- *
- * Returns: 0
  */
 static int
 soc_common_pcmcia_set_socket(struct pcmcia_socket *sock, socket_state_t *state)
@@ -407,7 +406,7 @@ soc_common_pcmcia_set_io_map(struct pcmc
  * the map speed as requested, but override the address ranges
  * supplied by Card Services.
  *
- * Returns: 0 on success, -1 on error
+ * Returns: 0 on success, -ERRNO on error
  */
 static int
 soc_common_pcmcia_set_mem_map(struct pcmcia_socket *sock, struct pccard_mem_map *map)
@@ -655,8 +654,8 @@ static void soc_pcmcia_cpufreq_unregiste
 }
 
 #else
-#define soc_pcmcia_cpufreq_register()
-#define soc_pcmcia_cpufreq_unregister()
+static int soc_pcmcia_cpufreq_register(void) { return 0; }
+static void soc_pcmcia_cpufreq_unregister(void) {}
 #endif
 
 int soc_common_drv_pcmcia_probe(struct device *dev, struct pcmcia_low_level *ops, int first, int nr)
@@ -738,7 +737,7 @@ int soc_common_drv_pcmcia_probe(struct d
 			goto out_err_5;
 		}
 
-		if ( list_empty(&soc_pcmcia_sockets) )
+		if (list_empty(&soc_pcmcia_sockets))
 			soc_pcmcia_cpufreq_register();
 
 		list_add(&skt->node, &soc_pcmcia_sockets);
@@ -839,7 +838,7 @@ int soc_common_drv_pcmcia_remove(struct 
 		release_resource(&skt->res_io);
 		release_resource(&skt->res_skt);
 	}
-	if ( list_empty(&soc_pcmcia_sockets) )
+	if (list_empty(&soc_pcmcia_sockets))
 		soc_pcmcia_cpufreq_unregister();
 
 	up(&soc_pcmcia_sockets_lock);

-- 
if you have sharp zaurus hardware you don't need... you know my address
