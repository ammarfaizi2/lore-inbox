Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261538AbVEaJQP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261538AbVEaJQP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 May 2005 05:16:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261491AbVEaJQP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 May 2005 05:16:15 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:11652 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S261538AbVEaJPn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 May 2005 05:15:43 -0400
From: Denis Vlasenko <vda@ilport.com.ua>
To: Andi Kleen <ak@muc.de>, dean gaudet <dean-list-linux-kernel@arctic.org>,
       Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [RFC] x86-64: Use SSE for copy_page and clear_page
Date: Tue, 31 May 2005 12:15:06 +0300
User-Agent: KMail/1.5.4
Cc: Benjamin LaHaise <bcrl@kvack.org>, linux-kernel@vger.kernel.org
References: <20050530181626.GA10212@kvack.org> <20050530193225.GC25794@muc.de> <200505311137.00011.vda@ilport.com.ua>
In-Reply-To: <200505311137.00011.vda@ilport.com.ua>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200505311215.06495.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 31 May 2005 11:37, Denis Vlasenko wrote:
> On Monday 30 May 2005 22:32, Andi Kleen wrote:
> > Any use of write combining for copy_page/clear_page is a bad idea.
> > The problem is that write combining always forces the destination
> > out of cache.  While it gives you better microbenchmarks your real workloads
> > suffer because they eat lot more additional cache misses when
> > accessing the fresh pages.
> > 
> > Don't go down that path please.
> 
> I doubt it unless real-world data will back your claim up.
> 
> I did microbenchmarking. You said it looks good in microbench but
> hurts real-world.
> 
> Sometime after that I made a patch which allows for switching
> clear/copy routines on the fly, and played a bit with real-world tests.
> 
> See http://www.thisishull.net/showthread.php?t=36562
> 
> In short, I ran forking test programs which excercise clearing and copying
> routines in kernel. I wasn't able to find a usage pattern where page copying
> using SSE non-temporal stores is a loss. Page clear was demonstrably worse,
> no argument about that.

Let me explain what did I test, and how.

[snip explanation why nt store is a loss on small buffer, see
 http://www.thisishull.net/showthread.php?t=36562 if you want to know]

Core of copy test program:

#define N (256/4)
#define SIZE 4096
...
    for(k = 0; k < 5000; k++) {
        int pid;
        pid = fork();
        if(pid == 0) {
            /* child */
            for(i = 0; i < N; i++) mem[i*SIZE+1] = 'b';          /* force copy */
            strchr(mem, 'c') == mem+N*SIZE-1 || printf("BUG\n");        /* read all */
            exit(0);
        } else if(pid == -1) {
	    perror("fork");
        } else {
            /* parent */
            waitpid(pid, NULL, 0);
        }
    }

Each copy test does one fork per one loop.
With each fork, kernel zeroes out 3 pages and copies 8 pages.
This amounts to 12k+32k bytes.

256k copying, 5x5000 loops:
slow: 0m8.036 0m8.063 0m8.192 0m8.233 0m8.252 75600/1800468
mmx_APn: 0m7.461 0m7.496 0m7.543 0m7.687 0m7.725 75586/1800446
mmx_APN: 0m6.351 0m6.366 0m6.378 0m6.382 0m6.525 75586/1800436
mmx_APn/APN: 0m6.412 0m6.448 0m6.501 0m6.663 0m6.669 75584/1800439
^^^^^^^^^^^^ ^^^^^^^^^^^^^^^^^^^^^^^^^time (5 runs)  ^^^^^^^^^^^^^ pages cleared/copied (as reported by patched kernel)
A/a - align/do not align loop
P/p - prefetch/do not prefetch
N/n - nt stores/normal stores
"mmx_APn/APN" means "normal stores for clear and nt stores for copy"
(because nt clear is already known to be bad)

nt stores win as expected on working sets larger tnan cache size

Smaller working set, 44k touched by fork and 20k by copying.
This is still larger than 64k L1 size:

20k copying, 5x20000 loops:
slow: 0m6.610 0m6.665 0m6.694 0m6.750 0m6.774 300315/1300468
mmx_APn: 0m6.208 0m6.218 0m6.263 0m6.335 0m6.452 300352/1300448
mmx_APN: 0m4.887 0m4.984 0m5.021 0m5.052 0m5.057 300295/1300443
mmx_APn/APN: 0m5.115 0m5.160 0m5.167 0m5.172 0m5.183 300292/1300443

Smallest working set possible for this test program.
44k touched by fork and 4k by copying:

4k copying, 5x40000 loops:
slow: 0m8.303 0m8.334 0m8.354 0m8.510 0m8.572 600313/1800473
mmx_APn: 0m8.233 0m8.350 0m8.406 0m8.407 0m8.642 600323/1800467
mmx_APN: 0m6.475 0m6.501 0m6.510 0m6.534 0m6.783 600302/1800436
mmx_APn/APN: 0m6.540 0m6.551 0m6.603 0m6.640 0m6.708 600271/1800442

Unexpectedly, these small ones still run quite noticeably faster
with nt stores!

Why? Simply because small-workspace test did not need to read
back all 32k of data copied by fork. This is also likely to be
the case for the most frequent use of fork: fork+exec.

Thus with "normal" page clear and "nt" page copy routines
both clear and copy benchmarks run faster than with
stock kernel, both with small and large working set.

Am I wrong?
--
vda

