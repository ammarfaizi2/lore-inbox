Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265342AbTFSMIL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jun 2003 08:08:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265393AbTFSMIK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jun 2003 08:08:10 -0400
Received: from mailgw.cvut.cz ([147.32.3.235]:21398 "EHLO mailgw.cvut.cz")
	by vger.kernel.org with ESMTP id S265342AbTFSMIG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jun 2003 08:08:06 -0400
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: David Woodhouse <dwmw2@infradead.org>
Date: Thu, 19 Jun 2003 14:21:47 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: matroxfb console oops in 2.4.2x
Cc: linux-kernel@vger.kernel.org, jsimmons@infradead.org
X-mailer: Pegasus Mail v3.50
Message-ID: <4DB6BC835A7@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 19 Jun 03 at 11:06, David Woodhouse wrote:

> Below is a workaround which lets the machine boot. It's obviously not a
> fix.
> 
> --- drivers/video/matrox/matroxfb_accel.c~  Wed Jun 18 17:16:40 2003
> +++ drivers/video/matrox/matroxfb_accel.c   Thu Jun 19 10:57:54 2003
> @@ -487,6 +487,9 @@
>  
>     DBG_HEAVY("matroxfb_cfb8_putc");
>  
> +   if (!ACCESS_FBINFO(curr.putc))
> +       return;
> +

It looks like that someone tried to print something on the console
during fbcon initialization. It is not allowed to call fbdev's putc 
before mode set was issued (at least I always believed to it; before
first mode set hardware is in VGA state). Do not you see some error 
message in dmesg with these fixes?

> @@ -504,6 +507,9 @@
>  
>     DBG_HEAVY("matroxfb_cfb16_putc");
>  
> +   if (!ACCESS_FBINFO(curr.putc))
> +       return;
> +

Instead of plugging these tests into fast path please call
"matrox_init_putc(PMINFO NULL, NULL)" somewhere in the initMatrox2(),
before call to the register_framebuffer. At worst some part of video
memory gets smashed by painted characters, but no damage should
occur.
                                                Petr Vandrovec
                                                

