Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261490AbVCNQXw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261490AbVCNQXw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 11:23:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261553AbVCNQXv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 11:23:51 -0500
Received: from styx.suse.cz ([82.119.242.94]:27628 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S261490AbVCNQXt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 11:23:49 -0500
Date: Mon, 14 Mar 2005 17:24:26 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: davej@codemonkey.org.uk, linux@brodo.de, pavel@suse.cz,
       linux-kernel@vger.kernel.org
Subject: PowerNow-K8 and Winchester CPUs
Message-ID: <20050314162426.GA2598@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I have a machine with an Athlon64 with a Winchester core. It has a max
frequency of 2GHz, vid 0x6. The maximum vid allowed is 0x4. It has an
intermediate vid 0x8. RVO is 3.

When transitioning (phase1) from vid 0x8 to vid 0x6, it first increases
the vid to 6, and then proceeds increasing it three more steps. This of
course fails, because it overflows the maximum allowed vid 0x4.

My first attempt to fix this was to limit the vid to the max vid while
doing the rvo bump-up.

However, I believe that the real reason for the problem is that the
condition to start doing the rvo bump is wrong.

This patch should fix it:

diff -Nru a/arch/i386/kernel/cpu/cpufreq/powernow-k8.c b/arch/i386/kernel/cpu/cpufreq/powernow-k8.c
--- a/arch/i386/kernel/cpu/cpufreq/powernow-k8.c	2005-03-14 17:20:17 +01:00
+++ b/arch/i386/kernel/cpu/cpufreq/powernow-k8.c	2005-03-14 17:20:17 +01:00
@@ -286,7 +286,7 @@
 			return 1;
 	}
 
-	while ((rvosteps > 0)  && ((data->rvo + data->currvid) > reqvid)) {
+	while ((rvosteps > 0) && ((data->currvid - data->rvo) > reqvid)) {
 		if (data->currvid == 0) {
 			rvosteps = 0;
 		} else {

if I understand the original intent of the second test in the while()
statement. 

Any comments? Is my understanding of that bit of code correct?

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
