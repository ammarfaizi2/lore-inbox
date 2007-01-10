Return-Path: <linux-kernel-owner+w=401wt.eu-S932781AbXAJN2u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932781AbXAJN2u (ORCPT <rfc822;w@1wt.eu>);
	Wed, 10 Jan 2007 08:28:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932596AbXAJN2u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Jan 2007 08:28:50 -0500
Received: from moutng.kundenserver.de ([212.227.126.188]:65478 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932781AbXAJN2t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Jan 2007 08:28:49 -0500
From: Bernhard Schiffner <bernhard@schiffner-limbach.de>
To: linux-kernel@vger.kernel.org
Subject: ntp.c : possible inconsistency?
Date: Wed, 10 Jan 2007 14:23:36 +0100
User-Agent: KMail/1.9.4
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200701101423.36740.bernhard@schiffner-limbach.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:3106147cf13cfbe25b2f22b4c4169fde
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

trying to find reasons for some crazy ntpd-behavior I read
http://lkml.org/lkml/2006/10/27/67

This thread doesn't result in a pulished patch, so I (hopefully) did what was 
said there. The patch doesn't break my system, but it doesn't change ntpd's 
crazyness too.
Nevertheless it should be discussed again in the sense of preventing an 
inconsistency.

Bernhard


PS:
Can someone point me to the reason for doing txc->constant + 4, please?

References:
lkml-thread (start)
http://lkml.org/lkml/2006/10/26/47

ntpd-crazyness (comparing 2.6.15 with 2.6.19)
http://ml.enneenne.com/pipermail/linuxpps/2006-December/000482.html

Patch:
index 3afeaa3..36d7ecc 100644
--- a/kernel/time/ntp.c
+++ b/kernel/time/ntp.c
@@ -263,7 +263,7 @@ int do_adjtimex(struct timex *txc)
                    result = -EINVAL;
                    goto leave;
                }
-               time_constant = min(txc->constant + 4, (long)MAXTC);
+               time_constant = min(txc->constant + 4, (long)MAXTC + 4);
            }

            if (txc->modes & ADJ_OFFSET) {      /* values checked earlier */
@@ -329,7 +329,7 @@ leave:      if ((time_status & (STA_UNSYNC|
STA_CLOCKERR)) != 0)
        txc->maxerror      = time_maxerror;
        txc->esterror      = time_esterror;
        txc->status        = time_status;
-       txc->constant      = time_constant;
+       txc->constant      = time_constant - 4;
        txc->precision     = 1;
        txc->tolerance     = MAXFREQ;
        txc->tick          = tick_usec;
