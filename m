Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316274AbSEKUVk>; Sat, 11 May 2002 16:21:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316275AbSEKUVj>; Sat, 11 May 2002 16:21:39 -0400
Received: from smtp10.atl.mindspring.net ([207.69.200.246]:7 "EHLO
	smtp10.atl.mindspring.net") by vger.kernel.org with ESMTP
	id <S316274AbSEKUVg>; Sat, 11 May 2002 16:21:36 -0400
From: "Steven A. DuChene" <linux-clusters@mindspring.com>
Date: Sat, 11 May 2002 16:21:33 -0400
To: linux-kernel@vger.kernel.org
Subject: choice of framebuffer causes Oops from char/console.c (2.4.19-pre7-ac4)
Message-ID: <20020511162133.L278@lapsony.mydomain.here>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am trying to debug a problem but have hit an impass so additional
directions/suggestions would be most appreciated.

I have a dual PentiumPro system with a Riva128 based video card in it.
When I build a kernel for it I choose the following options:

CONFIG_MTRR=y
CONFIG_FB=y
CONFIG_DUMMY_CONSOLE=y
CONFIG_FB_RIVA=y
CONFIG_VIDEO_SELECT=y
CONFIG_FBCON_ADVANCED=y
CONFIG_FBCON_CFB8=y
CONFIG_FBCON_CFB16=y
CONFIG_FBCON_FONTS=y
CONFIG_FONT_8x16=y
CONFIG_FONT_SUN8x16=y
CONFIG_FONT_SUN12x22=y

Now thru 2.4.19-pre1 this has worked just fine and I am able to put the following
in my lilo.conf file and have a very nice small font and large screen on the console:

  append="video=riva:1280x1024-15@74"

>From 2.4.19-pre2 on this has caused the system to lock up solid during booting.
The system would get to the following (output captured via serial console):

apm: BIOS not found.
Starting kswapd
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
rivafb: RIVA MTRR set to ON

and then just stop. At that point I would have to hit the reset or powerbutton
on the system.

Today I took some time to trace this down via inserting printk's into various spots
in the source code.

Since I had a starting pont from the above messages where the last one comes from
drivers/video/riva/fbdev.c  so I inserted some printk's there after the original
printk line that output "rivafb: RIVA MTRR set to ON"
This lead me to the register_framebuffer() function call on line 1973 of riva/fbdev.c

This function is defined in drivers/video/fbmem.c so I continued putting printk's
into the register_framebuffer() function there. That led me to the call to
take_over_console() on line 779 of video/fbmem.c

This function is defined in drivers/char/console.c so again more printk's into
that function definition. The output stopped just before the call to visual_init
on line 2569 of char/console.c

I tried putting some printk's into that function definition but the output
stops as soon as it enters that function and I then get a Ooops shown below:


apm: BIOS not found.
Starting kswapd
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
rivafb: RIVA MTRR set to ON
rivafb: RIVA got to next step
rivafb: RIVA got to next step2
rivafb: RIVA got to next step3
rivafb: RIVA got to next step4
rivafb: RIVA got to next step5
rivafb: RIVA got to next step6
got to register_framebuffer
register_framebuffer step 1
register_framebuffer step 2
register_framebuffer step 3
register_framebuffer step 4
register_framebuffer step 5
register_framebuffer step 6
got to take_over_console
take_over_console step 1
take_over_console step 2
take_over_console step 3
take_over_console step 4
take_over_console step 5
take_over_console step 6
take_over_console step 7
take_over_console step 8
got to visual_init
<1>Unable to handle kernel NULL pointer dereference at virtual address 00000018
 printing eip:
c01e12e4
*pde = 00000000
Oops: 0000
CPU:    1
EIP:    0010:[<c01e12e4>]    Not tainted
EFLAGS: 00010246
eax: 00000000   ebx: 00000000   ecx: c0335820   edx: c026afa0
esi: c03464e0   edi: 00000002   ebp: 0000003b   esp: c13afe14
ds: 0018   es: 0018   ss: 0018
Process swapper (pid: 1, stackpage=c13af000)
Stack: 00000000 00000000 00000000 00000000 00000000 c019d9f8 c1344000 00000002
       00000000 c0316975 c01a0da7 00000000 c0287760 c0316975 000021f5 00002208
       00000000 c028a8e0 00000000 000021df 00000000 c011b6be c0287760 c0316975
Call Trace: [<c019d9f8>] [<c01a0da7>] [<c011b6be>] [<c011b723>] [<c011b7d9>]
   [<c011ba1f>] [<c011b9a5>] [<c019dcc1>] [<c01a1696>] [<c01df7c8>] [<c01d604a>
   [<c01d60ac>] [<c0105000>] [<c0105075>] [<c0105000>] [<c01070ff>]

Code: 83 7b 18 00 74 52 8b 5c 24 18 0f b7 43 2c 66 89 86 e8 00 00
 <0>Kernel panic: Attempted to kill init!

-- 
Steven A. DuChene      linux-clusters@mindspring.com
                      sduchene@mindspring.com

        http://www.mindspring.com/~sduchene/
