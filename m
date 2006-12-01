Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758196AbWLAFvI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758196AbWLAFvI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 00:51:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759111AbWLAFvI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 00:51:08 -0500
Received: from smtpout.mac.com ([17.250.248.176]:10232 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S1758196AbWLAFvF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 00:51:05 -0500
In-Reply-To: <MDEHLPKNGKAHNMBLJOLKOEGKAAAC.davids@webmaster.com>
References: <MDEHLPKNGKAHNMBLJOLKOEGKAAAC.davids@webmaster.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <A3610BE9-66B4-452A-9EEB-D2620A4958E2@mac.com>
Cc: "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: [patch 2.6.19-rc6] Stop gcc 4.1.0 optimizing wait_hpet_tick away
Date: Fri, 1 Dec 2006 00:50:59 -0500
To: davids@webmaster.com
X-Mailer: Apple Mail (2.752.2)
X-Brightmail-Tracker: AAAAAA==
X-Brightmail-scanned: yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Nov 29, 2006, at 20:04:28, David Schwartz wrote:
> Ask yourself this question: Can an assignment to a non-volatile  
> variable be optimized out?  Then ask yourself this question: Does  
> casting away volatile make it not volatile any more?

Hmm, let's put this in a C file:
> int my_global = 0;

And put this in a header:
> extern int my_global;
> static int my_func(int a)
> {
> 	return a + my_global++;
> }

Now put this in another source file
> #include <my_header.h>
>
> int main()
> {
> 	while (my_func(3) < 5)
> 		printf("It hasn't happened yet!\n");
> 	return 0;
> }

The obvious result is that it prints "It hasn't happened yet!"  
twice.  On the third iteration when my_global == 2 it breaks out of  
the loop.  This is all fairly standard C so far.

Imagine we change the code to read from some auto-increment hardware  
at a specific MMIO address instead of a global:
> static int my_func(int a)
> {
> 	return a + *(volatile int *)(0xABCD1234);
> }

But you're telling me that the change in the header file (where the  
new function returns the exact same series of values with every call  
as the old) causes the program to enter an infinite loop?

How do you rationalize this again?

> The 'readl' function should actually assign the value to a volatile  
> variable. Assignments to volatiles cannot be cast away, but casts  
> can and assignments to non-volatile variables can be optimized out.

Actually, no.  The reason for the volatile in the pointer dereference  
is to force the memory access to *always* happen.  It's a guarantee  
that the compiler will do that memory access every time it appears.   
You have a volatile int afterwards and what you do with that nobody  
cares.  The point is the presence of the volatile in a single pointer- 
dereference forcibly turns off any optimization of that specific  
access, including loop unrolling and such.

Cheers,
Kyle Moffett

