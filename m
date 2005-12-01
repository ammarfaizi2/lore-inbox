Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932509AbVLAV4w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932509AbVLAV4w (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 16:56:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932508AbVLAV4w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 16:56:52 -0500
Received: from smtp.osdl.org ([65.172.181.4]:23506 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932509AbVLAV4v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 16:56:51 -0500
Date: Thu, 1 Dec 2005 13:53:28 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Eyal Lebedinsky <eyal@eyal.emu.id.au>
cc: list linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.15-rc4
In-Reply-To: <438F6DFF.2040603@eyal.emu.id.au>
Message-ID: <Pine.LNX.4.64.0512011347290.3099@g5.osdl.org>
References: <Pine.LNX.4.64.0511302234020.3099@g5.osdl.org> 
 <1133445903.16820.1.camel@localhost>  <Pine.LNX.4.64.0512010759571.3099@g5.osdl.org>
 <6f6293f10512011112m6e50fe0ejf0aa5ba9d09dca1e@mail.gmail.com>
 <Pine.LNX.4.64.0512011125280.3099@g5.osdl.org> <438F6DFF.2040603@eyal.emu.id.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 2 Dec 2005, Eyal Lebedinsky wrote:
> 
> I am also getting the NVIDIA messages, here they are from a patched kernel.
> my driver continues to work OK, however I am not running any gl apps.

Ok. It seems at least the NVidia driver is happy with the new code, and we 
could disable messages for it. 

The NVidia driver would probably be even _happier_ to use the new 
"vm_insert_page()" function that was designed to do exactly what NVidia 
seems to want to do (insert single pages at specified addresses), but that 
obviously requires that driver to change.

It seems to be the ATI driver that has some magic expectations. People 
with the ATI driver, please test with the noisier patch and report. 
Please.

(There are a couple of in-tree drivers that it would be interesting to 
hear about too. In particular, all these files:

	arch/ia64/kernel/perfmon.c
	drivers/media/video/cpia.c
	drivers/media/video/em28xx/em28xx-video.c
	drivers/media/video/meye.c
	drivers/media/video/planb.c
	drivers/media/video/vino.c
	drivers/media/video/zr36120.c
	drivers/usb/class/audio.c
	drivers/usb/media/ov511.c
	drivers/usb/media/pwc/pwc-if.c
	drivers/usb/media/se401.c
	drivers/usb/media/sn9c102_core.c
	drivers/usb/media/stv680.c
	drivers/usb/media/usbvideo.c
	drivers/usb/media/vicam.c

use remap_pfn_range() to map a single page, and should thus probably be 
converted to the new lighter-weight vm_insert_page() instead which matches 
much more closely what they actually want to do, and doesn't require 
reserved pages etc. However, since I have none of the affected hardware, 
and since you need to be careful about the page protections, I didn't do 
any of the apparently trivial conversions).

Anybody who is interested in this, please just read the comment in 
mm/memory.c above the vm_insert_page() function, it really should be very 
straightforward, but needs some trivial testing..

			Linus
