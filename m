Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289228AbSAVKWH>; Tue, 22 Jan 2002 05:22:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289233AbSAVKV6>; Tue, 22 Jan 2002 05:21:58 -0500
Received: from [195.66.192.167] ([195.66.192.167]:25874 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S289228AbSAVKVl>; Tue, 22 Jan 2002 05:21:41 -0500
Message-Id: <200201221017.g0MAHME01752@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=US-ASCII
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>,
        Andre Hedrick <andre@linuxdiskcert.org>, <vojtech@suse.cz>
Subject: Re: Linux 2.5.3-pre1-aia1
Date: Tue, 22 Jan 2002 12:17:31 -0200
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <F9158D81E5D@vcnet.vc.cvut.cz>
In-Reply-To: <F9158D81E5D@vcnet.vc.cvut.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Whee, an IDE flamewar! :-)

People, can we get colder? Let's clarify positions without generating useless 
heat, ok?


1. Re multi-sector reads/writes:

On 21 January 2002 20:45, Petr Vandrovec wrote:
> If the number of requested sectors is not evenly divisible by the block
> count, as many full blocks as possible are transferred, followed by a
> final, partial block transfer. The partial block transfer shall be for n
> sectors, where n = remainder (sector count/block count).
>
> And almost identical text appears on page 296, where it talks about
> WRITE MULTIPLE.
>
> If you are trying to persuade us that there are devices which support
> ATA interface, and do not follow these paragraphs word by word, there
> is certainly something wrong in the ATA world...

Seems logical to me too. Imagine we have told drive to use 16 sector multi 
mode. Now we are trying to read 24 sectors (6 pages of 4k each):
CPU                       IDE
------------- ---------------
read_multiple(sect cnt=24) ->
         *reading 16 sectors*
                 <- interrupt
give me data ->
 (asm: 'rep insw')
<- <- <-16bit words with data
<- <- <-  (total: 16 sectors)
          *reading 8 sectors*
                 <- interrupt
give me data ->
<- <- <-16bit words with data
<- <- <-   (total: 8 sectors)

Andre, do you think that it is _not_ ok to do multi-sector read/write ops 
with sector count non-divisible by programmed multisector count?
Do you have or know of some existing drive which misbehaves? Do you think 
such drive will appear in future?


2. Re cotiguous buffer for large PIO blocks:

On 21 January 2002 21:53, Andre Hedrick wrote:
> OLD Method, with Request Page Walking:
> issue atomic write 255 sectors
>         write sectors
>         interrupt_issued
> 		walk copy of request
> 	continue write_loop;
> 	exit on completion and request and free local buffer.
>
> CORRECT Method:
> collect contigious physical buffer of 255 sectors
> memcpy_to_local (one memcpy)
> issue atomic write 255 sectors
> 	write sectors
> 	interrupt_issued
> 		update pointer
> 	continue write_loop;
> 	exit on completion and request and free local buffer.

Do I understand OLD method correctly? Example: reading 128 sectors
in one transfer (assuming drive can do 128 multisector PIO):

void* page[16];  /* holds addresses of target 4k pages */
...
/* in interrupt handler: get data from IDE in PIO mode */
i=0;
while(i<16) {
    rep_insw(4096/2, page[i]);   
        /* rep_insw() in i386 pseudo-asm: 
        dx=ioport; ecx=4096/2; edi=page[i]; cld; rep insw 
        */
    i++;
}
...

I don't see flaws here, IDE will never notice that buffer is non-contiguous
(except for tiny delay between insw's while i++ and i<16 get executed).
Andre, can you explain what's wrong here and why you think we need CORRECT 
method?
--
vda
