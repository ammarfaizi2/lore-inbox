Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262185AbUKDM7o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262185AbUKDM7o (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 07:59:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262194AbUKDM7o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 07:59:44 -0500
Received: from sartre.ispvip.biz ([209.118.182.154]:11962 "HELO
	sartre.ispvip.biz") by vger.kernel.org with SMTP id S262185AbUKDM7l
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 07:59:41 -0500
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.10-rc1-mm2-V0.7.7
From: "Michael J. Cohen" <mjc@unre.st>
To: Ingo Molnar <mingo@elte.hu>
Cc: "K.R. Foley" <kr@cybsft.com>, sboyce@blueyonder.co.uk,
       linux-kernel@vger.kernel.org
In-Reply-To: <20041104114545.GA3722@elte.hu>
References: <4189108C.2050804@blueyonder.co.uk>
	 <41892899.6080400@cybsft.com> <41897119.6030607@blueyonder.co.uk>
	 <418988A6.4090902@cybsft.com> <20041104100634.GA29785@elte.hu>
	 <1099563805.30372.2.camel@localhost> <1099567061.7911.4.camel@localhost>
	 <20041104114545.GA3722@elte.hu>
Content-Type: text/plain
Date: Thu, 04 Nov 2004 07:59:31 -0500
Message-Id: <1099573171.7876.0.camel@optie.uni.325i.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-11-04 at 12:45 +0100, Ingo Molnar wrote:
> * Michael J. Cohen <mjc@unre.st> wrote:
> 
> > Turned off the debugging stuff to fix this one :/
> > 
> > might_sleep issue at swap_on and firefox causes oopsen.
> > 
> > dmesg is 120k+ so here:
> > 
> > http://325i.org/software/2.6.10-rc1-mm2-RT-V0.7.8.dmesg
> 
> does the patch below fix the fbcon problem? (if any new oops happens or
> old one triggers again then please re-post the syslog or serial console
> capture)
> 
> 	Ingo
> 
> --- linux/drivers/video/console/fbcon.c.orig
> +++ linux/drivers/video/console/fbcon.c
> @@ -1051,7 +1051,14 @@ static void fbcon_cursor(struct vc_data 
>  	struct display *p = &fb_display[vc->vc_num];
>  	int y = real_y(p, vc->vc_y);
>   	int c = scr_readw((u16 *) vc->vc_pos);
> +#ifdef CONFIG_PREEMPT_REALTIME
> +	unsigned long flags;
> +#endif
>  
> +#ifdef CONFIG_PREEMPT_REALTIME
> +	local_save_flags(flags);
> +	local_irq_enable();
> +#endif
>  	ops->cursor_flash = 1;
>  	if (mode & CM_SOFTBACK) {
>  		mode &= ~CM_SOFTBACK;
> @@ -1069,6 +1076,9 @@ static void fbcon_cursor(struct vc_data 
>  	ops->cursor(vc, info, p, mode, get_color(vc, info, c, 1),
>  		    get_color(vc, info, c, 0));
>  	vbl_cursor_cnt = CURSOR_DRAW_DELAY;
> +#ifdef CONFIG_PREEMPT_REALTIME
> +	local_irq_restore(flags);
> +#endif
>  }
>  
>  static int scrollback_phys_max = 0;

Works fine so far. still have to deal with e1000 though...

------
Michael Cohen

