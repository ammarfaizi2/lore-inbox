Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261985AbTFXLlF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jun 2003 07:41:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261989AbTFXLlF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jun 2003 07:41:05 -0400
Received: from mailgw.cvut.cz ([147.32.3.235]:55183 "EHLO mailgw.cvut.cz")
	by vger.kernel.org with ESMTP id S261985AbTFXLlD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jun 2003 07:41:03 -0400
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: David Woodhouse <dwmw2@infradead.org>
Date: Tue, 24 Jun 2003 13:54:33 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: matroxfb console oops in 2.4.2x
Cc: linux-kernel@vger.kernel.org, jsimmons@infradead.org
X-mailer: Pegasus Mail v3.50
Message-ID: <552FB6B07DA@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 24 Jun 03 at 10:09, David Woodhouse wrote:
> On Thu, 2003-06-19 at 20:45, Petr Vandrovec wrote:
> > This one is culprit. If you'll comment this message out, it will not
> > crash.
> 
> As discussed, this is true but if anyone _else_ happens to call printk
> during the same period, it'll still crash. 
> 
> Matroxfb is registering a screen for which it's not yet willing to
> attempt output -- and taking out this printk only serves to fix the
> coincidence which makes it 100% reproducible -- the thing is still
> broken without that printk.

There is no way around - at least I do not know such. matroxfb cannot 
initialize hardware before call to the set_var, as otherwise you'll 
get white 80x25 square instead of vgacon text copied to the matroxfb.

If you'll replace matroxfb_set_var(..., -2, &ACCESS_FBINFO(fbcon))
with matroxfb_set_var(..., -1, &ACCESS_FBINFO(fbcon)) in matroxfb_base.c,
you'll get behavior you are asking for: hardware gets initialized before
call to register_framebuffer(). Unfortunately it breaks 
take_over_console for all vgacon users - and as there is more vgacon
users than sh users, I prefer just creating dummy putc/putcs functions
which will do nothing, over changing initialization order.

I'm still trying to find why PLL does not lock on your hardware,
but I still do not understand why it works on ia32 for secondary adapters,
but not on sh.
                                                    Petr Vandrovec
                                                    vandrove@vc.cvut.cz
                                                    

