Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750947AbWGQQcJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750947AbWGQQcJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jul 2006 12:32:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750959AbWGQQcJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jul 2006 12:32:09 -0400
Received: from mail.kroah.org ([69.55.234.183]:37306 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1750947AbWGQQcG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jul 2006 12:32:06 -0400
Date: Mon, 17 Jul 2006 09:27:19 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       v4l-dvb maintainer list <v4l-dvb-maintainer@linuxtv.org>,
       Andrew de Quincey <adq_dvb@lidskialf.net>,
       Michael Krufky <mkrufky@linuxtv.org>,
       Chris Wright <chrisw@sous-sol.org>, Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 18/45] v4l/dvb: Backport the DISEQC regression fix to 2.6.17.x
Message-ID: <20060717162719.GS4829@kroah.com>
References: <20060717160652.408007000@blue.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="v4l-dvb-backport-the-diseqc-regression-fix-to-2.6.17.x.patch"
In-Reply-To: <20060717162452.GA4829@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------
From: Andrew de Quincey <adq_dvb@lidskialf.net>

Backport the DISEQC regression fix to 2.6.17.x

Signed-off-by: Andrew de Quincey <adq_dvb@lidskialf.net>
Signed-off-by: Michael Krufky <mkrufky@linuxtv.org>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---

 drivers/media/dvb/dvb-core/dvb_frontend.c |   14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

--- linux-2.6.17.3.orig/drivers/media/dvb/dvb-core/dvb_frontend.c
+++ linux-2.6.17.3/drivers/media/dvb/dvb-core/dvb_frontend.c
@@ -519,7 +519,9 @@ static int dvb_frontend_thread(void *dat
 	fepriv->delay = 3*HZ;
 	fepriv->status = 0;
 	fepriv->wakeup = 0;
-	fepriv->reinitialise = 1;
+	fepriv->reinitialise = 0;
+
+	dvb_frontend_init(fe);
 
 	while (1) {
 		up(&fepriv->sem);	    /* is locked when we enter the thread... */
@@ -996,17 +998,17 @@ static int dvb_frontend_open(struct inod
 		return ret;
 
 	if ((file->f_flags & O_ACCMODE) != O_RDONLY) {
+		/* normal tune mode when opened R/W */
+		fepriv->tune_mode_flags &= ~FE_TUNE_MODE_ONESHOT;
+		fepriv->tone = -1;
+		fepriv->voltage = -1;
+
 		ret = dvb_frontend_start (fe);
 		if (ret)
 			dvb_generic_release (inode, file);
 
 		/*  empty event queue */
 		fepriv->events.eventr = fepriv->events.eventw = 0;
-
-		/* normal tune mode when opened R/W */
-		fepriv->tune_mode_flags &= ~FE_TUNE_MODE_ONESHOT;
-		fepriv->tone = -1;
-		fepriv->voltage = -1;
 	}
 
 	return ret;

--
