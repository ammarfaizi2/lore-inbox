Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753335AbWKCQgx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753335AbWKCQgx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Nov 2006 11:36:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753358AbWKCQgx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Nov 2006 11:36:53 -0500
Received: from isilmar.linta.de ([213.239.214.66]:38584 "EHLO linta.de")
	by vger.kernel.org with ESMTP id S1753335AbWKCQgw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Nov 2006 11:36:52 -0500
Date: Fri, 3 Nov 2006 11:02:47 -0500
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: Romano Giannetti <romano.giannetti@gmail.com>
Cc: Pete Zaitcev <zaitcev@redhat.com>, linux-pcmcia@lists.infradead.org,
       fabrice@bellet.info, linux-kernel@vger.kernel.org
Subject: Re: pcmcia: patch to fix pccard_store_cis
Message-ID: <20061103160247.GB11160@dominikbrodowski.de>
Mail-Followup-To: Romano Giannetti <romano.giannetti@gmail.com>,
	Pete Zaitcev <zaitcev@redhat.com>, linux-pcmcia@lists.infradead.org,
	fabrice@bellet.info, linux-kernel@vger.kernel.org
References: <20061001122107.9260aa5d.zaitcev@redhat.com> <20061002003138.GB16938@isilmar.linta.de> <1159794094.8246.2.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1159794094.8246.2.camel@localhost>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Oct 02, 2006 at 03:01:34PM +0200, Romano Giannetti wrote:
> On Mon, 2006-10-02 at 02:31 +0200, Dominik Brodowski wrote:
> > Hi,
> > 
> > On Sun, Oct 01, 2006 at 12:21:07PM -0700, Pete Zaitcev wrote:
> > > The ``ret'' obviously cannot be zero here, because it's initialized to the
> > > write count and not zero.
> > 
> > Thanks -- Linus was faster, though, and already applied his patch to the
> > linux-2.6 git tree. Regarding the other issue seen in RH bug# 207910, I'll
> > try to take a look at it soon.
> 
> BTW: I had the same problem, reported here: 
> 
> https://launchpad.net/distros/ubuntu/+source/pcmciautils/+bug/52510
> 
> and here: 
> 
> http://lists.infradead.org/pipermail/linux-pcmcia/2006-August/003893.html
> 
> and my modem did work without IRQ problems after I got rid of .cis and
> started (obsolete) cardmgr. Just as a data point more... 

Does it work again (after re-copying the cis file to /lib/firmware) when
you use this patch?

Thanks,
	Dominik

>From 4bb59569454f09e8bfc3a0f7bbdef46ccc7a51e0 Mon Sep 17 00:00:00 2001
From: Dominik Brodowski <linux@dominikbrodowski.net>
Date: Fri, 3 Nov 2006 10:54:00 -0500
Subject: [PATCH] pcmcia: start over after CIS override

When overriding the CIS, re-start the configuration of the card from
scratch. Reported and debugged by Fabrice Bellet <fabrice@bellet.info>

Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
---
 drivers/pcmcia/cs_internal.h  |    2 +-
 drivers/pcmcia/ds.c           |   12 ++++++++----
 drivers/pcmcia/socket_sysfs.c |    4 ++--
 3 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/pcmcia/cs_internal.h b/drivers/pcmcia/cs_internal.h
index d6164cd..f573ea0 100644
--- a/drivers/pcmcia/cs_internal.h
+++ b/drivers/pcmcia/cs_internal.h
@@ -135,7 +135,7 @@ int pccard_get_status(struct pcmcia_sock
 struct pcmcia_callback{
 	struct module	*owner;
 	int		(*event) (struct pcmcia_socket *s, event_t event, int priority);
-	void		(*requery) (struct pcmcia_socket *s);
+	void		(*requery) (struct pcmcia_socket *s, int new_cis);
 	int		(*suspend) (struct pcmcia_socket *s);
 	int		(*resume) (struct pcmcia_socket *s);
 };
diff --git a/drivers/pcmcia/ds.c b/drivers/pcmcia/ds.c
index 0f70192..3fe4d31 100644
--- a/drivers/pcmcia/ds.c
+++ b/drivers/pcmcia/ds.c
@@ -714,22 +714,26 @@ static int pcmcia_requery(struct device
 	return 0;
 }
 
-static void pcmcia_bus_rescan(struct pcmcia_socket *skt)
+static void pcmcia_bus_rescan(struct pcmcia_socket *skt, int new_cis)
 {
-	int no_devices=0;
+	int no_devices = 0;
 	int ret = 0;
 	unsigned long flags;
 
 	/* must be called with skt_mutex held */
 	spin_lock_irqsave(&pcmcia_dev_list_lock, flags);
 	if (list_empty(&skt->devices_list))
-		no_devices=1;
+		no_devices = 1;
 	spin_unlock_irqrestore(&pcmcia_dev_list_lock, flags);
 
+	/* If this is because of a CIS override, start over */
+	if (new_cis && !no_devices)
+		pcmcia_card_remove(skt, NULL);
+
 	/* if no devices were added for this socket yet because of
 	 * missing resource information or other trouble, we need to
 	 * do this now. */
-	if (no_devices) {
+	if (no_devices || new_cis) {
 		ret = pcmcia_card_add(skt);
 		if (ret)
 			return;
diff --git a/drivers/pcmcia/socket_sysfs.c b/drivers/pcmcia/socket_sysfs.c
index 933cd86..b005602 100644
--- a/drivers/pcmcia/socket_sysfs.c
+++ b/drivers/pcmcia/socket_sysfs.c
@@ -188,7 +188,7 @@ static ssize_t pccard_store_resource(str
 	    (s->state & SOCKET_PRESENT) &&
 	    !(s->state & SOCKET_CARDBUS)) {
 		if (try_module_get(s->callback->owner)) {
-			s->callback->requery(s);
+			s->callback->requery(s, 0);
 			module_put(s->callback->owner);
 		}
 	}
@@ -325,7 +325,7 @@ static ssize_t pccard_store_cis(struct k
 	if ((s->callback) && (s->state & SOCKET_PRESENT) &&
 	    !(s->state & SOCKET_CARDBUS)) {
 		if (try_module_get(s->callback->owner)) {
-			s->callback->requery(s);
+			s->callback->requery(s, 1);
 			module_put(s->callback->owner);
 		}
 	}
-- 
1.4.3.3

