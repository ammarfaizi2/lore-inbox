Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261618AbUCQPnf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Mar 2004 10:43:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261655AbUCQPnf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Mar 2004 10:43:35 -0500
Received: from smtp-send.myrealbox.com ([192.108.102.143]:9606 "EHLO
	smtp-send.myrealbox.com") by vger.kernel.org with ESMTP
	id S261618AbUCQPn3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Mar 2004 10:43:29 -0500
Message-ID: <405872E1.8020109@myrealbox.com>
Date: Wed, 17 Mar 2004 07:46:41 -0800
From: walt <wa1ter@myrealbox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7b) Gecko/20040316
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
CC: linux-kernel@vger.kernel.org, jgarzik@pobox.com
Subject: Re: Broadcom gigabit solution for Jeff.
References: <40578C04.3070202@myrealbox.com> <20040316174511.3003f880.davem@redhat.com>
In-Reply-To: <20040316174511.3003f880.davem@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller wrote:
> On Tue, 16 Mar 2004 15:21:40 -0800
> walt <wa1ter@myrealbox.com> wrote:
> 
> 
>>...this is the first time I've tried the driver from Broadcom, so I can't
>> tell you when it was fixed...
> 
> 
> The current driver in the current 2.4.x and 2.6.x pre-release trees should
> have this bug fixed in the tg3 driver.

I admit I seem to be the only one still complaining, so I suspect I must have
a mobo with a rare chip type.  The bug is definitely *not* fixed for me, as of
today's latests changesets from Linus.

The problem lies in the way the chip is initialized on bootup, clearly, because
doing ifconfig down/up changes a few bytes of memory and starts things working
until the next reboot.

Here is a before/after diff of lspci -xxx.  You can see that byte 0x94 has been
reset by the ifconfig down/up:

#diff before after
83,89c83,89
< 90: 09 02 00 01 01 00 00 00 00 00 00 00 c8 00 00 00
< a0: 00 00 00 00 00 00 00 00 00 00 00 00 03 00 00 00
< b0: 00 00 00 00 01 00 00 00 00 00 00 00 01 00 00 00
< c0: 00 00 00 00 01 00 00 00 00 00 00 00 01 00 00 00
< d0: 00 00 00 00 01 00 00 00 00 00 00 00 01 00 00 00
< e0: 00 00 00 00 01 00 00 00 00 00 00 00 01 00 00 00
< f0: 00 00 00 00 01 00 00 00 00 00 00 00 01 00 00 00
---
 > 90: 09 02 00 01 00 00 00 00 00 00 00 00 c8 00 00 00
 > a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 > b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 > c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 > d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 > e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 > f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

I wish I had the expertise to figure out what code is responsible
for resetting that bit, but alas I don't.

If you could give me even a hint of what sections of the tg3 code
to look at I might be able to pick it up from there -- e.g. what
part of the driver code would be exercised by 'ifconfig down' that
isn't done by the 'ifconfig up' at bootup.
