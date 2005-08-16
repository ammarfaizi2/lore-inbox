Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964804AbVHPCIH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964804AbVHPCIH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Aug 2005 22:08:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964810AbVHPCIH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Aug 2005 22:08:07 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:27083 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S964804AbVHPCIG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Aug 2005 22:08:06 -0400
Subject: Re: [RFC][PATCH - 4/13] NTP cleanup: Breakup ntp_adjtimex()
From: john stultz <johnstul@us.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: George Anzinger <george@mvista.com>, frank@tuxrocks.com,
       Anton Blanchard <anton@samba.org>, benh@kernel.crashing.org,
       Nishanth Aravamudan <nacc@us.ibm.com>,
       Roman Zippel <zippel@linux-m68k.org>,
       Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>
In-Reply-To: <1123723634.32330.4.camel@cog.beaverton.ibm.com>
References: <1123723279.30963.267.camel@cog.beaverton.ibm.com>
	 <1123723384.30963.269.camel@cog.beaverton.ibm.com>
	 <1123723534.32330.0.camel@cog.beaverton.ibm.com>
	 <1123723578.32330.2.camel@cog.beaverton.ibm.com>
	 <1123723634.32330.4.camel@cog.beaverton.ibm.com>
Content-Type: text/plain
Date: Mon, 15 Aug 2005 19:08:00 -0700
Message-Id: <1124158081.8630.92.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-08-10 at 18:27 -0700, john stultz wrote:
> All,
> 	This patch breaks up the complex nesting of code in ntp_adjtimex() by
> creating a ntp_hardupdate() function and simplifying some of the logic.
> This also mimics the documented NTP spec somewhat better.
> 
> Any comments or feedback would be greatly appreciated.

Ugh. I just caught a bug where I misplaced the parens. 

> -			} /* STA_PLL */
> +				else if (ntp_hardupdate(txc->offset, xtime))
> +					result = TIME_ERROR;
> +			}
>  		} /* txc->modes & ADJ_OFFSET */
 
That's wrong. The following patch fixes it. 

thanks
-john


diff --git a/kernel/ntp.c b/kernel/ntp.c
--- a/kernel/ntp.c
+++ b/kernel/ntp.c
@@ -388,9 +388,8 @@ int ntp_adjtimex(struct timex *txc)
 				/* adjtime() is independent from ntp_adjtime() */
 				if ((time_next_adjust = txc->offset) == 0)
 					time_adjust = 0;
-				else if (ntp_hardupdate(txc->offset, xtime))
-					result = TIME_ERROR;
-			}
+			} else if (ntp_hardupdate(txc->offset, xtime))
+				result = TIME_ERROR;
 		} /* txc->modes & ADJ_OFFSET */
 
 		if (txc->modes & ADJ_TICK) {


