Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751187AbVJ2QAr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751187AbVJ2QAr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Oct 2005 12:00:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751213AbVJ2QAr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Oct 2005 12:00:47 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:43535 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1751187AbVJ2QAq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Oct 2005 12:00:46 -0400
Date: Sat, 29 Oct 2005 17:00:19 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Michal Srajer <michal@mat.uni.torun.pl>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] include/linux/etherdevice.h, kernel 2.6.14
Message-ID: <20051029160019.GB14039@flint.arm.linux.org.uk>
Mail-Followup-To: Michal Srajer <michal@mat.uni.torun.pl>,
	Linux Kernel List <linux-kernel@vger.kernel.org>
References: <20051029141046.GA17715@ultra60.mat.uni.torun.pl> <20051029141757.GA14039@flint.arm.linux.org.uk> <20051029154027.GC17715@ultra60.mat.uni.torun.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051029154027.GC17715@ultra60.mat.uni.torun.pl>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please do not drop CC's from discussions on mailing lists.

On Sat, Oct 29, 2005 at 05:40:27PM +0200, Michal Srajer wrote:
> On Sat, Oct 29, 2005 at 03:17:57PM +0100, Russell King wrote:
> > On Sat, Oct 29, 2005 at 04:10:46PM +0200, Michal Srajer wrote:
> > > Description: Very small optimization patch for include/linux/etherdevice.h in 2.6.14 kernel.
> > 
> > How is this an optimisation?
> 
> I wrote C proggram which is about two times faster 
> when using is_zero_ether_addr2 than is_zero_ether_addr1.
> 
> --------cut--------
> typedef unsigned char u8;
> 
> static inline int is_zero_ether_addr1(const u8 *addr)
> {
>        return !(addr[0] | addr[1] | addr[2] | addr[3] | addr[4] | addr[5]);
> }
> 
> static inline int is_zero_ether_addr2(const u8 *addr)
> {
>        return !(addr[0] || addr[1] || addr[2] || addr[3] || addr[4] || addr[5]);
> }
> 
> main () {
>         long i;
>         u8 test_data[6] = {0x00,0x12,0xF0,0x0E,0xC9,0xDE};
>         u8 test_data0[6] = {0x00,0x00,0x00,0x00,0x00,0x00};
>         for (i=0; i<50000000; i++) {
>                 is_zero_ether_addr1(test_data);
>                 is_zero_ether_addr1(test_data0);
>         }
>         return 0;
> }
> --------cut--------
> $ time ./is_zero_ether_addr1_test
> real    0m5.986s
> user    0m5.976s
> sys     0m0.004s
> $ time ./is_zero_ether_addr2_test
> real    0m3.092s
> user    0m3.076s
> sys     0m0.004s
> 
> I use gcc 4.0.3.
> $ gcc is_zero_ether_addr1_test.c -o is_zero_ether_addr1_test
> Should I use some special gcc options?

The test is data dependent.  is_zero_ether_addr1() provides a determinstic
execution time irrespective of the supplied data.

is_zero_ether_addr2() depends on the data supplied, and whether the
architecture is able to optimise it sufficiently well (x86 may be able
to, RISC architectures less so.)

Therefore, the existing code is far more preferable, at least to me.
This is what I get on ARM:

$ /usr/bin/time ./t1
0.66user 0.02system 0:00.68elapsed 98%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+106minor)pagefaults 0swaps
$ /usr/bin/time ./t2
1.10user 0.02system 0:01.13elapsed 99%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+106minor)pagefaults 0swaps
$ /usr/bin/time ./t1
0.67user 0.01system 0:00.68elapsed 98%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+106mino^[[Ar)pagefaults 0swaps
$ /usr/bin/time ./t2
1.11user 0.02system 0:01.12elapsed 100%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+106minor)pagefaults 0swaps
$ /usr/bin/time ./t1
0.67user 0.02system 0:00.69elapsed 99%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+106minor)pagefaults 0swaps
$ /usr/bin/time ./t2
1.11user 0.01system 0:01.12elapsed 99%CPU (0avgtext+0avgdata 0maxresident)k
0inputs+0outputs (0major+106minor)pagefaults 0swaps

where t1 is using is_zero_ether_addr1 and t2 is using
is_zero_ether_addr2.  That's almost twice as long for your "optimised"
version than for the present version.

-- 
Russell King
