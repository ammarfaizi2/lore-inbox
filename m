Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161533AbWJ3W7e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161533AbWJ3W7e (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 17:59:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161532AbWJ3W7e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 17:59:34 -0500
Received: from deine-taler.de ([217.160.107.63]:52178 "EHLO
	p15091797.pureserver.info") by vger.kernel.org with ESMTP
	id S1161353AbWJ3W7d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 17:59:33 -0500
Message-ID: <454683D1.4030200@deine-taler.de>
Date: Mon, 30 Oct 2006 23:59:29 +0100
From: Uli Kunitz <kune@deine-taler.de>
User-Agent: Thunderbird 1.5.0.7 (X11/20060922)
MIME-Version: 1.0
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Daniel Drake <dsd@gentoo.org>, Holden Karau <holden@pigscanfly.ca>,
       zd1211-devs@lists.sourceforge.net, linville@tuxdriver.com,
       netdev <netdev@vger.kernel.org>, linux-kernel@vger.kernel.org,
       holdenk@xandros.com
Subject: Re: [PATCH] wireless-2.6 zd1211rw check against regulatory domain
 rather than hardcoded value of 11
References: <f46018bb0610231121s4fb48f88l28a6e7d4f31d40bb@mail.gmail.com>	 <453D48E5.8040100@gentoo.org>	 <f46018bb0610240709y203d8cdbw95cdf66db23aa1ce@mail.gmail.com>	 <453E2C9A.7010604@gentoo.org>  <4544CBC8.5090305@deine-taler.de> <1162197749.2854.5.camel@ux156>
In-Reply-To: <1162197749.2854.5.camel@ux156>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Johannes Berg wrote:
>> I'm not so sure about this. This patching might be US-specific and we 
>> cannot simply apply the setting for top channel of another domain 
>> instead of channel 11. One option would be to set the value only under 
>> the US regulatory domain.
> 
> ??
> What the patch does is replace the top channel which is hardcoded to 11
> by the top channel given by the current regulatory domain. How can that
> be wrong? Except that you may want to init the regulatory domain from
> the EEPROM but I'm not sure how the ieee80211 code works wrt. that.
> 
> johannes

The problem is not so much that I don't trust the geo code, but whether
setting the register to that band-edge value for a higher channel is
the right thing to do. It looks like that this is a hack for FFC
compliance. Therefore I suggest to patch CR128 only
for the US regulatory domain.

Here is the code from the GPL vendor driver (zdhw.c):

    if (pObj->HWFeature & BIT_21)  //6321 for FCC regulation, enabled HWFeature 6M band edge bit (for AL2230, AL2230S)
     {
         if (ChannelNo == 1 || ChannelNo == 11)  //MARK_003, band edge, these may depend on PCB layout
         {
             pObj->SetReg(reg, ZD_CR128, 0x12);
             pObj->SetReg(reg, ZD_CR129, 0x12);
             pObj->SetReg(reg, ZD_CR130, 0x10);
             pObj->SetReg(reg, ZD_CR47, 0x1E);
         }
         else //(ChannelNo 2 ~ 10, 12 ~ 14)
         {
             pObj->SetReg(reg, ZD_CR128, 0x14);
             pObj->SetReg(reg, ZD_CR129, 0x12);
             pObj->SetReg(reg, ZD_CR130, 0x10);
             pObj->SetReg(reg, ZD_CR47, 0x1E);
         }
     }

The patch from Holden would set ZD_CR128 to 0x12 for the highest channel,
which would not reflect the logic of the vendor driver.

Kind regards,

Uli

-- 
Uli Kunitz (kune@deine-taler.de)
