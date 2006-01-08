Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030628AbWAHJ5r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030628AbWAHJ5r (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jan 2006 04:57:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030629AbWAHJ5r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jan 2006 04:57:47 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:39692 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S1030628AbWAHJ5q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jan 2006 04:57:46 -0500
Date: Sun, 8 Jan 2006 10:57:41 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Grant Coady <gcoady@gmail.com>
Cc: Markus Rechberger <mrechberger@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: Why is 2.4.32 four times faster than 2.6.14.6??
Message-ID: <20060108095741.GH7142@w.ods.org>
References: <l6b1s152vo49j7dmthvbhoqej1modrs2k7@4ax.com> <d9def9db0601072258v39ac4334kccc843838b436bba@mail.gmail.com> <gre1s1lkr687o2npgom26gqq3etgjdjgpo@4ax.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <gre1s1lkr687o2npgom26gqq3etgjdjgpo@4ax.com>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Grant,

On Sun, Jan 08, 2006 at 06:28:53PM +1100, Grant Coady wrote:
> On Sun, 8 Jan 2006 07:58:09 +0100, Markus Rechberger <mrechberger@gmail.com> wrote:
> 
> >Were there any other processes running during the test?
> box runs same config both kernels: the usual light load ~100% idle ;)
> >what does "vmstat 1" show up during the test?
> 
> grant@deltree:~$ uname -r
> 2.6.14.6a
> grant@deltree:~$ vmstat 1
> procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
>  r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
> [...]
>  0  0      0  63800  11520  32352    0    0     0     0  110    18  0  0 100  0
>  0  0      0  63800  11520  32352    0    0     0     0  106    17  1  0 99  0
>  3  0      0  63560  11520  32352    0    0     0     0  346   502 22  9 69  0
>  1  0      0  63560  11520  32352    0    0     0     0 1057  1987 59 41  0  0
>  1  0      0  63560  11520  32352    0    0     0     0 1062  2011 59 41  0  0
>  1  0      0  63560  11520  32352    0    0     0     0 1053  2001 50 50  0  0
>  1  0      0  63500  11596  32352    0    0     0   136 1054  1974 61 39  0  0
>  1  0      0  63500  11596  32352    0    0     0     0 1040  1978 50 50  0  0
>  0  0      0  63620  11596  32352    0    0     0     0  799  1425 45 27 29  0
>  0  0      0  63620  11596  32352    0    0     0     0  104    12  0  0 100  0
>  0  0      0  63620  11596  32352    0    0     0     0  103    10  0  0 100  0
> 
> grant@deltree:~$ uname -r
> 2.4.32-hf32.1
> grant@deltree:~$ vmstat 1
> procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
>  r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
> [...]
>  0  0      0  83192   6532  21404    0    0     0     0  104    12  0  1 99  0
>  0  0      0  83152   6572  21404    0    0     0    80  116    24  0  1 99  0
>  1  0      0  82952   6572  21404    0    0     0     0  168   130  6  5 89  0
>  2  0      0  82952   6572  21404    0    0     0     0  667  1019 65 35  0  0
>  0  0      0  83152   6572  21404    0    0     0     0  297   378 41 10 49  0
>  0  0      0  83152   6572  21404    0    0     0     0  104     9  0  1 99  0
>  0  0      0  83064   6656  21404    0    0     0   304  169   121  0  1 99  0
>  0  0      0  83064   6656  21404    0    0     0     0  137    42  0  2 98  0

It's rather strange that 2.6 *eats* CPU apparently doing nothing ! At first
I thought about a PIO/DMA problemn but we can clearly see that there's no
IO in on both vmstat. Could you please retest :
  - without the pipe (remove '| cut ...') to avoid inter-process
    communications
  - with cat instead of grep to ensure you don't spend time processing
    anything

You should be able to find one simple pattern which makes the problem
appear/disappear on 2.6. At least, 'cat x.log >/dev/null' should not
take time or that time should be spent in I/O. I remember an old test
I did a long time ago which behaved badly on 2.6, it consisted in lots
of pipes (eg: dd bs=1 | dd bs=1 |...). May be you're on a simplified
form of this.

> -- 
> Thanks,
> Grant.
> http://bugsplatter.mine.nu/

Cheers,
Willy

