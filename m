Return-Path: <linux-kernel-owner+w=401wt.eu-S1161159AbWLUChi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161159AbWLUChi (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 21:37:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161156AbWLUChi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 21:37:38 -0500
Received: from smtp131.iad.emailsrvr.com ([207.97.245.131]:42400 "EHLO
	smtp131.iad.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161155AbWLUChh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 21:37:37 -0500
X-Greylist: delayed 525 seconds by postgrey-1.27 at vger.kernel.org; Wed, 20 Dec 2006 21:37:37 EST
Message-ID: <4589F39C.7010201@gentoo.org>
Date: Wed, 20 Dec 2006 21:38:20 -0500
From: Daniel Drake <dsd@gentoo.org>
User-Agent: Thunderbird 1.5.0.8 (X11/20061111)
MIME-Version: 1.0
To: Matthew Garrett <mjg59@srcf.ucam.org>
CC: Michael Wu <flamingice@sourmilk.net>,
       Stephen Hemminger <shemminger@osdl.org>,
       Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Subject: Re: Network drivers that don't suspend on interface down
References: <20061220042648.GA19814@srcf.ucam.org> <20061220144906.7863bcd3@dxpl.pdx.osdl.net> <20061221011209.GA32625@srcf.ucam.org> <200612202105.31093.flamingice@sourmilk.net> <20061221021832.GA723@srcf.ucam.org>
In-Reply-To: <20061221021832.GA723@srcf.ucam.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Garrett wrote:
>> In order to scan, we need to have the radio on and we need to be able to send 
>> and receive. What are you gonna turn off?
> 
> The obvious route would be to power the card down, but come back up 
> every two minutes to perform a scan, or if userspace explicitly requests 
> one. Would this cause problems in some cases?

I don't think it makes sense. For zd1211 the power consumption and heat 
emission goes up considerably when the interface is brought up (radio 
on, interrupts enabled, etc), and this is also a relatively long 
operation in terms of duration needed to bring the interface up and 
down. A scanning operation requires radio on, interrupts enabled, lots 
of register reading, RF calibration, RX/TX ringbuffers allocation, etc.

I don't think that supporting scanning when the interface is supposed to 
be disabled is sensible. If you want to scan, you are simply sending and 
receiving frames, it's no different from having the interface up and 
sending/receiving data frames.

There are additional implementation problems: scanning requires 2 
different ioctl calls: siwscan, then several giwscan. If you want the 
driver to effectively temporarily bring the interface up when userspace 
requests a scan but the interface was down, then how does the driver 
know when to bring it down again?

Daniel
