Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315439AbSEGNJu>; Tue, 7 May 2002 09:09:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315440AbSEGNJt>; Tue, 7 May 2002 09:09:49 -0400
Received: from [195.63.194.11] ([195.63.194.11]:20746 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S315439AbSEGNJt>; Tue, 7 May 2002 09:09:49 -0400
Message-ID: <3CD7C360.6050002@evision-ventures.com>
Date: Tue, 07 May 2002 14:06:56 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0rc1) Gecko/20020419
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.5.13 IDE 54
In-Reply-To: <1019549894.1450.41.camel@turbulence.megapathdsl.net>	<3CC7E358.8050905@evision-ventures.com>	<20020425172508.GK3542@suse.de>	<20020425173439.GM3542@suse.de>	<aa9qtb$d8a$1@penguin.transmeta.com>	<3CD5564A.6030308@evision-ventures.com> <15575.52723.240506.668782@argo.ozlabs.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Uz.ytkownik Paul Mackerras napisa?:
> Martin Dalecki writes:
> 
> 
>>Sun May  5 16:32:22 CEST 2002 ide-clean-54
>>
>>- Finish the changes from patch 53. ide_dma_actaion_t is gone now as well as
>>   whole hidden code paths associated with it. I hope I didn't mess too many
>>   things up with this, since the sheer size of the changes make them sensitive.
> 
> 
> I'm wondering how you would suggest that I change ide-pmac.c now so
> that it compiles and works again.
> 
> With this patch we have calls to udma_enable scattered throughout
> ide.c, and udma_enable assumes that it is to do its stuff by poking
> particular I/O ports.  You seem to have taken away the ability to have
> a chipset provide its own methods for setting up, enabling and
> disabling DMA.
> 
> The comment above udma_enable seems to indicate that you think it
> should be ifdef'd per-architecture.  That won't work for us (besides
> being ugly), because we can have two ATA host adaptors in the one
> machine that need to be programmed quite differently.  Consider for
> instance a powermac with the built-in IDE interface (which would use
> the ide-pmac.c code) and a plug-in PCI IDE card, for which the
> udma_enable code is presumably correct.
> 
> So we definitely need to have the DMA setup/enable/disable methods
> able to be specified per host adaptor.

OK I see I have "forced" you to take care of this.
My problem previously was the simple fact that in esp.
the pmac code was sidestepping the generic code and providing his
own mechanisms for handling chipset specific dma transfer methods.

As you can see now it's possible to have overloaded most
of the "virtuaized" udma_xxx channel methods.

Now you request me to virtualize the udma_enable stuff.
Nothing easier then this.

Now we have:

udma_enable()
{
...
     /* default method implementation */
...
}

I will do the following with it:

static do_dma_enable() // was udma_enable() before
{
    /* default method implementation */
}


udma_enable()
{
    if (ch->udma_enable)
		return ch->udma_enable();

    /* fallback to default implementation */
    do_dma_enable();
}


I think this should suite your needs and you will be
able to just overload the implementation of
udma_enable() in ide-pmac.c

by setting the udma_enable method in the
host chip initialization routine there. (Directly alonside
the the compiler will chock on ->udma so such memmber.)

> If I have missed something, please let me know.  But it looks to me
> very much as though this patch makes it impossible for me to use my
> powermac IDE interfaces.


Would the above infrastructue adjustment suit your needs?

If Yes (I think so), please just drop me an OK please.


