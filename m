Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318732AbSHAMjE>; Thu, 1 Aug 2002 08:39:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318743AbSHAMjE>; Thu, 1 Aug 2002 08:39:04 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:16046 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S318732AbSHAMjD>;
	Thu, 1 Aug 2002 08:39:03 -0400
Subject: RE: [Lse-tech] [RFC]  per cpu slab fix to reduce freemiss
To: "Luck, Tony" <tony.luck@intel.com>, linux-kernel@vger.kernel.org,
       lse <lse-tech@lists.sourceforge.net>
Cc: Bill Hartner <Bill_Hartner@us.ibm.com>
X-Mailer: Lotus Notes Release 5.0.7  March 21, 2001
Message-ID: <OFAA15AB55.4677568D-ON87256C07.0049E839@boulder.ibm.com>
From: "Mala Anand" <manand@us.ibm.com>
Date: Thu, 1 Aug 2002 07:42:10 -0500
X-MIMETrack: Serialize by Router on D03NM123/03/M/IBM(Release 5.0.10 |March 22, 2002) at
 08/01/2002 06:42:04 AM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Tony Luck wrote..
>> No I am using the object(beginning space) to store the links. When
>> allocated, I can initialize the space occupied by the link address.

>You can't use the start of the object (or any other part) in this way,
>you'll have no way to restore the value you overwrote.

>Take a look at Jeff Bonwick's paper on slab allocators which explains
>this a lot better than I can:

>
http://www.usenix.org/publications/library/proceedings/bos94/full_papers/bon

>wick.a

 I read the document and see that I cannot use the object space even
when the object is free.  However I would like to know how much of this
assumption is used in the Linux Kernel code.  Looking through the tcpip
stack code I realized that most of the caches(tcp_opne_request,
tcp_bind_bucket, tcp_tw_bucket, inet_peer_cache etc.,) do not have
constructors and destructors.Some of the caches have them ofcourse.
Skbs have constructor, however the code executes constructor before
freeing the object and initializes the rest of the fields during
allocation.  In this case, this feature of preserving the object
between uses do not eliminate any of the object initialization code.
Having said that I would like to know if in any part of the Linux code
is taking advantage of this assumption. That is, the object is preserved
by the slab allocator between uses so the user does not have to
reinitialize.

Furthermore I think this design does not take into consideration of
multiprocessor issues such as cache-bouncing, cache-warmthness etc.,
And also the original implementation of the slab cache in the Linux
kernel did not have per cpu support (I am not sure if the paper takes
into consideration of SMP etc., also). So this assumption needs to be
examined in the light of SMP, NUMA etc., I would like to explore the
possibility of changing this assumption if possible in lieu of SMP/NUMA
cache effects.

In the present design there is a limit on how many free objects are held
in the per cpu array. So when an object is freed it might end in another
cpu more often.  The main cost lies in memory latency than execution of
initializing the fields.  I doubt if we get the same gain as explained in
the paper by preserving the fields between uses on an SMP/NUMA machines.

I agree that preserving read only variables that can be used between uses
will help performance. We still can do that by revising the assumption to
leave the first 4 or whatever bytes needed to store the links. What do you
think?



Regards,
    Mala


   Mala Anand
   IBM Linux Technology Center - Kernel Performance
   E-mail:manand@us.ibm.com
   Phone:838-8088; Tie-line:678-8088




