Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261892AbTLDNbd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Dec 2003 08:31:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261947AbTLDNbd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Dec 2003 08:31:33 -0500
Received: from [139.30.44.16] ([139.30.44.16]:36783 "EHLO
	gockel.physik3.uni-rostock.de") by vger.kernel.org with ESMTP
	id S261892AbTLDNba convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Dec 2003 08:31:30 -0500
Date: Thu, 4 Dec 2003 14:31:15 +0100 (CET)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: Con Kolivas <kernel@kolivas.org>
cc: "Tvrtko A. =?utf-8?q?Ur=C5=A1ulin?=" <tvrtko@croadria.com>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.23-ck1
In-Reply-To: <200312042321.44902.kernel@kolivas.org>
Message-ID: <Pine.LNX.4.53.0312041421300.9854@gockel.physik3.uni-rostock.de>
References: <200312040228.44980.kernel@kolivas.org> <200312041143.43629.tvrtko@croadria.com>
 <200312042321.44902.kernel@kolivas.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Dec 2003, Con Kolivas wrote:

> On Thu, 4 Dec 2003 21:43, Tvrtko A. Uršulin wrote:
> > There is something wrong with /proc/stat which confuses xosview and
> > ksysguard regarding CPU usage. Top is working ok.
> >
> > tvrtko@oxygene:~> cat /proc/stat
> > cpu  7452 0 2048 40426
> > cpu0 7452 0 2048 1844674407370950652
> 
> You're right. This looks like a hangover from the 64bit jiffies or the 
> variable Hz. It's not a critical bug so unless someone can debug it for me it 
> can wait.

Oops, yes. I made a mistake when merging variable HZ with 64bit jiffies.
Please apply the following patch on top of that.
Could you please confirm this fixes things, and could you also check that
btime stays constant with this patch? Thanks!

Warning: totally untested. Pretty much obvious, however.

Sorry,
Tim


--- linux-2.4.23-ck1/fs/proc/proc_misc.c	2003-12-04 14:15:59.000000000 +0100
+++ linux-2.4.23-ck1-fix/fs/proc/proc_misc.c	2003-12-04 14:20:07.000000000 +0100
@@ -422,7 +422,7 @@
 			(unsigned long long) jiffies_64_to_clock_t(user),
 			(unsigned long long) jiffies_64_to_clock_t(nice),
 			(unsigned long long) jiffies_64_to_clock_t(system),
-			(unsigned long long) jiffies_64_to_clock_t(jif - user - nice - system));
+			(unsigned long long) jif - jiffies_64_to_clock_t(user + nice + system));
 	}
 	proc_sprintf(page, &off, &len,
 		"page %u %u\n"
@@ -460,7 +460,7 @@
 		}
 	}
 
-	do_div(jif, HZ);
+	do_div(jif, USER_HZ);
 	proc_sprintf(page, &off, &len,
 		"\nctxt %lu\n"
 		"btime %lu\n"
