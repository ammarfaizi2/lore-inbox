Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965213AbVJ1Mkk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965213AbVJ1Mkk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Oct 2005 08:40:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965224AbVJ1Mkk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Oct 2005 08:40:40 -0400
Received: from pythagoras.zen.co.uk ([212.23.3.140]:9924 "EHLO
	pythagoras.zen.co.uk") by vger.kernel.org with ESMTP
	id S965213AbVJ1Mkj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Oct 2005 08:40:39 -0400
Message-ID: <43621C40.3030005@cantab.net>
Date: Fri, 28 Oct 2005 13:40:32 +0100
From: David Vrabel <dvrabel@cantab.net>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: jbowler@acm.org
CC: "'Deepak Saxena'" <dsaxena@plexity.net>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.6.14-rc3 ixp4xx_copy_from little endian/alignment
References: <000e01c5db86$29ba4120$1001a8c0@kalmiopsis>
In-Reply-To: <000e01c5db86$29ba4120$1001a8c0@kalmiopsis>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-Pythagoras-IP: [82.70.146.41]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Bowler wrote:
> 
> +/* On a little-endian IXP4XX system (tested on NSLU2) contrary to the
> + * Intel documentation LDRH/STRH appears to XOR the address with 10b.

I don't think this is correct. i.e., I think the Intel docmentation is 
correct.

The Application Note on IXP4xx endianess operation[1] says that (by 
default) the XScale core operates in address coherency mode (i.e., it 
flips address bits).  I suspect you need to set BYTE_SWAP_EN in 
EXP_CNFG1 and use the P bit in the MMU to get data coherency mode for 
various peripherals (probably all expansion bus periperals and possibly 
all the APB peripherals).

Also, I've noticed that the PCI_CSR is mis-configured when the XScale 
core is in little-endian mode.  ABE (AHB is big-endian) /must/ always be 
set -- remember that the NPEs are always big-endian devices.

Since I'd never run an IXP4xx in little-endian mode I've not looked at 
this issue in any great depth so I could be wrong here.  Regardless, the 
proposed hack to the flash map driver is wrong since all expansion bus 
peripherals are affected not just flash (i.e., the solution needs to be 
more generic rather than flash driver specific).

David Vrabel

[1] http://www.intel.com/design/network/applnots/25423701.pdf
