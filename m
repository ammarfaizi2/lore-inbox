Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317488AbSHYUIW>; Sun, 25 Aug 2002 16:08:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317489AbSHYUIV>; Sun, 25 Aug 2002 16:08:21 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:2798 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S317488AbSHYUIU>;
	Sun, 25 Aug 2002 16:08:20 -0400
Subject: Re: [Lse-tech] Re: (RFC): SKB Initialization
To: jamal <hadi@cyberus.ca>
Cc: linux-kernel@vger.kernel.org, "Mala Anand" <manand@us.ibm.com>,
       netdev@oss.sgi.com, Robert Olsson <Robert.Olsson@data.slu.se>
X-Mailer: Lotus Notes Release 5.0.3 (Intl) 21 March 2000
Message-ID: <OF7A029023.8004C095-ON87256C20.005B4894@boulder.ibm.com>
From: "Mala Anand" <manand@us.ibm.com>
Date: Sun, 25 Aug 2002 15:12:06 -0500
X-MIMETrack: Serialize by Router on D03NM123/03/M/IBM(Release 5.0.10 |March 22, 2002) at
 08/25/2002 02:12:08 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Jamal wrote ..

>Could you please at least cc netdev on networking related issues?
>It says so in the kernel FAQ.
>I swore back around 95 to join lk only when Linux gets a IDE maintainer
>who is not insane. Hasnt happened yet.

 Yes I will, it is a mistake from my part,

>Can you repeat your tests with the hotlist turned off (i.e set to 0)?

 Even if I turned the hot list, the slab allocator has a per cpu array of
objects. In this case it keeps by default 60 objects and hot list keeps
126 objects. So there may be a difference. I will try this.

 This skb init work is the result of my probing in to the slab cache work.
Read
my posting on slab cache:
http://marc.theaimsgroup.com/?l=linux-kernel&m=102773718023056&w=2
This work triggered the skb init patch. To quantify the effect of bouncing
the objects between cpus, I choose skb to measure. And it turns out that
the
limited cpu array is not the culprit in this case, it is how the objects
are
allocated in one cpu and freed in another cpu is what causing the bouncing
of objects between cpus.

>Also if you would be doing tests on NAPI please either copy us or netdev;
>it is not nice to read weeks after you post.

 Yes I will.

>Also Robert and i did a few tests and we did find skb recycling (based on
>a patch from Robert a few years back) was infact giving perfomance
>improvements of upto 15% over regular slab.
>Did you test with that patch for the e1000 he pointed you at?
>I repeated the tests (around June/July) with the tulip with input rates of
>a few 100K packets/sec and noticed a improvement over regular NAPI by
>about 10%. Theres one bug on the tulip which we are chasing that
>might be related to tulips alignment requirements;

Yes I got the patch from Robert and I am planning on testing the patch. My
understanding is that skbs are recylced in other operating systems as well
to
improve performance. And it particularly helps in architectures where pci
mapping is expensive and when skbs are recycled, remapping is eliminated. I
think the skbinit patch and recycling skbs are mutually exclusive.
Recycling
skbs will reduce the number of times we hit alloc_skb and __kfree_skb.

>The idea of only freeing on the same CPU a skb allocated is free with
>the e1000 NAPI driver style but not in the tulip NAPI  where a txmit
>interupt might happen on a different CPU. The skb recycler patch only
>recylces if allocation and freeing are happening on the same CPU;
>otherwise we let the slab take the hit. On the tulip this happens about
>50% of the time.
 So skbinit patch will help the other case.

Regards,
    Mala


   Mala Anand
   IBM Linux Technology Center - Kernel Performance
   E-mail:manand@us.ibm.com
   http://www-124.ibm.com/developerworks/opensource/linuxperf
   http://www-124.ibm.com/developerworks/projects/linuxperf
   Phone:838-8088; Tie-line:678-8088






