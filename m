Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317751AbSHZBFB>; Sun, 25 Aug 2002 21:05:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317752AbSHZBFB>; Sun, 25 Aug 2002 21:05:01 -0400
Received: from mail.cyberus.ca ([216.191.240.111]:56293 "EHLO cyberus.ca")
	by vger.kernel.org with ESMTP id <S317751AbSHZBFA>;
	Sun, 25 Aug 2002 21:05:00 -0400
Date: Sun, 25 Aug 2002 21:02:31 -0400 (EDT)
From: jamal <hadi@cyberus.ca>
To: Mala Anand <manand@us.ibm.com>
cc: <linux-kernel@vger.kernel.org>, <netdev@oss.sgi.com>,
       Robert Olsson <Robert.Olsson@data.slu.se>
Subject: Re: [Lse-tech] Re: (RFC): SKB Initialization
In-Reply-To: <OF7A029023.8004C095-ON87256C20.005B4894@boulder.ibm.com>
Message-ID: <Pine.GSO.4.30.0208252052320.675-100000@shell.cyberus.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 25 Aug 2002, Mala Anand wrote:

>
> Jamal wrote ..
>
> >Can you repeat your tests with the hotlist turned off (i.e set to 0)?
>
>  Even if I turned the hot list, the slab allocator has a per cpu array of
> objects. In this case it keeps by default 60 objects and hot list keeps
> 126 objects. So there may be a difference. I will try this.
>

Well, the hotlist is supposed to be one way to reduce the effect of
initialization.

>  This skb init work is the result of my probing in to the slab cache work.
> Read
> my posting on slab cache:
> http://marc.theaimsgroup.com/?l=linux-kernel&m=102773718023056&w=2
> This work triggered the skb init patch. To quantify the effect of bouncing
> the objects between cpus, I choose skb to measure. And it turns out that
> the
> limited cpu array is not the culprit in this case, it is how the objects
> are
> allocated in one cpu and freed in another cpu is what causing the bouncing
> of objects between cpus.
>

Same conclusion as us then

> >Also Robert and i did a few tests and we did find skb recycling (based on
> >a patch from Robert a few years back) was infact giving perfomance
> >improvements of upto 15% over regular slab.
> >Did you test with that patch for the e1000 he pointed you at?
> >I repeated the tests (around June/July) with the tulip with input rates of
> >a few 100K packets/sec and noticed a improvement over regular NAPI by
> >about 10%. Theres one bug on the tulip which we are chasing that
> >might be related to tulips alignment requirements;
>
> Yes I got the patch from Robert and I am planning on testing the patch. My
> understanding is that skbs are recylced in other operating systems as well
> to
> improve performance. And it particularly helps in architectures where pci
> mapping is expensive and when skbs are recycled, remapping is eliminated.

standard practise for eons on networking in rtoses at least.
Slab on Linux was supposed to get rid of this. Thats why Robert
hid his original patch.

>I think the skbinit patch and recycling skbs are mutually exclusive.

I would say they are more orthogonal than mutually exclusive.
Although ou still need to prove that relocating the code actually helps in
real life. On paper it looks good.

> Recycling
> skbs will reduce the number of times we hit alloc_skb and __kfree_skb.
>

Thats what we see.

> >The idea of only freeing on the same CPU a skb allocated is free with
> >the e1000 NAPI driver style but not in the tulip NAPI  where a txmit
> >interupt might happen on a different CPU. The skb recycler patch only
> >recylces if allocation and freeing are happening on the same CPU;
> >otherwise we let the slab take the hit. On the tulip this happens about
> >50% of the time.
>  So skbinit patch will help the other case.
>

It will. Note, however that on the e1000 style coding, the hit ration is
much higher -- almost 100% in theory at least.
Perhaps its time to convert the tulip ...

cheers,
jamal


