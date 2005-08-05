Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261967AbVHEOiK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261967AbVHEOiK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 10:38:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262307AbVHEOhd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 10:37:33 -0400
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:35290 "EHLO
	ms-smtp-04.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S261848AbVHEOgr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 10:36:47 -0400
Subject: [PATCH] netpoll can lock up on low memory.
From: Steven Rostedt <rostedt@goodmis.org>
To: Andi Kleen <ak@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
       John B?ckstrand <sandos@home.se>
In-Reply-To: <20050805141426.GU8266@wotan.suse.de>
References: <42F347D2.7000207@home.se.suse.lists.linux.kernel>
	 <p73ek987gjw.fsf@bragg.suse.de>
	 <1123249743.18332.16.camel@localhost.localdomain>
	 <20050805135551.GQ8266@wotan.suse.de>
	 <1123251013.18332.28.camel@localhost.localdomain>
	 <20050805141426.GU8266@wotan.suse.de>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Fri, 05 Aug 2005 10:36:31 -0400
Message-Id: <1123252591.18332.45.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Looking at the netpoll routines, I noticed that the find_skb could
lockup if the memory is low.  This is because the allocations are called
with GFP_ATOMIC (since this is in interrupt context) and if it fails, it
will continue to fail. This is just by observing the code, I didn't have
this actually happen. So if this is not the case, please let me know how
it can get out. Otherwise, please accept this patch.  Also, as Andi told
me, the printk here would probably not show up anyway if this happens
with netconsole.

Here I changed it to break out instead of just looping.

-- Steve


Signed-off-by: Steven Rostedt <rostedt@goodmis.org>

--- linux-2.6.13-rc3/net/core/netpoll.c.orig	2005-08-05 09:37:00.000000000 -0400
+++ linux-2.6.13-rc3/net/core/netpoll.c	2005-08-05 10:29:32.000000000 -0400
@@ -229,8 +229,9 @@ repeat:
 	}
 
 	if(!skb) {
-		count++;
-		if (once && (count == 1000000)) {
+		if (count++ == 100000)
+			return NULL;
+		if (once)
 			printk("out of netpoll skbs!\n");
 			once = 0;
 		}


