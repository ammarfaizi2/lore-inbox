Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265141AbUAJH2U (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jan 2004 02:28:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265150AbUAJH2U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jan 2004 02:28:20 -0500
Received: from smtpq1.home.nl ([213.51.128.196]:21898 "EHLO smtpq1.home.nl")
	by vger.kernel.org with ESMTP id S265141AbUAJH2S (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jan 2004 02:28:18 -0500
Message-ID: <3FFFA8C3.6040609@keyaccess.nl>
Date: Sat, 10 Jan 2004 08:24:51 +0100
From: Rene Herman <rene.herman@keyaccess.nl>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.1) Gecko/20031029
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Santiago Garcia Mantinan <manty@manty.net>
CC: Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org,
       Adam Belay <ambx1@neo.rr.com>
Subject: Re: ALSA in 2.6 failing to find the OPL chip of the sb cards
References: <20040107212916.GA978@man.manty.net> <s5hy8sixsor.wl@alsa2.suse.de> <20040109171715.GA933@man.manty.net> <s5hn08xgh06.wl@alsa2.suse.de> <20040109201423.GA1677@man.manty.net>
In-Reply-To: <20040109201423.GA1677@man.manty.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-AtHome-MailScanner-Information: Neem contact op met support@home.nl voor meer informatie
X-AtHome-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Santiago Garcia Mantinan wrote:

>>then it fails in the reset sequence of opl chip, namely, 
>>what happens if you replace the line 441
>>	opl3->command = &snd_opl2_command;
>>with
>>	opl3->command = &snd_opl3_command;
> 
> 
> Looks exactly the same thing to me:
> 
> pnp: Device 00:01.00 activated.
> ALSA sound/isa/sb/sb16.c:313: pnp SB16: port=0x220, mpu port=0x330, fm port=0x388
> ALSA sound/isa/sb/sb16.c:315: pnp SB16: dma1=1, dma2=5, irq=10
> ALSA sound/isa/sb/sb_common.c:133: SB [0x220]: DSP chip found, version = 4.13
> ALSA sound/drivers/opl3/opl3_lib.c:133: OPL3: stat1 = 0xff
> ALSA sound/drivers/opl3/opl3_lib.c:444: OPL2/3 chip not detected at 0x388/0x38a
> ALSA sound/isa/sb/sb16.c:484: sb16: no OPL device at 0x388-0x38a
> 
> I think I have already said that in 2.4 it works, and I have tested both
> alsa in the kernel plus alsa sources downloaded from alsa-project, this last
> one works in 2.4 but doesn't work in 2.6.

I'm seeing the same behaviour with a Sound Blaster AWE64 Gold. It seems 
it's not an ALSA problem though, but ISA-PnP. Enabling the card from 
userspace with the old isapnp tool makes the OPL chip appear:

root@7ixe4:~# dmesg -n8
root@7ixe4:~# modprobe snd-sbawe
pnp: the driver 'sb16' has been registered
pnp: match found with the PnP device '01:01.00' and the driver 'sb16'
pnp: match found with the PnP device '01:01.02' and the driver 'sb16'
pnp: Device 01:01.00 activated.
pnp: Device 01:01.02 activated.
ALSA sound/isa/sb/sb16.c:484: sbawe: no OPL device at 0x388-0x38a
root@7ixe4:~# modprobe -r snd-sbawe
pnp: Device 01:01.00 disabled.
pnp: Device 01:01.02 disabled.
pnp: the driver 'sb16' has been unregistered
root@7ixe4:~# isapnp awe64g
Board 1 has Identity 43 0f f1 94 5c 9e 00 8c 0e:  CTL009e Serial No 
267490396 [checksum 43]
Board 2 has Identity 2c 00 0f e4 18 02 00 94 16:  ETT0002 Serial No 
1041432 [checksum 2c]
root@7ixe4:~# modprobe snd-sbawe
pnp: the driver 'sb16' has been registered
pnp: match found with the PnP device '01:01.00' and the driver 'sb16'
pnp: match found with the PnP device '01:01.02' and the driver 'sb16'
pnp: Device 01:01.00 activated.
pnp: Device 01:01.02 activated.
root@7ixe4:~#

("awe64g" is just "pnpdump >awe64g", with preffered config uncommented)

That is, the driver doesn't complain anymore. Still didn't see the OPL 
appear in /proc/ioports though (loading with fm_port=0x388 doesn't 
change that). Haven't investigated further yet, will do.

Rene.


