Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265270AbUAYUxf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jan 2004 15:53:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265284AbUAYUxf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jan 2004 15:53:35 -0500
Received: from hall.mail.mindspring.net ([207.69.200.60]:19245 "EHLO
	hall.mail.mindspring.net") by vger.kernel.org with ESMTP
	id S265270AbUAYUwp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jan 2004 15:52:45 -0500
Message-ID: <40142C76.4070907@mindspring.com>
Date: Sun, 25 Jan 2004 12:52:06 -0800
From: Emmanuel Hislen <hislen@mindspring.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.1) Gecko/20031114
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: hrm@carfax.org.uk
CC: linux-kernel@vger.kernel.org
Subject: Re: TR: SiI2112 + Seagate + nFroce2: no DMA!
References: <IEEHKGFDFPBODOHJKGLIEEILCAAA.hislen@mindspring.com>
In-Reply-To: <IEEHKGFDFPBODOHJKGLIEEILCAAA.hislen@mindspring.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi again,

Here's a more complete report on this issue.

-1-

Going to Fedora Core 12.4.22-1.2115.nptl fixed the DMA issue. The 
Seagate SATA drive (ST3160023AS) came up in DMA mode.
The speed however (hdparm -t) was 25MB/s, better but still unacceptable.

-2-

I got the latest Fedora Core: 2.4.22-1.2149.nptl

Interestingly enough I found out that this release comes with a sata_sil 
module that is not even in 2.4.24, it was probably ported from 2.6.1 by 
the Fedora team.
Anyway I believe this is just a RAID driver, it did not change anything 
(same as -1-).

-3-

Now I decided to live dangerously and I tried tuning max_kb_per_request, 
the default being 15:

/echo "max_kb_per_request:128" > /proc/ide/hde/settings/

On my first hdparm -t I got 55MB/s !!!


BUT the drive was still making a lot of noise after I got the results, 
and every time I tried the command again (only waiting a couple seconds 
before retrying after I got the results), the throughput went lower each 
time. In 5 retries I was at 7 MB/s. The drive was very noisy, still busy 
minutes after I was done torturing him.

Unfortunately this did not come as a surprise as I had found the 
following thread on Google:

> Andre Hedrick wrote:
>
> />/
> />Seagate and Silicon Image are the only two player (well intel now) 
> who did/
> />their own PHY. They did not use the Marvel pairs./
> />/
> />It is a function of possible ECC on the wire and the relation to the/
> />segments in the PIO or SG operations. It is a FIFO issue based on 
> 512byte/
> />boundaries being breached on corner cases./
> />/
> />The data on the wire is in 8K units./
> />/
> />It is a 7.5K + 0.5K corner case./
> />/
> />max_kb_per_request:15 == 7.5K/
> />/
> />This prevents this corner case until I can code the proper special 
> case SG/
> />table./
> />/
> />drive->id->hwconfig |= 0x6000;/
> />/
> />Is needed to fake the driver for device side cable detect./
> />There are several issues and I have not had time to keep up./


-3-

The same machine is now dual boot with Windows 2000 SP4. I installed 
Sandra 2004, a software for benchmnarking, and I got the following 
results regarding the SATA drive:

  Buffered Read: 83 MB/s
  Sequential Read: 48 MB/s
  Random Read:  8 MB/s
  Buffered write: 68 MB/s
  Sequential write: 48 MB/s
  Random write: 9 MB/s

I know, comparing results obtained with  2 different benchmarking 
products  is almost irrelevant, but it is enough for the big picture:

There is nothing wrong with the harsware (Seagate or Silicon Image), it 
works just fine with the windows drivers/libraries ... Oops did I just 
praise microsoft?


-4-

I compiled/installed a new linux kernel to replace the one from the 
Fedora distrib with 2.4.24

Absolutely no difference, same as -1-: 25 MB/s


-5-

Now I tried kernel 2.6.1: it is worse, it dropped to 14 MB/s !?!?!
I've seem several similar reports about 2.6.


-6-

So at this point I am ready to give up, and to simply buy a PATA drive.

However, after doing all the above (which is reported in chronological 
order), I booted the latest Fedora Core: 2.4.22-1.2149.nptl again, and 
decided to give another try to:

echo "max_kb_per_request:128" > /proc/ide/hde/settings


Now I have consistent 55 MB/s and no horrible noise from the drive, and 
I let this run for 4 hours without any issue. Even typing the "hdparm 
-Tt" commands one after another results are consistent.

What the heck is going on here (not that I don't appreciate things 
working, but I'd like to understand)??? I can see only the following 
possibilities:

- I was lucky, and it all depends on when you change 
"max_kb_per_request" due to some race condition.
- going to 2.6.1, I upgraded 2 packages:
  quota-tools: went from 3.06 to 3.10
  procps: went from 2.0.17 to 3.1.15
  I really don't see how this would change anything, but who knows...
- running the Win2000 benchmark with Sandra somehow did something to the 
drive and/or the SATA controller, and they are now friends. Fishy...


Does anybody knows where the default 15kb is coming from for this drive?
How can I change this permanently? I mean other than than a hack rc 
script running at init time...

I understand 2.6.1 is not using /proc/ide/hde/settings, how do I change 
max_kb_per_request with this kernel?

Anyway I will make several more attempts with max_kb_per_request set to 
128, to make sure it is really OK before enforcing it with a script 
(anyway this script would have to be kernel-version specific, to keep a 
back door).


Hope I haven't been too long and boring. Comments/suggestions are welcome.


Thanks for your help!


Emmanuel.


Emmanuel Hislen wrote:

>
> -----Message d'origine-----
> De : Emmanuel Hislen [mailto:hislen@mindspring.com]
> Envoye : Saturday, January 24, 2004 1:27 AM
> A : Hugo Mills
> Cc : linux-kernel@vger.kernel.org
> Objet : RE: SiI2112 + Seagate + nFroce2: no DMA!
>
>
>
> Hi Hugo,
>
> I have re-installed my machine with Fedora Core 1 (thinking a newer 
> version
> than RH9 would make the jump to 2.4.24 or 2.6 easier), and this fixed the
> DMA issue :-)
>
> Now my SATA drive is running stable in UDMA6.
>
> However, performance is still way below expectations.
>
> I got a huge improvement: my disc read speed (hdparm -t) went from 1.3 
> to 25
> MB/sec.
> This is still slower than my PATA drive on my 3 years old AMD 900 PC 
> running
> Redhat 9.0 (around 35 MB/sec).
>
> Could you please let me know what you are getting so I know what to 
> expect?
>
>
> My next step is to try 2.4.24 or 2.6.1 as you suggested, but googling 
> around
> a little bit before I do so I found out a few worrying things:
>
> - people have reported a drop in performance on SATA in some 2.6 based
> kernel (2.6.0-test9), with reported speeds around 20MB/sec. Apparently 
> there
> is no more way to tune max_kb_per_req in 2.6??
> - I have found reports that both ide and libdata libraries are limiting
> max_kb_per_req to 15 Kb specifically for Seagate drives. So It looks 
> like I
> can't even set it to 128 (I did not even try as I saw reports of memory
> corruption).
>
> So basically since you've got it to work I'd like to know:
>
> * what speed you get, and what is the RPM of your Seagate
> * what is your max_kb_per_req setting (I have 15K)
> * what is your accoustic management setting (I have 0)
>
>
> I could not fix the time on linux so I am sending this mail from WinXP 
> (just
> kidding I lost my mails on the linux machine after re-installing :-).
>
>
> Thanks,
>
>
> Emmanuel.
>
>
>
> -----Message d'origine-----
> De : Hugo Ranger Mills [mailto:hrm@carfax.org.uk]De la part de Hugo
> Mills
> Envoye : Tuesday, January 20, 2004 12:58 AM
> A : manu
> Cc : linux-kernel@vger.kernel.org
> Objet : Re: SiI2112 + Seagate + nFroce2: no DMA!
>
>
> On Tue, Dec 31, 2002 at 09:55:59PM -0800, manu wrote:
>
> Incidentally, did you know that the date on your computer is very,
> very wrong?
>
>> I'm about to give up on my SATA drive as I can't get it to work properly.
>> So I thought I may try asking the experts before falling back to PATA.
>>
>> I have seen many mails reporting the same issue, some of them 6-month 
>> old:
>>
>> - SATA drive comes up in pio mode, not in dma
>> - trying to turn on dma with hdparm is a nightmare: I/O errors, crash
>> with data corruption... I tried both:
>>
>> hddarm -d1 /dev/hde
>>
>> and:
>>
>> hdparm -u1 -c3 -d1 -X66 /dev/hde
>>
>> crash in both cases :-((
>>
>>
>> Here's my equipment:
>>
>>
>> ABIT AN7 motherboard (nForce2 chipset, SiI3112 SATA controller)
>> AMD Athlon XP 2600+ (+ 512 DDR / 400 MHz)
>> SATA HD Seagate Barracuda 160 Gb
>>
>> The SATA HD is my only drive. The only thing connected to my IDE
>> controllers is a DVD/CD combo.
>>
>> Running Linux Redhat 9.0
>> kernel 2.4.20-28.9
>
> ^^^^^^^^^^^^^^^^^^
> This is your problem. There have been a number of bug-fixes to the
> SiI drivers since 2.4.20. Try it again with a newer kernel -- such as
> 2.4.24.
>
>> I've been googling for days now and could not come accross a solution,
>> on the contrary I came under the impression that the combination of
>> SiI3112 +and Seagate was doomed.
>
>
> Not so. I have a SiI3112 controller and a 120GiB Seagate drive, and
> they work very well together. I'm using 2.6.1, although 2.4.23 also
> worked well for me.
>
> [snip]
>
>> Isn't there a solution??
>>
>> I am willing to try patches of experimental code. At this point I am
>> looking at reinstalling everything on a PATA drive anyway, so I have
>> nothing to loose.
>
>
> Try using 2.4.24 or 2.6.1.
>
> Hugo.
>
> --
> === Hugo Mills: hugo@... carfax.org.uk | darksatanic.net | lug.org.uk ===
> PGP key: 1C335860 from wwwkeys.eu.pgp.net or http://www.carfax.org.uk
> --- All hope abandon, Ye who press Enter here. ---
>
>


