Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292855AbSDDSbm>; Thu, 4 Apr 2002 13:31:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292957AbSDDSbd>; Thu, 4 Apr 2002 13:31:33 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:43280 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S292855AbSDDSbP>; Thu, 4 Apr 2002 13:31:15 -0500
Message-ID: <3CAC9BD4.5050500@zytor.com>
Date: Thu, 04 Apr 2002 10:30:44 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020312
X-Accept-Language: en-us, en, sv
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederm@xmission.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86 Boot enhancements, boot protocol 2.04 7/9
In-Reply-To: <m1ofh0spik.fsf@frodo.biederman.org>	<a8flgc$ms2$1@cesium.transmeta.com> <m1lmc3qtaz.fsf@frodo.biederman.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric W. Biederman wrote:
> 
> It's not legacy it is still the optimal address.  The amount of memory
> required to load the kernel is directly related to how much low memory
> the decompresser can use.  If you move it lower you need more memory
> above 1MB to load the kernel.
> 
> To load the real mode code at < 0x90000 requires a fairly
> sophisticated bootloader.  You have already convinced me how it is bad
> for bootloaders to make BIOS calls on behalf of the kernel, and how
> bad it is to need bootloaders to change.  So unless the real mode code
> does the int 12 call itself and relocates itself as high as it can go
> I really don't see the default load address changing.  And I am
> documenting the default load address.
> 

No, that's not how that works in reality.  In practice, the boot loader 
picks the lowest address it can practically use, in order to minimize 
the conventional memory ceiling.  For example, PXELINUX always loads at 
0x50000, simply because odds that you have a PXE stack and can use 
0x90000 is about zero to none.  In fact, these days there are enough 
BIOSes that load stuff in the high part of memory that using 0x90000 is 
actively dangerous and **needs to be avoided**.  Theoretically, you're 
right; it adds a  very small amount of memory to the decompression.  If 
that matters, there is actually a very easy way to deal with it: for any 
boot loader there is a Lowest Usable Address (conventional memory 
ceiling).  You can use INT 12h and adjust the load address all the way 
up to 0x90000 if the conventional memory ceiling permits; this usually 
is something like five lines of assembly.

> I'd like to change the way we do this, so I'm going to stare at this
> problem a little bit more.  Changing the default load address and
> still being able to compute how much memory the kernel is going
> to use is a challenge.

There can't be a "default load address".  0x90000 is actively dangerous 
and trying to encourage it for anything than legacy kernels is WRONG. 
If you can't handle this, then you need to go back to the drawing board.

	-hpa




