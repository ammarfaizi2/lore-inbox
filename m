Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132359AbRDUAdv>; Fri, 20 Apr 2001 20:33:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132370AbRDUAdl>; Fri, 20 Apr 2001 20:33:41 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:48393 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S132359AbRDUAdV>; Fri, 20 Apr 2001 20:33:21 -0400
Subject: Re: Athlon problem report summary
To: lkml@sigkill.net (Disconnect)
Date: Sat, 21 Apr 2001 01:34:46 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <20010420203029.C20176@sigkill.net> from "Disconnect" at Apr 20, 2001 08:30:29 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14qlMO-0002bj-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Is there anything out there to test/benchmark MMX ops? (Preferably with
> reporting on MMX and equiv non-MMX ops, tunable memory bandwidth, etc.)

I wrote a set of programs to tune the MMX code. Arjan I suspect did similar
when he reoptimised the code for the newer Athlon. Simple stuff like



#include <stdio.h>

char space[1024*1024];
char target[1024*1024];

void mmx_copy(char *from, char *to)
{
	int i;
	char fpu_save[108];
	__asm__ __volatile__ ( " fsave %0; fwait\n"::"m"(fpu_save[0]) );
	__asm__ __volatile__ (
		"  prefetch (%0)\n"
		"  prefetch 64(%0)\n"
		"  prefetch 128(%0)\n"
		"  prefetch 192(%0)\n"
		"  prefetch 256(%0)\n"
		: : "r" (from) );

	for(i=0;i<4096/64;i++)
	{
		__asm__ __volatile__ (
		"  prefetch 320(%0)\n"
		"  movq (%0), %%mm0\n"
		"  movq 8(%0), %%mm1\n"
		"  movq 16(%0), %%mm2\n"
		"  movq 24(%0), %%mm3\n"
		"  movq %%mm0, (%1)\n"
		"  movq %%mm1, 8(%1)\n"
		"  movq %%mm2, 16(%1)\n"
		"  movq %%mm3, 24(%1)\n"
		"  movq 32(%0), %%mm0\n"
		"  movq 40(%0), %%mm1\n"
		"  movq 48(%0), %%mm2\n"
		"  movq 56(%0), %%mm3\n"
		"  movq %%mm0, 32(%1)\n"
		"  movq %%mm1, 40(%1)\n"
		"  movq %%mm2, 48(%1)\n"
		"  movq %%mm3, 56(%1)\n"
		: : "r" (from), "r" (to) : "memory");
		from+=64;
		to+=64;
	}
	__asm__ __volatile__ ( " frstor %0;\n"::"m"(fpu_save[0]) );
}

int main(int argc, char *argv)
{
	char *from=space;
	char *to=target;
	int r;
	int i;
	for(r=0;r<2048;r++)
	{
		for(i=0;i<256;i++)
		{
			mmx_copy(from, to);
			from+=4096;
			to+=4096;
			
		}
		from=space;
		to=target;
	}
}
