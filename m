Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268345AbUHQRAg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268345AbUHQRAg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 13:00:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268342AbUHQRAg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 13:00:36 -0400
Received: from delerium.kernelslacker.org ([81.187.208.145]:2498 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S268346AbUHQRAH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 13:00:07 -0400
Date: Tue, 17 Aug 2004 17:58:31 +0100
From: Dave Jones <davej@redhat.com>
To: Zwane Mwaikambo <zwane@linuxpower.ca>
Cc: Petr Vandrovec <VANDROVE@vc.cvut.cz>, Shaun Jackman <sjackman@telus.net>,
       linux-kernel@vger.kernel.org
Subject: Re: Hang after "BIOS data check successful" with DVI
Message-ID: <20040817165831.GC19243@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Zwane Mwaikambo <zwane@linuxpower.ca>,
	Petr Vandrovec <VANDROVE@vc.cvut.cz>,
	Shaun Jackman <sjackman@telus.net>, linux-kernel@vger.kernel.org
References: <E82D6B0981@vcnet.vc.cvut.cz> <Pine.LNX.4.58.0408170950470.22078@montezuma.fsmlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0408170950470.22078@montezuma.fsmlabs.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 17, 2004 at 09:51:55AM -0400, Zwane Mwaikambo wrote:
 > On Tue, 17 Aug 2004, Petr Vandrovec wrote:
 > 
 > > On 16 Aug 04 at 16:55, Shaun Jackman wrote:
 > > > When I have a DVI display plugged into my Matrox G550 video card the
 > > > boot process hangs at "BIOS data check successful". I am running Linux
 > > > kernel 2.6.6. This problem does not affect Linux kernel 2.4.26. If I
 > > > boot without the DVI display plugged in, I can plug it in after the
 > > > boot process and the display works.
 > >
 > > Try disabling CONFIG_VIDEO_SELECT and/or comment out call to store_edid
 > > in arch/i386/boot/video.S. Also which bootloader you use? From
 > > quick glance at bootloaders, grub1 seems to set %sp to 0x9000, while
 > > LILO to 0x0800. And I think that 2048 byte stack (plus something already
 > > allocated by loader) might be too small for DDC call, as MGA BIOS first
 > > creates EDID copy on stack...
 > 
 > Urgh, this bug is still around :(
 > 
 > http://bugme.osdl.org/show_bug.cgi?id=1458

sidenote: A number of the int 10h calls in arch/i386/boot/video.S either
don't check the return code, and blindly assume everything went ok,
or do the wrong thing with them.

Example..

# get video mem size
    leaw    modelist+1024, %di
    movw    $0x4f00, %ax
    int $0x10
    xorl    %eax, %eax
    movw    18(%di), %ax
    movl    %eax, %fs:(PARAM_LFB_SIZE)

Checking http://www.ctyme.com/intr/rb-0273.htm shows that on return
from the int 10h, we should check al==4f before doing anything with
the results. Instead we not only ignore the return code, but trash it 8-)

Same story with function 4f0a a few lines below.

I did have a patch to change this a looong time ago (early 2.5)
but I don't know what became of it. Even google doesn't seem to turn it
up, so its possible I never got around to posting it.

		Dave

