Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262390AbVAZXKy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262390AbVAZXKy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jan 2005 18:10:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261851AbVAZXKo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jan 2005 18:10:44 -0500
Received: from alog0652.analogic.com ([208.224.223.189]:38016 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S262431AbVAZRHF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jan 2005 12:07:05 -0500
Date: Wed, 26 Jan 2005 12:05:47 -0500 (EST)
From: linux-os <linux-os@analogic.com>
Reply-To: linux-os@analogic.com
To: dtor_core@ameritech.net
cc: Vojtech Pavlik <vojtech@suse.cz>, linux-input@atrey.karlin.mff.cuni.cz,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: i8042 access timings
In-Reply-To: <d120d5000501260836686003d7@mail.gmail.com>
Message-ID: <Pine.LNX.4.61.0501261156330.18131@chaos.analogic.com>
References: <200501250241.14695.dtor_core@ameritech.net>  <20050126154307.GB4422@ucw.cz>
 <d120d5000501260836686003d7@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Jan 2005, Dmitry Torokhov wrote:

> On Wed, 26 Jan 2005 16:43:07 +0100, Vojtech Pavlik <vojtech@suse.cz> wrote:
>> On Tue, Jan 25, 2005 at 02:41:14AM -0500, Dmitry Torokhov wrote:
>>> @@ -213,7 +217,10 @@
>>>       if (!retval)
>>>               for (i = 0; i < ((command >> 8) & 0xf); i++) {
>>>                       if ((retval = i8042_wait_read())) break;
>>> -                     if (i8042_read_status() & I8042_STR_AUXDATA)
>>> +                     udelay(I8042_STR_DELAY);
>>> +                     str = i8042_read_status();
>> []
>>> +                     udelay(I8042_DATA_DELAY);
>>> +                     if (str & I8042_STR_AUXDATA)
>>>                               param[i] = ~i8042_read_data();
>>>                       else
>>>                               param[i] = i8042_read_data();
>>
>> We may as well drop the negation. It's a bad way to signal the data came
>> from the AUX port. Then we don't need the extra status read and can just
>> proceed to read the data, since IMO we don't need to wait inbetween,
>> even according to the IBM spec.
>
> Do you remember why it has been done to begin with?
>
> -- 
> Dmitry


The only time you need any delay at all is after you have send
the chip a reset command (0xff). Of course if you expect the
device to turn ON/OFF something like the old A20 bit, then
you need to wait for it to (1) get the command, (2) interpret
it (it contains a uP), then read/modify write the appropriate
bit. That takes time. However, if you get an interrupt that
says "data are available", you read the data with no waiting.
It's there and has been for a long time. The status bits will
have always been set before the internal status event. There
is never any need to wait after that.

Most of the newer emulations are inside Super-IO chips. They
don't suffer the port I/O glitches that the old ISA-mapped
devices did. You done' even need the "_p" in the port read/writes
but we need to maintain compatibility with some old machines
so I wouldn't change that.


Cheers,
Dick Johnson
Penguin : Linux version 2.6.10 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by Dictator Bush.
                  98.36% of all statistics are fiction.
