Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261457AbVFMKG3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261457AbVFMKG3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 06:06:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261455AbVFMKG3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 06:06:29 -0400
Received: from colin.muc.de ([193.149.48.1]:26376 "EHLO mail.muc.de")
	by vger.kernel.org with ESMTP id S261457AbVFMKGF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 06:06:05 -0400
Date: 13 Jun 2005 12:06:04 +0200
Date: Mon, 13 Jun 2005 12:06:04 +0200
From: Andi Kleen <ak@muc.de>
To: Jacob Martin <martin@cs.uga.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM:  OOPSes in PREEMPT SMP for AMD Opteron Dual-Core with Memhole Mapping (non tainted kernel)
Message-ID: <20050613100604.GA18976@muc.de>
References: <200506071836.12076.martin@cs.uga.edu> <m1wtp1ch07.fsf@muc.de> <200506121529.50259.martin@cs.uga.edu>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="AhhlLboLdkugWU4S"
Content-Disposition: inline
In-Reply-To: <200506121529.50259.martin@cs.uga.edu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--AhhlLboLdkugWU4S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Jun 12, 2005 at 03:29:50PM -0400, Jacob Martin wrote:
> Hardware memhole mapping never seems to work, or causes lockups right away.  I 
> need to test it further though.
> 
> I have discovered that with the following features enabled:
> 
> 1.  Software memhole mapping
> 2.  Continuous,
> 
> linux sees the entire 4GB of memory.  However, when things start getting 
> requested from the upper half, there are Oopses generated.  Attached are two 
> Oopses that occurred under the test scenario described.  

What happens when you boot with numa=off or with numa=noacpi ? 

The system seems to believe it has memory in an area not covered
by mem_map.


> launch big memory apps.
> 
> I suppose I could write a program to consume/probe the upper memory half.  
> Anyone know of a good/quicky way to do that?  

You can use the attached program which I often use for similar purposes.
It writes nearly all free memory in a loop and also often triggers memory 
problems.

-Andi


--AhhlLboLdkugWU4S
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="memeat.c"

#define _GNU_SOURCE 1
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
int main(void)
{
	size_t linelen = 0;
	char *line = NULL;
	unsigned long freemem = 0;
	FILE *f = fopen("/proc/meminfo", "r");
	while (getdelim(&line, &linelen, '\n', f) > 0) { 
		if (sscanf(line, "LowFree: %lu", &freemem) == 1)
			break; 
	} 

	freemem *= 1024; 

	freemem -= freemem/20;
	char *s = malloc(freemem);
	if (s) {
		long i;
		for (;;) { 
		printf("\nwrite\n");
		for (i = 0; i < freemem; i += 10*1024*1024) {
			long w = freemem - i;
			if (w > 10*1024*1024)
				w = 10*1024*1024;
			memset(s + i, 0xff, w);
			putchar('.');
			fflush(stdout);
		}
		printf("\nread\n");
		for (i = 0; i < freemem; i += 10*1024*1024) {
			long w = freemem - i;
			if (w > 10*1024*1024)
				w = 10*1024*1024;
			memcpy(s, s + i, w);
			putchar('.');
			fflush(stdout);
		}
		}
	} else
		printf("Cannot allocate memory\n");
	
	return 0;
}

--AhhlLboLdkugWU4S--
