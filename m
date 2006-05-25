Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964795AbWEYBQd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964795AbWEYBQd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 May 2006 21:16:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964796AbWEYBQd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 May 2006 21:16:33 -0400
Received: from py-out-1112.google.com ([64.233.166.177]:5413 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S964795AbWEYBQc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 May 2006 21:16:32 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:content-type:content-transfer-encoding;
        b=GUJYHAmgT8l9MaVTCRKTH50hdsJqyFL2ZTIt+9CwEKTkFValeo4NECfs6mYXOipd53WmDarYNbE6EKawobAiepKdkl+45P/0j/+atrZoVqR06D6cRabRymiBU09D2anUA3H5Rllw4SfVJ70f0YLFmy109mvlQydchdKGqpQa9zk=
Message-ID: <4475069B.9060100@gmail.com>
Date: Wed, 24 May 2006 21:21:31 -0400
From: Florin Malita <fmalita@gmail.com>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: linux-pcmcia@lists.infradead.org
CC: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] PCMCIA: missing pcmcia_get_socket() result check
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The result of pcmcia_get_socket() may be NULL but ds_event() uses it
without checking.

Coverity CID: 436.

Signed-off-by: Florin Malita <fmalita@gmail.com>
---

diff --git a/drivers/pcmcia/ds.c b/drivers/pcmcia/ds.c
index 48d3b3d..74b3124 100644
--- a/drivers/pcmcia/ds.c
+++ b/drivers/pcmcia/ds.c
@@ -1143,6 +1143,12 @@ static int ds_event(struct pcmcia_socket
 {
 	struct pcmcia_socket *s = pcmcia_get_socket(skt);
 
+	if (!s) {
+		printk(KERN_ERR "PCMCIA obtaining reference to socket %p " \
+			"failed, event 0x%x lost!\n", skt, event);
+		return -ENODEV;
+	}
+
 	ds_dbg(1, "ds_event(0x%06x, %d, 0x%p)\n",
 	       event, priority, skt);
 


