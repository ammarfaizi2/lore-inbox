Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261916AbTKYBxv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Nov 2003 20:53:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261928AbTKYBxv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Nov 2003 20:53:51 -0500
Received: from fw.osdl.org ([65.172.181.6]:19363 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261916AbTKYBxu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Nov 2003 20:53:50 -0500
Date: Mon, 24 Nov 2003 18:00:17 -0800
From: Andrew Morton <akpm@osdl.org>
To: Torrey Hoffman <thoffman@arnor.net>
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Subject: Re: 2.6.-test10: bad "__might_sleep" in ALSA sound drivers
Message-Id: <20031124180017.70d58566.akpm@osdl.org>
In-Reply-To: <1069718546.2268.9.camel@moria.arnor.net>
References: <1069718546.2268.9.camel@moria.arnor.net>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Torrey Hoffman <thoffman@arnor.net> wrote:
>
> I get this every time I boot 2.6.0-test10.  I think this problem has
> been around for a while.
> 
> Debug: sleeping function called from invalid context at
> include/asm/semaphore.h:119
> in_atomic():1, irqs_disabled():0
> Call Trace:
>  [<c01229d0>] __might_sleep+0xab/0xc9
>  [<fcff57bd>] ap_cs8427_sendbytes+0x38/0xd2 [snd_ice1712]
>  [<fcfa825a>] snd_i2c_sendbytes+0x22/0x26 [snd_i2c]
>  [<fcfaf15e>] snd_cs8427_reg_read+0x2c/0x8c [snd_cs8427]
>  [<fcfaf414>] snd_cs8427_create+0xa4/0x347 [snd_cs8427]
>  [<c02dc4b0>] snd_device_new+0x20/0x6a
>  [<fcff151a>] snd_ice1712_init_cs8427+0x2f/0x6f [snd_ice1712]
>  [<fcff6153>] snd_ice1712_delta_init+0x230/0x2b9 [snd_ice1712]
>  [<fcff5227>] snd_ice1712_probe+0x323/0x34c [snd_ice1712]

snd_cs8427_create() does:

	snd_i2c_lock(bus);
	if ((err = snd_cs8427_reg_read(device, CS8427_REG_ID_AND_VER)) != CS8427_VER8427A) {

the first statement takes a spinlock.  snd_cs8427_reg_read() then calls
ap_cs8427_sendbytes() which downs a semaphore.


It might be more appropriate to use a semaphore for ice1712_t.gpio_mutex?


