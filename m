Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262979AbSJWIhC>; Wed, 23 Oct 2002 04:37:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263016AbSJWIhC>; Wed, 23 Oct 2002 04:37:02 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:13758 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S262979AbSJWIhB>;
	Wed, 23 Oct 2002 04:37:01 -0400
Date: Wed, 23 Oct 2002 10:42:22 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Take Vos <Take.Vos@binary-magic.com>, linux-kernel@vger.kernel.org,
       Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: PROBLEM: PS/2 mouse wart does not work, while scratch pad does.
Message-ID: <20021023104222.B28139@ucw.cz>
References: <200210221046.46700.Take.Vos@binary-magic.com> <5001.1035330391@passion.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <5001.1035330391@passion.cambridge.redhat.com>; from dwmw2@infradead.org on Wed, Oct 23, 2002 at 12:46:31AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 23, 2002 at 12:46:31AM +0100, David Woodhouse wrote:

> Take.Vos@binary-magic.com said:
> > hardware:DELL Inspiron 8100
> 
> >  The internal scratch pad works, but the internal wart mouse doesn't,
> > in the  BIOS it is set to use both devices for input. This is tested
> > with both  Xfree86 and running cat on /dev/input/mice and /dev/input/
> > mouse0 and  /dev/input/event0. 
> 
> Probing for various other PS/2 extensions appears to confuse the thing such 
> that the clitmouse no longer works. If we probe for it first and then abort 
> the other probes, it seems happier...

Thanks, applied.

> --- 1.16/drivers/input/mouse/psmouse.c  Tue Oct  8 11:51:30 2002
> +++ edited/drivers/input/mouse/psmouse.c        Wed Oct 23 00:39:06 2002
> @@ -311,6 +311,26 @@
>         if (psmouse_noext)
>                 return PSMOUSE_PS2;
> 
> +/*
> + * Try Synaptics TouchPad magic ID
> + */
> +
> +       param[0] = 0;
> +       psmouse_command(psmouse, param, PSMOUSE_CMD_SETRES);
> +       psmouse_command(psmouse, param, PSMOUSE_CMD_SETRES);
> +       psmouse_command(psmouse, param, PSMOUSE_CMD_SETRES);
> +       psmouse_command(psmouse, param, PSMOUSE_CMD_SETRES);
> +       psmouse_command(psmouse, param, PSMOUSE_CMD_GETINFO);
> +
> +       if (param[1] == 0x47) {
> +               /* We could do more here. But it's sufficient just
> +                  to stop the subsequent probes from screwing the
> +                  thing up. */
> +               psmouse->vendor = "Synaptics";
> +               psmouse->name = "TouchPad";
> +               return PSMOUSE_PS2;
> +       }
> +
>  /*
>   * Try Genius NetMouse magic init.
>   */

-- 
Vojtech Pavlik
SuSE Labs
