Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262487AbVAUTJz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262487AbVAUTJz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 14:09:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262493AbVAUTJz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 14:09:55 -0500
Received: from terminus.zytor.com ([209.128.68.124]:62646 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S262487AbVAUTJQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 14:09:16 -0500
Message-ID: <41F15297.1000309@zytor.com>
Date: Fri, 21 Jan 2005 11:05:59 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041127)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Matt Domsch <Matt_Domsch@dell.com>
CC: Andi Kleen <ak@suse.de>,
       "Catalin(ux aka Dino) BOIE" <util@deuroconsult.ro>,
       Adrian Bunk <bunk@stusta.de>,
       Janos Farkas <jf-ml-k1-1087813225@lk8rp.mail.xeon.eu.org>,
       linux-kernel@vger.kernel.org, Chris Bruner <cryst@golden.net>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Subject: Re: COMMAND_LINE_SIZE increasing in 2.6.11-rc1-bk6
References: <20050119231322.GA2287@lk8rp.mail.xeon.eu.org> <20050120162807.GA3174@stusta.de> <20050120164829.GG450@wotan.suse.de> <Pine.LNX.4.61.0501210857170.17260@webhosting.rdsbv.ro> <20050121071144.GB657@wotan.suse.de> <20050121174645.GA11386@lists.us.dell.com>
In-Reply-To: <20050121174645.GA11386@lists.us.dell.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matt Domsch wrote:
> On Fri, Jan 21, 2005 at 08:11:44AM +0100, Andi Kleen wrote:
> 
>>>I really suggest to push this limit to 4k. My reason is that under UML I 
>>>need to put a lot of stuff in command line and uml crash if I not extend 
>>>this limit. Can we make it depend on arhitecture?
>>
>>It's dependent on the architecture already. I would like to enable
>>it on i386/x86-64 because the kernel command line is often used
>>to pass parameters to installers, and having a small limit there
>>can be awkward.
>>
>>But first need to figure out what went wrong with EDD. 
>>
>>Matt D., do you have thoughts on this?
> 
> 
> It is definitely boot-loader dependent.  Simply changing
> COMMAND_LINE_SIZE from 256 to 2048 in the kernel isn't enough.
> 
> There are 2 ways the command line is passed from the boot loader into
> the kernel.
> 
> Boot loader version <= 0x0201  (which LILO uses)
> I believe the command line is located at the end of what was known as
> the 'empty zero page', now known as the boot parameters.  This part is
> black magic to me.
> 
> Boot loader version >= 0x0202  (which GRUB uses)
> command line can be essentially any size, located anywhere in memory,
> and the boot loader tells the kernel where to find it.  The EDD real
> mode code uses only this case for parsing the command line, and if an
> older loader is used, EDD skips parsing the command line looking
> for its options.
> 
> 
> There's little space left in the boot parameters block, my EDD code
> uses nearly all that was remaining, and could use some more if it were
> available.  Having a longer command line would be nice too.  I spoke
> with hpa at OLS last summer about this, and he offered to help.
> Peter?
> 

The protocol itself doesn't encode it, but before we extend it for 
protocol >= 0x0202 we need to make sure that older kernels don't break 
if they get a very long command line (truncation is OK, crashing is 
not.)  If they do crash, we need to add a field in the header.

I don't see any reason why the boot parameter block can't be more than 
one page long.  I think today that it's just a static structure.

	-hpa
