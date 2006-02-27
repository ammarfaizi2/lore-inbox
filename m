Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751779AbWB0XbR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751779AbWB0XbR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 18:31:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751784AbWB0XbR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 18:31:17 -0500
Received: from smtpq1.groni1.gr.home.nl ([213.51.130.200]:38341 "EHLO
	smtpq1.groni1.gr.home.nl") by vger.kernel.org with ESMTP
	id S1751779AbWB0XbQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 18:31:16 -0500
Message-ID: <44038BFE.6090907@keyaccess.nl>
Date: Tue, 28 Feb 2006 00:32:14 +0100
From: Rene Herman <rene.herman@keyaccess.nl>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: torvalds@osdl.org, linux-kernel@vger.kernel.org, ambx1@neo.rr.com
Subject: Re: Linux v2.6.16-rc5
References: <Pine.LNX.4.64.0602262122000.22647@g5.osdl.org>	<4403586C.2020004@keyaccess.nl> <20060227145120.0712eaac.akpm@osdl.org>
In-Reply-To: <20060227145120.0712eaac.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-AtHome-MailScanner-Information: Neem contact op met support@home.nl voor meer informatie
X-AtHome-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

> Rene Herman <rene.herman@keyaccess.nl> wrote:

>> This one isn't in: http://lkml.org/lkml/2006/2/21/7
>>
>> Andrew did pick it up -- pnp-bus-type-fix.patch, named as being in the 
>> 2.6.16 queue in his 2.6.16-rc4-mm2 announce:
>>
>> http://lkml.org/lkml/2006/2/24/66
>>
>> so it's probably okay. The other two patches from that same thread 
>> already made it into -rc5 though, so thought I'd ping anyway. It does 
>> really want to make 2.6.16. Many ISA-PnP drivers are quite severely 
>> broken without (it's also a regression against 2.6.15).
>>
> 
> Problem is, that patch was just a "here, try this" thing which Adam slung
> onto the mailing list - I have no idea whether it was compete or final or
> whether he wants it in 2.6.16 or what.

Adam? But something will need to go in. At the moment an entire bus 
subsystem appears to be broken.

> No indication of what problem it's fixing, nor how, now what risk
> there is of breaking something else.  It's just a lonely little diff
> at present.

The problem it fixed for me was that the CS4236 ALSA driver's private 
PnP remove method was not being called at modprobe -r, which meant that 
the card wasn't being freed at all, resulting in memory leaks, the 
inability to reload the driver, and oopses, during modprobe -r and reboot.

All ALSA ISA card drivers, not just CS4236, use the same interface to 
PnP (the pnp_card_driver struct) meaning they would all appear to be 
broken in that exact same way as well. Or rather, _any_ ISA-PnP driver 
using that pnp_card_driver interface (there's also drivers using the 
pnp_driver interface -- those appear to be okay). CS4236 isn't doing 
anything special...

The problem seems to be caused by the "bustype" driver model changes in 
2.6.16, the same ones that made the sensors drivers complain about 
private methods versus bustype methods which was fixed in -rc2. Adam 
said that in fact not so much the teardown was broken, but the setup, 
and the patch replaces a subsystem probe method with a bustype method.

As to the risk of it breaking anything else... I doubt it. Given that 
the old method did not work _at all_ it seems this is simply the way to 
do this.

Adam ofcourse is the PnP expert though...

Rene.

