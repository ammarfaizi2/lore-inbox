Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269001AbUJQCbi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269001AbUJQCbi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Oct 2004 22:31:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269006AbUJQCbi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Oct 2004 22:31:38 -0400
Received: from smtp208.mail.sc5.yahoo.com ([216.136.130.116]:13678 "HELO
	smtp208.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S269001AbUJQCbf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Oct 2004 22:31:35 -0400
Message-ID: <4171D982.10605@yahoo.com.au>
Date: Sun, 17 Oct 2004 12:31:30 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040820 Debian/1.7.2-4
X-Accept-Language: en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org, ak@suse.de,
       axboe@suse.de
Subject: Re: Hang on x86-64, 2.6.9-rc3-bk4
References: <41719537.1080505@pobox.com>	<417196AA.3090207@pobox.com>	<20041016154818.271a394b.akpm@osdl.org>	<4171B23F.6060305@pobox.com> <20041016171458.4511ad8b.akpm@osdl.org> <4171C20D.1000105@pobox.com> <4171C9CD.4000303@yahoo.com.au> <4171D5F8.8050504@pobox.com> <4171D6A0.4030200@yahoo.com.au>
In-Reply-To: <4171D6A0.4030200@yahoo.com.au>
Content-Type: multipart/mixed;
 boundary="------------040505090706070806080207"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040505090706070806080207
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Nick Piggin wrote:
> Jeff Garzik wrote:
> 

>>
>> Nope, this patch does not fix the hang.
>>
> 
> Arrgh, sorry that should be
>     if (zone->pages_scanned *>=* blah)
> 
> If you've got zero LRU pages, both sides of this should be zero, and
> we *want* all_unreclaimable to be set.


We'd better do this too, so kswapd can't take the machine down
even if it wants to.

--------------040505090706070806080207
Content-Type: text/x-patch;
 name="vm-break-kswapd.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="vm-break-kswapd.patch"




---

 linux-2.6-npiggin/mm/vmscan.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletion(-)

diff -puN mm/vmscan.c~vm-break-kswapd mm/vmscan.c
--- linux-2.6/mm/vmscan.c~vm-break-kswapd	2004-10-17 12:30:02.000000000 +1000
+++ linux-2.6-npiggin/mm/vmscan.c	2004-10-17 12:30:16.000000000 +1000
@@ -1103,8 +1103,10 @@ out:
 
 		zone->prev_priority = zone->temp_priority;
 	}
-	if (!all_zones_ok)
+	if (!all_zones_ok) {
+		cond_resched();
 		goto loop_again;
+	}
 
 	return total_reclaimed;
 }

_

--------------040505090706070806080207--
