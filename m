Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261193AbTKDWbd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Nov 2003 17:31:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261332AbTKDWbd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Nov 2003 17:31:33 -0500
Received: from fw.osdl.org ([65.172.181.6]:61058 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261193AbTKDWb2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Nov 2003 17:31:28 -0500
Date: Tue, 4 Nov 2003 14:31:18 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Ulrich Drepper <drepper@redhat.com>
cc: "Bill Rugolsky Jr." <brugolsky@telemetry-investments.com>,
       Paul Venezia <pvenezia@jpj.net>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: ext3 performance inconsistencies, 2.4/2.6
In-Reply-To: <3FA82161.9000507@redhat.com>
Message-ID: <Pine.LNX.4.44.0311041422580.20373-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 4 Nov 2003, Ulrich Drepper wrote:
> 
> I don't see any verison numbers mentioned.  If you want to benchmark
> NPTL use the recent code, e.g., from Fedora Core 1 or RHEL3.  Nothing
> else makes any sense since there have mean countless changes since the
> early releases.

This is actually _really_ trivial to see with a simple test program.

This is Fedora Core test3:

	#include <stdlib.h>

	/* Change this to match your CPU */
	#define NR (10*1000*1000)

	int main(int argc, char **argv)
	{
	        int i;
	        for (i = 0; i < NR; i++)
	                putchar(0);
	}

and then just time it.

I get:

	torvalds@home:~> time ./a.out > /dev/null 

	real    0m1.305s
	user    0m1.283s
	sys     0m0.004s

and

	torvalds@home:~> time LD_ASSUME_KERNEL=2.4.1 ./a.out > /dev/null 
	
	real    0m0.321s
	user    0m0.318s
	sys     0m0.003s

ie a factor of _four_ difference in the speed of "putchar()".

Interestingly, if I compile the program statically, I don't see this 
effect, and it's noticeably faster still:

	torvalds@home:~> gcc -O2 -static test.c 
	torvalds@home:~> time ./a.out > /dev/null 

	real    0m0.193s
	user    0m0.191s
	sys     0m0.002s

	torvalds@home:~> time LD_ASSUME_KERNEL=2.4.1 ./a.out > /dev/null 

	real    0m0.194s
	user    0m0.190s
	sys     0m0.004s

Is the TLS stuff done through an extra dynamically loaded indirection or
something?

		Linus

