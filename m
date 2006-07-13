Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030285AbWGMSsQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030285AbWGMSsQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 14:48:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030288AbWGMSsQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 14:48:16 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:55785 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1030285AbWGMSsP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 14:48:15 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=qbSE7FAp6CkYl2wAhc33txX7E9lXEnfgiHwsoX7jhRXoVPyjV0mG7KwmHqAo6nAM052Mgi/IvtDWMSg/1ydjpsSfCujeRCISgqsh8yoHxkkogOKCPQq5WcxCwRSdCfflmF3QjwenITYZuqx5PCOM6o1A6WnVu6tL2WBPdwoWgTk=
Message-ID: <d120d5000607131148y3c80abadhb49cc22db0593d6e@mail.gmail.com>
Date: Thu, 13 Jul 2006 14:48:13 -0400
From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
To: "Paulo Marques" <pmarques@grupopie.com>
Subject: Re: [patch] Re: Magic Alt-SysRq change in 2.6.18-rc1
Cc: "Roman Zippel" <zippel@linux-m68k.org>, "Andrew Morton" <akpm@osdl.org>,
       pavel@ucw.cz, roubert@df.lth.se, stern@rowland.harvard.edu,
       linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
In-Reply-To: <44B575EF.1080409@grupopie.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <Pine.LNX.4.44L0.0607091657490.28904-100000@netrider.rowland.org>
	 <Pine.LNX.4.64.0607120213060.12900@scrub.home>
	 <20060711173735.43e9af94.akpm@osdl.org>
	 <Pine.LNX.4.64.0607120248050.12900@scrub.home>
	 <20060711183647.5c5c0204.akpm@osdl.org>
	 <Pine.LNX.4.64.0607121056170.12900@scrub.home>
	 <44B4F88D.3060301@grupopie.com> <44B55091.2040207@grupopie.com>
	 <d120d5000607121305g5fa5bda2v2038ecac893f4c83@mail.gmail.com>
	 <44B575EF.1080409@grupopie.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/12/06, Paulo Marques <pmarques@grupopie.com> wrote:
> >
> > We also need to check if emulate_raw() needs to be adjusted...
>
> I looked at that very quickly, to be honest, but couldn't understand it
> entirely. This code:
>
> 1087 if (keycode == KEY_SYSRQ && sysrq_alt) {
> 1088   put_queue(vc, 0x54 | up_flag);
> 1089   return 0;
> 1090 }
>
> seems to be supposed to cancel the Alt "press" by sending a Alt
> "release" to handle the sequence press alt -> press sysrq without
> affecting the application. However, this is just a guess. I couldn't
> find out what that magic 0x54 meant or why this would be enough wether
> we pressed the left or the right alt...
>

Real AT keyboards (that's what we are trying to emulate here) send
0x54 scancode (and 0xB4 break code) if PrintScreen/SysRq key is
pressed while holding Alt (left or right). Otherwise it sends e0 2a e0
37. That's it.

> Then there are other things that I don't understand there: I don't see
> any code to filter out the keys we press ('T','P', etc.) while using
> SysRq magic if we are in raw mode. emulate_raw will happily call
> put_queue on them before we have a chance to bail out.
>
> Maybe we should just stop calling emulate_raw while sysrq_active is
> active. This way, after we press Alt + SysRq, every keypress would be
> processed as a magic sysrq and not handled by any other code until we
> release both keys.

We never supressed sysrq scancodes from reaching userspace if keyboard
is in raw mode (2.4 works the same). Plus you won't be able to supress
it for keyboards working in hadware raw mode (kbd_rawcode is called
even before we get to detecting SysRq state). Also users getting
keyboard events from alternative interfaces (such as evdev) won't be
affected anyway so I think we shoudl leave it as is.

-- 
Dmitry
