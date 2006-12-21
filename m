Return-Path: <linux-kernel-owner+w=401wt.eu-S1161174AbWLUDHl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161174AbWLUDHl (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 22:07:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161172AbWLUDHl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 22:07:41 -0500
Received: from smtp111.iad.emailsrvr.com ([207.97.245.111]:37513 "EHLO
	smtp111.iad.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161171AbWLUDHj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 22:07:39 -0500
Message-ID: <4589FAA6.509@gentoo.org>
Date: Wed, 20 Dec 2006 22:08:22 -0500
From: Daniel Drake <dsd@gentoo.org>
User-Agent: Thunderbird 1.5.0.8 (X11/20061111)
MIME-Version: 1.0
To: Matthew Garrett <mjg59@srcf.ucam.org>
CC: Michael Wu <flamingice@sourmilk.net>,
       Stephen Hemminger <shemminger@osdl.org>,
       Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Subject: Re: Network drivers that don't suspend on interface down
References: <20061220042648.GA19814@srcf.ucam.org> <20061220144906.7863bcd3@dxpl.pdx.osdl.net> <20061221011209.GA32625@srcf.ucam.org> <200612202105.31093.flamingice@sourmilk.net> <20061221021832.GA723@srcf.ucam.org> <4589F39C.7010201@gentoo.org> <20061221024533.GA1025@srcf.ucam.org>
In-Reply-To: <20061221024533.GA1025@srcf.ucam.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Garrett wrote:
>> There are additional implementation problems: scanning requires 2 
>> different ioctl calls: siwscan, then several giwscan. If you want the 
>> driver to effectively temporarily bring the interface up when userspace 
>> requests a scan but the interface was down, then how does the driver 
>> know when to bring it down again?
> 
> Hm. Does the spec not set any upper bound on how long it might take for 
> APs to respond? I'm afraid that my 802.11 knowledge is pretty slim. 

I'm not sure, but thats not entirely relevant either.  The time it takes 
for the AP to respond is not related to the delay between userspace 
sending the siwscan and giwscan ioctls (unless you're thinking of 
userspace being too quick, but GIWSCAN already returns -EINPROGRESS when 
appropriate so this is detectable)

> Picking a number out of thin air would be one answer, but clearly less 
> than ideal. This may be a case of us not being able to satisfy everyone, 
> and so just having to force the user to choose between low power or 
> wireless scanning.

I think it's reasonable to keep the interface down, but then when the 
user does want to connect, bring the interface up, scan, present scan 
results. Scanning is quick, there would be minimal wait needed here.

Alternatively, if you do want to prepare scan results in the background 
every 2 minutes, use a sequence something like:

- bring interface up
- siwscan
- giwscan [...]
- bring interface down
- repeat after 2 mins

If this kind of thing was implemented at the driver level, in most cases 
it would be identical to doing the above anyway.

Daniel
