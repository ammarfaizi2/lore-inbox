Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262850AbSJWFDH>; Wed, 23 Oct 2002 01:03:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262862AbSJWFDH>; Wed, 23 Oct 2002 01:03:07 -0400
Received: from ns.cinet.co.jp ([210.166.75.130]:39439 "EHLO multi.cinet.co.jp")
	by vger.kernel.org with ESMTP id <S262850AbSJWFDG>;
	Wed, 23 Oct 2002 01:03:06 -0400
Message-ID: <E6D19EE98F00AB4DB465A44FCF3FA46903A30A@ns.cinet.co.jp>
From: Osamu Tomita <tomita@cinet.co.jp>
To: "'Vojtech Pavlik '" <vojtech@suse.cz>
Cc: "'LKML '" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH][RFC] add support for PC-9800 architecture (13/26) key
	board
Date: Wed, 23 Oct 2002 14:09:12 +0900
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-2022-jp"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for comments.

-----Original Message-----
From: Vojtech Pavlik
To: Osamu Tomita
Cc: LKML; Linus Torvalds
Sent: 2002/10/22 19:43
Subject: Re: [PATCH][RFC] add support for PC-9800 architecture (13/26)
keyboard

> I won't merge this unless it's cleaned up, kana support either made
> generic or put into keymaps, and the below problems resolved.

> ... no way I'll add another default keymap when now we have unified
> keycodes. And we do support japanese keycodes/keymappings. 
Japanese keycodes/keymapping support! We are very happy. IMHO To realize
this, emulations include shift-state modifier are needed??
Please point me where is source code, and we don't touch defkeymaps.

>> diff -urN linux/drivers/char/keyboard.c
> Either there is a need for a special kanji mode changing function for
> japanese keyboards or there is not. Either way, it isn't PC-98 specific.
I think it's for emergency(or rescue) purpose. For example, system cannot
boot due to illegal kanji named file, input kenji to select one and change
it. We plan direct character code input. In kanji-mode, do convert from
hex numeric input to kanji. But not implemented yet.


>> +#ifndef CONFIG_PC9800
>>  #define KBD_DEFLEDS 0
>> +#else
>> +#define KBD_DEFLEDS (1 << VC_NUMLOCK)
>> +#endif
> You want numlock on by default?
Yes. Desktop PC-9800 has Ten-key pad. But doesn't have NumLock key!
Perhaps BIOS initialize always NumLock ON.
Note book PC-9800 has NumLock key. But NumLock key never send scancode,
do change scancode internaly.

>>  #ifdef CONFIG_MAGIC_SYSRQ
>>  unsigned char kbd_sysrq_xlate[128] =
> The keycodes are defined constants. They do not change between
> architectures. So this table also must be constant.
I see.

>>  static void fn_scroll_forw(struct vc_data *vc)
>>  {
>> +#ifndef CONFIG_PC9800
>>  	scrollfront(0);
>> +#else
>> +	scrollfront(3);
>> +#endif
>>  }
> Huh?
Due to our implementation of console driver. For old PC-9800, we use only
video ram. If don't, scrolling is _very_ slow. So our console can scroll
less than half lines of screen. If call with 0, screen doesn't scroll.

>>  static void k_spec(struct vc_data *vc, unsigned char value, char
up_flag)
>>  {
>> +#ifndef CONFIG_PC9800
>>  	if (up_flag)
>> +#else
>> +	if (up_flag && value != 7 && value != 0x14) /* caps/kana lock */
>> +#endif
> Very ugly. This should be handled by the keymap.
I'll remove it. Thanks.

>> diff -urN linux/include/linux/logibusmouse.h
linux98/include/linux/logibusmouse.h
>> --- linux/include/linux/logibusmouse.h	Tue Aug  3 01:54:29 1999
>> +++ linux98/include/linux/logibusmouse.h	Fri Aug 17 22:15:13 2001
> Hmm, this file isn't used at all in 2.5. Why patching it?
IMHO Those (pc_keyb.h too) are remaining to compile user mode application.
I think it's a very rare, but ....

Regards
Osamu Tomita
