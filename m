Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263038AbTCLFFf>; Wed, 12 Mar 2003 00:05:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263039AbTCLFFf>; Wed, 12 Mar 2003 00:05:35 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:53151 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S263038AbTCLFFd>;
	Wed, 12 Mar 2003 00:05:33 -0500
Message-ID: <3E6EC2AD.7000504@pobox.com>
Date: Wed, 12 Mar 2003 00:16:29 -0500
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: "H. Peter Anvin" <hpa@zytor.com>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch 3/3] add Via Nehemiah ("xstore") rng support
References: <200303120427.UAA00323@cesium.transmeta.com>
In-Reply-To: <200303120427.UAA00323@cesium.transmeta.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

H. Peter Anvin wrote:
> In article <3E6EA909.9020200@pobox.com> of
> linux.dev.kernel, you write:
> 
>>diff -Nru a/drivers/char/Kconfig b/drivers/char/Kconfig
>>--- a/drivers/char/Kconfig	Tue Mar 11 21:37:50 2003
>>+++ b/drivers/char/Kconfig	Tue Mar 11 21:37:50 2003
>>@@ -710,7 +710,7 @@
>> 	  If you're not sure, say N.
>> 
>> config HW_RANDOM
>>-	tristate "Intel/AMD H/W Random Number Generator support"
>>+	tristate "Intel/AMD/Via H/W Random Number Generator support"
>> 	depends on (X86 || IA64) && PCI
>> 	---help---
>> 	  This driver provides kernel-side support for the Random Number
> 
> 
> 
> How about changing this to "HW Random Number Generator"?

easily done.


>>+static inline u32 xstore(u32 *addr, u32 edx_in)
>>+{
>>+	u32 eax_out;
>>+
>>+	asm(".byte 0x0F,0xA7,0xC0 /* xstore %%edi (addr=%0) */"
>>+		:"=m"(*addr), "=a"(eax_out)
>>+		:"D"(addr), "d"(edx_in));
>>+
>>+	return eax_out;
>>+}
> 
> 
> Note that your "=m" (*addr) is never actually used here -- it doesn't
> affect the instruction encoding, and it only shows up in a comment.
> Since gcc will generate an instruction mode here, it will be highly
> confused.
> 
> I am assuming 0xC0 is a modr/m byte, in which case the most sane
> interpretation of this instruction would be "xstore %eax"; %edi is
> presumably implicit since you claim it can take a REP prefix...

and yet strangely the asm code seems to be correct :)

         .p2align 4,,15
         .type   via_data_present,@function
via_data_present:
         pushl   %edi
         xorl    %edi, %edi	# zero edi
         movl    $3, %edx        #  edx_in
         movl    %edi, via_rng_datum     #  zero via_rng_datum
         movl    $via_rng_datum, %edi    #  addr
#APP
         .byte 0x0F,0xA7,0xC0 /* xstore %edi (addr=via_rng_datum) */
#NO_APP
         popl    %edi
         andl    $15, %eax       #  eax_out
         setne   %al
         movzbl  %al, %eax
         ret


