Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265692AbUBBJno (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Feb 2004 04:43:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265693AbUBBJno
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Feb 2004 04:43:44 -0500
Received: from twilight.ucw.cz ([81.30.235.3]:56192 "EHLO midnight.ucw.cz")
	by vger.kernel.org with ESMTP id S265692AbUBBJnR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Feb 2004 04:43:17 -0500
Date: Mon, 2 Feb 2004 10:43:36 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Andries Brouwer <aebr@win.tue.nl>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: 2.6 input drivers FAQ
Message-ID: <20040202094336.GH548@ucw.cz>
References: <20040201100644.GA2201@ucw.cz> <20040201141516.A28045@pclin040.win.tue.nl> <20040201135001.GA1804@ucw.cz> <20040201161452.A28063@pclin040.win.tue.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040201161452.A28063@pclin040.win.tue.nl>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 01, 2004 at 04:14:52PM +0100, Andries Brouwer wrote:

> On Sun, Feb 01, 2004 at 02:50:01PM +0100, Vojtech Pavlik wrote:
> 
> > Sorry. I was typing that from memory. I'll fix it. Btw, could you make
> > the kbd package accept scancodes in the 0x80-0xff range (same as e000 to
> > e07f), if it is not yet there? And how about scancodes in the
> > 0x100-0x1ff range? Will those work?
> 
> What is needed for the 2.6 kernel is rather volatile
> (and maybe the present kernel version is not quite final yet).
> But setkeycodes does ioctl(fd,KDSETKEYCODE,&a) where 
> 
>                 a.keycode = atoi(argv[2]);
>                 a.scancode = strtol(argv[1], &ep, 16);
>                 if (a.scancode >= 0xe000) {
>                         a.scancode -= 0xe000;
>                         a.scancode += 128;      /* some kernels needed +256 */
>                 }

I think this is fine. It keeps backwards compatibility with
people's old scripts and still it allows arbitrary scancodes.

> The 2.6.1 kernel is still very messy, with code
> 
>         if (atkbd->emul) {
>                 if (--atkbd->emul)
>                         goto out;
>                 code |= (atkbd->set != 3) ? 0x80 : 0x100;
>         }
> 
> where the representation of the e0 prefix depends on the current scancode mode.
> A bad idea.

Well, I think it's a bad idea to have the userspace tool know about the
e0 thing at all. It should be just opaque numbers to it.

I agree that the above code choosing between 0x80 and 0x100 is not very
nice, but it has two reasons:

	0) e0+(00..7f) is the most common code for extra keys in set2,
	   while (80..df) is the most common code for extra keys in set3
	
	1) it will work in old setkeycodes - although the values you'll
           have to specify with set3 are rather nonsensical, you still
	   will be able to set extra keys on a set3 keyboard.

	2) the scancode tables are much more compact.

I don't have a problem with swapping the set3 table, if setkeycodes
works reasonably now for scancodes above 128.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
