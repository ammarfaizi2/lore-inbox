Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310187AbSCKQZb>; Mon, 11 Mar 2002 11:25:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310191AbSCKQZW>; Mon, 11 Mar 2002 11:25:22 -0500
Received: from [195.63.194.11] ([195.63.194.11]:49673 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S310187AbSCKQZN>; Mon, 11 Mar 2002 11:25:13 -0500
Message-ID: <3C8CDA0D.7020703@evision-ventures.com>
Date: Mon, 11 Mar 2002 17:23:41 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020205
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.6 IDE 19
In-Reply-To: <E16kRZp-0000or-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
>>   in replacements for CF cards in digital cameras and I would rather expect
>>   them to be very tolerant about the driver in front of them. And then 
>>
> 
> Oh dear me. Wrong again. Microdrives require proper polite wakeups. But you
> see camera vendors buy in IDE code from people who can read and follow 
> standards documents. 
> 
> 
>>the WB
>>   caches of IDE devices are not caches in the sense of a MESI cache, 
>>they are
>>   more like buffer caches and should therefore flush them self after s 
>>short
>>   period of inactivity without the application of any special flush 
>>command.
>>
> 
> You now have an absolute vote of *NO CONFIDENCE* on my part. I'm simply
> not going to consider running your code. "It probably wont eat your disk"
> and handwaving is not how you write a block layer.

You are claiming this repeatidly. But please just send me the f*cking
strace and I will beleve you. Or point me at the corresponding docs.
I see no special purpose Win2000 microdrive drivers on IBM.
And I suppose you don't even *own* an IBM MicroDrive. And please
note as well that I didn't tell: "I will never ever include such a
thing if it's required". What I was about is that there is *no* reason
to not include Pavels stuff, even if it leaks, which I know very well,
some required functionality by now. Just to satisfy your imagination of how
broken an implementation of the ATA firmware could be isn't a reaons.
If you have a damn Micro Drive, then feel free to add the required wakeup code -
you are all welcome. But please don't implement it as cat jksadfgkjhasdjkf >
/proc/some/wried/stuff.

> How is anyone supposed to debug file system code in 2.5 when its known
> that it will trash data on some disks anyway ? I'd like to see you cite
> a paragraph where the IDE device is required to flush the data back
> promptly, or on power off. I'd like to see what you plan to do about all
> the IBM disks you plan to mistreat and give bad blocks that require a 
> reformat ?

For gods sake:

1. How is Win2000 going to work then?

2. I assume (modulo mistakes) that writers of firmware
are just not stupid and implement the cache as a write behind buffer and not
as a MESI cache snooping on the drives bus. But I never claimed
that I'm relying on this assumption in any way!

3. Why are *all the other* ATA drivers in different operating systems
such easy on this matter and generally much simpler leaner and more
readable then the Linux one?!

It's not like one couldn't compare... see for example www.ata-atapi.com

Fsck let's cite the IBM appilcation notes about the Micro Drive
found here http://www.storage.ibm.com/hdd/micro/appguide.htm

The IBM microdrive supports the write cache feature. When the write cache 
feature is enabled, the
microdrive posts a command completion for the write command as soon as all the 
write data has
been transferred to the microdrive's cache buffer. The host system, then, can 
prepare for the next
command while the microdrive performs actual disk writing off-line. The write 
cache feature also
contributes to the host system's battery life by shortening the amount of time 
for write operation.

Because the write command completion does not correspond with the actual 
disk-write completion,
the host system is required to take special care not to lose supply power to the 
microdrive so that the
data that is cached but not yet written to disk will no be lost.

To ensure that the actual disk-writing of the cached data has been completed, it 
is recommended that
a host system issues a `Standby Immediate' command and waits for a command 
complete from the
microdrive.

The cached data will be lost when :
     1. A host system cuts off the power for the microdrive
     2. A user ejects the microdrive
before the microdrive completes writing cached data to disk.

The microdrive cleans (flushes out) whole cached data upon command completion of 
Standby Immediate. If
the host system enables the write cache feature, it is strongly recommended to 
issue Standby Immediate
before power removed, system shutdown or ejection of the microdrive.

The write cache feature is disabled at power-on reset. It is possible for the 
host system to enable this feature
by issuing Set Features (Enable Write Cache). Because the microdrive may be used 
with a host system
without such care for data integrity, IBM insists that the write cache feature 
should not be a power-on default.

  * Consideration for a time-out value when using the write cache

The microdrive can queue several consecutive write commands. Even if the host 
system receives a
command completion, the microdrive may still be performing disk writing for 
queued commands, each of
which could take up to 7.5 seconds as previously mentioned if an error has 
occurred and an error
recovery routine starts.
This delay eventually surfaces when processing a first non-queued command during 
write cache.

For example, suppose the microdrive queues 2 write commands and each command 
takes 7.5 seconds
for some extreme reason. Then if the microdrive receives Read Sectors, which is 
a non-queue command,
it will be processed just after disk writing is completed.  In the worst case, 
delay for the Read Sectors
would be close to 15 seconds (7.5 x 2).

In light of the stuation above,  IBM recommends 30 seconds as a time-out value 
if the host system uses
the write cache feature.


And apparently we see that there is nothing special about them... Just don't
enable the write cache and all should be well with a timeout of 30 seconds.

