Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262005AbVATAX1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262005AbVATAX1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 19:23:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261989AbVATATn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 19:19:43 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:3317 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S261995AbVATASW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 19:18:22 -0500
Message-ID: <41EEF8BB.1000302@mvista.com>
Date: Wed, 19 Jan 2005 16:18:03 -0800
From: George Anzinger <george@mvista.com>
Reply-To: george@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.2) Gecko/20040308
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Roland McGrath <roland@redhat.com>, Hugh Dickins <hugh@veritas.com>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>,
       Andrew Morton <akpm@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cputime.h seems to assume HZ==1000
References: <200501180157.j0I1v9YI013216@magilla.sf.frob.com> <Pine.LNX.4.58.0501171840560.8178@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0501171840560.8178@ppc970.osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Mon, 17 Jan 2005, Roland McGrath wrote:
> 
>>Shouldn't msecs mean msecs, not secs/HZ?
> 
> 
> Hmm, sure, but why go through "msecs" at all?
> 
> 
>>--- linux-2.6/include/asm-generic/cputime.h
>>+++ linux-2.6/include/asm-generic/cputime.h
>>@@ -35,8 +35,8 @@ typedef u64 cputime64_t;
>> /*
>>  * Convert cputime to seconds and back.
>>  */
>>-#define cputime_to_secs(__ct)		(jiffies_to_msecs(__ct) / HZ)
>>-#define secs_to_cputime(__secs)		(msecs_to_jiffies(__secs * HZ))
>>+#define cputime_to_secs(__ct)		(jiffies_to_msecs(__ct) / 1000)
>>+#define secs_to_cputime(__secs)		(msecs_to_jiffies(__secs * 1000))
> 
> 
> iow, why not
> 
> 	#define cputime_to_secs(jif)	((jif) / HZ)
> 	#define secs_to_cputime(sec)	((sec) * HZ)
> 
> which avoids double rounding issues etc.

If we care, the jiffies_to_msecs() code is in include/linux/jiffies.h just prior 
to other conversion code that does NOT make the assumtion that HZ is exact.  To 
be exact:

static inline long cputime_to_secs(unsigned long jif)
{
	int t;
	u64 result = (u64)jif * TICK_NSEC;
	t = do_div(result ,NSEC_PER_SEC);
	return (u32)result + t ? 1:0;      /* round up if not exact */
}
#define secs_to_cputime(sec) (((U64) sec * SEC_CONVERSION) >> SEC_JIFFIE_SC)

This last assumes sec worth of jiffies will actually fit in a long...

-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/

