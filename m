Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129735AbQJ0KMT>; Fri, 27 Oct 2000 06:12:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129724AbQJ0KMJ>; Fri, 27 Oct 2000 06:12:09 -0400
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:19177 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id <S129655AbQJ0KLz>; Fri, 27 Oct 2000 06:11:55 -0400
From: kumon@flab.fujitsu.co.jp
Date: Fri, 27 Oct 2000 19:11:19 +0900
Message-Id: <200010271011.TAA23564@asami.proc.flab.fujitsu.co.jp>
To: Alexander Viro <viro@math.psu.edu>
Cc: "Jeff V. Merkey" <jmerkey@timpanogas.org>, kumon@flab.fujitsu.co.jp,
        Rik van Riel <riel@conectiva.com.br>, linux-kernel@vger.kernel.org
Subject: Re: Negative scalability by removal of lock_kernel()?(Was: Strange
  performance behavior of 2.4.0-test9)
In-Reply-To: <Pine.GSO.4.21.0010270257550.18660-100000@weyl.math.psu.edu>
In-Reply-To: <39F92187.A7621A09@timpanogas.org>
	<Pine.GSO.4.21.0010270257550.18660-100000@weyl.math.psu.edu>
Reply-To: kumon@flab.fujitsu.co.jp
Cc: kumon@flab.fujitsu.co.jp
X-Mailer: Handmade Mailer version 1.0
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Viro writes:
 > BTW, what spinlocks get contention in variant without BKL? And what about
 > comparison between the BKL and non-BKL versions? If it's something like
 > 	BKL	no BKL
 > 4-way	50	20
 > 8-way	30	30
 > - something is certainly wrong, but restoring the BKL is _not_ a win.

the measured performance is:
			4way->8way
	2.4.0-test1	2816->3702 (31%up)
	2.4.0-test8	4006->5287 (63%up)
	2.4.0-test9	3669->2193 (40%down)

So, roughly speaking,
 	BKL	no BKL
4-way	40	36
8-way	53	22
	- Above are the comparison between test8 and test9.

Test9 with BKL shows 5249 @8way, nearly equal to test8 @8way.

 > scenarios, but... Seriously, folks, could you compare the 4 variants above
 > and gather the contention data for the -test9 on your loads? That would help
 > a lot.

What kind of contention data you requested?
* kernel-lock spining time
* semaphore task switching time
 ...

Now, I understand the difference of test8 and test9.
test8 uses kernel_lock() to protect critical region,
test9 uses up/down semaphor for that.

FYI, I resend following data again.

> The following table shows one minute average of "vmstat 1".
> 
>  configuration Req/s    | r     b       intr    c-sw    user    os      idle
> ------------------------+--------------------------------------------------
> 2.4.0t1 4cpu    2816    | 60    0       28877    5103   18      82       0 
>         8cpu    3702    | 37    0       33495   16387   14      86       0 
> 2.4.0t8 4cpu    4066    | 57    0       38743    8674   27      73       0 
>         8cpu    5287    | 33    0       40755   30626   21      78       0 
> 2.4.0t9 4cpu    3669    | 53    3       35822   18898   25      73       2 
>         8cpu    2193    |  5    8       22114   94609    9      52      39 

context switch count on test9 is 2-3 times bigger.

And, using the above table, average transaction time and its
breakdowns can be calculated as follows.

		time/req	USER	OS	IDLE
 2.4.0t1 4cpu    1.42ms    |	0.26ms	1.16ms	   0ms
         8cpu    2.16ms    |	0.30ms	1.85ms	   0ms
 2.4.0t8 4cpu    0.98ms    |	0.26ms	0.72ms	   0ms
         8cpu    1.44ms    |	0.30ms	1.12ms	   0ms
 2.4.0t9 4cpu    1.09ms    |	0.27ms	0.80ms	0.02ms
         8cpu    3.65ms    |	0.33ms	1.90ms	1.42ms

Test9 needs longer OS time than test8, especialy on 8cpu (80% longer).
Test9 needs longer USER time than test8 on 8cpu.
Test9 idle too much.

Frequent context switchs eat OS time.
Frequent process migrations eat USER time.

I think, the critical region is too small to be protected by semaphor
and task-switch.

--
Computer Systems Laboratory, Fujitsu Labs.
kumon@flab.fujitsu.co.jp
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
