Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281429AbRKUCEf>; Tue, 20 Nov 2001 21:04:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281440AbRKUCEQ>; Tue, 20 Nov 2001 21:04:16 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:55812 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S281429AbRKUCEG>; Tue, 20 Nov 2001 21:04:06 -0500
Message-ID: <3BFB0B6E.147EBABF@zip.com.au>
Date: Tue, 20 Nov 2001 18:03:26 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.14-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Bernd Eckenfels <ecki@lina.inka.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: slab: avoid linear search in kmalloc? (GCC Guru wanted :)
In-Reply-To: <20011121024525.A18750@lina.inka.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bernd Eckenfels wrote:
> 
> Hello,
> 
> I noticed that kmalloc and kmem_find_general_cachep are doing a linear
> search in the cache_sizes array. Isnt it better to speed that up by doing a
> binary search or a b-tree if like the following patch?
> 

Possibly.  I've never seen it on a profile though.

Just for kicks, try feeding this into gcc and take a look
at the assembly output:

int thing(int size)
{
	int ret;

	switch (size) {
	case 0 ... 2:
		return 1;
	case 3 ... 4:
		return 2;
	case 5 ... 8:
		return 3;
	case 9 ... 16:
		return 4;
	case 17 ... 31:
		return 5;
	case 32 ... 64:
		return 6;
	case 65 ... 128:
		return 7;
	case 129 ... 256:
		return 8;
	case 257 ... 512:
		return 9;
	case 513 ... 1024:
		return 10;
	case 1025 ... 2048:
		return 11;
	case 2049 ... 4096:
		return 12;
	case 4097 ... 8192:
		return 13;
	case 8193 ... 16384:
		return 14;
	case 16385 ... 32768:
		return 15;
	case 32769 ... 65536:
		return 16;
	}
	return -1;
}
