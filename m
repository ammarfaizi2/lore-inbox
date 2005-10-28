Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030231AbVJ1QAx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030231AbVJ1QAx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 12:00:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030230AbVJ1QAx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 12:00:53 -0400
Received: from send.forptr.21cn.com ([202.105.45.48]:52708 "HELO 21cn.com")
	by vger.kernel.org with SMTP id S1030227AbVJ1QAw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 12:00:52 -0400
Message-ID: <43624B98.6010405@21cn.com>
Date: Sat, 29 Oct 2005 00:02:32 +0800
From: Yan Zheng <yanzheng@21cn.com>
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: netdev@vger.kernel.org
CC: linux-kernel@vger.kernel.org
Subject: [PATH] [MCAST] IPv6: Fix algorithm to compute Querier's Query Interval
 and Maximum Response Delay
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AIMC-AUTH: yanzheng
X-AIMC-MAILFROM: yanzheng@21cn.com
X-AIMC-Msg-ID: 0GIh65OB
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

5.1.3.  Maximum Response Code

   The Maximum Response Code field specifies the maximum time allowed
   before sending a responding Report.  The actual time allowed, called
   the Maximum Response Delay, is represented in units of milliseconds,
   and is derived from the Maximum Response Code as follows:

   If Maximum Response Code < 32768,
      Maximum Response Delay = Maximum Response Code

   If Maximum Response Code >=32768, Maximum Response Code represents a
   floating-point value as follows:

       0 1 2 3 4 5 6 7 8 9 A B C D E F
      +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
      |1| exp |          mant         |
      +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+

   Maximum Response Delay = (mant | 0x1000) << (exp+3)


5.1.9.  QQIC (Querier's Query Interval Code)

   The Querier's Query Interval Code field specifies the [Query
   Interval] used by the Querier.  The actual interval, called the
   Querier's Query Interval (QQI), is represented in units of seconds,
   and is derived from the Querier's Query Interval Code as follows:

   If QQIC < 128, QQI = QQIC

   If QQIC >= 128, QQIC represents a floating-point value as follows:

       0 1 2 3 4 5 6 7
      +-+-+-+-+-+-+-+-+
      |1| exp | mant  |
      +-+-+-+-+-+-+-+-+

   QQI = (mant | 0x10) << (exp + 3)

                                                -- rfc3810

#define MLDV2_QQIC(value) MLDV2_EXP(0x80, 4, 3, value)
#define MLDV2_MRC(value) MLDV2_EXP(0x8000, 12, 3, value)

Above macro are defined in mcast.c. but 1 << 4 == 0x10 and 1 << 12 == 0x1000.
So the result computed by original Macro is larger.


Signed-off-by: Yan Zheng <yanzheng@21cn.com>

Index: net/ipv6/mcast.c
===================================================================
--- linux-2.6.14/net/ipv6/mcast.c	2005-10-28 08:02:08.000000000 +0800
+++ linux/net/ipv6/mcast.c	2005-10-28 23:41:18.000000000 +0800
@@ -164,7 +164,7 @@
 #define MLDV2_MASK(value, nb) ((nb)>=32 ? (value) : ((1<<(nb))-1) & (value))
 #define MLDV2_EXP(thresh, nbmant, nbexp, value) \
 	((value) < (thresh) ? (value) : \
-	((MLDV2_MASK(value, nbmant) | (1<<(nbmant+nbexp))) << \
+	((MLDV2_MASK(value, nbmant) | (1<<(nbmant))) << \
 	(MLDV2_MASK((value) >> (nbmant), nbexp) + (nbexp))))
 
 #define MLDV2_QQIC(value) MLDV2_EXP(0x80, 4, 3, value)

