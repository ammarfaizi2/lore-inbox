Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750728AbVKTVjE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750728AbVKTVjE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Nov 2005 16:39:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750780AbVKTVjD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Nov 2005 16:39:03 -0500
Received: from s0003.shadowconnect.net ([213.239.201.226]:62128 "EHLO
	mail.shadowconnect.com") by vger.kernel.org with ESMTP
	id S1750728AbVKTVjC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Nov 2005 16:39:02 -0500
Message-ID: <4380ECEE.6060302@shadowconnect.com>
Date: Sun, 20 Nov 2005 22:38:54 +0100
From: Markus Lidel <Markus.Lidel@shadowconnect.com>
User-Agent: Mozilla Thunderbird 1.0.6 (Windows/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: "David S. Miller" <davem@davemloft.net>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] I2O: SPARC fixes
References: <437E7ADB.5080200@shadowconnect.com>	 <20051118.172230.126076770.davem@davemloft.net>	 <1132371039.5238.14.camel@localhost.localdomain>	 <20051118.203707.129707514.davem@davemloft.net> <1132406315.5238.16.camel@localhost.localdomain>
In-Reply-To: <1132406315.5238.16.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi...

Alan Cox wrote:
>> On Gwe, 2005-11-18 at 17:22 -0800, David S. Miller wrote:
>>>Ho hum, I guess keep it a config option for now until we find a
>>>way to auto-detect this reliably.
>> The notify functionality is mandatory. You are seeing the same cards
>> fail on sparc but work on x86. This sounds to me a lot more like an
>> unfound endian bug that needs fixing than a real lack of support
>>That's very possible, but it also could be that the cards
>>that fail only on Sparc have Sun forth firmware on them,
>>which would thus only load firmware on Sparc boxes.
> The firmware on the DPT I2O card processor is kept in flash on the
> processor. The BIOS setup code might be different but nothing at the
> business end of things

That's right there are two different firmwares. One for "Intel"-cards and 
one for SUN-cards. The LCT-Notify function works as follow.

The LCT on the I2O controller has a change indicator which is incremented 
by the I2O controller each time something changes (e. g. a disk is 
removed or added or so). The i2o_exec_lct_notify() function only send a 
number to the I2O controller. If this number is <= then the current 
change indicator of the LCT, then the controller send out the new LCT to 
the OS. On startup the change indicator is normally 1. So if there is 
some BE<->LE issue, then the function wouldn't send in 0x00000002 but 
0x02000000. What should happen then is that you won't be notified for a 
long time. But that didn't happened, and the controller immediately send 
out the LCT, although if you send in 0xffffffff. And as i'm told, this is 
wanted for some reason for the "SUN"-firmware.

It should probably be "fixed" if you upload a "Intel"-firmware onto the 
I2O controller, but because i don't own a SPARC machine with a PCI slot 
myself, i don't want to try it out on someones else machine and probably 
break it :-)

If someone has a SPARC machine with an I2O controller, and he want to try 
it out, please let me know...

Bye...
------------------------------------------
Markus Lidel (Senior IT Consultant)

Shadow Connect GmbH
Carl-Reisch-Weg 12
D-86381 Krumbach
Germany

Phone:  +49 82 82/99 51-0
Fax:    +49 82 82/99 51-11

E-Mail: Markus.Lidel@shadowconnect.com
URL:    http://www.shadowconnect.com
