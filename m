Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262715AbVHDV2n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262715AbVHDV2n (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 17:28:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262718AbVHDV0b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 17:26:31 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:38641 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S262715AbVHDVYV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 17:24:21 -0400
Message-ID: <42F28707.7060806@mvista.com>
Date: Thu, 04 Aug 2005 14:22:15 -0700
From: George Anzinger <george@mvista.com>
Reply-To: george@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050323 Fedora/1.7.6-1.3.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Gerd Knorr <kraxel@suse.de>, Andrew Morton <akpm@osdl.org>,
       Roland McGrath <roland@redhat.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] Re: 2.6.12: itimer_real timers don't survive execve() any
 more
References: <20050804164532.GB31853@bytesex>
In-Reply-To: <20050804164532.GB31853@bytesex>
Content-Type: multipart/mixed;
 boundary="------------070206080902050503080605"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is a multi-part message in MIME format.
--------------070206080902050503080605
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Gerd Knorr wrote:
>   Hi,
> 
> Somewhere between 2.6.11 and 2.6.12 the regression in $subject
> was added to the linux kernel.  Testcase below.

Yep.  The itimer changes got a bit carried away.  Here is a fix.

-- 
George Anzinger   george@mvista.com
HRT (High-res-timers):  http://sourceforge.net/projects/high-res-timers/

--------------070206080902050503080605
Content-Type: text/plain;
 name="itimer-fix2.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="itimer-fix2.patch"

Source: MontaVista Software, Inc. George Anzinger <george@mvista.com>
Type: Defect Fix 
Description:

 	The changes to itimer of late (after 2.6.11) cause itimers not
 	to survive the exec* calls.  Standard says they should.  

Signed-off-by: George Anzinger<george@mvista.com>

 exit.c         |    1 +
 posix-timers.c |    4 ++--
 2 files changed, 3 insertions(+), 2 deletions(-)


Index: linux-2.6.13-rc/kernel/exit.c
===================================================================
--- linux-2.6.13-rc.orig/kernel/exit.c
+++ linux-2.6.13-rc/kernel/exit.c
@@ -794,6 +794,7 @@ fastcall NORET_TYPE void do_exit(long co
 	}
 
 	tsk->flags |= PF_EXITING;
+	del_timer_sync(&tsk->signal->real_timer);
 
 	/*
 	 * Make sure we don't try to process any timer firings
Index: linux-2.6.13-rc/kernel/posix-timers.c
===================================================================
--- linux-2.6.13-rc.orig/kernel/posix-timers.c
+++ linux-2.6.13-rc/kernel/posix-timers.c
@@ -1183,10 +1183,10 @@ void exit_itimers(struct signal_struct *
 	struct k_itimer *tmr;
 
 	while (!list_empty(&sig->posix_timers)) {
-		tmr = list_entry(sig->posix_timers.next, struct k_itimer, list);
+		tmr = list_entry(sig->posix_timers.next,
+				 struct k_itimer, list);
 		itimer_delete(tmr);
 	}
-	del_timer_sync(&sig->real_timer);
 }
 
 /*

--------------070206080902050503080605--
