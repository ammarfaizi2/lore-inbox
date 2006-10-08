Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751392AbWJHUzq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751392AbWJHUzq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Oct 2006 16:55:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751393AbWJHUzq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Oct 2006 16:55:46 -0400
Received: from smtp.osdl.org ([65.172.181.4]:45504 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751392AbWJHUzp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Oct 2006 16:55:45 -0400
Date: Sun, 8 Oct 2006 13:55:36 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Om Narasimhan" <om.turyx@gmail.com>
Cc: "Yoichi Yuasa" <yoichi_yuasa@tripeaks.co.jp>, linux-kernel@vger.kernel.org,
       Dominik Brodowski <linux@dominikbrodowski.net>
Subject: Re: fixed PCMCIA au1000_generic.c potential crash.
Message-Id: <20061008135536.07b60db6.akpm@osdl.org>
In-Reply-To: <6b4e42d10610071626v22ca2dafpd88d689429313a98@mail.gmail.com>
References: <6b4e42d10610071626v22ca2dafpd88d689429313a98@mail.gmail.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 7 Oct 2006 16:26:40 -0700
"Om Narasimhan" <om.turyx@gmail.com> wrote:

> Please find the corrected patch.

The patch is wordwrapped, has spaces replaced by tabs and each version is
subtly different from its predecessor.  This confuses me.

Please confirm that the below is the appropriate and final patch, thanks.



From: "Om Narasimhan" <om.turyx@gmail.com>

The previous code did something like,

if (error) goto out_err;
....
do {
             struct au1000_pcmcia_socket *skt = PCMCIA_SOCKET(i);
              del_timer_sync(&skt->poll_timer);
               pcmcia_unregister_socket(&skt->socket);
out_err:
               flush_scheduled_work();
               ops->hw_shutdown(skt);
               i--;
} while (i > 0)
.....


- On the error path, skt would not contain a valid value for the first
  iteration (skt is masked by uninitialized automatic skt)

- Does not do hw_shutdown() for 0th element of PCMCIA_SOCKET

Signed-off-by: Om Narasimhan <om.turyx@gmail.com>
Cc: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: "Yoichi Yuasa" <yoichi_yuasa@tripeaks.co.jp>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 drivers/pcmcia/au1000_generic.c |   15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff -puN drivers/pcmcia/au1000_generic.c~pcmcia-au1000_generic-fix drivers/pcmcia/au1000_generic.c
--- a/drivers/pcmcia/au1000_generic.c~pcmcia-au1000_generic-fix
+++ a/drivers/pcmcia/au1000_generic.c
@@ -351,6 +351,7 @@ struct skt_dev_info {
 int au1x00_pcmcia_socket_probe(struct device *dev, struct pcmcia_low_level *ops, int first, int nr)
 {
 	struct skt_dev_info *sinfo;
+	struct au1000_pcmcia_socket *skt;
 	int ret, i;
 
 	sinfo = kzalloc(sizeof(struct skt_dev_info), GFP_KERNEL);
@@ -365,7 +366,7 @@ int au1x00_pcmcia_socket_probe(struct de
 	 * Initialise the per-socket structure.
 	 */
 	for (i = 0; i < nr; i++) {
-		struct au1000_pcmcia_socket *skt = PCMCIA_SOCKET(i);
+		skt = PCMCIA_SOCKET(i);
 		memset(skt, 0, sizeof(*skt));
 
 		skt->socket.resource_ops = &pccard_static_ops;
@@ -438,17 +439,19 @@ int au1x00_pcmcia_socket_probe(struct de
 	dev_set_drvdata(dev, sinfo);
 	return 0;
 
-	do {
-		struct au1000_pcmcia_socket *skt = PCMCIA_SOCKET(i);
+
+out_err:
+	flush_scheduled_work();
+	ops->hw_shutdown(skt);
+	while (i-- > 0) {
+		skt = PCMCIA_SOCKET(i);
 
 		del_timer_sync(&skt->poll_timer);
 		pcmcia_unregister_socket(&skt->socket);
-out_err:
 		flush_scheduled_work();
 		ops->hw_shutdown(skt);
 
-		i--;
-	} while (i > 0);
+	}
 	kfree(sinfo);
 out:
 	return ret;
_

