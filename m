Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262063AbTLSSE3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Dec 2003 13:04:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263343AbTLSSE3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Dec 2003 13:04:29 -0500
Received: from delerium.codemonkey.org.uk ([81.187.208.145]:19631 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S262063AbTLSSE1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Dec 2003 13:04:27 -0500
Date: Fri, 19 Dec 2003 18:04:06 +0000
From: Dave Jones <davej@redhat.com>
To: Jurgen Kramer <gtm.kramer@inter.nl.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6.0 cpufreq] longhaul trouble
Message-ID: <20031219180406.GA24413@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Jurgen Kramer <gtm.kramer@inter.nl.net>,
	linux-kernel@vger.kernel.org
References: <1071851531.9835.5.camel@paragon.slim>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1071851531.9835.5.camel@paragon.slim>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 19, 2003 at 05:32:11PM +0100, Jurgen Kramer wrote:
 > When I insert the longhaul cpufreq module on my VIA EPIA 800 the system
 > completely freezes. It does not give any oops or other helpful error
 > message.
 > 

Does this help ?

	Dave

diff -urpN --exclude-from=/home/davej/.exclude bk-linus/arch/i386/kernel/cpu/cpufreq/longhaul.c cpufreq/arch/i386/kernel/cpu/cpufreq/longhaul.c
--- bk-linus/arch/i386/kernel/cpu/cpufreq/longhaul.c	2003-10-15 05:00:29.000000000 +0100
+++ cpufreq/arch/i386/kernel/cpu/cpufreq/longhaul.c	2003-11-21 02:20:59.000000000 +0000
@@ -170,6 +170,9 @@ static void longhaul_setstate (unsigned 
  * between that value multiplied by possible FSBs and cpu_mhz which
  * was calculated at boot time. Really ugly, but no other way to do this.
  */
+
+#define ROUNDING	0xf
+
 static int _guess (int guess, int maxmult)
 {
 	int target;
@@ -177,16 +180,20 @@ static int _guess (int guess, int maxmul
 	target = ((maxmult/10)*guess);
 	if (maxmult%10 != 0)
 		target += (guess/2);
-	target &= ~0xf;
+	target += ROUNDING/2;
+	target &= ~ROUNDING;
 	return target;
 }
 
 static int guess_fsb(int maxmult)
 {
-	int speed = (cpu_khz/1000) & ~0xf;
+	int speed = (cpu_khz/1000);
 	int i;
 	int speeds[3] = { 66, 100, 133 };
 
+	speed += ROUNDING/2;
+	speed &= ~ROUNDING;
+
 	for (i=0; i<3; i++) {
 		if (_guess(speeds[i],maxmult) == speed)
 			return speeds[i];

