Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261162AbUEVMXP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261162AbUEVMXP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 May 2004 08:23:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261169AbUEVMXP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 May 2004 08:23:15 -0400
Received: from dbl.q-ag.de ([213.172.117.3]:30159 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S261162AbUEVMXB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 May 2004 08:23:01 -0400
Message-ID: <40AF4618.5060300@colorfullife.com>
Date: Sat, 22 May 2004 14:22:48 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.4.1) Gecko/20031114
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: William Lee Irwin III <wli@holomorphy.com>
CC: mpm@selenic.com, linux-kernel@vger.kernel.org
Subject: Re: slab redzoning
References: <20040522034902.GB2161@holomorphy.com> <40AF0911.6020000@colorfullife.com> <20040522082602.GJ2161@holomorphy.com> <40AF12C3.80902@colorfullife.com> <20040522085236.GL2161@holomorphy.com>
In-Reply-To: <20040522085236.GL2161@holomorphy.com>
Content-Type: multipart/mixed;
 boundary="------------030709040309070708060501"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------030709040309070708060501
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

William Lee Irwin III wrote:

>William Lee Irwin III wrote:
>  
>
>>>It returns a false positive when size + 3*BYTES_PER_WORD == 2**n, e.g.
>>>size == 16373. Here, fls(size - 1) == 13, but fls(size - 1 + 12) == 13
>>>while size - 1 + 12 == 16384, where we'd want the check to fail.
>>>      
>>>
>
>On Sat, May 22, 2004 at 10:43:47AM +0200, Manfred Spraul wrote:
>  
>
>>No, 16373 must fail: After adding 12 bytes the object size would be 
>>16385, which would mean an order==3 allocation.
>>And 16372 must succeed: 16384 is still an order==2 allocation.
>>The idea is that there shouldn't be an allocation order increase due to 
>>redzoning, and afaics that doesn't happen, except between 4082 and 4095 
>>bytes.
>>    
>>
>
>Yes. While you've corrected the one-offs in my post (arithmetic is boring,
>we have machines to do that for us now)
>
I admit, I'm cheating:
I'd copied the test to user space and then tested all values between 32 
and 131072. 16372 passes:
fls(16371) == fls(16383).

I'll send a patch to Andrew to fix the range between 4084 and 4095.

--
    Manfred

--------------030709040309070708060501
Content-Type: text/x-csrc;
 name="test.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="test.c"

#include <stdio.h>

#define BYTES_PER_WORD	4
#define PAGE_SIZE 4096

/*
 * fls: find last bit set.
 */

static int fls(int x)
{
	int r = 32;

	if (!x)
		return 0;
	if (!(x & 0xffff0000u)) {
		x <<= 16;
		r -= 16;
	}
	if (!(x & 0xff000000u)) {
		x <<= 8;
		r -= 8;
	}
	if (!(x & 0xf0000000u)) {
		x <<= 4;
		r -= 4;
	}
	if (!(x & 0xc0000000u)) {
		x <<= 2;
		r -= 2;
	}
	if (!(x & 0x80000000u)) {
		x <<= 1;
		r -= 1;
	}
	return r;
}

int main(void)
{
	int size;

	for (size=32;size<131073;size++) {
		if ((size <= PAGE_SIZE-3*BYTES_PER_WORD || fls(size-1) == fls(size-1+3*BYTES_PER_WORD))) {
			/* printf("%6d: no order change \n", size); */
		} else {
			printf("%6d: order change \n", size);
		}
	}
	return 0;
}

--------------030709040309070708060501--

