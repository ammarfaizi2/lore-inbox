Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265602AbTFNGV4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jun 2003 02:21:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265628AbTFNGV4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jun 2003 02:21:56 -0400
Received: from ossipee.unh.edu ([132.177.137.39]:192 "EHLO ossipee.unh.edu")
	by vger.kernel.org with ESMTP id S265602AbTFNGVz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jun 2003 02:21:55 -0400
Date: Sat, 14 Jun 2003 02:35:39 -0400
From: Samuel Thibault <Samuel.Thibault@ens-lyon.fr>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: [patch][2.5] speedstep_detect_speed might not reenable interrupts
Message-ID: <20030614063539.GA508@bouh.unh.edu>
Reply-To: Samuel Thibault <samuel.thibault@fnac.net>
Mail-Followup-To: Samuel Thibault <Samuel.Thibault@ens-lyon.fr>,
	linux-kernel@vger.kernel.org, torvalds@transmeta.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i-nntp
X-MailScanner-Information: http://pubpages.unh.edu/notes/mailfiltering.html
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam, SpamAssassin (score=-8.7, required 5,
	BAYES_01, PATCH_UNIFIED_DIFF, USER_AGENT_MUTT)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

local_irq_save() is called at the beginning of speedstep_detect_speeds,
but local_irq_restore() is not called on I/O errors.

--- linux-2.5.70-bk12/arch/i386/kernel/cpu/cpufreq/speedstep.c	2003-05-26 21:00:20.000000000 -0400
+++ linux-2.5.70-bk12-perso/arch/i386/kernel/cpu/cpufreq/speedstep.c	2003-06-14 02:23:34.000000000 -0400
@@ -538,8 +538,10 @@
 	for (i=0; i<2; i++) {
 		/* read the current state */
 		result = speedstep_get_state(&state);
-		if (result)
+		if (result) {
+			local_irq_restore(flags);
 			return result;
+		}
 
 		/* save the correct value, and switch to other */
 		if (state == SPEEDSTEP_LOW) {
