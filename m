Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317493AbSG2Qos>; Mon, 29 Jul 2002 12:44:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317508AbSG2Qor>; Mon, 29 Jul 2002 12:44:47 -0400
Received: from petasus.ch.intel.com ([143.182.124.5]:29293 "EHLO
	petasus.ch.intel.com") by vger.kernel.org with ESMTP
	id <S317493AbSG2Qoq>; Mon, 29 Jul 2002 12:44:46 -0400
Message-ID: <39B5C4829263D411AA93009027AE9EBB13299538@fmsmsx35.fm.intel.com>
From: "Luck, Tony" <tony.luck@intel.com>
To: "'Mala Anand'" <manand@us.ibm.com>, linux-kernel@vger.kernel.org,
       lse <lse-tech@lists.sourceforge.net>
Cc: Bill Hartner <Bill_Hartner@us.ibm.com>
Subject: RE: [Lse-tech] [RFC]  per cpu slab fix to reduce freemiss
Date: Mon, 29 Jul 2002 09:47:54 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mala,

You don't specify any details of how the "singly linked list of
free objects" would be implemented.  You cannot use any of the
memory in the freed object (as the constructor for a slab is only
called when memory is first allocated, not when an object is recycled)
so using any part of the object might confuse a caller by giving them
a corrupted object.

Are you going to have some external structure to maintain the linked
list?  Or secretly enlarge the object to provide space for the link,
or some other way?

-Tony

-----Original Message-----
From: Mala Anand [mailto:manand@us.ibm.com]
Sent: Friday, July 26, 2002 7:30 PM
To: linux-kernel@vger.kernel.org; lse
Cc: Bill Hartner
Subject: Re: [Lse-tech] [RFC] per cpu slab fix to reduce freemiss



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








-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
Lse-tech mailing list
Lse-tech@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/lse-tech
