Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965025AbWGJPhe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965025AbWGJPhe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 11:37:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965035AbWGJPhe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 11:37:34 -0400
Received: from khc.piap.pl ([195.187.100.11]:34701 "EHLO khc.piap.pl")
	by vger.kernel.org with ESMTP id S965025AbWGJPhe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 11:37:34 -0400
To: "Antonino A. Daplas" <adaplas@gmail.com>
Cc: "Antonino A. Daplas" <adaplas@pol.net>, Jean Delvare <khali@linux-fr.org>,
       Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] cirrus-logic-framebuffer-i2c-support.patch
References: <200607050147.k651kxmT023763@shell0.pdx.osdl.net>
	<20060705165255.ab7f1b83.khali@linux-fr.org>
	<m3bqryv7jx.fsf_-_@defiant.localdomain> <44B196ED.1070804@pol.net>
	<m3irm5hjr0.fsf@defiant.localdomain> <44B226E8.40104@pol.net>
	<m3mzbh68g9.fsf@defiant.localdomain> <44B2398B.7040300@pol.net>
	<m3ejwt65of.fsf@defiant.localdomain> <44B248E4.2020506@pol.net>
	<m3u05p4mkx.fsf@defiant.localdomain> <44B26004.4050500@gmail.com>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: Mon, 10 Jul 2006 17:37:30 +0200
In-Reply-To: <44B26004.4050500@gmail.com> (Antonino A. Daplas's message of "Mon, 10 Jul 2006 22:11:16 +0800")
Message-ID: <m3r70tqxmt.fsf@defiant.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Antonino A. Daplas" <adaplas@gmail.com> writes:

> David Eger is the author, the last I heard from him was 2 years ago.
> But I haven't received that many problem reports on cirrusfb.

Doesn't matter, what is important is that you know the stuff.

> The only register touched by the i2c code is EEPROM control (CL_SEQR8).
> This is never touched by the rest of the cirrusfb code. So I don't
> think concurrent access is a problem (unless the hardware has restrictions
> such as no other register accesses are allowed while this register is being
> accessed).

I mean I'm using (simplified):

unsigned char vga_rseq (void *regbase, unsigned char reg)
{
        vga_w (regbase, VGA_SEQ_I, reg);
        return vga_r (regbase, VGA_SEQ_D);
}

and

void vga_wseq (void *regbase, unsigned char reg, unsigned char val)
{
#ifdef VGA_OUTW_WRITE
        vga_w_fast (regbase, VGA_SEQ_I, reg, val);
#else
        vga_w (regbase, VGA_SEQ_I, reg);
        vga_w (regbase, VGA_SEQ_D, val);
#endif /* VGA_OUTW_WRITE */
}


How do I know the following will not happen:

taskA) alpine_getsda() called from I2C subsystem
 taskB) cirrusfb_blank() called from elsewhere
taskA) vga_rseq() calls vga_w()
 taskB) vga_rseq() or _wseq() calls vga_w()
taskA) vga_r() performed with wrong index (set by taskB).

I see most of vga_[rw]seq() calls are at init/set_mode time but still
this could be a problem.

This question isn't limited to cirrusfb only, of course.

> The framebuffer layer is serialized by
> acquire_console_sem()/release_console_sem(). If you think concurrent access
> is a problem, you can always use that.

It's quite big... While I haven't investigated that, I rather thought
about some small lock for vga_rseq() and vga_wseq(). Not sure.

Another thing... How is access to VGA registers shared between
X11 and the framebuffer?
-- 
Krzysztof Halasa
