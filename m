Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264969AbUFAJys@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264969AbUFAJys (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jun 2004 05:54:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264968AbUFAJys
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jun 2004 05:54:48 -0400
Received: from styx.suse.cz ([82.208.2.94]:11137 "EHLO shadow.ucw.cz")
	by vger.kernel.org with ESMTP id S264969AbUFAJy0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jun 2004 05:54:26 -0400
Date: Tue, 1 Jun 2004 11:55:18 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Sau Dan Lee <danlee@informatik.uni-freiburg.de>
Cc: Andries Brouwer <aebr@win.tue.nl>, linux-kernel@vger.kernel.org
Subject: Re: BUG FIX: atkbd.c keyboard driver bug [Was: keyboard problem with 2.6.6]
Message-ID: <20040601095518.GA1527@ucw.cz>
References: <200406010904.i5194pSo010367@fire-2.osdl.org> <xb7iseb7gtv.fsf@savona.informatik.uni-freiburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xb7iseb7gtv.fsf@savona.informatik.uni-freiburg.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 01, 2004 at 11:44:44AM +0200, Sau Dan Lee wrote:
> >>>>> "bugme-daemon" == bugme-daemon  <bugme-daemon@osdl.org> writes:
> 
>     bugme-daemon> http://bugme.osdl.org/show_bug.cgi?id=2808
>     bugme-daemon> vojtech@suse.cz changed:
> 
>     bugme-daemon>    What    |Removed             |Added
>     bugme-daemon> ----------------------------------------------------
>     bugme-daemon>      Status|NEW                 |REJECTED
>     bugme-daemon>  Resolution|                    |INVALID
> 
>     Vojtech> I'm sorry you can't use the fn+printscreen function on
>     Vojtech> your LifeBook, but such is life. 
> 
> Disappointed.
> 
>     Vojtech> Is using Alt+printscreen such a big difference?
> 
> That means I need to press FOUR keys to use sysrq, because PrintScreen
> is  only  available via  [Fn].   That becomes  [Fn]+Alt+PrintScreen+X,
> where "X" is the sysrq function.  :(
> 
> 
>     Vojtech> On USB keyboards (and many others, too), there is no
>     Vojtech> specific SysRq keycode, and thus the kernel magic-sysrq
>     Vojtech> handler uses the alt-printscreen combination, to make it
>     Vojtech> work on ALL keyboards. This is intentional.
> 
> Isn't  the keyboard  driver  supposed to  iron  out such  differences?

The atkbd.c driver does exactly that. It hides the fact that there is a
special scancode for the PrintScreen key, if you press it together with
some other keys.

There is no special scancode on any other keyboard type for it,
including PS/2 keyboards in their native Set3 mode.

It's a hack by IBM engineers, the PC/XT keyboard had a SysRq key, the
PC/AT keyboard did not, yet some old DOS programs needed it, so they
made the AT keyboard generate the keycode for alt-sysrq when running in
XT compatibility mode.

Unfortunately, the XT compatibility mode stuck, and that's what we're
using now.

> Isn't  it your  philosophy that  the drivers  should know  the devices
> well, and present  a consistent interface to the  upper layers?  Then,
> the correct way to do it is:
> 
>         USB keyboard driver: generate a "sysrq" event in reaction to
>                              Alt-PrintScreen 
>         AT/PS2 keyboard driver: generate a "sysrq" when receiving a
>                                 0x54 keycode
> 
> The  kernel  keyboard  handler  shouldn't  see  or  bother  about  the
> difference.   It is  insane that  the handler  has to  care  about the
> status of the Alt keys.

The kernel works with real keys. There is no real sysrq key. My
definition of sanity is to base your thinking on reality where possible.

>     Vojtech> Further, keycode 99 is KEY_SYSRQ, as defined in input.h,
> 
> Then, why use it for PrintScreen?   With the 'evbug' facility, I see a
> keyboard  event with code  KEY_SYSRQ when  I press  PrintScreen.  Just
> PrintScreen, not  Alt-PrintScreen.  So,  this is a  feature and  not a
> bug?

Ok, it's probably a bad name for it, it should have been named
KEY_PRTSCR, but it wasn't, and it'd only cause breakage now to change
it.

>     Vojtech> and is used for the PrtScr/SysRq key. 
> 
> So, why not have seperate keycodes for the two?
 
Because there is only one key.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
