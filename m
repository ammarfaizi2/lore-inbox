Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751106AbWIHTby@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751106AbWIHTby (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Sep 2006 15:31:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751085AbWIHTby
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Sep 2006 15:31:54 -0400
Received: from mail-in-02.arcor-online.net ([151.189.21.42]:18106 "EHLO
	mail-in-02.arcor-online.net") by vger.kernel.org with ESMTP
	id S1751084AbWIHTbx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Sep 2006 15:31:53 -0400
In-Reply-To: <1551EAE59135BE47B544934E30FC4FC093FB19@NT-IRVA-0751.brcm.ad.broadcom.com>
References: <1551EAE59135BE47B544934E30FC4FC093FB19@NT-IRVA-0751.brcm.ad.broadcom.com>
Mime-Version: 1.0 (Apple Message framework v750)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <9EAEC3B2-260E-444E-BCA1-3C9806340F65@kernel.crashing.org>
Cc: "Benjamin Herrenschmidt" <benh@kernel.crashing.org>,
       netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
       "Linux Kernel list" <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 7bit
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: TG3 data corruption (TSO ?)
Date: Fri, 8 Sep 2006 21:29:38 +0200
To: Michael Chan <mchan@broadcom.com>
X-Mailer: Apple Mail (2.750)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> I've been chasing with Segher a data corruption problem lately.
>> Basically transferring huge amount of data (several Gb) and I get
>> corrupted data at the rx side. I cannot tell for sure wether what  
>> I've
>> been observing here is the same problem that segher's been seing  
>> on is
>> blades, he will confirm or not. He also seemed to imply that  
>> reverting
>> to an older kernel on the -receiver- side fixed it, which makes me
>> wonder, since it's looks really like a sending side problem (see
>> explanation below), if some change in, for exmaple, window scaling,
>> might hide or trigger it.
>
> Please send me lspci and tg3 probing output so that I know what
> tg3 hardware you're using.

I use a 5780 rev. A3, but the problem is not limited to this chip.

> I also want to look at the tcpdump or
> ethereal on the mirrored port that shows the packet being corrupted.

I don't have such, sorry.

>> That's all the data I have at this point. I can't guarantee 100% that
>> it's a TSO bug (it might be a bug that TSO renders visible
>> due to timing
>> effects) but it looks like it since I've not reproduced yet with TSO
>> disabled.

It seems to indeed to only be exposed by TSO, not actually a
bug of it /an sich/.

I've got a patch that seems so solve the problem, it needs more testing
though (maybe Ben can do this :-) ).  The problem is that there should
be quite a few wmb()'s in the code that are just not there; adding some
to tg3_set_txd() seems to fix the immediate problem but more is needed
(and I don't see why those should be needed, unless tg3_set_txd() is
updating a life ring entry in place or something like that).

More testing is needed, but the problem is definitely the lack of memory
ordering.


Segher

