Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267674AbTAMPg5>; Mon, 13 Jan 2003 10:36:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267679AbTAMPg5>; Mon, 13 Jan 2003 10:36:57 -0500
Received: from ophelia.ess.nec.de ([193.141.139.8]:2781 "EHLO
	ophelia.ess.nec.de") by vger.kernel.org with ESMTP
	id <S267674AbTAMPgz> convert rfc822-to-8bit; Mon, 13 Jan 2003 10:36:55 -0500
Content-Type: text/plain; charset=US-ASCII
From: Erich Focht <efocht@ess.nec.de>
To: Christoph Hellwig <hch@infradead.org>
Subject: Re: [Lse-tech] Re: NUMA scheduler 2nd approach
Date: Mon, 13 Jan 2003 16:46:10 +0100
User-Agent: KMail/1.4.3
Cc: "Martin J. Bligh" <mbligh@aracnet.com>,
       Michael Hohnbaum <hohnbaum@us.ibm.com>, Robert Love <rml@tech9.net>,
       Ingo Molnar <mingo@elte.hu>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       lse-tech <lse-tech@lists.sourceforge.net>
References: <52570000.1042156448@flay> <200301131232.40600.efocht@ess.nec.de> <20030113152642.A21994@infradead.org>
In-Reply-To: <20030113152642.A21994@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200301131646.10634.efocht@ess.nec.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph,

I just finished some experiments which show that the finetuning can
really be left for later. So this approach is ok for me. I hope we can
get enough support for integrating this tiny numa scheduler. 

I didn't do all possible measurements, the interesting ones are with
patches 1-4 (nb-smooth) and 1-5 (nb-sm-var1, nb-sm-var2) applied. They
show pretty consistent results (within error bars). The fine-tuning in
patch #5 doesn't buy us much right now (on my platform), so we can
leave it out.

Here's the data:

Results on a 8 CPU ia64 machine with 4 nodes (2 CPUs per node).

kernbench:
                elapsed       user          system
      stock52   134.52(0.84)  951.64(0.97)  20.72(0.22)
      sched52   133.19(1.49)  944.24(0.50)  21.36(0.24)
   minsched52   135.47(0.47)  937.61(0.20)  21.30(0.14)
    nb-smooth   133.61(0.71)  944.71(0.35)  21.22(0.22)
   nb-sm-var1   135.23(2.07)  943.78(0.54)  21.54(0.17)
   nb-sm-var2   133.87(0.61)  944.18(0.62)  21.32(0.13)

schedbench/hackbench: time(s)
               10         25         50         100
      stock52  0.81(0.04) 2.06(0.07) 4.09(0.13) 7.89(0.25)
      sched52  0.81(0.04) 2.03(0.07) 4.14(0.20) 8.61(0.35)
   minsched52  1.28(0.05) 3.19(0.06) 6.59(0.13) 13.56(0.27)
    nb-smooth  0.77(0.03) 1.94(0.04) 3.80(0.06) 7.97(0.35)
   nb-sm-var1  0.81(0.05) 2.01(0.09) 3.89(0.21) 8.20(0.34)
   nb-sm-var2  0.82(0.04) 2.10(0.09) 4.19(0.14) 8.15(0.24)

numabench/numa_test 4
               AvgUserTime ElapsedTime TotUserTime TotSysTime
      stock52  ---         27.23(0.52) 89.30(4.18) 0.09(0.01)
      sched52  22.32(1.00) 27.39(0.42) 89.29(4.02) 0.10(0.01)
   minsched52  20.01(0.01) 23.40(0.13) 80.05(0.02) 0.08(0.01)
    nb-smooth  21.01(0.79) 24.70(2.75) 84.04(3.15) 0.09(0.01)
   nb-sm-var1  21.39(0.83) 26.03(2.15) 85.56(3.31) 0.09(0.01)
   nb-sm-var2  22.18(0.74) 27.36(0.42) 88.72(2.94) 0.09(0.01)

numabench/numa_test 8
               AvgUserTime ElapsedTime TotUserTime  TotSysTime
      stock52  ---         27.50(2.58) 174.74(6.66) 0.18(0.01)
      sched52  21.73(1.00) 33.70(1.82) 173.87(7.96) 0.18(0.01)
   minsched52  20.31(0.00) 23.50(0.12) 162.47(0.04) 0.16(0.01)
    nb-smooth  20.46(0.44) 24.21(1.95) 163.68(3.56) 0.16(0.01)
   nb-sm-var1  20.45(0.44) 23.95(1.73) 163.62(3.49) 0.17(0.01)
   nb-sm-var2  20.71(0.82) 23.78(2.42) 165.74(6.58) 0.17(0.01)

numabench/numa_test 16
               AvgUserTime ElapsedTime TotUserTime   TotSysTime
      stock52  ---         52.68(1.51) 390.03(15.10) 0.34(0.01)
      sched52  21.51(0.80) 47.18(3.24) 344.29(12.78) 0.36(0.01)
   minsched52  20.50(0.03) 43.82(0.08) 328.05(0.45)  0.34(0.01)
    nb-smooth  21.12(0.69) 47.42(4.02) 337.99(10.99) 0.34(0.01)
   nb-sm-var1  21.18(0.77) 48.19(5.05) 338.94(12.38) 0.34(0.01)
   nb-sm-var2  21.69(0.91) 49.05(4.36) 347.03(14.49) 0.34(0.01)

numabench/numa_test 32
               AvgUserTime ElapsedTime  TotUserTime   TotSysTime
      stock52  ---         102.60(3.89) 794.57(31.72) 0.65(0.01)
      sched52  21.93(0.57) 92.46(1.10)  701.75(18.38) 0.67(0.02)
   minsched52  20.64(0.10) 89.95(3.16)  660.72(3.13)  0.68(0.07)
    nb-smooth  20.95(0.19) 86.63(1.74)  670.56(6.02)  0.66(0.02)
   nb-sm-var1  21.47(0.54) 90.95(3.28)  687.12(17.42) 0.67(0.02)
   nb-sm-var2  21.45(0.67) 89.91(3.80)  686.47(21.37) 0.68(0.02)


The kernels used:
  - stock52 : 2.5.52 + ia64 patch
  - sched52 : stock52 + old numa scheduler
  - minisched52 : stock52 + miniature NUMA scheduler (cannot load
  balance across nodes)
  - nb-smooth : minisched52 + node balancer + smooth node load patch
  - nb-sm-var1 : nb-smooth + variable internode_lb, (MIN,MAX) = (4,40)
  - nb-sm-var2 : nb-smooth + variable internode_lb, (MIN,MAX) = (1,16)

Best regards,
Erich


On Monday 13 January 2003 16:26, Christoph Hellwig wrote:
> Anyone interested in this cleaned up minimal numa scheduler?  This
> is basically Erich's patches 1-3 with my suggestions applied.
>
> This does not mean I don't like 4 & 5, but I'd rather get a small,
> non-intrusive patch into Linus' tree now and do the fine-tuning later.
>
[...]

