Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751399AbVLESl0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751399AbVLESl0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 13:41:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751403AbVLESl0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 13:41:26 -0500
Received: from mail.dvmed.net ([216.237.124.58]:10124 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751399AbVLESlY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 13:41:24 -0500
Message-ID: <439489CE.9060607@pobox.com>
Date: Mon, 05 Dec 2005 13:41:18 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Tejun Heo <htejun@gmail.com>
CC: Ethan Chen <thanatoz@ucla.edu>, linux-kernel@vger.kernel.org,
       Carlos Pardo <Carlos.Pardo@siliconimage.com>,
       Linux-ide <linux-ide@vger.kernel.org>
Subject: Re: SIL_QUIRK_MOD15WRITE workaround problem on 2.6.14
References: <438BD351.60902@ucla.edu> <438D2792.9050105@gmail.com> <438D2DCC.4010805@pobox.com> <438D3AA8.9030504@gmail.com> <438FAADC.6060907@pobox.com> <43931CDF.3080202@gmail.com>
In-Reply-To: <43931CDF.3080202@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.1 (/)
X-Spam-Report: Spam detection software, running on the system "srv2.dvmed.net", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  Tejun Heo wrote: > Jeff Garzik wrote: > >> Tejun Heo
	wrote: >> >>> Ethan confirmed that it's 1095:3114. Arghhh.... Maybe we
	should >>> keep m15w quirk for 3114's for the time being? Better be
	slow than >>> hang. Whatever bug the m15w quirk was hiding. >> >> >> >>
	A generic 'slow_down_io' module option is reasonable. >> >> It is not
	appropriate to apply mod15write quirk to hardware that isn't >>
	affected by the chip bug. >> >> A better solution is to write a
	311x-specific interrupt handler. >> > > Hello, Jeff. Hello, Carlos. > >
	I bought a sii3114 controller yesterday and took out my ST3120026AS for
	> testing. The drive times out during a WRITE_EXT, and locks up. > > *
	The ST3120026AS works perfectly on a VIA controller. > * The sii3114
	controller works perfectly with Maxtor 6B080M0 drives. > > I don't
	know. It acts and smells like m15w problem. What are the odds > of
	having the same symptom on the same combination? [...] 
	Content analysis details:   (0.1 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[69.134.188.146 listed in dnsbl.sorbs.net]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tejun Heo wrote:
> Jeff Garzik wrote:
> 
>> Tejun Heo wrote:
>>
>>> Ethan confirmed that it's 1095:3114.  Arghhh....  Maybe we should 
>>> keep m15w quirk for 3114's for the time being?  Better be slow than 
>>> hang. Whatever bug the m15w quirk was hiding.
>>
>>
>>
>> A generic 'slow_down_io' module option is reasonable.
>>
>> It is not appropriate to apply mod15write quirk to hardware that isn't 
>> affected by the chip bug.
>>
>> A better solution is to write a 311x-specific interrupt handler.
>>
> 
> Hello, Jeff.  Hello, Carlos.
> 
> I bought a sii3114 controller yesterday and took out my ST3120026AS for 
> testing.  The drive times out during a WRITE_EXT, and locks up.
> 
> * The ST3120026AS works perfectly on a VIA controller.
> * The sii3114 controller works perfectly with Maxtor 6B080M0 drives.
> 
> I don't know.  It acts and smells like m15w problem.  What are the odds 
> of having the same symptom on the same combination?

A lock-up is very generic, and could be anything.  Tons of problems are 
hidden by slowing things down, so I just feel that presuming this is 
_the_ mod15write problem may lead us down the wrong path.

Key example:  On error, we need to do a channel-reset, and possibly a 
FIFO-reset.  See the FreeBSD code.  sata_sil doesn't do this at all, and 
probably should.  The reset may cure lockups.

	Jeff


