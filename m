Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261417AbVDIXgK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261417AbVDIXgK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Apr 2005 19:36:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261418AbVDIXgK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Apr 2005 19:36:10 -0400
Received: from gate.crashing.org ([63.228.1.57]:64389 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261417AbVDIXfB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Apr 2005 19:35:01 -0400
Subject: Re: [PATCH] radeonfb: (#2) Implement proper workarounds for PLL
	accesses
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andreas Schwab <schwab@suse.de>
Cc: Dave Airlie <airlied@gmail.com>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
In-Reply-To: <jey8brj4tx.fsf@sykes.suse.de>
References: <1110519743.5810.13.camel@gaston>
	 <1110672745.5787.60.camel@gaston> <je8y3wyk3g.fsf@sykes.suse.de>
	 <1112743901.9568.67.camel@gaston> <jeoecr1qk8.fsf@sykes.suse.de>
	 <1112827655.9518.194.camel@gaston> <jehdii8hjk.fsf@sykes.suse.de>
	 <21d7e9970504071422349426eb@mail.gmail.com>
	 <1112914795.9568.320.camel@gaston> <jemzsa6sxg.fsf@sykes.suse.de>
	 <1112923186.9567.349.camel@gaston> <jezmw9ug7j.fsf@sykes.suse.de>
	 <1113005006.9568.402.camel@gaston>  <jey8brj4tx.fsf@sykes.suse.de>
Content-Type: text/plain
Date: Sun, 10 Apr 2005 09:33:11 +1000
Message-Id: <1113089591.9518.440.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-04-09 at 18:24 +0200, Andreas Schwab wrote:
> Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:
> 
> > Can you redo the counting of the workarounds with the patch ?
> 
> Switching from X to console:
> 
> radeon_write_pll_regs: INPLL
> radeon_write_pll_regs: INPLL
> radeon_write_mode: OUTPLL
> radeonfb_engine_reset: INPLL
> radeonfb_engine_reset: OUTPLL
> radeonfb_engine_reset: OUTPLL
> radeonfb_setcmap: INPLL
> radeonfb_setcmap: OUTPLL
> radeonfb_setcmap: OUTPLL
> radeon_write_pll_regs: INPLL
> radeon_write_pll_regs: INPLL
> radeon_write_mode: OUTPLL
> radeonfb_engine_reset: INPLL
> radeonfb_engine_reset: OUTPLL
> radeonfb_engine_reset: OUTPLL
> radeonfb_setcmap: INPLL
> radeonfb_setcmap: OUTPLL
> radeonfb_setcmap: OUTPLL
> radeonfb_setcmap: INPLL
> radeonfb_setcmap: OUTPLL
> radeonfb_setcmap: OUTPLL
> radeonfb_setcmap: INPLL
> radeonfb_setcmap: OUTPLL
> radeonfb_setcmap: OUTPLL
> radeonfb_setcmap: INPLL
> radeonfb_setcmap: OUTPLL

Ok, so the above is interesting, something is callign setcmap way too
much here I would say... Besides, it looks like set_par is called twice,
which is wrong too.

> Switching from console to X:
> 
> radeonfb_setcmap: OUTPLL
> radeon_write_pll_regs: INPLL
> radeon_write_pll_regs: INPLL
> radeon_write_mode: OUTPLL
> radeonfb_engine_reset: INPLL
> radeonfb_engine_reset: OUTPLL
> radeonfb_engine_reset: OUTPLL
> radeonfb_setcmap: INPLL
> radeonfb_setcmap: OUTPLL
> radeonfb_setcmap: OUTPLL
> agpgart: Putting AGP V2 device at 0000:00:0b.0 into 1x mode
> agpgart: Putting AGP V2 device at 0000:00:10.0 into 1x mode
> radeonfb_setcolreg: INPLL
> radeonfb_setcolreg: OUTPLL
> radeonfb_setcolreg: OUTPLL
> ... last three lines repeated 63 times

Hrm... the last (serie of 64 setcolreg) are probably X beeing extremely
dumb, and calling the ioctl 64 times to set each palette entry instead
of doing a single call for the whole palette...

Anyway. Except for maybe the double set-par on switch from X to console,
there isn't much more we can do here. We might be able to improve X but
there is a significant lag between a fix done to X.org HEAD appears in
any distro. The fact is, according to ATI, there is a HW bug on M6 taht
can cause lockups of the chip, and this 5ms workaround is necessary to
avoid it... 

Ben.


