Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264461AbRFIKYF>; Sat, 9 Jun 2001 06:24:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264460AbRFIKXz>; Sat, 9 Jun 2001 06:23:55 -0400
Received: from mail3.svr.pol.co.uk ([195.92.193.19]:32544 "EHLO
	mail3.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S264459AbRFIKXr>; Sat, 9 Jun 2001 06:23:47 -0400
Message-ID: <3B21F918.4090101@humboldt.co.uk>
Date: Sat, 09 Jun 2001 11:23:20 +0100
From: Adrian Cox <adrian@humboldt.co.uk>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.5 i686; en-US; rv:0.9+) Gecko/20010531
X-Accept-Language: en-us
MIME-Version: 1.0
To: Paulo Afonso Graner Fessel <pafessel@zaz.com.br>
CC: linux-kernel@vger.kernel.org, hollis@austin.rr.com,
        torben.mathiasen@compaq.com
Subject: Re: Probable endianess problem in TLAN driver
In-Reply-To: <3B21A790.63F428CE@zaz.com.br>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paulo Afonso Graner Fessel wrote:

> [...]

> He said me that these funtions don't address the endianess question, and
> sent me a patch. He said that this probably wouldn't work, but I've
> decided to give a try anyway. Here is the patch:
> 
> --- tlan.c.old  Thu Jun  7 21:24:25 2001
> +++ tlan.c      Thu Jun  7 21:37:42 2001
> @@ -172,6 +172,12 @@
>  #include <linux/delay.h>
>  #include <linux/spinlock.h>
>  
> +#if defined(__powerpc__)
> +#define inw(addr)                      le32_to_cpu(inw(addr))
> +#define inl(addr)                      le32_to_cpu(inl(addr))
> +#define outw(val, addr)                outw(cpu_to_le32(val), addr)
> +#define outl(val, addr)                outl(cpu_to_le32(val), addr)
> +#endif

On ppc the inw, inl, outw, and outl functions already byteswap, so by 
adding the extra byteswap you're now passing unswapped data to the chip. 
Take a look at include/asm-ppc/io.h and you'll see it uses byte reversed 
load and store instructions. Which means that either the chip is running 
in a big-endian mode, or that the problem is actually with data 
structures placed in host memory.

Often when porting a driver from i386 to ppc all that is required is to 
add the cpu_to_le32() macros around data in host memory that the device 
accesses, and to remove any #ifdef __powerpc__ code written by people 
who don't realise that ppc uses the standard linux pci code.

-- 
Adrian Cox   http://www.humboldt.co.uk/


