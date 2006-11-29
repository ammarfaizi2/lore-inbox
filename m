Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758338AbWK2WDu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758338AbWK2WDu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 17:03:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758284AbWK2WD0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 17:03:26 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:46548 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S1758270AbWK2WDQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 17:03:16 -0500
Message-Id: <20061129220453.517238000@sous-sol.org>
References: <20061129220111.137430000@sous-sol.org>
User-Agent: quilt/0.45-1
Date: Wed, 29 Nov 2006 14:00:23 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, torvalds@osdl.org, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, Daniel Ritz <daniel.ritz-ml@swissonline.ch>,
       Daniel Ritz <daniel.ritz@gmx.ch>,
       Dominik Brodowski <linux@dominikbrodowski.net>,
       Pavol Gono <Palo.Gono@gmail.com>
Subject: [patch 12/23] pcmcia: fix rmmod pcmcia with unbound devices
Content-Disposition: inline; filename=pcmcia-fix-rmmod-pcmcia-with-unbound-devices.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

From: Daniel Ritz <daniel.ritz-ml@swissonline.ch>

Having unbound PCMCIA devices: doing a 'find /sys' after a 'rmmod pcmcia'
gives an oops because the pcmcia_device is not unregisterd from the driver
core.

fixes bugzilla #7481

Signed-off-by: Daniel Ritz <daniel.ritz@gmx.ch>
Acked-by: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: Pavol Gono <Palo.Gono@gmail.com>
Cc: <stable@kernel.org>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Linus Torvalds <torvalds@osdl.org>
[chrisw: add subsequent mutex fix]
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
---
 drivers/pcmcia/ds.c |    5 +++++
 1 file changed, 5 insertions(+)

--- linux-2.6.18.4.orig/drivers/pcmcia/ds.c
+++ linux-2.6.18.4/drivers/pcmcia/ds.c
@@ -1264,6 +1264,11 @@ static void pcmcia_bus_remove_socket(str
 	socket->pcmcia_state.dead = 1;
 	pccard_register_pcmcia(socket, NULL);
 
+	/* unregister any unbound devices */
+	mutex_lock(&socket->skt_mutex);
+	pcmcia_card_remove(socket, NULL);
+	mutex_unlock(&socket->skt_mutex);
+
 	pcmcia_put_socket(socket);
 
 	return;

--
