Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262765AbVAQKoW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262765AbVAQKoW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jan 2005 05:44:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262767AbVAQKoW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jan 2005 05:44:22 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:20998 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262765AbVAQKoQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jan 2005 05:44:16 -0500
Date: Mon, 17 Jan 2005 10:43:52 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, Philip.Blundell@pobox.com, tim@cyberelk.net,
       linux-parport@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] non-PC parport config change
Message-ID: <20050117104352.A21009@flint.arm.linux.org.uk>
Mail-Followup-To: Adrian Bunk <bunk@stusta.de>,
	Andrew Morton <akpm@osdl.org>, Philip.Blundell@pobox.com,
	tim@cyberelk.net, linux-parport@lists.infradead.org,
	linux-kernel@vger.kernel.org
References: <20050117103317.GM4274@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050117103317.GM4274@stusta.de>; from bunk@stusta.de on Mon, Jan 17, 2005 at 11:33:17AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 17, 2005 at 11:33:17AM +0100, Adrian Bunk wrote:
> This patch adds a config option PARPORT_NOT_PC (and removes the 
> PARPORT_OTHER option) and lets all non-PC parallel ports options depend 
> on it.
> 
> Advantages:
> - the config structure is IMHO a bit more logical
> - the mega #if in parport.h is gone now
> 
> Additionally, it removes the unneeded PARPORT_NEED_GENERIC_OPS #define.
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>

This actually looks like a nice example where the use of select would
work nicely.  IOW:

config PARPORT_ARC
	tristate "Archimedes hardware"
	depends on ARM && PARPORT
	select PARPORT_NOT_PC

config PARPORT_AMIGA
	tristate "Amiga builtin port"
	depends on AMIGA && PARPORT
	select PARPORT_NOT_PC

config PARPORT_NOT_PC
	bool

And I notice in passing that you've already used select on this new
configuration option in USB, and this new configuration option is user
visible.  Bad.

The golden rule (if you don't wish _me_ to complain) is:

   Don't use select on user-visible options.  Either make them
   non-user visibile or don't use select at all.

In this case, the former is far more preferable because it means that
the existing defconfig files don't need to be fixed for their parports
work again.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
