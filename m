Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267705AbUG3PX1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267705AbUG3PX1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jul 2004 11:23:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267706AbUG3PX1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jul 2004 11:23:27 -0400
Received: from mail.timesys.com ([65.117.135.102]:35643 "EHLO
	exchange.timesys.com") by vger.kernel.org with ESMTP
	id S267705AbUG3PXY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jul 2004 11:23:24 -0400
Message-ID: <410A67EA.80705@timesys.com>
Date: Fri, 30 Jul 2004 11:23:22 -0400
From: Greg Weeks <greg.weeks@timesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
CC: Dan Malek <dan@embeddededge.com>, Kumar Gala <kumar.gala@freescale.com>,
       LKML <linux-kernel@vger.kernel.org>,
       LinuxPPC-dev Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: [BUG] PPC math-emu multiply problem
References: <4108F845.7080305@timesys.com> <85C49799-E168-11D8-B0AC-000393DBC2E8@freescale.com> <A46787F8-E194-11D8-B8DB-003065F9B7DC@embeddededge.com> <410A5F08.90103@timesys.com>
In-Reply-To: <410A5F08.90103@timesys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 30 Jul 2004 15:22:55.0921 (UTC) FILETIME=[16BA3A10:01C47649]
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg Weeks wrote:

> Dan Malek wrote:
>
>>
>> On Jul 29, 2004, at 10:06 AM, Kumar Gala wrote:
>>
>>>
>>> On Jul 29, 2004, at 8:14 AM, Greg Weeks wrote:
>>>
>>>> I'm seeing what appears to be a bug in the ppc kernel trap math
>>>> emulator. An extreme case for multiplies isn't working the way gcc
>>>> soft-float or hardware floating point is.
>>>
>>>
>>
>> I'm not surprised.  I lifted this code from Sparc, glibc, and adapted
>> it as best I could for PPC years ago for the 8xx.  I was happy when
>> it appeared to work for the general cases. :-)
>>
>> Due to its overhead, I never expected it to be _the_ solution for
>> processors that don't have floating point hardware.  Recompiling
>> the libraries with soft-float and using that option when compiling
>> is the way to go.
>
>
> OK, this patch fixes my multiply problem with the LSB test. I still 
> need to test to make sure I didn't break anything else, but it appears 
> the rounding is only used when converting back to IEEE format. Is 
> there some reason this is something really dumb to do?
>
When I actually built a kernel rather than just my test code the 
FP_ROUNDMODE is picked up from the linux/math-emu/soft-fp.h. I don't 
want to change the common definition unless I'm sure this is the correct 
solution.

Signed-off-by: Greg Weeks <greg.weeks@timesys.com> under TS0087

--- tanith-linux-2.6.6/arch/ppc/math-emu/soft-fp.h.orig    2004-07-30 
10:31:34.000000000 -0400
+++ tanith-linux-2.6.6/arch/ppc/math-emu/soft-fp.h    2004-07-30 
11:18:59.000000000 -0400
@@ -14,9 +14,8 @@
 # define FP_RND_ZERO        1
 # define FP_RND_PINF        2
 # define FP_RND_MINF        3
-#ifndef FP_ROUNDMODE
-# define FP_ROUNDMODE        FP_RND_NEAREST
-#endif
+#undef FP_ROUNDMODE
+# define FP_ROUNDMODE        FP_RND_ZERO
 #endif
 
 #define _FP_ROUND_NEAREST(wc, X)            \

