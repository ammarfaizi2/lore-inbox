Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751337AbWCVPa0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751337AbWCVPa0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 10:30:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751332AbWCVPaZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 10:30:25 -0500
Received: from smtp.osdl.org ([65.172.181.4]:56039 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751339AbWCVPaX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 10:30:23 -0500
Date: Wed, 22 Mar 2006 07:30:06 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Knut Petersen <Knut_Petersen@t-online.de>
cc: Dave Jones <davej@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [BUG] wrong bogomips  values with kernel 2.6.16
In-Reply-To: <4420DE54.1020004@t-online.de>
Message-ID: <Pine.LNX.4.64.0603220717270.26286@g5.osdl.org>
References: <441FFB28.5050609@t-online.de> <Pine.LNX.4.64.0603211004250.3622@g5.osdl.org>
 <4420DE54.1020004@t-online.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 22 Mar 2006, Knut Petersen wrote:
> 
> All Pentium M, Xeon up to model 2 and the P6 family increment with every
> internal processor cycle.

Just to humor me. Try the bogomips loop in user space with something like 
the appended (make sure the frequency is fixed to the lowest frequency).

		Linus
---
#include <stdio.h>
#include <sys/time.h>

#define read_tsc(r) asm volatile("rdtsc":"=A" (r))

int main(int argc, char **argv)
{
	struct timeval a;
	unsigned long start, end;
	unsigned long mhz, low;

	gettimeofday(&a, NULL);
	read_tsc(start);
	for (;;) {
		unsigned long usec;
		struct timeval b;
		gettimeofday(&b, NULL);
		usec = (b.tv_sec - a.tv_sec)*1000000;
		usec += b.tv_usec - a.tv_usec;
		if (usec >= 1000000)
			break;
	}
	read_tsc(end);
	end -= start;
	mhz = end / 1000000;
	low = end % 1000000;
	printf("TSC: %lu.%06lu MHz\n", mhz, low);
	return 0;
}
