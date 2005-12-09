Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964788AbVLIQiX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964788AbVLIQiX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Dec 2005 11:38:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932464AbVLIQiX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Dec 2005 11:38:23 -0500
Received: from zproxy.gmail.com ([64.233.162.204]:10045 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932461AbVLIQiW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Dec 2005 11:38:22 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=dnZa4k3lyx+iQQ0I9KdIB+92lOqjoP14o7JyF16s4xZka6x6vF8q2dX7ekxHE+ejhpTdIIM7MR1TCpRoRbfaqii1V1dLeoG5Bg/9eMME6JwzmW2QZjbRBheGA1afMyzDsqKcsRlfcLowjf03einBrKC/xRJ90j8nk8hZav29ms8=
Message-ID: <4399B2F0.5070505@gmail.com>
Date: Sat, 10 Dec 2005 00:38:08 +0800
From: "Antonino A. Daplas" <adaplas@gmail.com>
User-Agent: Thunderbird 1.5 (X11/20051025)
MIME-Version: 1.0
To: Knut Petersen <Knut_Petersen@t-online.de>
CC: linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 1/1 2.6.15-rc4-git1] Fix switching to KD_TEXT
References: <4398B888.50005@t-online.de> <4398CEAF.9050303@gmail.com> <43997037.4020206@t-online.de>
In-Reply-To: <43997037.4020206@t-online.de>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Knut Petersen wrote:

Had time to look at your tracing closely...

> 
> Framebuffer console is 1 with mode 1280x1024, X console is 7 and has
> been set to 1024x768
> before X was activated.
> 
> Now I do run "chvt 7;sleep 3;chvt 1" on the vt 1.
> 
>    [  972.360841]  [<c0282331>] cyblafb_set_par+0x31/0xd80

The set_par call should not happen if the var of vt7 and vt1 are
the same.

>    [  972.360898]  [<c027bb38>] fb_set_var+0x1e8/0x210
>    [  972.360925]  [<c02742fc>] fbcon_switch+0x16c/0x690
>    [  972.360951]  [<c02cc645>] redraw_screen+0xe5/0x1c0
>    [  972.360989]  [<c02c811a>] complete_change_console+0x2a/0xd0
>    [  972.361018]  [<c02c8203>] change_console+0x43/0x90
>    [  972.361043]  [<c02ceebd>] console_callback+0xed/0x110
>    [  972.361101]  [<c0127e6a>] worker_thread+0x1ba/0x260
>    [  972.361143]  [<c012c115>] kthread+0x95/0xd0
>    [  972.361171]  [<c0100c15>] kernel_thread_helper+0x5/0x10
>    [  972.361212] cyblafb: Switching to new mode: fbset -g 1024 768 1024
> 768 8 -t 15385 160 24 29 3 136 6
>    [  972.363308] cyblafb: pixclock = 64.99 MHz, k/m/n 1 b 6e
> 
>    [  972.363916]  [<c0282331>] cyblafb_set_par+0x31/0xd80

Okay, this particular set_par() will only be called if the info
mapped to vt1 and info mapped to vt7 are different.  Which means
you have multiple fbdevs loaded in your system. 

The other reason, of course, is you have a patched fbcon_switch (yours).

>    [  972.363945]  [<c0274759>] fbcon_switch+0x5c9/0x690
>    [  972.363969]  [<c02cc645>] redraw_screen+0xe5/0x1c0
>    [  972.363996]  [<c02c811a>] complete_change_console+0x2a/0xd0
>    [  972.364023]  [<c02c8203>] change_console+0x43/0x90
>    [  972.364047]  [<c02ceebd>] console_callback+0xed/0x110
>    [  972.364093]  [<c0127e6a>] worker_thread+0x1ba/0x260
>    [  972.364121]  [<c012c115>] kthread+0x95/0xd0
>    [  972.364143]  [<c0100c15>] kernel_thread_helper+0x5/0x10
>    [  972.364181] cyblafb: Switching to new mode: fbset -g 1024 768 1024
> 768 8 -t 15385 160 24 29 3 136 6
>    [  972.366271] cyblafb: pixclock = 64.99 MHz, k/m/n 1 b 6e
>    [  972.366325] cyblafb: Switching to KD_GRAPHICS
> 
> Not so nice. Now let´s have a look at the log entries caused switching
> back to
> the framebuffer console:
> 
> This call to set_par() is the result of my patch:
> 
>    [  975.751407]  [<c0282331>] cyblafb_set_par+0x31/0xd80
>    [  975.751437]  [<c027bb38>] fb_set_var+0x1e8/0x210
>    [  975.751462]  [<c02742fc>] fbcon_switch+0x16c/0x690
>    [  975.751486]  [<c02cc645>] redraw_screen+0xe5/0x1c0
>    [  975.751513]  [<c02c811a>] complete_change_console+0x2a/0xd0
>    [  975.751540]  [<c02c765d>] vt_ioctl+0x103d/0x19b0
>    [  975.751564]  [<c02c17eb>] tty_ioctl+0x18b/0x3d0
>    [  975.751587]  [<c016e92a>] do_ioctl+0x5a/0x90
>    [  975.751613]  [<c016eaeb>] vfs_ioctl+0x5b/0x1d0
>    [  975.751640]  [<c016eca5>] sys_ioctl+0x45/0x70
>    [  975.751666]  [<c01029a9>] syscall_call+0x7/0xb
>    [  975.751702] cyblafb: Switching to new mode: fbset -g 1280 1024
> 2048 4096 8 -t 7407 232 16 39 0 160 3
>    [  975.753795] cyblafb: pixclock = 135.00 MHz, k/m/n 0 5 3a
> 
> Without that prior set_par() that´s the point where the enhanced cyblafb
> would
> have serious problems:
> 
>    [  975.753839] cyblafb_pan_display: entry
>    [  975.753853]  [<c0281f7c>] cyblafb_pan_display+0x9c/0xb0
>    [  975.753883]  [<c027b911>] fb_pan_display+0x61/0xa0
>    [  975.753925]  [<c027ba4f>] fb_set_var+0xff/0x210
>    [  975.753949]  [<c02742fc>] fbcon_switch+0x16c/0x690
>    [  975.753973]  [<c02cc645>] redraw_screen+0xe5/0x1c0
>    [  975.754000]  [<c02c811a>] complete_change_console+0x2a/0xd0
>    [  975.754027]  [<c02c765d>] vt_ioctl+0x103d/0x19b0
>    [  975.754051]  [<c02c17eb>] tty_ioctl+0x18b/0x3d0
>    [  975.754074]  [<c016e92a>] do_ioctl+0x5a/0x90
>    [  975.754100]  [<c016eaeb>] vfs_ioctl+0x5b/0x1d0
>    [  975.754127]  [<c016eca5>] sys_ioctl+0x45/0x70
>    [  975.754153]  [<c01029a9>] syscall_call+0x7/0xb

Yes, this is a problem.  Should be easily fixed.

> 
> Again a call to set_par:
> 
>    [  975.754744]  [<c0282331>] cyblafb_set_par+0x31/0xd80

This either came from your patch, or you have multiple fbdevs.

>    [  975.754773]  [<c0274759>] fbcon_switch+0x5c9/0x690
>    [  975.754796]  [<c02cc645>] redraw_screen+0xe5/0x1c0
>    [  975.754823]  [<c02c811a>] complete_change_console+0x2a/0xd0
>    [  975.754850]  [<c02c765d>] vt_ioctl+0x103d/0x19b0
>    [  975.754875]  [<c02c17eb>] tty_ioctl+0x18b/0x3d0
>    [  975.754917]  [<c016e92a>] do_ioctl+0x5a/0x90
>    [  975.754943]  [<c016eaeb>] vfs_ioctl+0x5b/0x1d0
>    [  975.754970]  [<c016eca5>] sys_ioctl+0x45/0x70
>    [  975.754996]  [<c01029a9>] syscall_call+0x7/0xb
>    [  975.755032] cyblafb: Switching to new mode: fbset -g 1280 1024
> 2048 4096 8 -t 7407 232 16 39 0 160 3
>    [  975.757123] cyblafb: pixclock = 135.00 MHz, k/m/n 0 5 3a
> 
> Now the save_state() function is called:
> 
>    [  975.757745] cyblafb: Switching to KD_TEXT
> 
> and again a call to set_par():
> 
>    [  975.757759]  [<c0282331>] cyblafb_set_par+0x31/0xd80

This set_par is the one that is needed.  This is the point where
the vt is entering KD_TEXT mode fro KD_GRAPHICS.

>    [  975.757789]  [<c027bb38>] fb_set_var+0x1e8/0x210
>    [  975.757813]  [<c027498a>] fbcon_blank+0x11a/0x1b0
>    [  975.757837]  [<c02cff17>] do_unblank_screen+0x67/0x120
>    [  975.757869]  [<c02c8130>] complete_change_console+0x40/0xd0
>    [  975.757955]  [<c02c765d>] vt_ioctl+0x103d/0x19b0
>    [  975.757979]  [<c02c17eb>] tty_ioctl+0x18b/0x3d0
>    [  975.758002]  [<c016e92a>] do_ioctl+0x5a/0x90
>    [  975.758029]  [<c016eaeb>] vfs_ioctl+0x5b/0x1d0
>    [  975.758055]  [<c016eca5>] sys_ioctl+0x45/0x70
>    [  975.758081]  [<c01029a9>] syscall_call+0x7/0xb
>    [  975.758117] cyblafb: Switching to new mode: fbset -g 1280 1024
> 2048 4096 8 -t 7407 232 16 39 0 160 3
>    [  975.760205] cyblafb: pixclock = 135.00 MHz, k/m/n 0 5 3a
> 
> And now, the be really shure, again, a call to set_par():
> 
>    [  975.760827]  [<c0282331>] cyblafb_set_par+0x31/0xd80

Again, this set_par() is either from your patch, or you have multiple
fbdev's.

>    [  975.760856]  [<c0274759>] fbcon_switch+0x5c9/0x690
>    [  975.760880]  [<c02cc645>] redraw_screen+0xe5/0x1c0
>    [  975.760923]  [<c02749e6>] fbcon_blank+0x176/0x1b0
>    [  975.760947]  [<c02cff17>] do_unblank_screen+0x67/0x120
>    [  975.760976]  [<c02c8130>] complete_change_console+0x40/0xd0
>    [  975.761002]  [<c02c765d>] vt_ioctl+0x103d/0x19b0
>    [  975.761027]  [<c02c17eb>] tty_ioctl+0x18b/0x3d0
>    [  975.761050]  [<c016e92a>] do_ioctl+0x5a/0x90
>    [  975.761076]  [<c016eaeb>] vfs_ioctl+0x5b/0x1d0
>    [  975.761102]  [<c016eca5>] sys_ioctl+0x45/0x70
>    [  975.761129]  [<c01029a9>] syscall_call+0x7/0xb
>    [  975.761164] cyblafb: Switching to new mode: fbset -g 1280 1024
> 2048 4096 8 -t 7407 232 16 39 0 160 3
>    [  975.763280] cyblafb: pixclock = 135.00 MHz, k/m/n 0 5 3a
> 
> First of all: set_par is executed too often. With and without my patch.

In the final analysis, the set_par is actually called only once on an
X to console switch in a typical system. The multiple set_par() present
in your trace is due to:

a. different per-display var
b. multiple fbdevs
c. your patch.

In summary.  For a typical system (single fbdev, all vt's with the
same var) switching from X to vt should be like this, with only a
single, necessary call to set_par().

(The set_par call after fbcon_blank is only present when switching
from KD_GRAPHICS.  This will be absent on a KD_TEXT to KD_TEXT switch).

fbcon_blank()
set_par() 
fbcon_switch()
fb_set_var()

If you have different vars, the sequence will be like this:

fbcon_blank()
set_par()
fbcon_switch()
fb_set_var()->set_par()

If you have multiple fbdev's, same var:

fbcon_blank()
set_par()
fbcon_switch()
fb_set_var()
set_par()

And if you have multiple fbdev's, different var's:

fbcon_blank()
set_par()
fbcon_switch()
fb_set_var()->set_par()
set_par()

So the unnecessary (arguable) set_par calls are only present if
you have multiple fbdevs/multi-head system.

Tony
