Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315214AbSHVRUw>; Thu, 22 Aug 2002 13:20:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315178AbSHVRTq>; Thu, 22 Aug 2002 13:19:46 -0400
Received: from e21.nc.us.ibm.com ([32.97.136.227]:49370 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S314548AbSHVRTL>; Thu, 22 Aug 2002 13:19:11 -0400
Subject: Re: [Lse-tech] Re: (RFC): SKB Initialization
To: Benjamin LaHaise <bcrl@redhat.com>
Cc: alan@lxorguk.ukuu.org.uk, Bill Hartner <bhartner@us.ibm.com>,
       davem@redhat.com, linux-kernel@vger.kernel.org,
       lse-tech@lists.sourceforge.net, lse-tech-admin@lists.sourceforge.net
X-Mailer: Lotus Notes Release 5.0.7  March 21, 2001
Message-ID: <OF126E7130.D54285DD-ON87256C1C.0077A747@boulder.ibm.com>
From: "Mala Anand" <manand@us.ibm.com>
Date: Thu, 22 Aug 2002 12:22:34 -0500
X-MIMETrack: Serialize by Router on D03NM123/03/M/IBM(Release 5.0.10 |March 22, 2002) at
 08/22/2002 11:22:34 AM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>On Wed, Aug 21, 2002 at 01:07:09PM -0500, Mala Anand wrote:
>>
>> >On Wed, Aug 21, 2002 at 11:59:44AM -0500, Mala Anand wrote:
>> >> The patch reduces the number of cylces by 25%
>>
>> >The data you are reporting is flawed: where are the average cycle
>> >times spent in __kfree_skb with the patch?
>>
>> I measured the cycles for only the initialization code in alloc_skb
>> and __kfree_skb. Since the init code is removed from __kfree_skb,
>> no cycles are spent there.

>Then the testing technique is flawed.  You should include all of the
>operations included in an alloc_skb/kfree_skb pair in order to see
>the overall effect of the change, otherwise your change could have a
>net negative effect which would not be noticed.

Cycles for the whole routines alloc_skb and __kfree_skb are as follows:

Baseline 2.5.25
----------------
       alloc/free average cycles
       -------------------------
Runs:      1st              2nd          3rd

CPU0:    337/1163       336/1132      304/1100
CPU1:    318/1164       309/1153      311/1127


2.5.25+skbinit patch
--------------------

       alloc/free average cycles
       -------------------------
Runs:      1st          2nd            3rd

CPU0:   447/1015       580/846        402/905
CPU1:   419/1003       383/915        547/856

The above figures indicate that the cycles spent in alloc_skb and
__kfree_skb have gained 5% in the patch case.  However if you
take the absolute cycles and average them for the three runs it
comes around 145 cycles saving that is close to what I posted earlier
by measuring just the changed code. As the scope of the code measured
widens the percentage improvement comes down.

So the first two scopes, 1. measuring the cycles spent in changed code
2. measuring the cycles spent in alloc_skb and __kfree_skb, results
are consistent.

The third scope would be measuring this patch in a workload environment.
We measured it in a web serving workload and found that we get 0.7%
improvement.

I would like to stress again that this patch helps only when the
allocations
and frees occur on two different CPUs.  I measured it in a UNI system and
did not see any impact.

Regards,
    Mala


   Mala Anand
   IBM Linux Technology Center - Kernel Performance
   E-mail:manand@us.ibm.com
   http://www-124.ibm.com/developerworks/opensource/linuxperf
   http://www-124.ibm.com/developerworks/projects/linuxperf
   Phone:838-8088; Tie-line:678-8088




                                                                                                                                               
                      Benjamin LaHaise                                                                                                         
                      <bcrl@redhat.com>                To:       Mala Anand/Austin/IBM@IBMUS                                                   
                      Sent by:                         cc:       alan@lxorguk.ukuu.org.uk, Bill Hartner/Austin/IBM@IBMUS, davem@redhat.com,    
                      lse-tech-admin@lists.sour         linux-kernel@vger.kernel.org, lse-tech@lists.sourceforge.net                           
                      ceforge.net                      Subject:  [Lse-tech] Re: (RFC): SKB Initialization                                      
                                                                                                                                               
                                                                                                                                               
                      08/21/02 01:16 PM                                                                                                        
                                                                                                                                               
                                                                                                                                               



On Wed, Aug 21, 2002 at 01:07:09PM -0500, Mala Anand wrote:
>
> >On Wed, Aug 21, 2002 at 11:59:44AM -0500, Mala Anand wrote:
> >> The patch reduces the numer of cylces by 25%
>
> >The data you are reporting is flawed: where are the average cycle
> >times spent in __kfree_skb with the patch?
>
> I measured the cycles for only the initialization code in alloc_skb
> and __kfree_skb. Since the init code is removed from __kfree_skb,
> no cycles are spent there.

Then the testing technique is flawed.  You should include all of the
operations included in an alloc_skb/kfree_skb pair in order to see
the overall effect of the change, otherwise your change could have a
net negative effect which would not be noticed.

                         -ben
--
"You will be reincarnated as a toad; and you will be much happier."


-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
_______________________________________________
Lse-tech mailing list
Lse-tech@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/lse-tech





