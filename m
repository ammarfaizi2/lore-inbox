Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267886AbTBKRMG>; Tue, 11 Feb 2003 12:12:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267887AbTBKRMG>; Tue, 11 Feb 2003 12:12:06 -0500
Received: from dbl.q-ag.de ([80.146.160.66]:62133 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id <S267886AbTBKRMD>;
	Tue, 11 Feb 2003 12:12:03 -0500
Message-ID: <3E49311E.6090108@colorfullife.com>
Date: Tue, 11 Feb 2003 18:21:34 +0100
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Martin J. Bligh" <mbligh@aracnet.com>
CC: Hartmut Manz <manz@intes.de>, linux-kernel@vger.kernel.org
Subject: Re: allocate more than 2 GB on IA32
Content-Type: multipart/mixed;
 boundary="------------090201040100010306030001"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090201040100010306030001
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Martin wrote:

>> i would like to allocate more than 2 GB of memory on an IA32 architecture.
>> 
>> The machine is a dual XEON_DP with 3 GB of Ram and 4 GB of swap space.
>> 
>> I have tried with the default SUSE 8.1 kernel as well as with a
>> 2.4.20-pre4aa1 Kernel compile by my own using these Options:
>> 
>> CONFIG_HIGHMEM4G=y
>> CONFIG_HIGHMEM=y
>> CONFIG_1GB=y
>> 
>> but I am only able to allocate 2 GB with a single malloc call.
>> I tought it should be possible to allocate up to 2.9 GB of memory to a
>> process, with this kernel settings.
>
>Well, assuming you had no user-space code or data, or a stack, or any
>shared libraries to fit into that space as well ;-)
>  
>
It's tricky, but not impossible.

Hartmut, start you application, allocate 2 gigabyte memory and then check
    /proc/<pidof your app>/maps.
It shows how your virtual memory is used.

You application is loaded at address 0x08000000. The stack is at 
0xbfffxxxx. Addresses above 0xC0000000 are reserved for the kernel.
Usually shared libraries are loaded at 0x40000000, and thus the largest 
area is 2 GB: from 0x400xxxx to 0xbfffxxxx.

You must remove everything that is at 0x4000xxxx, then you can malloc 
2.9 GB. Linking with --static is definitively required, but it's not 
enough - the glibc-2.3 library startup seems to malloc something at 
0x40000000. Try another C library.

One alternative would be a 2.9 GB global variable. An ugly example is 
attached - I could create a 2943 MB large variable.
With some asm-foo, it should be possible to create one 2.9 GB variable. 
Then implement your own malloc, backed by that 2.9 GB memory area.

--
    Manfred

--------------090201040100010306030001
Content-Type: text/plain;
 name="testmalloc.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="testmalloc.c"

#include <malloc.h>
// Test the maximum size of one linear block that is achievable with Linux
// compile with gcc --static.

#define SIZE	2943

unsigned char dummy1[1024UL*1024*SIZE/2];
unsigned char dummy2[1024UL*1024*SIZE/2];

int main(void)
{
	if ((unsigned long)dummy2 != (unsigned long) ((&dummy1)+1))  {
		printf("dummy1 has address %lx, ends at %lxh.\n",dummy1, (&dummy1)+1);
		printf("dummy2 has address %lx.\n",dummy2);
		printf("duh. something went wrong.\n");
	} else {
		printf("%d MB memory block starting at address %lxh available.\n",
				SIZE, (unsigned long)dummy1);
	}
	for(;;) sleep(100);
	return 0;
}

--------------090201040100010306030001--

