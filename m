Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932425AbWF3RgK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932425AbWF3RgK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jun 2006 13:36:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932854AbWF3RgK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jun 2006 13:36:10 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:5331 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932849AbWF3RgI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jun 2006 13:36:08 -0400
Subject: Re: 2.6.17-mm4
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Dave Jones <davej@redhat.com>
Cc: Arjan van de Ven <arjan@infradead.org>, Ingo Molnar <mingo@elte.hu>,
       Michal Piotrowski <michal.k.k.piotrowski@gmail.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
In-Reply-To: <20060630172713.GH32729@redhat.com>
References: <20060629013643.4b47e8bd.akpm@osdl.org>
	 <6bffcb0e0606291339s69a16bc5ie108c0b8d4e29ed6@mail.gmail.com>
	 <20060629204330.GC13619@redhat.com> <20060629210950.GA300@elte.hu>
	 <20060629230517.GA18838@elte.hu>
	 <1151662073.31392.4.camel@localhost.localdomain>
	 <1151661242.11434.20.camel@laptopd505.fenrus.org>
	 <1151669670.31392.16.camel@localhost.localdomain>
	 <20060630172713.GH32729@redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 30 Jun 2006 18:52:13 +0100
Message-Id: <1151689933.31392.69.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Gwe, 2006-06-30 am 13:27 -0400, ysgrifennodd Dave Jones:
>   surely no-one made an acpi aware vlb machine :)
> 
> There are probably other creative ways.

And the not-so-creative simple one which is how old IDE addresses much
of this:

Date: Fri Jun 30 16:39:20 2006 +0100
Subject: [PATCH 13/20] My name is Ingo Molnar, you killed my make allyesconfig, prepare to die

Teach the qdi driver to be more polite about probing when compiled in
so that people who make allyesconfig don't get burned.

Alan

Signed-off-by: Alan Cox <alan@redhat.com>


---

 drivers/scsi/pata_qdi.c |   15 +++++++++++++--
 1 files changed, 13 insertions(+), 2 deletions(-)

12b633d45a8600147314c2ce33b28f92f52c92bd
diff --git a/drivers/scsi/pata_qdi.c b/drivers/scsi/pata_qdi.c
index ca6fef0..f8fc0ef 100644
--- a/drivers/scsi/pata_qdi.c
+++ b/drivers/scsi/pata_qdi.c
@@ -26,7 +26,7 @@
 #include <linux/platform_device.h>
 
 #define DRV_NAME "pata_qdi"
-#define DRV_VERSION "0.2.3"
+#define DRV_VERSION "0.2.4"
 
 #define NR_HOST 4	/* Two 6580s */
 
@@ -41,7 +41,13 @@ struct qdi_data {
 
 static struct ata_host_set *qdi_host[NR_HOST];
 static struct qdi_data qdi_data[NR_HOST];
-static int nr_qdi_host = 0;
+static int nr_qdi_host;
+
+#ifdef MODULE
+static int probe_qdi = 1;
+#else
+static int probe_qdi;
+#endif
 
 static void qdi6500_set_piomode(struct ata_port *ap, struct ata_device *adev)
 {
@@ -302,6 +308,9 @@ static __init int qdi_init(void)
 	int ct = 0;
 	int i;
 	
+	if (probe_qdi == 0)
+		return;
+	
 	/*
  	 *	Check each possible QD65xx base address
 	 */
@@ -390,3 +399,5 @@ MODULE_VERSION(DRV_VERSION);
 module_init(qdi_init);
 module_exit(qdi_exit);
 
+module_param(probe_qdi, int, 0);
+
-- 
1.2.GIT


