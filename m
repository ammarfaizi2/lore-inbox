Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311211AbSDIUFQ>; Tue, 9 Apr 2002 16:05:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311239AbSDIUFP>; Tue, 9 Apr 2002 16:05:15 -0400
Received: from mailf.telia.com ([194.22.194.25]:32203 "EHLO mailf.telia.com")
	by vger.kernel.org with ESMTP id <S311211AbSDIUFP>;
	Tue, 9 Apr 2002 16:05:15 -0400
Content-Type: text/plain;
  charset="iso-8859-1"
From: Roger Larsson <roger.larsson@norran.net> (by way of Roger Larsson
	<roger.larsson@norran.net>)
Subject: Re: PROMBLEM: CD burning at 16x uses excessive CPU, although DMA is enabled
Date: Tue, 9 Apr 2002 22:06:02 +0200
X-Mailer: KMail [version 1.4]
To: Anssi Saari <as@sci.fi>
Cc: linux-kernel@vger.kernel.org, Mark Mielke <mark@mark.mielke.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200204092206.02376.roger.larsson@norran.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On tisdagen den 9 april 2002 12.01, Anssi Saari wrote:
> On Mon, Apr 08, 2002 at 06:02:55PM -0400, Mark Hahn wrote:
> > I think someone else already pointed out that doing
> > a kernel profile would be good.  strace would also
> > be quite useful, even just the -c form.
>
> Here it is:
>
> With unmaskirq=1 first:
>
>
>     49 handle_IRQ_event                           0.5104
>    239 file_read_actor                            2.4896
>   3324 default_idle                              69.2500
>  20097 ide_output_data                          104.6719

Hey, what is this?

Comment of the function is:
"This is used for most PIO data transfers *to* the IDE interface"
(see /drivers/ide/ide.c:426)
Has it reverted to PIO mode?

Some information might be found with
# more /proc/ide/hd*/settings

This is how mine look like
cat /proc/ide/hdc/settings
name                    value           min             max             mode
----                    -----           ---             ---             ----
bios_cyl			0               0               1023            rw
bios_head		0               0               255             rw
bios_sect		0               0               63              rw
current_speed	66              0               69              rw
ide_scsi		0               0               1               rw
init_speed		66              0               69              rw
io_32bit			0               0               3               rw
keepsettings	0               0               1               rw
log				0               0               1               rw
nice1			1               0               1               rw
number			2               0               3               rw
pio_mode		write-only      0               255             w
slow			0               0               1               rw
transform		1               0               3               rw
unmaskirq		1               0               1               rw
using_dma		1               0               1               rw

>  23952 total                                      0.0236
> Number of interrupts on ide1 during burn: 17531
>
> And then, unmaskirq=0:
>
> - - -
>    168 do_softirq                                 0.9545
>    234 file_read_actor                            2.4375
>   1942 handle_IRQ_event                          20.2292
>   2949 default_idle                              61.4375
>   6808 ide_intr                                  18.5000
>  12333 total                                      0.0122
> Number of interrupts on ide1 during burn: 17532

This looks like mine results. Quite some time spent in interrupt
routines. (weighted 38%)
Using or not using unmaskirq does not matter for me:
It stays below 40%, but I do only run at 10x (40% is quite much
for any disk bound operation...)

I will attempt a profiling while unmasked too.

I assume you also use ide_scsi, right?

/RogerL

--
Roger Larsson
Skellefteå
Sweden

