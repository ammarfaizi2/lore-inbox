Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267434AbTACC6F>; Thu, 2 Jan 2003 21:58:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267435AbTACC6F>; Thu, 2 Jan 2003 21:58:05 -0500
Received: from Xenon.Stanford.EDU ([171.64.66.201]:1712 "EHLO
	Xenon.Stanford.EDU") by vger.kernel.org with ESMTP
	id <S267434AbTACC6E>; Thu, 2 Jan 2003 21:58:04 -0500
Date: Thu, 2 Jan 2003 19:06:26 -0800
From: Andy Chou <acc@CS.Stanford.EDU>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: acc@cs.stanford.edu,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       mc@cs.stanford.edu
Subject: Re: [CHECKER] 24 more buffer overruns in 2.5.48
Message-ID: <20030103030626.GA2272@Xenon.stanford.edu>
Reply-To: acc@cs.stanford.edu
References: <20030103003708.GA2861@Xenon.stanford.edu> <1041558816.24900.112.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1041558816.24900.112.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > [BUG] Possibly the caller's fault.
> > /u1/acc/linux/2.5.48/drivers/ide/ide-lib.c:380:ide_get_best_pio_mode: ERROR:BUFFER:380:380:Array bounds error: ide_pio_timings[6] indexed with [255] [Callstack: /u1/acc/linux/2.5.48/drivers/ide/legacy/qd65xx.c:272:ide_get_best_pio_mode(_, _, 255, _)] 
> > 		pio_mode = max_mode;
> > 		cycle_time = 0;
> > 	}
> > 	if (d) {
> > 		d->pio_mode = pio_mode;
> > 
> > Error --->
> > 		d->cycle_time = cycle_time ? cycle_time : ide_pio_timings[pio_mode].cycle_time;
> > 		d->use_iordy = use_iordy;
> > 		d->overridden = overridden;
> > 		d->blacklisted = blacklisted;
> 
> I can't construct a scenario in which this can occur.

In ide/legacy/qd65xx.c:272 there's a call where max_mode is 255.  Right 
before the piece of code that the checker warns about is the segment:

	if (pio_mode > max_mode) {
		pio_mode = max_mode;
		cycle_time = 0;
	}

Now, it may be that pio_mode can never be >= 255 in this scenario.  But if 
it can be, then this sets pio_mode to 255.


> > [BUG] [GEM] The caller is probably at fault: look at the call chain.
> > /u1/acc/linux/2.5.48/drivers/video/fbgen.c:180:do_install_cmap: ERROR:BUFFER:180:180:Array bounds error: fb_display[63] indexed with [-1] [Callstack: /u1/acc/linux/2.5.48/drivers/video/aty128fb.c:1746:aty128fb_set_var(_, -1, _) -> /u1/acc/linux/2.5.48/drivers/video/aty128fb.c:1406:do_install_cmap(-1, _)] 
> > 
> > void do_install_cmap(int con, struct fb_info *info)
> > {
> >     if (con != info->currcon)
> > 	return;
> 
> currcon can never be -1. I don't think the compiler can ever deduce that
> detail though.

Then there's some odd code, such as in fbgen.c:gen_switch():

	if (info->currcon >= 0) {
		...
	}
	
	info->currcon = con;

-Andy
