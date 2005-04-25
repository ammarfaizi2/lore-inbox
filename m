Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262505AbVDYD0F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262505AbVDYD0F (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Apr 2005 23:26:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262507AbVDYDZz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Apr 2005 23:25:55 -0400
Received: from smtp-out.hotpop.com ([38.113.3.71]:148 "EHLO
	smtp-out.hotpop.com") by vger.kernel.org with ESMTP id S262505AbVDYDZl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Apr 2005 23:25:41 -0400
From: "Antonino A. Daplas" <adaplas@hotpop.com>
Reply-To: adaplas@pol.net
To: lapinlam@vega.lnet.lut.fi (Tomi Lapinlampi), Adrian Bunk <bunk@stusta.de>
Subject: Re: 2.6.12-rc3 compile failure in tgafb.c, tgafb not working anymore
Date: Mon, 25 Apr 2005 11:21:14 +0800
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org, rth@twiddle.net,
       adaplas@pol.net, linux-fbdev-devel@lists.sourceforge.net
References: <20050421185034.GS607@vega.lnet.lut.fi> <20050422112030.GW607@vega.lnet.lut.fi> <20050422144047.GY607@vega.lnet.lut.fi>
In-Reply-To: <20050422144047.GY607@vega.lnet.lut.fi>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200504251121.16609.adaplas@hotpop.com>
X-HotPOP: -----------------------------------------------
                   Sent By HotPOP.com FREE Email
             Get your FREE POP email at www.HotPOP.com
          -----------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 22 April 2005 22:40, Tomi Lapinlampi wrote:
> On Fri, Apr 22, 2005 at 02:20:30PM +0300, Tomi Lapinlampi wrote:
> > Actually, I was able to get a clean compile with the patch from
> > http://marc.theaimsgroup.com/?l=linux-alpha&m=111392038121433&w=2
>
> Hi again,
>
> Although the tgafb driver compiles with the above patch, it shows
> similar behaviour as before: The kernel loads, the monitor comes alive
> but the screen stays completely blank.
> The last kernel that worked was 2.6.8.1. I've tested with 2.6.{9,10,11}

What does fbset show?  If the line rgba shows all zero, then you will get a
blank screen. The driver must properly set info->var.green|red|blue|transp,
which in turn depends on the hardware configuration.

You can try to insert these in tgafb_pci_register() after fb_find_mode().

If at 8bpp pseudocolor:

all->info.var.green.length = 8;
all->info.var.red.length = 8;
all->info.var.blue.length = 8;
all->info.var.green.offset = 0;
all->info.var.red.offset = 0;
all->info.var.blue.offset = 0;

If at 32-bit truecolor:

all->info.var.green.length = 8;
all->info.var.red.length = 8;
all->info.var.blue.length = 8;
all->info.var.green.offset = 8;
all->info.var.red.offset = 16;
all->info.var.blue.offset = 0;

If the above changes work, a definitive fix is still needed, one that will
also set the above for each visual the hardware supports on each
fb_check_var().

Tony


