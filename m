Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273385AbRJIHNd>; Tue, 9 Oct 2001 03:13:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273463AbRJIHNX>; Tue, 9 Oct 2001 03:13:23 -0400
Received: from wiprom2mx1.wipro.com ([203.197.164.41]:47851 "EHLO
	wiprom2mx1.wipro.com") by vger.kernel.org with ESMTP
	id <S273385AbRJIHNF>; Tue, 9 Oct 2001 03:13:05 -0400
Message-ID: <3BC2A3B3.3020004@wipro.com>
Date: Tue, 09 Oct 2001 12:43:55 +0530
From: "BALBIR SINGH" <balbir.singh@wipro.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20010913
X-Accept-Language: en-us
MIME-Version: 1.0
To: "Paul E. McKenney" <pmckenne@us.ibm.com>
CC: lse-tech@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: RFC: patch to allow lock-free traversal of lists with insertion
In-Reply-To: <200110090155.f991tPt22329@eng4.beaverton.ibm.com>
Content-Type: multipart/mixed;
	boundary="------------InterScan_NT_MIME_Boundary"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is a multi-part message in MIME format.

--------------InterScan_NT_MIME_Boundary
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit


Paul E. McKenney wrote:

>Request for comments...
>
>This is a proposal to provide a wmb()-like primitive that enables
>lock-free traversal of lists while elements are concurrently being
>inserted into these lists.
>
>This is already possible on many popular architectures, but not on
>
>some CPUs with very weak memory consistency models.  See:
>
>	http://lse.sourceforge.net/locking/wmbdd.html
>
>for more details.
>
>I am particularly interested in comments from people who understand
>the detailed operation of the SPARC membar instruction and the PARISC
>SYNC instruction.  My belief is that the membar("#SYNC") and SYNC
>instructions are sufficient, but the PA-RISC 2.0 Architecture book by
>Kane is not completely clear, and I have not yet received my copy of
>the SPARC architecture manual.
>
>Thoughts?
>

1) On Alpha this code does not improve performance since we end up using spinlocks
for my_global_data anyway, I think you already know this. I am a little confused
with the code snippet below


+       spin_lock_irqsave(&mb_global_data.mutex, flags); /* implied mb */
+       if ((mb_global_data.need_mb & this_cpu_mask) == 0) {
+               spin_unlock_irqrestore(&mb_global_data.mutex, flags);
+               return;
+       }
+       mb_global_data.need_mb &= this_cpu_mask;
+ 	if (mb_global_data.need_mb == 0) {
+               if (++mb_global_data.curgen - mb_global_data.maxgen <= 0) {
+                       mb_global_data.need_mb = to_whom;
+                       send_ipi_message(to_whom, IPI_MB);
+               }
+       }
+       spin_unlock_irqrestore(&mb_global_data.mutex, flags); /* implied mb */

Are we not checking for the same thing in 
		(mb_global_data.need_mb &am
p; this_cpu_mask) == 0

and in
		mb_global_data.need_mb &= this_cpu_mask;
		if (mb_global_data.need_mb == 0) {

In case 1 we return, but in case two we increment the curgen and if curgen is less than
or equal to maxgen then we send IPI's again.

2) What are the rules for incrementing or changing the generation numbers curgen, mygen and
maxgen in your code?

The approach is good, but what are the pratical uses of the approach. Like u mentioned a newly
added element may not show up in the search, searches using this method may have to search again
and there is no way of guaranty that an element that we are looking for will be found (especially
if it is just being added to the list).

The idea is tremendous for approaches where we do not care about elements being newly added.
It should definitely be in the Linux kernel  :-) 


Balbir

>
>
>						Thanx, Paul
>


--------------InterScan_NT_MIME_Boundary
Content-Type: text/plain;
	name="Wipro_Disclaimer.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="Wipro_Disclaimer.txt"

----------------------------------------------------------------------------------------------------------------------
Information transmitted by this E-MAIL is proprietary to Wipro and/or its Customers and
is intended for use only by the individual or entity to which it is
addressed, and may contain information that is privileged, confidential or
exempt from disclosure under applicable law. If you are not the intended
recipient or it appears that this mail has been forwarded to you without
proper authority, you are notified that any use or dissemination of this
information in any manner is strictly prohibited. In such cases, please
notify us immediately at mailto:mailadmin@wipro.com and delete this mail
from your records.
----------------------------------------------------------------------------------------------------------------------


--------------InterScan_NT_MIME_Boundary--
