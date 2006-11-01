Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946515AbWKAFyM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946515AbWKAFyM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 00:54:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946511AbWKAFiu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 00:38:50 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:34961 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S1946380AbWKAFir
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 00:38:47 -0500
Message-Id: <20061101053812.382556000@sous-sol.org>
References: <20061101053340.305569000@sous-sol.org>
User-Agent: quilt/0.45-1
Date: Tue, 31 Oct 2006 21:33:59 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, torvalds@osdl.org, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, Russell King <rmk+kernel@arm.linux.org.uk>,
       Russell King <rmk@dyn-67.arm.linux.org.uk>,
       David Woodhouse <dwmw2@infradead.org>,
       maximilian attems <maks@sternwelten.at>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 19/61] SERIAL: Fix resume handling bug
Content-Disposition: inline; filename=serial-fix-resume-handling-bug.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

From: Russell King <rmk+kernel@arm.linux.org.uk>

Unfortunately, pcmcia_dev_present() returns false when a device is
suspended, so checking this on resume does not work too well.  Omit
this test.

the backported patch below is already in fedora tree. -maks

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
Signed-off-by: maximilian attems <maks@sternwelten.at>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>

---
 drivers/serial/serial_cs.c |   12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

--- linux-2.6.18.1.orig/drivers/serial/serial_cs.c
+++ linux-2.6.18.1/drivers/serial/serial_cs.c
@@ -185,14 +185,12 @@ static int serial_suspend(struct pcmcia_
 
 static int serial_resume(struct pcmcia_device *link)
 {
-	if (pcmcia_dev_present(link)) {
-		struct serial_info *info = link->priv;
-		int i;
+	struct serial_info *info = link->priv;
+	int i;
 
-		for (i = 0; i < info->ndev; i++)
-			serial8250_resume_port(info->line[i]);
-		wakeup_card(info);
-	}
+	for (i = 0; i < info->ndev; i++)
+		serial8250_resume_port(info->line[i]);
+	wakeup_card(info);
 
 	return 0;
 }

--
