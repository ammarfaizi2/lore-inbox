Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751169AbWJQX4w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751169AbWJQX4w (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 19:56:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751183AbWJQX4w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 19:56:52 -0400
Received: from solarneutrino.net ([66.199.224.43]:24078 "EHLO
	tau.solarneutrino.net") by vger.kernel.org with ESMTP
	id S1751169AbWJQX4v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 19:56:51 -0400
Date: Tue, 17 Oct 2006 19:56:43 -0400
To: Keith Packard <keithp@keithp.com>
Cc: dri-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: Intel 965G: i915_dispatch_cmdbuffer failed (2.6.19-rc2)
Message-ID: <20061017235643.GB25185@tau.solarneutrino.net>
References: <20061013194516.GB19283@tau.solarneutrino.net> <1160849723.3943.41.camel@neko.keithp.com> <20061017174020.GA24789@tau.solarneutrino.net> <1161124062.25439.8.camel@neko.keithp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1161124062.25439.8.camel@neko.keithp.com>
User-Agent: Mutt/1.5.9i
From: Ryan Richter <ryan@tau.solarneutrino.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 18, 2006 at 06:27:42AM +0800, Keith Packard wrote:
> On Tue, 2006-10-17 at 13:40 -0400, Ryan Richter wrote:
> 
> > So do I want something like
> > 
> > 
> > static int do_validate_cmd(int cmd)
> > {
> > 	return 1;
> > }
> > 
> > in i915_dma.c?
> 
> that will certainly avoid any checks. Another alternative is to printk
> the cmd which fails validation so we can see what needs adding here.

With just the above, running a GL client (even glxinfo) locks up the
display such that it can't be recovered without a reboot.  It doesn't
kill the machine, though. What looks like a 64x64 block of garbage
appears on the screen. The kernel says

[drm:i915_wait_irq] *ERROR* i915_wait_irq: EBUSY -- rec: 0 emitted: 2

If instead I change the validate_cmd function to:


static int validate_cmd(int cmd)
{
        int ret = do_validate_cmd(cmd);

        if(!ret)
                printk("validate_cmd( %x ): %d\n", cmd, ret);

        return 1;
}

I get basically the same behavior, but different output:


validate_cmd( 1e3f0003 ): 0
validate_cmd( 1e3f0003 ): 0
validate_cmd( d90003 ): 0
validate_cmd( d90003 ): 0
validate_cmd( d70003 ): 0
validate_cmd( d90003 ): 0
validate_cmd( d90003 ): 0
validate_cmd( d90003 ): 0
validate_cmd( d90003 ): 0
validate_cmd( 8d8c0003 ): 0
validate_cmd( d70003 ): 0
[drm:i915_batchbuffer] *ERROR* i915_batchbuffer called without lock held

Thanks,
-ryan
