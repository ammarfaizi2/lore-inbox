Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422687AbWBNRMt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422687AbWBNRMt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 12:12:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422686AbWBNRMt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 12:12:49 -0500
Received: from adsl-70-250-156-241.dsl.austtx.swbell.net ([70.250.156.241]:38087
	"EHLO gw.microgate.com") by vger.kernel.org with ESMTP
	id S1422689AbWBNRMr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 12:12:47 -0500
Subject: Re: PPP with PCMCIA modem stalls on 2.6.10 or later
From: Paul Fulghum <paulkf@microgate.com>
To: Kouji Toriatama <toriatama@inter7.jp>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060215.005753.74732581.toriatama@inter7.jp>
References: <20060213.231636.103125334.toriatama@inter7.jp>
	 <1139863919.3868.16.camel@amdx2.microgate.com>
	 <20060215.005753.74732581.toriatama@inter7.jp>
Content-Type: text/plain
Date: Tue, 14 Feb 2006 11:12:39 -0600
Message-Id: <1139937159.3189.4.camel@amdx2.microgate.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-02-15 at 00:57 +0900, Kouji Toriatama wrote:
> Following is a status of ppp0 interface when the above wget
> command finished.  The count of RX errors, RX bytes and TX
> bytes has sometimes increased while stalling.  In kernel
> 2.6.9, the count of Rx errors was 0.
> -------------------------------------------------------------
> ppp0      Link encap:Point-to-Point Protocol  
>           inet addr:202.179.209.95  P-t-P:172.24.24.22  Mask:255.255.255.255
>           UP POINTOPOINT RUNNING NOARP MULTICAST  MTU:1500  Metric:1
>           RX packets:44 errors:18 dropped:0 overruns:0 frame:0
>           TX packets:50 errors:0 dropped:0 overruns:0 carrier:0
>           collisions:0 txqueuelen:3 
>           RX bytes:15992 (15.6 KiB)  TX bytes:2544 (2.4 KiB)

In 2.6.10, a new check for errors on received characters was added.

Try the patch below. It prevents the check from discarding
received frames, but outputs an error message to the syslog.

Run with the patch and return the results with
any syslog output containing the error message.

Thanks,
Paul

--- linux-2.6.15/drivers/net/ppp_async.c	2006-01-02 21:21:10.000000000 -0600
+++ b/drivers/net/ppp_async.c	2006-02-14 11:04:47.000000000 -0600
@@ -923,8 +923,9 @@ ppp_async_input(struct asyncppp *ap, con
 
 		c = buf[n];
 		if (flags != NULL && flags[n] != 0) {
-			ap->state |= SC_TOSS;
-		} else if (c == PPP_FLAG) {
+			printk("ppp_async:bad char c=%02X f=%02X\n", buf[n], flags[n]);
+		} 
+		if (c == PPP_FLAG) {
 			process_input_packet(ap);
 		} else if (c == PPP_ESCAPE) {
 			ap->state |= SC_ESCAPE;


