Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318680AbSG0C05>; Fri, 26 Jul 2002 22:26:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318681AbSG0C05>; Fri, 26 Jul 2002 22:26:57 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:58798 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S318680AbSG0C04>;
	Fri, 26 Jul 2002 22:26:56 -0400
Subject: Re: [Lse-tech] [RFC]  per cpu slab fix to reduce freemiss
To: linux-kernel@vger.kernel.org, lse <lse-tech@lists.sourceforge.net>
Cc: "Bill Hartner" <Bill_Hartner@us.ibm.com>
X-Mailer: Lotus Notes Release 5.0.3 (Intl) 21 March 2000
Message-ID: <OF832504F8.0A91920F-ON87256C03.000C218F@boulder.ibm.com>
From: "Mala Anand" <manand@us.ibm.com>
Date: Fri, 26 Jul 2002 21:29:56 -0500
X-MIMETrack: Serialize by Router on D03NM123/03/M/IBM(Release 5.0.10 |March 22, 2002) at
 07/26/2002 08:29:57 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I found a problem with per cpu slab allocator implementation in Linux
kernel. The per cpu array of objects get emptied unnecessarily when
there is no room to put back the freed object.  This might lead to a
scenario where the object array is emptied to find that the subsequent
alloc requests end up in re-populating the array with the objects.
These wasted cycles could be saved by simply changing the array
to a singly linked list of free objects. To see how much this is
really happening I looked at the slab stats collected using SPECweb99
workload.

The following slabinfo stats are edited for clarity sake. The allocmiss
and freemiss are the counters that indicate how many times we are
re-populating the object array with objects (allocmiss) and how many
times the object array was emptied to make room to add freed objects
(freemiss).

slabinfo - version: 1.1 (statistics) (SMP)
                  allochit    allocmiss freehit   freemiss
tcp_tw_bucket        7297373  60783    7299082     56577
tcp_open_request    13236826   1427   13236852      1369
file lock cache     13020821   6467   13020878      6336
skbuff_head_cache     770394  38817     401689      3201
sock                13231542   6584   13231816      5948
buffer_head          5886789 119467    3793394     10946
size-4096          333688059 3327893 333690264   3322182
size-2048           91797861  451537  91798246    450602
size-256           355278409  773333 355281803    766049
size-32             32253719    306   32246987       150


The slab stats counter above shows that allocmiss and freemiss
happen less than 1% of the time, which is not significant to consider
changing the code. However it is not only the number of times this happen,
in relation to allochit and freehit, is important but the amount of
processing being done when this happens is also important.

Next I looked at the Readprofile taken using the same specweb workload:

31653 total                                       0.0209
  1374 e1000_xmit_frame                           0.8218
  1266 __kfree_skb                                5.4569
  1261 ProcessTransmitInterrupts                  2.7898
  1202 csum_partial_copy_generic                  4.8468
  1158 skb_release_data                           9.9828
  1114 __wake_up                                  9.6034
  1024 ProcessReceiveInterrupts                   1.3913
   795 tcp_clean_rtx_queue                        1.0461
   754 net_rx_action                              1.2240
   696 kfree                                      4.8333 ***
   369 kmalloc                                    1.0853
   247 kfree_skbmem                               2.3750
   181 __free_pages                               5.6562
    63 kmem_cache_alloc                           0.2351 ***
    57 __free_pages_ok                            0.1122
    55 kmem_cache_free                            0.4435 ***

kfree is one of the top 10 hot routines and this is where freemiss
processing happens. kmalloc and kmem_cache_alloc include allocmiss
processing. I am working on fixing this. Comments and suggestions
are welcome.

Regards,
    Mala


   Mala Anand
   IBM Linux Technology Center - Kernel Performance
   E-mail:manand@us.ibm.com
   Phone:512-838-8088;






