Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261317AbSLZMCX>; Thu, 26 Dec 2002 07:02:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261338AbSLZMCX>; Thu, 26 Dec 2002 07:02:23 -0500
Received: from dbl.q-ag.de ([80.146.160.66]:7587 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id <S261317AbSLZMCV>;
	Thu, 26 Dec 2002 07:02:21 -0500
Message-ID: <3E0AF171.9050405@colorfullife.com>
Date: Thu, 26 Dec 2002 13:09:21 +0100
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Anton Blanchard <anton@samba.org>
CC: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5 fast poll on ppc64
References: <20021226064821.GA21628@krispykreme>
In-Reply-To: <20021226064821.GA21628@krispykreme>
Content-Type: multipart/mixed;
 boundary="------------050208020209070600040500"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------050208020209070600040500
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Anton Blanchard wrote:

>Hi,
>
>I was unable to boot 2.5-BK on ppc64 and narrowed it down to the fast
>poll patch.  I found:
>
>offsetof(struct poll_list, entries) == 12 but
>sizeof(struct poll_list) == 16
>
>This means pp+1 did not match up with pp->entries. Im not sure what the
>alignment requirements are for a zero length struct (ie is this a
>compiler bug) but the following patch fixes the problem and also changes
>->len to a long to ensure 8 byte alignment of ->entries on 64bit archs.
>  
>
That seems to be the root of the problem: ->entries requires 4 byte 
alignment, while struct poll_list requires 8 byte alignment. Thus the 
compiler aligns entries to a 4-byte boundary, and rounds up 
sizeof(struct poll_list) to 16.

Attached is a small test case that shows the problem on both 64-bit and 
32-bit platforms. I'm not sure if this is a gcc bug: the Compaq C 
compiler on Tru64 and MSVC on Windows generate the same structure layout.

--
    Manfred

--------------050208020209070600040500
Content-Type: text/plain;
 name="test.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="test.c"

/*
 * Testcase for a possible compiler bug:
 * structure with flexible array member.
 * offsetof(struct,flexible_member) != sizeof(struct).
 *
 * That seems to be a violation of 6.7.2.1, constraint 16 of the C99
 * standard:
 * "First, the size of the structure shall be equal to the offset of the
 * last element of an otherwise identical structure that replaces the
 * flexible array member with an array of unspecified length.
 */
#include <stdio.h>

/*
 * structure: sizeof() = 4.
 * alignment: 2, due to the short.
 */
struct pollfd {
	short fd;
	char events;
	char revents;
};

/*
 * sizeof: 12
 * alignment: 4, due to the int.
 */
struct n2 {
	/* offset 0 */
	int m;
	/* offset 4 */
	char n;
	/* one byte padding, 'struct pollfd' requires 2 byte alignment */
	/* offset 6 */
	struct pollfd a[1];
	/* offset 10: two bytes padding for 4 byte alignment,
	 * required for the int in this structure */
};

/*
 * sizeof: 8.
 * XXX
 * Is this correct?
 * offsetof(struct n1, a) is 6
 * --> offsetof(struct n1, a) != sizeof(struct n1)
 * XXX
 */
struct n1 {
	/* offset 0 */
	int m;
	/* offset 4 */
	char n;
	/* one byte padding, 'struct pollfd' required 2 byte alignment */
	/* offset 6 */
	struct pollfd a[];
};
	
#define offsetof(a,b) \
		(int)&((a*)NULL)->b

int main(void)
{
	printf("pollfd: sizeof: %d.\n", sizeof(struct pollfd));
	printf("fix: sizeof: %d, offsetof: %d.\n", sizeof(struct n2), offsetof(struct n2, a));
	printf("var: sizeof: %d, offsetof: %d.\n", sizeof(struct n1), offsetof(struct n1, a));
	return 0;
}

--------------050208020209070600040500--


