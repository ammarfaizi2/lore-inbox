Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262542AbUCCS74 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Mar 2004 13:59:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262544AbUCCS74
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Mar 2004 13:59:56 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:46486 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S262542AbUCCS7w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Mar 2004 13:59:52 -0500
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.3-bk7 i8042 does not work on a genuine i386 ibm ps/2 model 70.
References: <m1znb29css.fsf@ebiederm.dsl.xmission.com>
	<20040303101347.GB310@ucw.cz>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 03 Mar 2004 11:51:33 -0700
In-Reply-To: <20040303101347.GB310@ucw.cz>
Message-ID: <m1znax3gsq.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vojtech Pavlik <vojtech@suse.cz> writes:

> On Sun, Feb 29, 2004 at 07:32:19AM -0700, Eric W. Biederman wrote:
> > 
> > The i8042 driver attempts to detect if IBM PC compatiblity mode i.e.
> > I8042_CTR_XLATE is enabled.  Unfortunately on a genuine IBM PS/2, (a pc
> > incompatible :) this does not work. 
> > 
> > In i8042_controller_init if I disable the detection of the keyboard
> > not being in XLATE mode everything works fine.
> > 
> > /*
> >  * If the chip is configured into nontranslated mode by the BIOS, don't
> >  * bother enabling translating and be happy.
> >  */     
> > #if 0
> > 
> > 	if (~i8042_ctr & I8042_CTR_XLATE)
> > 		i8042_direct = 1;
> > #endif
> > 
> > 
> > The value of i8042_initial_ctr is 0x25 in case that helps.
> > 
> > I am not certain where to proceed from here.
> 
> This bit is an equivalent to 2.4 code in pc_keyb.c, that adds a
> workaround for IBM PowerPC portables, which don't seem to support
> translated mode:
> 
>        /* ibm powerpc portables need this to use scan-code set 1 -- Cort * */
>         if (!(kbd_write_command_w_and_wait(KBD_CCMD_READ_MODE) & KBD_MODE_KCC))
>         {
>                 /*
>                  * If the controller does not support conversion,
>                  * Set the keyboard to scan-code set 1.
>                  */
>                 kbd_write_output_w(0xF0);
>                 kbd_wait_for_input();
>                 kbd_write_output_w(0x01);
>                 kbd_wait_for_input();
>         }
> 
> As you can see, this sets the keyboard to scancode set 1, if
> KBD_MODE_KCC (which is 0x40, same as I8042_CTR_XLATE), bit is set.
> 
> This should break your keyboard as well, if it supports mode setting.
> 
> I guess we could kill that bit, and ignore the old PowerPCs ....

I will check what happens this evening.  But that sounds exactly
what is happening with my keyboard.  The scan codes I see are in
set 1.

> > The piece I am certain about is that the keyboard controller has
> > traditionally been a tiny microcontroller on PCs so that there is a
> > wide variance in the commands and the exact format that they support.
> 
> Yes. The translate/don't bit is documented by IBM, though.

Any pointers to the docs?

> > And so far every data sheet I have looked at the documentation is
> > slightly different.  The only real intel datasheet I could find was
> > for the i8741A.  And it does not document the traditional interface
> > implemented but the i8042, because that was done in firmware.
> > 
> > This machine is primarily a test machine to make certain my code
> > works on older hardware.  So I am willing try any interesting or
> > likely patches.
> 
> Does the machine by any chance have a PS/2 mouse port? If not, it may be
> the reason - it would have an AT-style i8042, and those might not be
> implementing that bit.

Yes.  But the plugs are clearly labeled which is for the keyboard
and which is for the mouse.

> We could skip the above check if we don't detect the AUX port.

Interesting.

Eric
