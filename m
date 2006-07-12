Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932140AbWGLUFp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932140AbWGLUFp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 16:05:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932157AbWGLUFp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 16:05:45 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:34016 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932140AbWGLUFp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 16:05:45 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=J635gx52MZHvE4NTh31meJPlc3so6rLhS6idGcgaRnH2luJ/mxoVJsfnnpzbvFyk/EzSDy9AoCHOaTtAzwU0rp3xwXX1UX2WUO58zTC7VjrVvMQZbA1WytHiFPBinzlYnRV196SckJ34CNHGV8OVmV7ZbtXNrGLs9ZOH9xRvxI4=
Message-ID: <d120d5000607121305g5fa5bda2v2038ecac893f4c83@mail.gmail.com>
Date: Wed, 12 Jul 2006 16:05:43 -0400
From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
To: "Paulo Marques" <pmarques@grupopie.com>
Subject: Re: [patch] Re: Magic Alt-SysRq change in 2.6.18-rc1
Cc: "Roman Zippel" <zippel@linux-m68k.org>, "Andrew Morton" <akpm@osdl.org>,
       pavel@ucw.cz, roubert@df.lth.se, stern@rowland.harvard.edu,
       linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
In-Reply-To: <44B55091.2040207@grupopie.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <Pine.LNX.4.44L0.0607091657490.28904-100000@netrider.rowland.org>
	 <Pine.LNX.4.64.0607120132440.12900@scrub.home>
	 <20060711165003.25265bb7.akpm@osdl.org>
	 <Pine.LNX.4.64.0607120213060.12900@scrub.home>
	 <20060711173735.43e9af94.akpm@osdl.org>
	 <Pine.LNX.4.64.0607120248050.12900@scrub.home>
	 <20060711183647.5c5c0204.akpm@osdl.org>
	 <Pine.LNX.4.64.0607121056170.12900@scrub.home>
	 <44B4F88D.3060301@grupopie.com> <44B55091.2040207@grupopie.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 7/12/06, Paulo Marques <pmarques@grupopie.com> wrote:
>
> Ok, I've tested it this time and this new one works as expected. I can
> use any of the sequences discussed and I can produce a SysRq every time.
> Still, just pressing SysRq or any sequence that doesn't start with
> "press Alt -> press SysRq" seems unaffected.
>

I like this, however:

> +       if (keycode == KEY_SYSRQ) {
> +               if (down) {
> +                       if(sysrq_alt)
> +                               sysrq_down = down;
> +               } else {
> +                       sysrq_down = 0;

Are you sure? This will set sysrq_down only if ALT has already been
pressed. If SysRq does not autorepeat and it is pressed first we won't
ever see sysrq_down. Am I missing something?

> +
> +       if (sysrq_down && sysrq_alt)
> +               sysrq_active = 1;
> +       else if (!sysrq_down && !sysrq_alt)
> +               sysrq_active = 0;
> +
> +       if (keycode == KEY_SYSRQ && sysrq_active)
> +               return;

What about alt? I think that "if (...) sysrq_active = 1;" statement
should go down, below handle_sysrq block.

> +
> +       if (sysrq_active && down && !rep) {
>                handle_sysrq(kbd_sysrq_xlate[keycode], regs, tty);
>                return;
>        }
>

We also need to check if emulate_raw() needs to be adjusted...

-- 
Dmitry
