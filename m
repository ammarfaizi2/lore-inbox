Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262792AbSJ1Amw>; Sun, 27 Oct 2002 19:42:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262795AbSJ1Amw>; Sun, 27 Oct 2002 19:42:52 -0500
Received: from franka.aracnet.com ([216.99.193.44]:11234 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S262792AbSJ1Amu>; Sun, 27 Oct 2002 19:42:50 -0500
Date: Sun, 27 Oct 2002 16:46:22 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
Reply-To: "Martin J. Bligh" <mbligh@aracnet.com>
To: Erich Focht <efocht@ess.nec.de>
cc: Michael Hohnbaum <hohnbaum@us.ibm.com>, mingo@redhat.com,
       habanero@us.ibm.com, linux-kernel@vger.kernel.org,
       lse-tech@lists.sourceforge.net
Subject: Re: NUMA scheduler  (was: 2.5 merge candidate list 1.5)
Message-ID: <3129290732.1035737182@[10.10.2.3]>
In-Reply-To: <200210280132.33624.efocht@ess.nec.de>
References: <200210280132.33624.efocht@ess.nec.de>
X-Mailer: Mulberry/2.1.2 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OK, so I tried Michael's without the balance_exec code as well,
then Erich's main patch with Michael's balance_exec (which seems
to be cheaper to calculate). Turns out I was actually running an
older version of Michael's patch .... with his latest stuff it
actually seems to perform better pretty much across the board
(comaring 2.5.44-mm4-focht-12 and 2.5.44-mm4-hbaum-12). And it's
also a lot simpler. 

Erich, what does all the pool stuff actually buy us over what
Michael is doing? Seems to be rather more complex, but maybe
it's useful for something we're just not measuring here?

              2.5.44-mm4     Virgin
      2.5.44-mm4-focht-1     Focht main
      2.5.44-mm4-hbaum-1     Hbaum main
     2.5.44-mm4-focht-12     Focht main + Focht balance_exec
      2.5.44-mm4-hbaum-1     Hbaum main + Hbaum balance_exec
        2.5.44-mm4-f1-h2     Focht main + Hbaum balance_exec

Kernbench:
                             Elapsed        User      System         CPU
              2.5.44-mm4     19.676s    192.794s     42.678s     1197.4%
      2.5.44-mm4-focht-1      19.46s    189.838s     37.938s       1171%
      2.5.44-mm4-hbaum-1     19.746s    189.232s     38.354s     1152.2%
     2.5.44-mm4-focht-12      20.32s        190s       44.4s     1153.6%
     2.5.44-mm4-hbaum-12     19.322s    190.176s     40.354s     1192.6%
        2.5.44-mm4-f1-h2     19.398s    190.118s      40.06s       1186%

Schedbench 4:
                             Elapsed   TotalUser    TotalSys     AvgUser
              2.5.44-mm4       32.45       49.47      129.86        0.82
      2.5.44-mm4-focht-1       38.61       45.15      154.48        1.06
      2.5.44-mm4-hbaum-1       37.81       46.44      151.26        0.78
     2.5.44-mm4-focht-12       23.23       38.87       92.99        0.85
     2.5.44-mm4-hbaum-12       22.26       34.70       89.09        0.70
        2.5.44-mm4-f1-h2       21.39       35.97       85.57        0.81

Schedbench 8:
                             Elapsed   TotalUser    TotalSys     AvgUser
              2.5.44-mm4       39.90       61.48      319.26        2.79
      2.5.44-mm4-focht-1       37.76       61.09      302.17        2.55
      2.5.44-mm4-hbaum-1       43.18       56.74      345.54        1.71
     2.5.44-mm4-focht-12       28.40       34.43      227.25        2.09
     2.5.44-mm4-hbaum-12       30.71       45.87      245.75        1.43
        2.5.44-mm4-f1-h2       36.11       45.18      288.98        2.10

Schedbench 16:
                             Elapsed   TotalUser    TotalSys     AvgUser
              2.5.44-mm4       62.99       93.59     1008.01        5.11
      2.5.44-mm4-focht-1       51.69       60.23      827.20        4.95
      2.5.44-mm4-hbaum-1       52.57       61.54      841.38        3.93
     2.5.44-mm4-focht-12       51.24       60.86      820.08        4.23
     2.5.44-mm4-hbaum-12       52.33       62.23      837.46        3.84
        2.5.44-mm4-f1-h2       51.76       60.15      828.33        5.67

Schedbench 32:
                             Elapsed   TotalUser    TotalSys     AvgUser
              2.5.44-mm4       88.13      194.53     2820.54       11.52
      2.5.44-mm4-focht-1       56.71      123.62     1815.12        7.92
      2.5.44-mm4-hbaum-1       54.57      153.56     1746.45        9.20
     2.5.44-mm4-focht-12       55.69      118.85     1782.25        7.28
     2.5.44-mm4-hbaum-12       54.36      135.30     1739.95        8.09
        2.5.44-mm4-f1-h2       55.97      119.28     1791.39        7.20

Schedbench 64:
                             Elapsed   TotalUser    TotalSys     AvgUser
              2.5.44-mm4      159.92      653.79    10235.93       25.16
      2.5.44-mm4-focht-1       55.60      232.36     3558.98       17.61
      2.5.44-mm4-hbaum-1       71.48      361.77     4575.45       18.53
     2.5.44-mm4-focht-12       56.03      234.45     3586.46       15.76
     2.5.44-mm4-hbaum-12       56.91      240.89     3642.99       15.67
        2.5.44-mm4-f1-h2       56.48      246.93     3615.32       16.97

