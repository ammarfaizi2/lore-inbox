Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261864AbVG1TJ2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261864AbVG1TJ2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 15:09:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261931AbVG1TJ1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 15:09:27 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:10487 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S262082AbVG1TGd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 15:06:33 -0400
Message-ID: <42E92C42.8000003@mvista.com>
Date: Thu, 28 Jul 2005 12:04:34 -0700
From: George Anzinger <george@mvista.com>
Reply-To: george@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050323 Fedora/1.7.6-1.3.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: [PATCH] fix normalize problem in posix timers.
Content-Type: multipart/mixed;
 boundary="------------040203090206030202080002"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is a multi-part message in MIME format.
--------------040203090206030202080002
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

We found this (after a customer complained) and it is in the kernel.org 
kernel.  Seems that for CLOCK_MONOTONIC absolute timers and 
clock_nanosleep calls both the request time and wall_to_monotonic are 
subtracted prior to the normalize resulting in an overflow in the 
existing normalize test.  This causes the result to be shifted ~4 
seconds ahead instead of ~2 seconds back in time.  Patch is attached.
-
George Anzinger   george@mvista.com
HRT (High-res-timers):  http://sourceforge.net/projects/high-res-timers/

--------------040203090206030202080002
Content-Type: text/plain;
 name="normalize.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="normalize.patch"

Source: MontaVista Software, Inc. George Anzinger <george@mvista.com>
Type: Defect Fix 
Description:
	The normalize code in posix-timers.c fails when the tv_nsec 
	member is ~1.2 seconds negative.  This can happen on absolute
	timers (and clock_nanosleeps) requested on CLOCK_MONOTONIC
	(both the request time and wall_to_monotonic are subtracted
	resulting in the possibility of a number close to -2 seconds.)

	This fix uses the set_normalized_timespec() (which does not 
	have an overflow problem) to fix the problem and as a side
	effect makes the code cleaner.

Signed-off-by: George Anzinger <george@mvista.com>
    
 posix-timers.c |   17 +++--------------
 1 files changed, 3 insertions(+), 14 deletions(-)

Index: linux-2.6.13-rc/kernel/posix-timers.c
===================================================================
--- linux-2.6.13-rc.orig/kernel/posix-timers.c
+++ linux-2.6.13-rc/kernel/posix-timers.c
@@ -915,21 +915,10 @@ static int adjust_abs_time(struct k_cloc
 			jiffies_64_f = get_jiffies_64();
 		}
 		/*
-		 * Take away now to get delta
+		 * Take away now to get delta and normalize
 		 */
-		oc.tv_sec -= now.tv_sec;
-		oc.tv_nsec -= now.tv_nsec;
-		/*
-		 * Normalize...
-		 */
-		while ((oc.tv_nsec - NSEC_PER_SEC) >= 0) {
-			oc.tv_nsec -= NSEC_PER_SEC;
-			oc.tv_sec++;
-		}
-		while ((oc.tv_nsec) < 0) {
-			oc.tv_nsec += NSEC_PER_SEC;
-			oc.tv_sec--;
-		}
+		set_normalized_timespec(&oc, oc.tv_sec - now.tv_sec,
+					oc.tv_nsec - now.tv_nsec);
 	}else{
 		jiffies_64_f = get_jiffies_64();
 	}

--------------040203090206030202080002--
