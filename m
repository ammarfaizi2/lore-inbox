Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264912AbUHFChi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264912AbUHFChi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 22:37:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268078AbUHFChi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 22:37:38 -0400
Received: from c3-1d224.neo.rr.com ([24.93.233.224]:29570 "EHLO neo.rr.com")
	by vger.kernel.org with ESMTP id S264912AbUHFCgn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 22:36:43 -0400
Date: Thu, 5 Aug 2004 22:28:20 +0000
From: Adam Belay <ambx1@neo.rr.com>
To: rmk@arm.linux.org.uk
Cc: linux@dominikbrodowski.de, akpm@osdl.org, rml@ximian.com,
       linux-kernel@vger.kernel.org, linux-pcmcia@lists.infradead.org
Subject: [PATCH] pcmcia driver model support [4/5]
Message-ID: <20040805222820.GE11641@neo.rr.com>
Mail-Followup-To: Adam Belay <ambx1@neo.rr.com>, rmk@arm.linux.org.uk,
	linux@dominikbrodowski.de, akpm@osdl.org, rml@ximian.com,
	linux-kernel@vger.kernel.org, linux-pcmcia@lists.infradead.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PCMCIA] fix eject lockup

It is not safe to use the skt_sem in pcmcia_validate_mem.  This patch fixes a
real world bug, and without it many systems will fail to shutdown properly. When
pcmcia-cs calls DS_EJECT_CARD, it creates a CS_EVENT_EJECTION_REQUEST event.
The event is then eventually reported to the ds.c client.  DS then informs
userspace of the ejection request and waits for userspace to reply with whether
the request was successful.  pcmcia-cs, in turn, calls DS_GET_FIRST_TUPLE while
verifying the ejection request.  Unfortunately, at this point the skt_sem
semaphore is already held by pcmcia_eject_card.  This results in the ds event
code waiting forever for skt_sem to become available.

--- a/drivers/pcmcia/rsrc_mgr.c	2004-08-05 13:05:45.000000000 +0000
+++ b/drivers/pcmcia/rsrc_mgr.c	2004-08-05 21:31:32.000000000 +0000
@@ -520,12 +520,8 @@
 
 void pcmcia_validate_mem(struct pcmcia_socket *s)
 {
-	down(&s->skt_sem);
-
 	if (probe_mem && s->state & SOCKET_PRESENT)
 		validate_mem(s);
-
-	up(&s->skt_sem);
 }
 
 EXPORT_SYMBOL(pcmcia_validate_mem);
