Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261202AbTINQvs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Sep 2003 12:51:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261204AbTINQvr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Sep 2003 12:51:47 -0400
Received: from mailhost.tue.nl ([131.155.2.7]:45326 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id S261202AbTINQvo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Sep 2003 12:51:44 -0400
Date: Sun, 14 Sep 2003 18:51:42 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Dmitri Katchalov <dmitrik@users.sourceforge.net>
Cc: Andries Brouwer <aebr@win.tue.nl>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0-test5 atkbd.c: Unknown key (100% reproduceable)
Message-ID: <20030914185142.F3371@pclin040.win.tue.nl>
References: <1063443074.3f62da82a7e24@webmail.netregistry.net> <20030913220743.B3295@pclin040.win.tue.nl> <1063527169.3f642301c00e7@webmail.netregistry.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1063527169.3f642301c00e7@webmail.netregistry.net>; from dmitrik@users.sourceforge.net on Sun, Sep 14, 2003 at 06:12:49PM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 14, 2003 at 06:12:49PM +1000, Dmitri Katchalov wrote:
> Quoting Andries Brouwer <aebr@win.tue.nl>:

> > On Sat, Sep 13, 2003 at 06:51:14PM +1000, Dmitri Katchalov wrote:
> > 
> > > I'm consistently getting this error:
> > > 
> > > atkbd.c: Unknown key (set 2, scancode 0xab, on isa0060/serio0) pressed.
> > > This happens whenever I type 'f' in "<F7>usbdevfs". 

> > Can you enable DEBUG in i8042.c, repeat the error
> > and mail me the resulting output?
> 
> See below. Hope it helps. 
> 
> Oh yes, it eats 'f' in "make menuconfig" 3 out of 4 times. 
> The keyboard in question is "StudyMate" keyboard.
> In addition to the usual keys it has left and right windows keys,
> menu key, power, sleep, wake and Fn keys. These extra keys 
> have never worked as far as I remember.
> On the back it says: "Turbo-Track Keyboard" FCC ID: HQK BITS9001
> The keyboard worked just fine in "the other" OS 

OK. First the standard probing. Nothing unusual.

> input: AT Set 2 keyboard on isa0060/serio0
> serio: i8042 KBD port at 0x60,0x64 irq 1
...

Then the "<F7>usbdevfs".

> i8042.c: 41 <- i8042 (interrupt, kbd, 1) [80466]
> i8042.c: c1 <- i8042 (interrupt, kbd, 1) [80561]
F7, F7 release

> i8042.c: 16 <- i8042 (interrupt, kbd, 1) [81692]
> i8042.c: 96 <- i8042 (interrupt, kbd, 1) [81772]
u, u release

> i8042.c: 1f <- i8042 (interrupt, kbd, 1) [82032]
> i8042.c: 9f <- i8042 (interrupt, kbd, 1) [82113]
s, s release

> i8042.c: 30 <- i8042 (interrupt, kbd, 1) [82347]
> i8042.c: b0 <- i8042 (interrupt, kbd, 1) [82443]
b, b release

> i8042.c: 20 <- i8042 (interrupt, kbd, 1) [82661]
> i8042.c: a0 <- i8042 (interrupt, kbd, 1) [82757]
d, d release

> i8042.c: 12 <- i8042 (interrupt, kbd, 1) [83018]
> i8042.c: 92 <- i8042 (interrupt, kbd, 1) [83098]
e, e release

> i8042.c: 2f <- i8042 (interrupt, kbd, 1) [83304]
> i8042.c: af <- i8042 (interrupt, kbd, 1) [83385]
v, v release

> i8042.c: 21 <- i8042 (interrupt, kbd, 1) [83675]
f
> i8042.c: ab <- i8042 (interrupt, kbd, 1) [83737]
> atkbd.c: Unknown key (set 2, scancode 0xab, on isa0060/serio0) pressed.
\ release

> i8042.c: 1f <- i8042 (interrupt, kbd, 1) [84426]
> i8042.c: 9f <- i8042 (interrupt, kbd, 1) [84507]
s, s release

It seems most likely that this keyboard is broken.
Instead of 0xa1 (f release) you get 0xab (\ release).
By some coincidence 0xab is f release in untranslated scancode set 2.
(But you are in translated scancode set 2, otherwise the other letters
would also have produced different codes.)

Could you try to run "showkey -s" on the console under 2.4.*?
Hit and release the f a few times. Type <F7>usbdevfs.

Just a broken key is something I have seen lots of times.
Since for most operating systems make codes are important
while break codes (other than those for Shift, Ctrl, Alt)
are not, a key with broken release code is usually harmless.

This case seems interesting because, if I understand you correctly,
the f in itself is not always broken, but this error occurs after
a particular sequence of keystrokes.

Andries

