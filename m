Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750918AbWGLWVi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750918AbWGLWVi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 18:21:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750999AbWGLWVi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 18:21:38 -0400
Received: from [195.23.16.24] ([195.23.16.24]:56797 "EHLO
	linuxbipbip.grupopie.com") by vger.kernel.org with ESMTP
	id S1750912AbWGLWVh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 18:21:37 -0400
Message-ID: <44B575EF.1080409@grupopie.com>
Date: Wed, 12 Jul 2006 23:21:35 +0100
From: Paulo Marques <pmarques@grupopie.com>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
CC: Roman Zippel <zippel@linux-m68k.org>, Andrew Morton <akpm@osdl.org>,
       pavel@ucw.cz, roubert@df.lth.se, stern@rowland.harvard.edu,
       linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
Subject: Re: [patch] Re: Magic Alt-SysRq change in 2.6.18-rc1
References: <Pine.LNX.4.44L0.0607091657490.28904-100000@netrider.rowland.org>	 <Pine.LNX.4.64.0607120132440.12900@scrub.home>	 <20060711165003.25265bb7.akpm@osdl.org>	 <Pine.LNX.4.64.0607120213060.12900@scrub.home>	 <20060711173735.43e9af94.akpm@osdl.org>	 <Pine.LNX.4.64.0607120248050.12900@scrub.home>	 <20060711183647.5c5c0204.akpm@osdl.org>	 <Pine.LNX.4.64.0607121056170.12900@scrub.home>	 <44B4F88D.3060301@grupopie.com> <44B55091.2040207@grupopie.com> <d120d5000607121305g5fa5bda2v2038ecac893f4c83@mail.gmail.com>
In-Reply-To: <d120d5000607121305g5fa5bda2v2038ecac893f4c83@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dmitry Torokhov wrote:
> Hi,
> 
> On 7/12/06, Paulo Marques <pmarques@grupopie.com> wrote:
> 
>> Ok, I've tested it this time and this new one works as expected. I can
>> use any of the sequences discussed and I can produce a SysRq every time.
>> Still, just pressing SysRq or any sequence that doesn't start with
>> "press Alt -> press SysRq" seems unaffected.
> 
> I like this, however:
> 
>> +       if (keycode == KEY_SYSRQ) {
>> +               if (down) {
>> +                       if(sysrq_alt)
>> +                               sysrq_down = down;
>> +               } else {
>> +                       sysrq_down = 0;
> 
> Are you sure? This will set sysrq_down only if ALT has already been
> pressed. If SysRq does not autorepeat and it is pressed first we won't
> ever see sysrq_down. Am I missing something?

This was done on purpose, yes. My first thought was to allow any order, 
but this could cause strange complications like: if I just press 
PrintScreen when is it ok to forward that keypress before I press Alt? 
The Alt afterwards arrives to late to not have messed the user space 
application already.

Anyway, none of the sequences posted required this, and it is more 
intuitive to press Alt first anyway.

>> +
>> +       if (sysrq_down && sysrq_alt)
>> +               sysrq_active = 1;
>> +       else if (!sysrq_down && !sysrq_alt)
>> +               sysrq_active = 0;
>> +
>> +       if (keycode == KEY_SYSRQ && sysrq_active)
>> +               return;
> 
> What about alt? I think that "if (...) sysrq_active = 1;" statement
> should go down, below handle_sysrq block.

It can not go down, or when you press Alt and then SysRq, the first 
SysRq down event will get through without returning.

alt is handled a little higher in that function outside the #IFDEF. This 
is because emulate_raw should work even if we don't support magic sysrq.

The logic here is pretty simple: if we press Alt and then SysRq we enter 
sysrq_active mode. We only come out of that mode when we release both 
keys. Releasing any one of them individually is fine.

Any KEY_SYSRQ repetitions or releases while on this mode are not 
processed any further.

Oops, I just realised that if I release Alt first and then SysRq, the 
SysRq release will get through because at that point we're already out 
of sysrq_active mode. This should be easy to fix, though. If this is a 
problem, I can send a new patch tomorrow (with some more comments in 
there, too).

>> +
>> +       if (sysrq_active && down && !rep) {
>>                handle_sysrq(kbd_sysrq_xlate[keycode], regs, tty);
>>                return;
>>        }
> 
> We also need to check if emulate_raw() needs to be adjusted...

I looked at that very quickly, to be honest, but couldn't understand it 
entirely. This code:

1087 if (keycode == KEY_SYSRQ && sysrq_alt) {
1088   put_queue(vc, 0x54 | up_flag);
1089   return 0;
1090 }

seems to be supposed to cancel the Alt "press" by sending a Alt 
"release" to handle the sequence press alt -> press sysrq without 
affecting the application. However, this is just a guess. I couldn't 
find out what that magic 0x54 meant or why this would be enough wether 
we pressed the left or the right alt...

Then there are other things that I don't understand there: I don't see 
any code to filter out the keys we press ('T','P', etc.) while using 
SysRq magic if we are in raw mode. emulate_raw will happily call 
put_queue on them before we have a chance to bail out.

Maybe we should just stop calling emulate_raw while sysrq_active is 
active. This way, after we press Alt + SysRq, every keypress would be 
processed as a magic sysrq and not handled by any other code until we 
release both keys.

Does this sound reasonable?

-- 
Paulo Marques - www.grupopie.com
