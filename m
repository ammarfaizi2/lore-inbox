Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261152AbVAGAvy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261152AbVAGAvy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 19:51:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261205AbVAGAtZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 19:49:25 -0500
Received: from adsl-69-149-197-17.dsl.austtx.swbell.net ([69.149.197.17]:10711
	"EHLO gw.microgate.com") by vger.kernel.org with ESMTP
	id S261252AbVAGAoS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 19:44:18 -0500
Message-ID: <41DDDB47.8050008@microgate.com>
Date: Thu, 06 Jan 2005 18:43:51 -0600
From: Paul Fulghum <paulkf@microgate.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Tim_T_Murphy@Dell.com, rmk+lkml@arm.linux.org.uk,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [BUG][2.6.8.1] serial driver hangs SMP kernel, but not the UP
 kernel
References: <4B0A1C17AA88F94289B0704CFABEF1AB0B4D32@ausx2kmps304.aus.amer.dell.com> <1105052674.24187.288.camel@localhost.localdomain>
In-Reply-To: <1105052674.24187.288.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> On Iau, 2005-01-06 at 22:47, Tim_T_Murphy@Dell.com wrote:
> 
>>>anything i can do to avoid dropping characters without using 
>>>low_latency, which still hangs SMP kernels?
>>
>>this patch fixes the problem for me, but its probably an awful hack -- a
>>brief interrupt storm occurs until tty processes its buffer, but IMHO
>>that's better than dropping characters.
> 
> Presumably this is a device with a fake 8250 that produces sudden large
> bursts of data ? If so then for now you -need- to set low_latency and
> should probably do it by the PCI vendor subid/device id. The problem is
> that the serial layer expects serial data arriving at serial speeds. It
> completely breaks down when it hits an emulation of a generic uart that
> suddenely receives 32Kbytes of data at ethernet speed.
> 
> The longer term fix for this is when the flip buffers go away, and the
> same problem gets cleaned up for things like mainframes and some of the
> high performance DMA devices. Until then just set low_latency and
> comment it as "not your fault" 8)

IIRC that guarantees a deadlock on SMP due to the
generic serial layer trying to grab a spinlock
that is already held. (Which prompted the original
bug report by Tim several months ago)

Perhaps the FIFO trigger threshold for this
specific device can be altered
to try and smooth the amount of data dumped
per IRQ.

--
Paul Fulghum
paulkf@microgate.com
