Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270028AbUIDDgJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270028AbUIDDgJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 23:36:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270035AbUIDDgJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 23:36:09 -0400
Received: from 213-229-38-18.static.adsl-line.inode.at ([213.229.38.18]:16571
	"HELO home.winischhofer.net") by vger.kernel.org with SMTP
	id S270028AbUIDDgD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 23:36:03 -0400
Message-ID: <41393829.6020302@winischhofer.net>
Date: Sat, 04 Sep 2004 05:36:09 +0200
From: Thomas Winischhofer <thomas@winischhofer.net>
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040819)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: adaplas@pol.net
CC: Andrew Morton <akpm@osdl.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/5][RFC] fbdev: Clean up framebuffer initialization
References: <200409041108.40276.adaplas@hotpop.com>
In-Reply-To: <200409041108.40276.adaplas@hotpop.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Antonino A. Daplas wrote:
> This patch probably deserves discussion among developers.
> 
> Currently, the framebuffer system is initialized in a roundabout manner.
> First, drivers/char/mem.c calls fbmem_init().  fbmem_init() will then
> iterate over an array of individual drivers' xxxfb_init(), then each driver
> registers its presence back to fbmem.  During console_init(),
> drivers/char/vt.c will call fb_console_init(). fbcon will check for
> registered drivers, and if any are present, will call take_over_console() in
> drivers/char/vt.c.
> 
> This patch changes the initialization sequence so it proceeds in this
> manner: Each driver has its own module_init(). Each driver calls
> register_framebuffer() in fbmem.c. fbmem.c will then notify fbcon of the
> driver registration.  Upon notification, fbcon calls take_over_console() in
> vt.c.
> 
> The following are the changes brought about by this patch:
> 
> 1. Each subsystem (fbcon, fbmem, xxxfb) will have their own module_init.
> Thus, explicit calls to each subsystem's init functions are eliminated.
> 
> 2. The struct fb_drivers array in fbmem.c can be removed.  This slashes
> around 400 lines in fbmem.c
> 
> 3. Parsing of kernel boot options were done by fbmem.c calling each
> driver's xxxfb_setup() function.  Because this is not possible with this
> patch, drivers can choose to either:
> 	a. have their own __setup() routine
> 	b. call fb_get_options("xxxfb") and pass the return  value to
> 	 xxxfb_setup(). This is to maintain compatibility with the
> 	'video=xxxfb:<options>' semantics.
> 
> 4. Getting a framebuffer console will occur a bit late during the boot
> process since the initialization sequence will depend upon the link order.
> So, 'video/' is moved up in drivers/Makefile, shortly after 'pci/'
> 
> 5. Because driver initialization will be dependent on the link order,
> hardware that depends on other subsystems (agpgart, usb, serial, etc) may
> choose to initialize after the subsystems they depend on. 
> 
> Signed-off-by: Antonino Daplas <adaplas@pol.net>

I don't really see a benefit but it's ok with me.

(Thanks for considering the "unified" nature of sisfb, by the way. Very 
considarate. Very much appreciated.)

I assume that you tested this stuff before posting it here.

Thomsd

-- 
Thomas Winischhofer
Vienna/Austria
thomas AT winischhofer DOT net          http://www.winischhofer.net/
twini AT xfree86 DOT org
