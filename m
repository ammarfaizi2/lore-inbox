Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317831AbSGRCFP>; Wed, 17 Jul 2002 22:05:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317856AbSGRCFP>; Wed, 17 Jul 2002 22:05:15 -0400
Received: from pl1295.nas911.n-yokohama.nttpc.ne.jp ([210.139.44.15]:34244
	"EHLO standard.erephon") by vger.kernel.org with ESMTP
	id <S317831AbSGRCFO>; Wed, 17 Jul 2002 22:05:14 -0400
Message-ID: <3D362309.7020004@yk.rim.or.jp>
Date: Thu, 18 Jul 2002 11:08:09 +0900
From: Chiaki <ishikawa@yk.rim.or.jp>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1a) Gecko/20020610
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Q: boot time memory region recognition and clearing.
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>
>> 
>> I ran memtest v3 on the motherboard, and
>> it didn't find any errors when I ran it overnight.
>
>I wasn't able to verify it so the AMD751 was disabled by default.
>
I modified the controller.c source file and enabled AMD751, but
it didn't change anything at all. memtest86 didn't find
any errors.

>> 
>> > Your objective is misguided.  Even with a bios that
>> > is slightly buggy in initializing the ECC bits, what you want is
>> > scrubbing.  Then if the error disappears after 5 minutes of uptime
>> > you can ignore it.  
>> 
>> I see. Then the problem would boil down whether
>> AMD751 supports scrubbingat the hardware level.
>> It reports that it saw correctable single bit error,
>> and I take it to mean that the chip itself
>> has fixed the single bit error.
>> Am I too optimistic to expect this?
>
>The single bit error has been corrected in only one direction,
>in the data going to the cpu.  The data remaining in memory
>was not corrected.
>

After reading some e-mails in ECC mailing list and
your comment above, I have a feeling that
the particular kernel I use (compiled for AMD K7) may
be reading an unitialized region during some operation
and that may trigger this incorrect region : and
that AMD751 doesn't do hardware scrubbing, so we
have the error looks as if the error got stuck.
(AMD's later 76x chipset seems to support hardware scrubbing.)

I am a little disappointed to find that the low-level hardware
doesn't support scrubbing. Incidently, I noticed from google search
that many
workstation have had explict software scrubber program to
check the available memory every now and then to
look for software ECC errors that can be corrected.
But I think this software aims at correcting soft errors before
other multiple errors would emerge and ECC at hardware level would
not be able to fix such errors any more.
In any case, at the granuality reported by
the AMD751, it is a little awkward to do software scrubbing.
Also, for effective software scrubber as in the workstation
software offerings (for checking memory: just read them
so that we can fix the ECC correctable errors in the physical memory
prbably by means of underlying hardware scrubbing function.),
such software ought to run from kernel context as a thread, and it probably
needs to know the interference from DMA's etc, so it is not
easy to write, I have to admit.

>
>> The problem, though, is this.
>> According to the AMD751 documentation, we
>> can clear the memory error info in the chip register,
>> by writing to a certain location of the PCI space.
>> However, when one error get reported on my motherboard,
>> it would NOT go away and I think there is something amiss
>> about this.
>
>That the location is frequently read and there is no hardware
>scrubbing (writing the correct value back to ram).
>  
>
Sounds plausible.

>> I am not sure if the AMD doc is correct about this now.
>> from controller.c of memtest86.
>> 
>>                 /* Clear the error status */
>>                 pci_conf_write(ctrl.bus, ctrl.dev, ctrl.fn, 0x58, 2, 0);
>> 
>> >From locally hacked ecc.c:
>>              /*
>>                  * clear error flag bits that were set by writing 0 to
>> them
>>                  * we hope the error was a fluke or something :)
>>                  */
>>                 /* int value = eccstat & 0xFCFF; */
>>                 /* pci_write_config_word(bridge, 0x58, value); */
>>                 pci_write_config_byte(bridge, 0x58, 0x0);
>>                 pci_write_config_byte(bridge, 0x59, 0x0);
>
>Both of which match.
>

Glad to hear that.

>
>> BTW, I tried both the byte and word write to 0x58, but
>> it never seemd to clear the error status.
>> (It is possible that the error is real, but again
>> the error is reported always in the first bank even if
>> I rotate the memry sticks...)
>
>Sounds like a questionable bit of documentation.
>
I wish someone who is familar with AMD chipset design
can speak up.

> 
>> > And if it comes back you know you really have
>> > something to worry about.  At least for single bit errors this should
>> > fix the whole problem with something that is useful for other
>> > purposes.
>> > 
>> > Eric
>> 
>> Thank you for your feedback. I noticed that you 
>> contributed to linuxBIOS and memtest86.
>> Please keep the good work going!
>
>Hopefully we can get the problems well enough understood in the community
>that we can actually get some of this code fixed up and working well.
>
>  
>
I hope so.

Currently I have a few plans to attack this topic.

- recompile the kernel to use a lesser aggressive kernel in terms of
  memory access by choosing, say, AMD k5 or something.
 (This might fix the bogus warning messages...)

- considering to use the part of memtest86 code to
  incorporate it into the boot loader steps somewhere so that
  all the memory is written to  at least once during booting.

- Or as someone suggested in private e-mail,  I might  want to add
  the aggressive memory copying code to memtest86 to see
 if such would make memtest86 to catch more subtle errors...

Thank you again for the feedback.



