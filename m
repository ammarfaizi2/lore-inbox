Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265280AbUBAPO4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Feb 2004 10:14:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265325AbUBAPO4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Feb 2004 10:14:56 -0500
Received: from mailhost.tue.nl ([131.155.2.7]:45836 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id S265280AbUBAPOz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Feb 2004 10:14:55 -0500
Date: Sun, 1 Feb 2004 16:14:52 +0100
From: Andries Brouwer <aebr@win.tue.nl>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Andries Brouwer <aebr@win.tue.nl>, linux-kernel@vger.kernel.org,
       akpm@osdl.org
Subject: Re: 2.6 input drivers FAQ
Message-ID: <20040201161452.A28063@pclin040.win.tue.nl>
References: <20040201100644.GA2201@ucw.cz> <20040201141516.A28045@pclin040.win.tue.nl> <20040201135001.GA1804@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040201135001.GA1804@ucw.cz>; from vojtech@suse.cz on Sun, Feb 01, 2004 at 02:50:01PM +0100
X-Spam-DCC: Servercave: mailhost.tue.nl 1183; Body=1 Fuz1=1 Fuz2=1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 01, 2004 at 02:50:01PM +0100, Vojtech Pavlik wrote:

> Sorry. I was typing that from memory. I'll fix it. Btw, could you make
> the kbd package accept scancodes in the 0x80-0xff range (same as e000 to
> e07f), if it is not yet there? And how about scancodes in the
> 0x100-0x1ff range? Will those work?

What is needed for the 2.6 kernel is rather volatile
(and maybe the present kernel version is not quite final yet).
But setkeycodes does ioctl(fd,KDSETKEYCODE,&a) where 

                a.keycode = atoi(argv[2]);
                a.scancode = strtol(argv[1], &ep, 16);
                if (a.scancode >= 0xe000) {
                        a.scancode -= 0xe000;
                        a.scancode += 128;      /* some kernels needed +256 */
                }

The 2.6.1 kernel is still very messy, with code

        if (atkbd->emul) {
                if (--atkbd->emul)
                        goto out;
                code |= (atkbd->set != 3) ? 0x80 : 0x100;
        }

where the representation of the e0 prefix depends on the current scancode mode.
A bad idea.

> One more question: Will kbdrate work properly (use ioctls) when compiled
> on a 2.6 kernels?

kbdrate first tries the KDKBDREP ioctl, then the KIOCSRATE ioctl,
and if both fail it will try to write to /dev/port.

Andries
