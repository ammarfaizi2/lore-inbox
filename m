Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263753AbTDNVP6 (for <rfc822;willy@w.ods.org>); Mon, 14 Apr 2003 17:15:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263744AbTDNVP6 (for <rfc822;linux-kernel-outgoing>);
	Mon, 14 Apr 2003 17:15:58 -0400
Received: from winds.org ([207.48.83.9]:54283 "EHLO winds.org")
	by vger.kernel.org with ESMTP id S263753AbTDNVPv (for <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Apr 2003 17:15:51 -0400
Date: Mon, 14 Apr 2003 17:27:39 -0400 (EDT)
From: Byron Stanoszek <gandalf@winds.org>
To: linux-kernel@vger.kernel.org
Subject: [vgacon] Font height discrepancy, Linux 2.5.x
Message-ID: <Pine.LNX.4.44.0304141712330.28989-100000@winds.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

To the person(s) who rewrote the vgacon.c &| vt_ioctl.c files for Linux 2.5
(since I don't know your names).. I have a slight problem with font height not
being saved across consoles.

I am the current developer of SVGATextMode and I'm looking for a way to set the
fontheight across curcons[0..MAX_NR_CONSOLES-1].d.vc_font_height through
ioctl() calls, only when using a VGA Console.

The ioctl() with VT_RESIZEX allows specifying a new character-cell height,
however it only appears to set for the Current Console, as per vt_ioctl:872:

                if (vlin)
                        vc->vc_scan_lines = vlin;
                if (clin)
                        vc->vc_font.height = clin;

                for (i = 0; i < MAX_NR_CONSOLES; i++)
                        vc_resize(i, cc, ll);

However, while vc_resize() is called for all consoles, it does Not set a new
font.height. The result is that any font height change will only take effect fo
rthe current VT, even though the VGA Console layer assumes every VT has the
same font style.

For instance, 'setfont' when run on other VTs, uses KBD routines to set the
font, and does not realize that the real number of scanlines on the screen have
changed. It essentially cuts the screen in half. Also, the cursor disappears
on the other consoles as it gets set with the wrong height.

I propose a patch that sets 'curcons[i].d.vc_font.height = clin' inside the
for() loop, however that could have an impact on the VFB module. AFAIK, the
framebuffer allows for different-sized character cells and fonts on different
VTs and doing this would defeat the purpose of having a vc_font.height variable
for each VT.

I would only like to set vc_font.height on all VTs if the underlying module is
a VGA Console and not a framebuffer.

What is the easiest way to do this? Perhaps the module should set a special
flag in the vt structure to determine if a font change affects all VTs (as in
the VGA Console) or only on the current VT (Framebuffer)?

Thank you very much!

 -Byron

-- 
Byron Stanoszek                         Ph: (330) 644-3059
Systems Programmer                      Fax: (330) 644-8110
Commercial Timesharing Inc.             Email: byron@comtime.com

