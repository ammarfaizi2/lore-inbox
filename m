Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265366AbUFSKCr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265366AbUFSKCr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jun 2004 06:02:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265395AbUFSKCr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jun 2004 06:02:47 -0400
Received: from babyruth.hotpop.com ([38.113.3.61]:24510 "EHLO
	babyruth.hotpop.com") by vger.kernel.org with ESMTP id S265366AbUFSKCo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jun 2004 06:02:44 -0400
From: "Antonino A. Daplas" <adaplas@hotpop.com>
Reply-To: adaplas@pol.net
To: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [Linux-fbdev-devel] 2.6.7 fbcon: set_con2fb on current console = crash
Date: Sat, 19 Jun 2004 18:03:10 +0800
User-Agent: KMail/1.5.4
Cc: Jakub Bogusz <qboosh@pld-linux.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Linux Frame Buffer Device Development 
	<linux-fbdev-devel@lists.sourceforge.net>,
       pld-kernel@pld-linux.org
References: <20040618215047.GA4723@satan.blackhosts> <200406191413.44439.adaplas@hotpop.com> <Pine.GSO.4.58.0406191127250.23356@waterleaf.sonytel.be>
In-Reply-To: <Pine.GSO.4.58.0406191127250.23356@waterleaf.sonytel.be>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200406191803.10736.adaplas@hotpop.com>
X-HotPOP: -----------------------------------------------
                   Sent By HotPOP.com FREE Email
             Get your FREE POP email at www.HotPOP.com
          -----------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 19 June 2004 17:28, Geert Uytterhoeven wrote:
> On Sat, 19 Jun 2004, Antonino A. Daplas wrote:
> > Thanks.  Actually there's still a critical flaw in the set_con2fbmap
> > code. For one, con2fb_map is never initialized.  It's just fortunate that
> > this array happens to be  filled with zeroes so con2fb_map[n] will always
> > return zero and registered_fb[0] happens to contain a valid info.  So it
> > works, by accident.
>
> According to the C standard, global variables are initialized to zero,
> unless specified otherwise.
>

I know, but what I meant was con2fb_map[] is never initialized by fbcon.  So 
if the first valid fbdev is in registered_fb[1], then con2fbmap must be 
initialized to 1's by fbcon.  It doesn't.  Note, fbdev-2.4 does the 
initialization correctly.

So 2 critical flaws in the code:

1. con2fb_map[] is always zero-set
2. fbcon assumes that registered_fb[0] is always valid

Both flaws will manifest by doing this:

modprobe fbdev1 - in registered_fb[0]
modprobe fbdev2 - in registered_fb[1]
rmmod fbdev1      - registered_fb[0] becomes invalid
modprobe fbcon  
	 - con2fb_map[] with zeroes instead of 1's and fbcon_startup looks for 
fb_info in registered_fb[0] instead of registered_fb[1]

Tony


