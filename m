Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268276AbUIBMG2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268276AbUIBMG2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 08:06:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268269AbUIBMFu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 08:05:50 -0400
Received: from [195.23.16.24] ([195.23.16.24]:1990 "EHLO
	bipbip.comserver-pie.com") by vger.kernel.org with ESMTP
	id S268268AbUIBMFX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 08:05:23 -0400
Message-ID: <41370C7E.4020304@grupopie.com>
Date: Thu, 02 Sep 2004 13:05:18 +0100
From: Paulo Marques <pmarques@grupopie.com>
Organization: Grupo PIE
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040626)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Rusty Russell <rusty@rustcorp.com.au>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Matt Mackall <mpm@selenic.com>
Subject: Re: [PATCH] kallsyms: speed up /proc/kallsyms
References: <4134DEF4.8090001@grupopie.com> <1094016277.17828.53.camel@bach> <4135AFBE.1000707@grupopie.com> <20040901192755.GC7219@mars.ravnborg.org> <41362694.9070101@grupopie.com> <20040901195132.GA15432@mars.ravnborg.org>
In-Reply-To: <20040901195132.GA15432@mars.ravnborg.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiVirus: checked by Vexira MailArmor (version: 2.0.1.16; VAE: 6.27.0.6; VDF: 6.27.0.43; host: bipbip)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sam Ravnborg wrote:
> On Wed, Sep 01, 2004 at 08:44:20PM +0100, Paulo Marques wrote:
> 
>>Sam Ravnborg wrote:
>>
>>>...
>>>
>>>When you have made the split Rusty requested and implemented
>>>the above could you please send patches to me. I will add them to
>>>my kbuild queue.
>>
>>I'd be glad to do this, but AFAICT the patch already entered the mm
>>tree, so I think that splitting it now, or sending it through a
>>different path would probably add to the confusion I already
>>managed to create :(
> 
> 
> I prefer the split-up Rusty requested.
> It will then enter -mm via my queue - but as three logical separated
> patches. This is much better when looking into this later.
> 
> Andrew will just back-out your previous patch and mark it as 'merged'.

Ok, I'll send you the 3 patches then, no problem.

However, the third patch will already be the "type char"
implementation instead of the "is-exported" bit patch.

All 3 patches will be against 2.6.9-rc1-mm2. I'm just saying
this to make sure I understood correctly what I'm supposed to
do.

Anyway, I did some tests with the "type char" included in the
compressed stream.

The original data: 13743 symbols ~240kB uncompressed data

Compressed:
    without type char:                126292 bytes
    with type char inserted:
      after compression               140035 bytes
      before compression              137073 bytes
      before compression, lower case  134222 bytes

The last option in this table is to keep the extra bit to say
"the type for this symbol is upper case" and place the type
always in lowercase, to improve compression.

The gain with the lower case doesn't seem to make up for the
_ugliness_ of the method. Keeping an extra bit together with
the length of the symbol, assuming that the symbol length
will never be more than 127, is not pretty at all and forces
the decompression code to have more "special cases".

Inserting just the type char before compressing seems to be
the most cleaner approach.

Note that this is a defconfig setup without the KALLSYMS_ALL
config option. With KALLSYMS_ALL, the compressed stream size
goes to about 300kb and the gains should grow proportionally.
(this reminds me, I should include a patch to change the
help description that says that KALLSYMS_ALL adds about
300kb to the kernel image to say that it adds about 200kb)

I'll try to build all this tonight, and send the new version.

If you don't agree with the "type char" approach that seems
the best to me, please say so now, or forever hold your
peace :)

-- 
Paulo Marques - www.grupopie.com

To err is human, but to really foul things up requires a computer.
Farmers' Almanac, 1978
