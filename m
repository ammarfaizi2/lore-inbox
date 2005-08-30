Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932116AbVH3EdI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932116AbVH3EdI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Aug 2005 00:33:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932118AbVH3EdI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Aug 2005 00:33:08 -0400
Received: from mail.dvmed.net ([216.237.124.58]:4548 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932116AbVH3EdH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Aug 2005 00:33:07 -0400
Message-ID: <4313E17C.4040401@pobox.com>
Date: Tue, 30 Aug 2005 00:33:00 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
CC: linux-ppc-embedded <linuxppc-embedded@ozlabs.org>,
       linux-kernel@vger.kernel.org, Russell King <rmk+lkml@arm.linux.org.uk>,
       Dan Malek <dan@embeddededge.com>, Pantelis Antoniou <panto@intracom.gr>
Subject: Re: [PATCH] MPC8xx PCMCIA driver
References: <20050830024840.GA5381@dmt.cnet> <4313D4D6.7080108@pobox.com> <20050830035338.GA5755@dmt.cnet>
In-Reply-To: <20050830035338.GA5755@dmt.cnet>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Tosatti wrote:
> On Mon, Aug 29, 2005 at 11:39:02PM -0400, Jeff Garzik wrote:
> 
>>Marcelo Tosatti wrote:
>>
>>>+static int voltage_set(int slot, int vcc, int vpp)
>>>+{
>>>+	u_int reg = 0;
>>>+
>>>+	switch(vcc) {
>>>+	case 0: break;
>>>+	case 33:
>>>+		reg |= BCSR1_PCVCTL4;
>>>+		break;
>>>+	case 50: 
>>>+		reg |= BCSR1_PCVCTL5;
>>>+		break;
>>>+	default: 
>>>+		return 1;
>>>+	}
>>>+
>>>+	switch(vpp) {
>>>+	case 0: break;
>>>+	case 33: 
>>>+	case 50:
>>>+		if(vcc == vpp)
>>>+			reg |= BCSR1_PCVCTL6;
>>>+		else
>>>+			return 1;
>>>+		break;
>>>+	case 120: 
>>>+		reg |= BCSR1_PCVCTL7;
>>>+	default:
>>>+		return 1;
>>>+	}
>>>+
>>>+	if(!((vcc == 50) || (vcc == 0)))
>>>+		return 1;
>>>+
>>>+	/* first, turn off all power */
>>>+
>>>+	*((uint *)RPX_CSR_ADDR) &= ~(BCSR1_PCVCTL4 | BCSR1_PCVCTL5
>>>+				     | BCSR1_PCVCTL6 | BCSR1_PCVCTL7);
>>>+
>>>+	/* enable new powersettings */
>>>+
>>>+	*((uint *)RPX_CSR_ADDR) |= reg;
>>
>>Should use bus read/write functions, such as foo_readl() or iowrite32().
> 
> 
> The memory map structure which contains device configuration/registers
> is _always_ directly mapped with pte's (the 8xx is a chip with builtin
> UART/network/etc functionality).
> 
> I don't think there is a need to use read/write acessors.

There are multiple reasons:

* Easier reviewing.  One cannot easily distinguish between writing to 
normal kernel virtual memory and "magic" memory that produces magicaly 
side effects such as initiating DMA of a net packet.

* Compiler safety.  As the code is written now, you have no guarantees 
that the compiler won't combine two stores to the same location, etc. 
Accessor macros are a convenient place to add compiler barriers or 
'volatile' notations that the MPC8xx code lacks.

* Maintainable.  foo_read[bwl] or foo_read{8,16,32} are preferred 
because that's the way other bus accessors look like -- yes even 
embedded SoC buses benefit from these code patterns.  You want your 
driver to look like other drivers as much as possible.

* Convenience.  The accessors can be a zero overhead memory read/write 
at a minimum.  But they can also be convenient places to use special 
memory read/write instructions that specify uncached memop, compiler 
barriers, memory barriers, etc.

Regards,

	Jeff


