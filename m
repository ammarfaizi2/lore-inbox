Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262359AbSJIXTy>; Wed, 9 Oct 2002 19:19:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263039AbSJIXQ0>; Wed, 9 Oct 2002 19:16:26 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.103]:11407 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S262937AbSJIXPc>;
	Wed, 9 Oct 2002 19:15:32 -0400
Subject: Re: 2.5.40-mm1 
To: akpm@digeo.com, lkml <linux-kernel@vger.kernel.org>,
       "linux-mm@kvack.org" <linux-mm@kvack.org>
Cc: "Bill Hartner" <bhartner@us.ibm.com>
X-Mailer: Lotus Notes Release 5.0.7  March 21, 2001
Message-ID: <OF13BF2DC5.95D8249D-ON87256C4C.00509A83@boulder.ibm.com>
From: "Mala Anand" <manand@us.ibm.com>
Date: Wed, 9 Oct 2002 18:20:52 -0500
X-MIMETrack: Serialize by Router on D03NM123/03/M/IBM(Release 5.0.10 |March 22, 2002) at
 10/09/2002 05:20:53 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>Andrew Morton wrote:

>So.  Patch is a huge win as-is.  For the PIII it looks like we need
>to enable it at all alignments except mod32.  And we need to test
>with aligned dest, unaligned source.

Pentium III (coppermine) 997Mhz 2-way
Read from pagecache to user buffer misaligning the source
Size of copy is 262144 and the number of iterations copied for
each test is 16384.
      Patch++ - uses copy_user_int if size > 64
      Patch - uses copy_user_int if size > 64, or src and dst
              are not aligned on an 8 byte boundary

dst aligned on an 4k and src misaligned

          2.5.40       2.5.40+patch     2.5.40+patch++
Align    throughout     throughput      throughput
(bytes)   KB/sec          KB/sec        KB/sec
0         275592          281356        285567
1         124266          197361
2         120157          200270
4         125935          197558
8         157244          156655        162189
16        167296          173202        173702
32        283731          285222        290810

Looks like the patch can be used for all the above tested
alignments on Pentium III.
>Can you please do some P4 testing?

P4 Xeon CPU 1.50 GHz 4-way - hyperthreading disabled
Src is aligned and dst is misaligned as follows:

 Dst      2.5.40       2.5.40+patch     2.5.40+patch++
Align    throughout     throughput      throughput
(bytes)   KB/sec          KB/sec        KB/sec
  0       1360071         1314783        912359
  1       323674           340447
  2       329202           336425
  4       512955           693170
  8       523223           615097        506641
 12       517184           558701        553700
 16       966598           872080        932736
 32       846937           838514        845178

I see too much variance in the test results so I ran
each test 3 times. I tried increasing the iterations
but it did not reduce the variance.

Dst is aligned and src is misaligned as follows:

 Dst      2.5.40       2.5.40+patch
Align    throughout     throughput
(bytes)   KB/sec          KB/sec
  0       1275372       1029815
  1        529907        511815
  2        534811        530850
  4        643196        627013
  8        568000        626676
 12        574468        658793
 16        631707        635979
 32        741485        592938

Since there is 5 - 10% variance in these test's results I am not
sure whether we can use this data to validate. I will try
to run this on another pentium 4 machine.

However I have seen using floating point registers instead of integer
registers on Pentium IV improves performance to a greater extent on
some alignments. I need to do more testing and then I will create a
patch for pentium IV.

Regards,
    Mala


   Mala Anand
   IBM Linux Technology Center - Kernel Performance
   E-mail:manand@us.ibm.com
   http://www-124.ibm.com/developerworks/opensource/linuxperf
   http://www-124.ibm.com/developerworks/projects/linuxperf
   Phone:838-8088; Tie-line:678-8088




