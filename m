Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751289AbWFKNYa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751289AbWFKNYa (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jun 2006 09:24:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751301AbWFKNYa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jun 2006 09:24:30 -0400
Received: from mailout08.sul.t-online.com ([194.25.134.20]:22990 "EHLO
	mailout08.sul.t-online.com") by vger.kernel.org with ESMTP
	id S1751289AbWFKNYa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jun 2006 09:24:30 -0400
Message-ID: <448C19D7.5010706@t-online.de>
Date: Sun, 11 Jun 2006 15:25:43 +0200
From: Knut Petersen <Knut_Petersen@t-online.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.7.10) Gecko/20050726
X-Accept-Language: de, en
MIME-Version: 1.0
To: linux-fbdev-devel@lists.sourceforge.net
CC: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [Linux-fbdev-devel] [PATCH 0/7] Detaching fbcon
References: <44856223.9010606@gmail.com>
In-Reply-To: <44856223.9010606@gmail.com>
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
X-ID: GWwAEoZUZevYQHxQN+eC1ObwcSUYligg4Owb7wB6GQyLIUUHAPdn6r@t-dialin.net
X-TOI-MSGID: 9755c115-1465-4f60-8f1d-5bff9a83bb9c
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Antonino A. Daplas wrote:

>Overall, this feature is a great help for developers working in the
>framebuffer or console layer.  
>
Well, it has long been possible to load / unload framebuffer hardware
drivers using the vfb module as an intermediate step. It even has been
possible to load both vesafb and another framebuffer driver for the same
hardware, to assign vesafb to tty{a,b,c..}, the other framebuffer driver
to tty{m,n,o...} and to switch between those drivers using the usual
keyboard hotkeys.

So the main addition of your patchset is the possibility to replace
fbcon and helper modules, a nice feature I missed in the past.

But should a framebuffer driver terminate and leave the hardware in
graphics mode or in text mode? Up to now that was not a real question,
as we all knew that another framebuffer driver would take over control.
With your patches it is possible that a user really wants to switch to text
mode and to remove the complete fbcon layer. So should we switch the
hardware to text mode upon unloading a framebuffer driver?

Maybe unbinding of the framebuffer console is not followed by an
unloading of the framebuffer module. You tell us that an
"echo 1 > /sys/class/graphics/fbcon/detach" has the simple effect of a
corrupt display unless vbetools is used. No, that´s not ok.

Think about an echo 1 > /sys/class/graphics/fbcon/detach inside of an
xterm session.

I think we need new fbops, eg.

    int fb_fbcon_unbind(...)
    int fb_fbcon_bind(...)

If these are not implemented, unbinding is not allowed. Any requests to do
so will be ignored.

If these are implemented the fbcon_unbind() function of the framebuffer
driver is called first. If it does not return an error, unbinding can 
continue,
otherwise it fails.

With implemented fb_restore_state() and fb_save_state() fbops the 
framebuffer
driver knows best about the current hardware state and can act in a way that
there is no need for vbetools & friends as well as no possibility of fatal
interactions with X.

Unbinding requests should only be honored if the framebuffer driver decides
that it is safe. Don´t enable it by default.

cu,
 knut


