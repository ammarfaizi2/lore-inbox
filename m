Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271813AbTG2PmH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 11:42:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271814AbTG2PmH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 11:42:07 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:59353 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S271813AbTG2PmE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 11:42:04 -0400
Date: Tue, 29 Jul 2003 10:41:35 -0500
From: linas@austin.ibm.com
To: linux-kernel@vger.kernel.org
Subject: PATCH: Race in 2.6.0-test2 timer code
Message-ID: <20030729104135.A48598@forte.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


PATCH: Race in 2.6.0-test2 timer code

Hi,

I have been chasing a pointer corruption bug in the timer code, and
found the following race in the mod_timer() routine.  I am still 
testing to see if this fixes my bug ... 

--linas



--- linux-2.6.0-test2/kernel/timer.c.orig	2003-07-27 12:07:34.000000000 -0500
+++ linux-2.6.0-test2/kernel/timer.c	2003-07-29 10:22:13.000000000 -0500
@@ -258,8 +258,13 @@ repeat:
 			spin_unlock(&old_base->lock);
 			goto repeat;
 		}
-	} else
+	} else {
 		spin_lock(&new_base->lock);
+		if (timer->base != old_base) {
+			spin_unlock(&new_base->lock);
+			goto repeat;
+		}
+	}
 
 	/*
 	 * Delete the previous timeout (if there was any), and install
