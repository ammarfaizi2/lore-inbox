Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265048AbVBDUER@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265048AbVBDUER (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 15:04:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264251AbVBDT4G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 14:56:06 -0500
Received: from 67.107.199.112.ptr.us.xo.net ([67.107.199.112]:37360 "EHLO
	hathawaymix.org") by vger.kernel.org with ESMTP id S266437AbVBDTy2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 14:54:28 -0500
Message-ID: <4203D4C1.1080007@hathawaymix.org>
Date: Fri, 04 Feb 2005 13:02:09 -0700
From: Shane Hathaway <shane@hathawaymix.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041228
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Hans-Peter Jansen <hpj@urpla.net>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Configure MTU via kernel DHCP
References: <200502022148.00045.shane@hathawaymix.org> <200502041755.41288.hpj@urpla.net>
In-Reply-To: <200502041755.41288.hpj@urpla.net>
X-Enigmail-Version: 0.89.6.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hans-Peter Jansen wrote:
> On Thursday 03 February 2005 05:47, Shane Hathaway wrote:
> 
>>The attached patch enhances the kernel's DHCP client support (in
>>net/ipv4/ipconfig.c) to set the interface MTU if provided by the
>>DHCP server. Without this patch, it's difficult to netboot on a
>>network that uses jumbo frames.  The patch is based on 2.6.10, but
>>I'll update it to the latest testing kernel if that would expedite
>>its inclusion in the kernel.
> 
> 
> Well, I've been there before, and asked for exact the same back in 
> June 2003, but had much less luck, nobody of kernel fame even 
> responded:
> http://marc.theaimsgroup.com/?l=linux-kernel&m=105624464918574&w=4

I wish I had found your patch before I went to the trouble of writing my 
own!  Yours is just as good as mine.

> For what is worth it, I ported my patch to current 2.6, which raised 
> some comments compared to yours:
> 
>  - Is it really necessary to protect the dev_set_mtu call, since it is
>    just setting up the device?

Without rtnl_shlock(), something complains about RTNL not being locked. 
I don't know much beyond that.

>  - I prefer to call dev_set_mtu only, if a change mtu request is
>    sent.. 

Yes, I can see that.  Either way is fine by me.

>  - Are you sure, you got the endianess right? 

On the MTU parameter?  Yes, it's network byte order, big-endian.

> Here's the "cost": ipconfig.o without my patch on x86:
> 
>   3 .init.data    0000005a  00000000  00000000  00000220  2**2
>                   CONTENTS, ALLOC, LOAD, RELOC, DATA
>   4 .rodata.str1.1 000001a2  00000000  00000000  0000027a  2**0
>                   CONTENTS, ALLOC, LOAD, READONLY, DATA
>   5 .rodata.str1.4 000003ad  00000000  00000000  0000041c  2**2
>                   CONTENTS, ALLOC, LOAD, READONLY, DATA
>   6 .init.text    00001a45  00000000  00000000  000007d0  2**4
>                   CONTENTS, ALLOC, LOAD, RELOC, READONLY, CODE
> 
> With patch:
> 
>   3 .init.data    0000005e  00000000  00000000  00000220  2**2
>                   CONTENTS, ALLOC, LOAD, RELOC, DATA
>   4 .rodata.str1.1 000001ab  00000000  00000000  0000027e  2**0
>                   CONTENTS, ALLOC, LOAD, READONLY, DATA
>   5 .rodata.str1.4 000003e5  00000000  00000000  0000042c  2**2
>                   CONTENTS, ALLOC, LOAD, READONLY, DATA
>   6 .init.text    00001ab5  00000000  00000000  00000820  2**4
>                   CONTENTS, ALLOC, LOAD, RELOC, READONLY, CODE
> 
> Difference: 181 Bytes (padding ignored)
> 
> The whole module takes about 9K, compared to dhcp in initrd, which 
> takes a few hundred K! Hmm.

It's probably better to compare your patch with its apparent successor, 
however.  The tiny DHCP client in the klibc package already supports 
setting the MTU.

> May the linux gods indulge on this topic one day or remove the 
> ipconfig module completely.

A friend of mine just had the misfortune of running into the exact same 
problem, but then he had the fortune of finding your patch.  So at least 
the curse has a temporary remedy. :-)  The long-term solution is klibc, 
I hope.  klibc in initramfs could ease a lot of pain.

Shane
