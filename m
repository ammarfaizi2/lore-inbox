Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964786AbWHCQZw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964786AbWHCQZw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Aug 2006 12:25:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964789AbWHCQZw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Aug 2006 12:25:52 -0400
Received: from ms-2.rz.RWTH-Aachen.DE ([134.130.3.131]:46047 "EHLO
	ms-dienst.rz.rwth-aachen.de") by vger.kernel.org with ESMTP
	id S964786AbWHCQZv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Aug 2006 12:25:51 -0400
Date: Thu, 03 Aug 2006 18:24:48 +0200
From: Arnd Hannemann <arnd@arndnet.de>
Subject: Re: problems with e1000 and jumboframes
In-reply-to: <41b516cb0608030857h1d55820rfd4ccd0cc56dd71d@mail.gmail.com>
To: Chris Leech <chris.leech@gmail.com>
Cc: Evgeniy Polyakov <johnpol@2ka.mipt.ru>, Krzysztof Oledzki <olel@ans.pl>,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Message-id: <44D22350.5070709@arndnet.de>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
Content-transfer-encoding: 7BIT
User-Agent: Thunderbird 1.5.0.4 (Windows/20060516)
X-Enigmail-Version: 0.94.0.0
X-Spam-Report: * -2.8 ALL_TRUSTED Did not pass through any untrusted hosts
References: <44D1FEB7.2050703@arndnet.de> <20060803135925.GA28348@2ka.mipt.ru>
 <44D20A2F.3090005@arndnet.de> <20060803150330.GB12915@2ka.mipt.ru>
 <Pine.LNX.4.64.0608031705560.8443@bizon.gios.gov.pl>
 <20060803151631.GA14774@2ka.mipt.ru>
 <41b516cb0608030857h1d55820rfd4ccd0cc56dd71d@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Leech schrieb:
> On 8/3/06, Evgeniy Polyakov <johnpol@2ka.mipt.ru> wrote:
> 
>> > Strange, why this skb_shared_info cannon be added before first
>> alignment?
>> > And what about smaller frames like 1500, does this driver behave
>> similar
>> > (first align then add)?
>>
>> It can be.
>> Could attached  (completely untested) patch help?
> 
> Note that e1000 uses power of two buffers because that's what the
> hardware supports.  Also, there's no program able MTU - only a single
> bit for "long packet enable" that disables frame length checks when
> using jumbo frames.  That means that if you tell the e1000 it has a
> 16k buffer, and a 16k frame shows up on the wire, it's going to write
> to the entire 16k regardless of your 9k MTU setting.  If a 32k frame
> shows up, two full 16k buffers get written to (OK, assuming the frame
> can fit into the receive FIFO)
> 
> That's why I've always been against trying to optimize the allocation
> sizes in the driver, even with your small change the skb_shinfo area
> can get corrupted.  It may be unlikely, because the frame still has to
> be valid, but some switches aren't real picky about what sized frame
> they'll forward on if you enable jumbo support either.  So any box on
> the LAN could send you larger than MTU frames in an attempt to corrupt
> memory.
> 
> I believe that if you tell a hardware device it has a buffer of a
> certain size, you need to be prepared for that entire buffer to get
> written to.  Unfortunately that means wasteful allocations for e1000
> if a single buffer per frame is going to be used.

Well you say "if a single buffer per frame is going to be used". Well,
if I understood you correctly i could set the MTU to, lets say 4000.
Then the driver would enable the "jumbo frame bit" of the hardware, and
allocate only a 4k rx buffer, right? (and allocate 16k, because of
skb_shinfo)
Now if a new 9k frame arrives the hardware will accept it regardless of
the 2k MTU and will split it into 3x 4k rx buffers?
Does the current driver work in this way? That would be great.

Perhaps then one should change the driver in a way that the MTU can
changed independently of the buffer size?

> - Chris
> -

Thanks,
Arnd Hannemann.



