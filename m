Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261607AbVB1NuF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261607AbVB1NuF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Feb 2005 08:50:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261601AbVB1Nsr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Feb 2005 08:48:47 -0500
Received: from [194.90.79.130] ([194.90.79.130]:13834 "EHLO argo2k.argo.co.il")
	by vger.kernel.org with ESMTP id S261606AbVB1Nqo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Feb 2005 08:46:44 -0500
Subject: [PATCH][x86-64] fix pit delay accounting in timer_interrupt()
From: Avi Kivity <avi@argo.co.il>
To: linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="=-+A8YHDQhcjs1HNw3XMbX"
Message-Id: <1109598397.4081.5.camel@avik.scalemp>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 28 Feb 2005 15:46:37 +0200
X-OriginalArrivalTime: 28 Feb 2005 13:46:40.0122 (UTC) FILETIME=[EE11FDA0:01C51D9B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-+A8YHDQhcjs1HNw3XMbX
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

timer_interrupt() measures the delay from an interrupt to its handling
in a variable called 'delay', but accounts every unit of delay as 1/HZ
seconds, instead of 1/CLOCK_TICK_RATE seconds.

on ordinary cpus this doesn't matter as delay is usually zero, but on my
10MHz bochs cpu this causes divide overflows later on.

(patch against 2.6.9 but should apply)

Signed-off-by: Avi Kivity <avi@argo.co.il>



--=-+A8YHDQhcjs1HNw3XMbX
Content-Disposition: attachment; filename=pit-delay.patch
Content-Type: text/plain; name=pit-delay.patch; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

--- linux-2.6.9/arch/x86_64/kernel/time.c~time	2005-02-28 14:26:52.000000000 +0200
+++ linux-2.6.9/arch/x86_64/kernel/time.c	2005-02-28 14:28:46.000000000 +0200
@@ -409,7 +409,7 @@
 
 		monotonic_base += (tsc - vxtime.last_tsc)*1000000/cpu_khz ;
 
-		vxtime.last_tsc = tsc - vxtime.quot * delay / vxtime.tsc_quot;
+		vxtime.last_tsc = tsc - vxtime.quot * delay / (LATCH * vxtime.tsc_quot);
 
 		if ((((tsc - vxtime.last_tsc) *
 		      vxtime.tsc_quot) >> 32) < offset)

--=-+A8YHDQhcjs1HNw3XMbX--

