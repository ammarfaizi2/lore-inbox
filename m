Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262238AbUJZLSy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262238AbUJZLSy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 07:18:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262236AbUJZLSy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 07:18:54 -0400
Received: from [195.23.16.24] ([195.23.16.24]:27557 "EHLO
	bipbip.comserver-pie.com") by vger.kernel.org with ESMTP
	id S262229AbUJZLOR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 07:14:17 -0400
Message-ID: <417E317C.2020703@grupopie.com>
Date: Tue, 26 Oct 2004 12:14:04 +0100
From: Paulo Marques <pmarques@grupopie.com>
Organization: Grupo PIE
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040626)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: adaplas@pol.net
Cc: linux-fbdev-devel@lists.sourceforge.net,
       Kendall Bennett <KendallB@scitechsoft.com>,
       Helge Hafting <helgehaf@aitel.hist.no>, linux-kernel@vger.kernel.org,
       penguinppc-team@lists.penguinppc.org,
       linuxconsole-dev@lists.sourceforge.net
Subject: Re: [Linux-fbdev-devel] Re: Generic VESA framebuffer driver and Video
 card BOOT?
References: <416FB624.31033.1D23BE5@localhost> <416FE8D9.18954.2984F7A@localhost> <200410160841.08441.adaplas@hotpop.com>
In-Reply-To: <200410160841.08441.adaplas@hotpop.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiVirus: checked by Vexira MailArmor (version: 2.0.1.16; VAE: 6.28.0.3; VDF: 6.28.0.38; host: bipbip)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Antonino A. Daplas wrote:
> On Saturday 16 October 2004 06:12, Kendall Bennett wrote:
> 
>>Helge Hafting <helgehaf@aitel.hist.no> wrote:
>>
>>>On Fri, Oct 15, 2004 at 11:36:04AM -0700, Kendall Bennett wrote:
>>>
>>>>Helge Hafting <helgehaf@aitel.hist.no> wrote:
>>>
>>>That's fine.  What I meant, was please make it independent of the
>>>VESA framebuffer driver, because one might want to use an
>>>acellerated driver when one is available.
>>
>>Oh, it already is. The VESA driver is not actually done yet so the only
>>drivers using VideoBoot right now are the accelerated ones ;-)
>>
> 
> 
> If these get in (emulator with/without the video boot), I'm willing to
> modify the vesafb driver.

Well, I played with the emulator last night to see if I could reduce the 
code size, so that it would be easier to make it to the official kernel.

I only took ops.c and did some transformations, like using a single 
function to make several operations based on the opcode, instead of a 
separate function for each opcode, etc.[1]

This is the result. Before:

Size of stripped libx86emu.a: ~74kb
ops.c source code lines: 11682
ops.o .text size: 36136
ops.o .data: 1312

After:

Size of stripped libx86emu.a: ~57kb
ops.c source code lines: 5908
ops.o .text size: 19320
ops.o .data: 1280

If the same treatment is applied to ops2.c and prim_ops.c, I believe it 
would be possible to have a functional emulator for about 32kb of kernel 
code size, which seems pretty reasonable to me and could solve a lot of 
problems.

The decrease in source code size also helps maintenance, since there is 
not so much repeated code has it was before.

Of course, these changes are optimizing the emulator for code size, and 
not execution speed. I haven't done any benchmarks to see if there is a 
noticeable difference in speed.






[1] The worst offenders were actually constructions like:

FETCH_DECODE_MODRM(mod, rh, rl);
switch (mod) {
   case 0:
       ...<some code>
       addr = decode_rm00_address(rl);
       ...<some more code>
       break;
   case 1:
       ...<exactly the same code as above>
       addr = decode_rm01_address(rl);
       ...<exactly the same code as above>
       break;
   case 2:
       ...<exactly the same code as above>
       addr = decode_rm10_address(rl);
       ...<exactly the same code as above>
       break;
    case 3:
       <diferent code to handle register-register ops>
       break;
   }

This could be easily changed to:

FETCH_DECODE_MODRM(mod, rh, rl);
if (mod < 3) {
       ...<some code>
       addr = decode_rmXX_address(mod, rl);
       ...<some more code>
   } else {
       <diferent code to handle register-register ops>
   }

simply by making a new decode_rmXX_address function that handles the mod 
parameter. There were more than 20 of these, and some of them were 
pretty big.

-- 
Paulo Marques - www.grupopie.com

All that is necessary for the triumph of evil is that good men do nothing.
Edmund Burke (1729 - 1797)


