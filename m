Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272815AbTHPH6X (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Aug 2003 03:58:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272816AbTHPH6X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Aug 2003 03:58:23 -0400
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:45452 "HELO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id S272815AbTHPH6V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Aug 2003 03:58:21 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Vojtech Pavlik <vojtech@suse.cz>
Date: Sat, 16 Aug 2003 17:57:41 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16189.58357.516036.664166@gargle.gargle.HOWL>
Cc: Andries Brouwer <aebr@win.tue.nl>, linux-kernel@vger.kernel.org
Subject: Re: Input issues - key down with no key up
In-Reply-To: message from Vojtech Pavlik on Friday August 15
References: <16188.27810.50931.158166@gargle.gargle.HOWL>
	<20030815094604.B2784@pclin040.win.tue.nl>
	<20030815105802.GA14836@ucw.cz>
	<16188.54799.675256.608570@gargle.gargle.HOWL>
	<20030815135248.GA7315@win.tue.nl>
	<20030815141328.GA16176@ucw.cz>
X-Mailer: VM 7.17 under Emacs 21.3.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday August 15, vojtech@suse.cz wrote:
> On Fri, Aug 15, 2003 at 03:52:48PM +0200, Andries Brouwer wrote:
> > On Fri, Aug 15, 2003 at 10:46:07PM +1000, Neil Brown wrote:
> > 
> > > It seems to work (though some of the keys actually generate 'down'
> > > events for both the down and up transitions, so it seems that the key
> > > is pressed twice.
> > 
> > Maybe it really is as you say. But your description sounds fishy.
> > It would be nice to know what really happens.
> > (And it would be nice to know which scancodes are involved.)
> 
> Indeed. Neil, please enable DEBUG in i8042.c ... both with and without the
> i8042_direct=1 and atkbd_set=3 options from my previous e-mail.
> 
> And for Andries, if you can, do the showkey -s test on 2.4, too ...

Well...

There are 5 keys in question.  Each one is fn + something else.
Some of them (wireless, brighter, darker) cause the bios to do
something, and only generate a keyboard event on a down transition.
The others (battery, cdeject) don't appear to cause the bios to do
anything, and generate a keyboard event on both the up and down
transition, and it is always the same scancode.

Key      Meaning   2.6 scancode     2.4 (direct) scancode
fn-F2    wireless    0x13d               e0 08
fn-F3    battery     0x136               e0 07 
fn-F10   cdeject     0x13e               e0 09 
fn-down  darker      0x125               e0 05
fn-up    brighter    0x12e               e0 06


The "2.6 scancode" is the scancode reported in the

 atkbd.c: Unknown key (set 2, scancode ...)

message, and it is always a "pressed" message.  It is also the
scancode I use in the EVIOCSKEYCODE ioctl to associate a keycode with
the key.

The "2.4 (direct) scancode" is what I get back from "showkey -s".

When I set i8042_direct=1, the keyboard doesn't work sensibly at all.
Many keys cause "Unknown key" messages, other cause unrelated
characters to start autorepeating.
The 5 keys in question generate scancodes reported as 0x100 plus the
second number in the "2.4 (direct) scancode" column.

Setting atkbd_set=3 doesn't appear to affect things at all.  It is
still reported as an "AT Set 2 keyboard".

When I enable debug in i8042.c, I get lots of messages about bytes to
and from the i8042.  There are no surprises in the bytes relating to
keystrokes.  They are exactly what is in the "2.4 (direct) scancode"
column. 
I can send you the i8042 initialisation conversations if they will
help. 


For my purposes, I need to use an "ioctl" to set a keycode for each
scancode, so adding an ioctl to set the no-keyup status is no hassle
for me.  However the suggest approach of auto-detecting keys which
have no up event would probably a good idea.

NeilBrown
