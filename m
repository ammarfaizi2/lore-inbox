Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262447AbVAUSJN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262447AbVAUSJN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 13:09:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262453AbVAUSHM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 13:07:12 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:11207 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262447AbVAUSAP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 13:00:15 -0500
Date: Fri, 21 Jan 2005 17:59:58 +0000 (GMT)
From: James Simmons <jsimmons@www.infradead.org>
X-X-Sender: jsimmons@pentafluge.infradead.org
To: Roman Zippel <zippel@linux-m68k.org>
cc: Christoph Hellwig <hch@lst.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] merge vt_struct into vc_data
In-Reply-To: <Pine.LNX.4.61.0501150440400.6118@scrub.home>
Message-ID: <Pine.LNX.4.56.0501211753550.26614@pentafluge.infradead.org>
References: <20041231143457.GA9165@lst.de> <Pine.LNX.4.61.0501150440400.6118@scrub.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Please don't remove strutc vt_struct. What should be done is that struct 
vt_struct is used to hold the data that is shared amoung all the VCs. For 
example struct consw. See we end up with something like this.

struct vt_struct {
	const struct consw *vt_sw;
	struct vc_data *vc_cons[MAX_NR_USER_CONSOLES];
}

This is key to future multi-desktop support which when I'm done with fbdev 
work I will continue to work on and then introduce into the kernel. Mind 
you alot more cleanup of the console code has to be done than this.

On Sat, 15 Jan 2005, Roman Zippel wrote:

> Hi,
> 
> The vt_struct and vc_data are always allocated together, so there is no 
> need for a separate vt_struct structure.
> 
> Signed-off-by: Roman Zippel <zippel@linux-m68k.org>
> 
>  drivers/char/selection.c       |    6 +-
>  drivers/char/vt.c              |   86 ++++++++++++++-----------------------
>  drivers/char/vt_ioctl.c        |   93 +++++++++++++++++------------------------
>  drivers/video/console/fbcon.c  |   44 ++++++++-----------
>  drivers/video/console/sticon.c |   10 +---
>  drivers/video/sun3fb.c         |    2 
>  fs/compat_ioctl.c              |    9 ++-
>  include/linux/console_struct.h |    7 ++-
>  include/linux/vt_kern.h        |    9 ---
>  9 files changed, 111 insertions(+), 155 deletions(-)
> 
> Index: linux-2.6-vc/drivers/char/selection.c
> ===================================================================
> --- linux-2.6-vc.orig/drivers/char/selection.c	2005-01-14 22:15:55.897857901 +0100
> +++ linux-2.6-vc/drivers/char/selection.c	2005-01-14 22:18:36.155245213 +0100
> @@ -275,7 +275,7 @@ int set_selection(const struct tiocl_sel
>   */
>  int paste_selection(struct tty_struct *tty)
>  {
> -	struct vt_struct *vt = (struct vt_struct *) tty->driver_data;
> +	struct vc_data *vc = (struct vc_data *)tty->driver_data;
>  	int	pasted = 0, count;
>  	struct  tty_ldisc *ld;
>  	DECLARE_WAITQUEUE(wait, current);
> @@ -286,7 +286,7 @@ int paste_selection(struct tty_struct *t
>  
>  	ld = tty_ldisc_ref_wait(tty);
>  	
> -	add_wait_queue(&vt->paste_wait, &wait);
> +	add_wait_queue(&vc->paste_wait, &wait);
>  	while (sel_buffer && sel_buffer_lth > pasted) {
>  		set_current_state(TASK_INTERRUPTIBLE);
>  		if (test_bit(TTY_THROTTLED, &tty->flags)) {
> @@ -298,7 +298,7 @@ int paste_selection(struct tty_struct *t
>  		tty->ldisc.receive_buf(tty, sel_buffer + pasted, NULL, count);
>  		pasted += count;
>  	}
> -	remove_wait_queue(&vt->paste_wait, &wait);
> +	remove_wait_queue(&vc->paste_wait, &wait);
>  	current->state = TASK_RUNNING;
>  
>  	tty_ldisc_deref(ld);
> Index: linux-2.6-vc/drivers/char/vt.c
> ===================================================================
> --- linux-2.6-vc.orig/drivers/char/vt.c	2005-01-14 22:16:13.448833821 +0100
> +++ linux-2.6-vc/drivers/char/vt.c	2005-01-14 22:18:36.157244868 +0100
> @@ -545,7 +545,7 @@ static void hide_cursor(struct vc_data *
>  static void set_cursor(struct vc_data *vc)
>  {
>  	if (!vc->vc_num != fg_console || console_blanked ||
> -	    vc->vc_vt->vc_mode == KD_GRAPHICS)
> +	    vc->vc_mode == KD_GRAPHICS)
>  		return;
>  	if (vc->vc_deccm) {
>  		if (vc == sel_cons)
> @@ -640,7 +640,7 @@ void redraw_screen(struct vc_data *vc, i
>  			update_attr(vc);
>  			clear_buffer_attributes(vc);
>  		}
> -		if (update && vt_cons[vc->vc_num]->vc_mode != KD_GRAPHICS)
> +		if (update && vc->vc_mode != KD_GRAPHICS)
>  			do_update_region(vc, vc->vc_origin, vc->vc_screenbuf_size / 2);
>  	}
>  	set_cursor(vc);
> @@ -693,7 +693,6 @@ int vc_allocate(unsigned int currcons)	/
>  		return -ENXIO;
>  	if (!vc_cons[currcons].d) {
>  	    struct vc_data *vc;
> -	    long p, q;
>  
>  	    /* prevent users from taking too much memory */
>  	    if (currcons >= MAX_NR_USER_CONSOLES && !capable(CAP_SYS_RESOURCE))
> @@ -705,24 +704,20 @@ int vc_allocate(unsigned int currcons)	/
>  	    /* although the numbers above are not valid since long ago, the
>  	       point is still up-to-date and the comment still has its value
>  	       even if only as a historical artifact.  --mj, July 1998 */
> -	    p = (long) kmalloc(sizeof(struct vc_data) + sizeof(struct vt_struct), GFP_KERNEL);
> -	    if (!p)
> +	    vc = kmalloc(sizeof(struct vc_data), GFP_KERNEL);
> +	    if (!vc)
>  		return -ENOMEM;
> -	    memset((void *)p, 0, sizeof(struct vc_data) + sizeof(struct vt_struct));
> -	    vc_cons[currcons].d = vc = (struct vc_data *)p;
> -	    vt_cons[currcons] = (struct vt_struct *)(p+sizeof(struct vc_data));
> -	    vc_cons[currcons].d->vc_vt = vt_cons[currcons];
> +	    memset(vc, 0, sizeof(*vc));
> +	    vc_cons[currcons].d = vc;
>  	    visual_init(vc, currcons, 1);
>  	    if (!*vc->vc_uni_pagedir_loc)
>  		con_set_default_unimap(vc);
> -	    q = (long)kmalloc(vc->vc_screenbuf_size, GFP_KERNEL);
> -	    if (!q) {
> -		kfree((char *) p);
> +	    vc->vc_screenbuf = kmalloc(vc->vc_screenbuf_size, GFP_KERNEL);
> +	    if (!vc->vc_screenbuf) {
> +		kfree(vc);
>  		vc_cons[currcons].d = NULL;
> -		vt_cons[currcons] = NULL;
>  		return -ENOMEM;
>  	    }
> -	    vc->vc_screenbuf = (unsigned short *)q;
>  	    vc->vc_kmalloced = 1;
>  	    vc_init(vc, vc->vc_rows, vc->vc_cols, 1);
>  
> @@ -740,7 +735,7 @@ inline int resize_screen(struct vc_data 
>  	/* Resizes the resolution of the display adapater */
>  	int err = 0;
>  
> -	if (vt_cons[vc->vc_num]->vc_mode != KD_GRAPHICS && vc->vc_sw->con_resize)
> +	if (vc->vc_mode != KD_GRAPHICS && vc->vc_sw->con_resize)
>  		err = vc->vc_sw->con_resize(vc, width, height);
>  	return err;
>  }
> @@ -1904,7 +1899,6 @@ static int do_con_write(struct tty_struc
>  	int c, tc, ok, n = 0, draw_x = -1;
>  	unsigned int currcons;
>  	unsigned long draw_from = 0, draw_to = 0;
> -	struct vt_struct *vt;
>  	struct vc_data *vc;
>  	u16 himask, charmask;
>  	const unsigned char *orig_buf = NULL;
> @@ -1916,14 +1910,14 @@ static int do_con_write(struct tty_struc
>  	might_sleep();
>  
>  	acquire_console_sem();
> -	vt = tty->driver_data;
> -	if (vt == NULL) {
> +	vc = tty->driver_data;
> +	if (vc == NULL) {
>  		printk(KERN_ERR "vt: argh, driver_data is NULL !\n");
>  		release_console_sem();
>  		return 0;
>  	}
>  
> -	currcons = vt->vc_num;
> +	currcons = vc->vc_num;
>  	if (!vc_cons_allocated(currcons)) {
>  	    /* could this happen? */
>  	    static int error = 0;
> @@ -1934,7 +1928,6 @@ static int do_con_write(struct tty_struc
>  	    release_console_sem();
>  	    return 0;
>  	}
> -	vc = vc_cons[currcons].d;
>  	release_console_sem();
>  
>  	orig_buf = buf;
> @@ -1949,8 +1942,8 @@ static int do_con_write(struct tty_struc
>  
>  	acquire_console_sem();
>  
> -	vt = tty->driver_data;
> -	if (vt == NULL) {
> +	vc = tty->driver_data;
> +	if (vc == NULL) {
>  		printk(KERN_ERR "vt: argh, driver_data _became_ NULL !\n");
>  		release_console_sem();
>  		goto out;
> @@ -2115,7 +2108,7 @@ static void console_callback(void *ignor
>  	if (scrollback_delta) {
>  		struct vc_data *vc = vc_cons[fg_console].d;
>  		clear_selection();
> -		if (vt_cons[vc->vc_num]->vc_mode == KD_TEXT)
> +		if (vc->vc_mode == KD_TEXT)
>  			vc->vc_sw->con_scrolldelta(vc, scrollback_delta);
>  		scrollback_delta = 0;
>  	}
> @@ -2169,7 +2162,7 @@ void vt_console_print(struct console *co
>  		goto quit;
>  	}
>  
> -	if (vt_cons[vc->vc_num]->vc_mode != KD_TEXT)
> +	if (vc->vc_mode != KD_TEXT)
>  		goto quit;
>  
>  	/* undraw cursor first */
> @@ -2390,9 +2383,9 @@ static void con_throttle(struct tty_stru
>  
>  static void con_unthrottle(struct tty_struct *tty)
>  {
> -	struct vt_struct *vt = tty->driver_data;
> +	struct vc_data *vc = tty->driver_data;
>  
> -	wake_up_interruptible(&vt->paste_wait);
> +	wake_up_interruptible(&vc->paste_wait);
>  }
>  
>  /*
> @@ -2427,16 +2420,16 @@ static void con_start(struct tty_struct 
>  
>  static void con_flush_chars(struct tty_struct *tty)
>  {
> -	struct vt_struct *vt;
> +	struct vc_data *vc;
>  
>  	if (in_interrupt())	/* from flush_to_ldisc */
>  		return;
>  
>  	/* if we race with con_close(), vt may be null */
>  	acquire_console_sem();
> -	vt = tty->driver_data;
> -	if (vt)
> -		set_cursor(vc_cons[vt->vc_num].d);
> +	vc = tty->driver_data;
> +	if (vc)
> +		set_cursor(vc);
>  	release_console_sem();
>  }
>  
> @@ -2453,8 +2446,7 @@ static int con_open(struct tty_struct *t
>  		ret = vc_allocate(currcons);
>  		if (ret == 0) {
>  			struct vc_data *vc = vc_cons[currcons].d;
> -			vt_cons[currcons]->vc_num = currcons;
> -			tty->driver_data = vt_cons[currcons];
> +			tty->driver_data = vc;
>  			vc->vc_tty = tty;
>  
>  			if (!tty->winsize.ws_row && !tty->winsize.ws_col) {
> @@ -2482,11 +2474,6 @@ static void con_close(struct tty_struct 
>  	down(&tty_sem);
>  	acquire_console_sem();
>  	if (tty && tty->count == 1) {
> -		struct vt_struct *vt;
> -
> -		vt = tty->driver_data;
> -		if (vt)
> -			vc_cons[vt->vc_num].d->vc_tty = NULL;
>  		tty->driver_data = NULL;
>  		release_console_sem();
>  		vcs_remove_devfs(tty);
> @@ -2522,7 +2509,7 @@ static void vc_init(struct vc_data *vc, 
>  	vc->vc_def_color       = 0x07;   /* white */
>  	vc->vc_ulcolor		= 0x0f;   /* bold white */
>  	vc->vc_halfcolor       = 0x08;   /* grey */
> -	init_waitqueue_head(&vt_cons[vc->vc_num]->paste_wait);
> +	init_waitqueue_head(&vc->paste_wait);
>  	reset_terminal(vc, do_clear);
>  }
>  
> @@ -2559,11 +2546,7 @@ static int __init con_init(void)
>  	 * kmalloc is not running yet - we use the bootmem allocator.
>  	 */
>  	for (currcons = 0; currcons < MIN_NR_CONSOLES; currcons++) {
> -		vc_cons[currcons].d = vc = (struct vc_data *)
> -				alloc_bootmem(sizeof(struct vc_data));
> -		vt_cons[currcons] = (struct vt_struct *)
> -				alloc_bootmem(sizeof(struct vt_struct));
> -		vc_cons[currcons].d->vc_vt = vt_cons[currcons];
> +		vc_cons[currcons].d = vc = alloc_bootmem(sizeof(struct vc_data));
>  		visual_init(vc, currcons, 1);
>  		vc->vc_screenbuf = (unsigned short *)alloc_bootmem(vc->vc_screenbuf_size);
>  		vc->vc_kmalloced = 0;
> @@ -2798,7 +2781,7 @@ void do_blank_screen(int entering_gfx)
>  	}
>  
>  	/* don't blank graphics */
> -	if (vt_cons[vc->vc_num]->vc_mode != KD_TEXT) {
> +	if (vc->vc_mode != KD_TEXT) {
>  		console_blanked = fg_console + 1;
>  		return;
>  	}
> @@ -2845,7 +2828,7 @@ void do_unblank_screen(int leaving_gfx)
>  		return;
>  	}
>  	vc = vc_cons[fg_console].d;
> -	if (vt_cons[vc->vc_num]->vc_mode != KD_TEXT)
> +	if (vc->vc_mode != KD_TEXT)
>  		return; /* but leave console_blanked != 0 */
>  
>  	if (blankinterval) {
> @@ -2896,7 +2879,7 @@ void poke_blanked_console(void)
>  	del_timer(&console_timer);
>  	blank_timer_expired = 0;
>  
> -	if (ignore_poke || !vt_cons[fg_console] || vt_cons[fg_console]->vc_mode == KD_GRAPHICS)
> +	if (ignore_poke || !vc_cons[fg_console].d || vc_cons[fg_console].d->vc_mode == KD_GRAPHICS)
>  		return;
>  	if (console_blanked)
>  		unblank_screen();
> @@ -2914,7 +2897,7 @@ void set_palette(struct vc_data *vc)
>  {
>  	WARN_CONSOLE_UNLOCKED();
>  
> -	if (vt_cons[vc->vc_num]->vc_mode != KD_GRAPHICS)
> +	if (vc->vc_mode != KD_GRAPHICS)
>  		vc->vc_sw->con_set_palette(vc, color_table);
>  }
>  
> @@ -3007,7 +2990,7 @@ int con_font_get(struct vc_data *vc, str
>  	int rc = -EINVAL;
>  	int c;
>  
> -	if (vt_cons[vc->vc_num]->vc_mode != KD_TEXT)
> +	if (vc->vc_mode != KD_TEXT)
>  		return -EINVAL;
>  
>  	if (op->data) {
> @@ -3062,7 +3045,7 @@ int con_font_set(struct vc_data *vc, str
>  	int rc = -EINVAL;
>  	int size;
>  
> -	if (vt_cons[vc->vc_num]->vc_mode != KD_TEXT)
> +	if (vc->vc_mode != KD_TEXT)
>  		return -EINVAL;
>  	if (!op->data)
>  		return -EINVAL;
> @@ -3120,7 +3103,7 @@ int con_font_default(struct vc_data *vc,
>  	char *s = name;
>  	int rc;
>  
> -	if (vt_cons[vc->vc_num]->vc_mode != KD_TEXT)
> +	if (vc->vc_mode != KD_TEXT)
>  		return -EINVAL;
>  
>  	if (!op->data)
> @@ -3148,7 +3131,7 @@ int con_font_copy(struct vc_data *vc, st
>  	int con = op->height;
>  	int rc;
>  
> -	if (vt_cons[vc->vc_num]->vc_mode != KD_TEXT)
> +	if (vc->vc_mode != KD_TEXT)
>  		return -EINVAL;
>  
>  	acquire_console_sem();
> @@ -3260,7 +3243,6 @@ EXPORT_SYMBOL(vc_resize);
>  EXPORT_SYMBOL(fg_console);
>  EXPORT_SYMBOL(console_blank_hook);
>  EXPORT_SYMBOL(console_blanked);
> -EXPORT_SYMBOL(vt_cons);
>  EXPORT_SYMBOL(vc_cons);
>  #ifndef VT_SINGLE_DRIVER
>  EXPORT_SYMBOL(take_over_console);
> Index: linux-2.6-vc/drivers/char/vt_ioctl.c
> ===================================================================
> --- linux-2.6-vc.orig/drivers/char/vt_ioctl.c	2005-01-14 22:15:55.896858073 +0100
> +++ linux-2.6-vc/drivers/char/vt_ioctl.c	2005-01-14 22:18:36.158244696 +0100
> @@ -52,8 +52,6 @@ extern struct tty_driver *console_driver
>   * to the current console is done by the main ioctl code.
>   */
>  
> -struct vt_struct *vt_cons[MAX_NR_CONSOLES];
> -
>  /* Keyboard type: Default is KB_101, but can be set by machine
>   * specific code.
>   */
> @@ -365,8 +363,7 @@ do_unimap_ioctl(int cmd, struct unimapde
>  int vt_ioctl(struct tty_struct *tty, struct file * file,
>  	     unsigned int cmd, unsigned long arg)
>  {
> -	struct vt_struct *vt = (struct vt_struct *)tty->driver_data;
> -	struct vc_data *vc = vc_cons[vt->vc_num].d;
> +	struct vc_data *vc = (struct vc_data *)tty->driver_data;
>  	struct console_font_op op;	/* used in multiple places here */
>  	struct kbd_struct * kbd;
>  	unsigned int console;
> @@ -374,7 +371,7 @@ int vt_ioctl(struct tty_struct *tty, str
>  	void __user *up = (void __user *)arg;
>  	int i, perm;
>  	
> -	console = vt->vc_num;
> +	console = vc->vc_num;
>  
>  	if (!vc_cons_allocated(console)) 	/* impossible? */
>  		return -ENOIOCTLCMD;
> @@ -487,9 +484,9 @@ int vt_ioctl(struct tty_struct *tty, str
>  		default:
>  			return -EINVAL;
>  		}
> -		if (vt_cons[console]->vc_mode == (unsigned char) arg)
> +		if (vc->vc_mode == (unsigned char) arg)
>  			return 0;
> -		vt_cons[console]->vc_mode = (unsigned char) arg;
> +		vc->vc_mode = (unsigned char) arg;
>  		if (console != fg_console)
>  			return 0;
>  		/*
> @@ -504,7 +501,7 @@ int vt_ioctl(struct tty_struct *tty, str
>  		return 0;
>  
>  	case KDGETMODE:
> -		ucval = vt_cons[console]->vc_mode;
> +		ucval = vc->vc_mode;
>  		goto setint;
>  
>  	case KDMAPDISP:
> @@ -667,12 +664,12 @@ int vt_ioctl(struct tty_struct *tty, str
>  		if (tmp.mode != VT_AUTO && tmp.mode != VT_PROCESS)
>  			return -EINVAL;
>  		acquire_console_sem();
> -		vt_cons[console]->vt_mode = tmp;
> +		vc->vt_mode = tmp;
>  		/* the frsig is ignored, so we set it to 0 */
> -		vt_cons[console]->vt_mode.frsig = 0;
> -		vt_cons[console]->vt_pid = current->pid;
> +		vc->vt_mode.frsig = 0;
> +		vc->vt_pid = current->pid;
>  		/* no switch is required -- saw@shade.msu.ru */
> -		vt_cons[console]->vt_newvt = -1; 
> +		vc->vt_newvt = -1; 
>  		release_console_sem();
>  		return 0;
>  	}
> @@ -683,7 +680,7 @@ int vt_ioctl(struct tty_struct *tty, str
>  		int rc;
>  
>  		acquire_console_sem();
> -		memcpy(&tmp, &vt_cons[console]->vt_mode, sizeof(struct vt_mode));
> +		memcpy(&tmp, &vc->vt_mode, sizeof(struct vt_mode));
>  		release_console_sem();
>  
>  		rc = copy_to_user(up, &tmp, sizeof(struct vt_mode));
> @@ -761,31 +758,29 @@ int vt_ioctl(struct tty_struct *tty, str
>  	case VT_RELDISP:
>  		if (!perm)
>  			return -EPERM;
> -		if (vt_cons[console]->vt_mode.mode != VT_PROCESS)
> +		if (vc->vt_mode.mode != VT_PROCESS)
>  			return -EINVAL;
>  
>  		/*
>  		 * Switching-from response
>  		 */
> -		if (vt_cons[console]->vt_newvt >= 0)
> -		{
> +		if (vc->vt_newvt >= 0) {
>  			if (arg == 0)
>  				/*
>  				 * Switch disallowed, so forget we were trying
>  				 * to do it.
>  				 */
> -				vt_cons[console]->vt_newvt = -1;
> +				vc->vt_newvt = -1;
>  
> -			else
> -			{
> +			else {
>  				/*
>  				 * The current vt has been released, so
>  				 * complete the switch.
>  				 */
>  				int newvt;
>  				acquire_console_sem();
> -				newvt = vt_cons[console]->vt_newvt;
> -				vt_cons[console]->vt_newvt = -1;
> +				newvt = vc->vt_newvt;
> +				vc->vt_newvt = -1;
>  				i = vc_allocate(newvt);
>  				if (i) {
>  					release_console_sem();
> @@ -1057,17 +1052,15 @@ int vt_waitactive(int vt)
>  
>  void reset_vc(struct vc_data *vc)
>  {
> -	struct vt_struct *vt = vt_cons[vc->vc_num];
> -
> -	vt->vc_mode = KD_TEXT;
> +	vc->vc_mode = KD_TEXT;
>  	kbd_table[vc->vc_num].kbdmode = VC_XLATE;
> -	vt->vt_mode.mode = VT_AUTO;
> -	vt->vt_mode.waitv = 0;
> -	vt->vt_mode.relsig = 0;
> -	vt->vt_mode.acqsig = 0;
> -	vt->vt_mode.frsig = 0;
> -	vt->vt_pid = -1;
> -	vt->vt_newvt = -1;
> +	vc->vt_mode.mode = VT_AUTO;
> +	vc->vt_mode.waitv = 0;
> +	vc->vt_mode.relsig = 0;
> +	vc->vt_mode.acqsig = 0;
> +	vc->vt_mode.frsig = 0;
> +	vc->vt_pid = -1;
> +	vc->vt_newvt = -1;
>  	if (!in_interrupt())    /* Via keyboard.c:SAK() - akpm */
>  		reset_palette(vc);
>  }
> @@ -1077,7 +1070,6 @@ void reset_vc(struct vc_data *vc)
>   */
>  void complete_change_console(struct vc_data *vc)
>  {
> -	unsigned int new_console = vc->vc_num;
>  	unsigned char old_vc_mode;
>  
>  	last_console = fg_console;
> @@ -1087,7 +1079,7 @@ void complete_change_console(struct vc_d
>  	 * KD_TEXT mode or vice versa, which means we need to blank or
>  	 * unblank the screen later.
>  	 */
> -	old_vc_mode = vt_cons[fg_console]->vc_mode;
> +	old_vc_mode = vc_cons[fg_console].d->vc_mode;
>  	switch_screen(vc);
>  
>  	/*
> @@ -1100,9 +1092,8 @@ void complete_change_console(struct vc_d
>  	 * To account for this we duplicate this code below only if the
>  	 * controlling process is gone and we've called reset_vc.
>  	 */
> -	if (old_vc_mode != vt_cons[new_console]->vc_mode)
> -	{
> -		if (vt_cons[new_console]->vc_mode == KD_TEXT)
> +	if (old_vc_mode != vc->vc_mode) {
> +		if (vc->vc_mode == KD_TEXT)
>  			do_unblank_screen(1);
>  		else
>  			do_blank_screen(1);
> @@ -1113,17 +1104,13 @@ void complete_change_console(struct vc_d
>  	 * telling it that it has acquired. Also check if it has died and
>  	 * clean up (similar to logic employed in change_console())
>  	 */
> -	if (vt_cons[new_console]->vt_mode.mode == VT_PROCESS)
> -	{
> +	if (vc->vt_mode.mode == VT_PROCESS) {
>  		/*
>  		 * Send the signal as privileged - kill_proc() will
>  		 * tell us if the process has gone or something else
>  		 * is awry
>  		 */
> -		if (kill_proc(vt_cons[new_console]->vt_pid,
> -			      vt_cons[new_console]->vt_mode.acqsig,
> -			      1) != 0)
> -		{
> +		if (kill_proc(vc->vt_pid, vc->vt_mode.acqsig, 1) != 0) {
>  		/*
>  		 * The controlling process has died, so we revert back to
>  		 * normal operation. In this case, we'll also change back
> @@ -1135,9 +1122,8 @@ void complete_change_console(struct vc_d
>  		 */
>  			reset_vc(vc);
>  
> -			if (old_vc_mode != vt_cons[new_console]->vc_mode)
> -			{
> -				if (vt_cons[new_console]->vc_mode == KD_TEXT)
> +			if (old_vc_mode != vc->vc_mode) {
> +				if (vc->vc_mode == KD_TEXT)
>  					do_unblank_screen(1);
>  				else
>  					do_blank_screen(1);
> @@ -1157,6 +1143,8 @@ void complete_change_console(struct vc_d
>   */
>  void change_console(struct vc_data *new_vc)
>  {
> +	struct vc_data *vc;
> +
>  	if (!new_vc || new_vc->vc_num == fg_console || vt_dont_switch)
>  		return;
>  
> @@ -1175,23 +1163,20 @@ void change_console(struct vc_data *new_
>  	 * the user waits just the right amount of time :-) and revert the
>  	 * vt to auto control.
>  	 */
> -	if (vt_cons[fg_console]->vt_mode.mode == VT_PROCESS)
> -	{
> +	vc = vc_cons[fg_console].d;
> +	if (vc->vt_mode.mode == VT_PROCESS) {
>  		/*
>  		 * Send the signal as privileged - kill_proc() will
>  		 * tell us if the process has gone or something else
>  		 * is awry
>  		 */
> -		if (kill_proc(vt_cons[fg_console]->vt_pid,
> -			      vt_cons[fg_console]->vt_mode.relsig,
> -			      1) == 0)
> -		{
> +		if (kill_proc(vc->vt_pid, vc->vt_mode.relsig, 1) == 0) {
>  			/*
>  			 * It worked. Mark the vt to switch to and
>  			 * return. The process needs to send us a
>  			 * VT_RELDISP ioctl to complete the switch.
>  			 */
> -			vt_cons[fg_console]->vt_newvt = new_vc->vc_num;
> +			vc->vt_newvt = new_vc->vc_num;
>  			return;
>  		}
>  
> @@ -1204,7 +1189,7 @@ void change_console(struct vc_data *new_
>  		 * this outside of VT_PROCESS but there is no single process
>  		 * to account for and tracking tty count may be undesirable.
>  		 */
> -		reset_vc(vc_cons[fg_console].d);
> +		reset_vc(vc);
>  
>  		/*
>  		 * Fall through to normal (VT_AUTO) handling of the switch...
> @@ -1214,7 +1199,7 @@ void change_console(struct vc_data *new_
>  	/*
>  	 * Ignore all switches in KD_GRAPHICS+VT_AUTO mode
>  	 */
> -	if (vt_cons[fg_console]->vc_mode == KD_GRAPHICS)
> +	if (vc->vc_mode == KD_GRAPHICS)
>  		return;
>  
>  	complete_change_console(new_vc);
> Index: linux-2.6-vc/drivers/video/console/fbcon.c
> ===================================================================
> --- linux-2.6-vc.orig/drivers/video/console/fbcon.c	2005-01-14 22:15:55.899857556 +0100
> +++ linux-2.6-vc/drivers/video/console/fbcon.c	2005-01-14 22:18:36.159244523 +0100
> @@ -203,7 +203,7 @@ static irqreturn_t fb_vbl_detect(int irq
>  static inline int fbcon_is_inactive(struct vc_data *vc, struct fb_info *info)
>  {
>  	return (info->state != FBINFO_STATE_RUNNING ||
> -		vt_cons[vc->vc_num]->vc_mode != KD_TEXT);
> +		vc->vc_mode != KD_TEXT);
>  }
>  
>  static inline int get_color(struct vc_data *vc, struct fb_info *info,
> @@ -456,7 +456,7 @@ static void fbcon_prepare_logo(struct vc
>  		    erase,
>  		    vc->vc_size_row * logo_lines);
>  
> -	if (CON_IS_VISIBLE(vc) && vt_cons[vc->vc_num]->vc_mode == KD_TEXT) {
> +	if (CON_IS_VISIBLE(vc) && vc->vc_mode == KD_TEXT) {
>  		fbcon_clear_margins(vc, 0);
>  		update_screen(vc);
>  	}
> @@ -2209,7 +2209,7 @@ static int fbcon_do_set_font(struct vc_d
>  			}
>  		}
>  	} else if (CON_IS_VISIBLE(vc)
> -		   && vt_cons[vc->vc_num]->vc_mode == KD_TEXT) {
> +		   && vc->vc_mode == KD_TEXT) {
>  		fbcon_clear_margins(vc, 0);
>  		update_screen(vc);
>  	}
> @@ -2436,7 +2436,7 @@ static int fbcon_scrolldelta(struct vc_d
>  	if (softback_top) {
>  		if (vc->vc_num != fg_console)
>  			return 0;
> -		if (vt_cons[vc->vc_num]->vc_mode != KD_TEXT || !lines)
> +		if (vc->vc_mode != KD_TEXT || !lines)
>  			return 0;
>  		if (logo_shown >= 0) {
>  			struct vc_data *conp2 = vc_cons[logo_shown].d;
> @@ -2553,11 +2553,11 @@ static void fbcon_modechanged(struct fb_
>  	struct display *p;
>  	int rows, cols;
>  
> -	if (!ops || ops->currcon < 0 || vt_cons[ops->currcon]->vc_mode !=
> -	    KD_TEXT || registered_fb[con2fb_map[ops->currcon]] != info)
> +	if (!ops || ops->currcon < 0)
>  		return;
> -
>  	vc = vc_cons[ops->currcon].d;
> +	if (vc->vc_mode != KD_TEXT || registered_fb[con2fb_map[ops->currcon]] != info)
> +		return;
>  
>  	p = &fb_display[vc->vc_num];
>  
> @@ -2639,26 +2639,20 @@ static int fbcon_fb_registered(int idx)
>  static void fbcon_fb_blanked(struct fb_info *info, int blank)
>  {
>  	struct fbcon_ops *ops = info->fbcon_par;
> -	int valid = 1;
> -
> -	if (!ops || ops->currcon < 0 ||
> -	    vt_cons[ops->currcon]->vc_mode != KD_TEXT ||
> -	    registered_fb[con2fb_map[ops->currcon]] != info)
> -		valid = 0;
> -
> -	if (valid) {
> -		struct vc_data *vc;
> -
> -		vc = vc_cons[ops->currcon].d;
> +	struct vc_data *vc;
>  
> -		if (CON_IS_VISIBLE(vc)) {
> -			ops->blank_state = blank;
> +	if (!ops || ops->currcon < 0)
> +		return;
> +	vc = vc_cons[ops->currcon].d;
> +	if (vc->vc_mode == KD_TEXT &&
> +	    registered_fb[con2fb_map[ops->currcon]] == info &&
> +	    CON_IS_VISIBLE(vc)) {
> +		ops->blank_state = blank;
>  
> -			if (blank)
> -				do_blank_screen(0);
> -			else
> -				do_unblank_screen(0);
> -		}
> +		if (blank)
> +			do_blank_screen(0);
> +		else
> +			do_unblank_screen(0);
>  	}
>  }
>  
> Index: linux-2.6-vc/drivers/video/console/sticon.c
> ===================================================================
> --- linux-2.6-vc.orig/drivers/video/console/sticon.c	2005-01-14 22:15:55.901857212 +0100
> +++ linux-2.6-vc/drivers/video/console/sticon.c	2005-01-14 22:18:36.159244523 +0100
> @@ -87,13 +87,12 @@ static int sticon_set_palette(struct vc_
>  
>  static void sticon_putc(struct vc_data *conp, int c, int ypos, int xpos)
>  {
> -    int unit = conp->vc_num;
>      int redraw_cursor = 0;
>  
>      if (vga_is_gfx || console_blanked)
>  	    return;
> -	    
> -    if (vt_cons[unit]->vc_mode != KD_TEXT)
> +
> +    if (conp->vc_mode != KD_TEXT)
>      	    return;
>  #if 0
>      if ((p->cursor_x == xpos) && (p->cursor_y == ypos)) {
> @@ -111,15 +110,14 @@ static void sticon_putc(struct vc_data *
>  static void sticon_putcs(struct vc_data *conp, const unsigned short *s,
>  			 int count, int ypos, int xpos)
>  {
> -    int unit = conp->vc_num;
>      int redraw_cursor = 0;
>  
>      if (vga_is_gfx || console_blanked)
>  	    return;
>  
> -    if (vt_cons[unit]->vc_mode != KD_TEXT)
> +    if (conp->vc_mode != KD_TEXT)
>      	    return;
> -    
> +
>  #if 0
>      if ((p->cursor_y == ypos) && (xpos <= p->cursor_x) &&
>  	(p->cursor_x < (xpos + count))) {
> Index: linux-2.6-vc/drivers/video/sun3fb.c
> ===================================================================
> --- linux-2.6-vc.orig/drivers/video/sun3fb.c	2005-01-14 22:12:13.401194838 +0100
> +++ linux-2.6-vc/drivers/video/sun3fb.c	2005-01-14 22:18:36.160244351 +0100
> @@ -505,7 +505,7 @@ void sun3fb_palette(int enter)
>  			if (fb->restore_palette) {
>  				if (enter)
>  					fb->restore_palette(fb);
> -				else if (vt_cons[i]->vc_mode != KD_GRAPHICS)
> +				else if (vc_cons[i].d->vc_mode != KD_GRAPHICS)
>  				         vc_cons[i].d->vc_sw->con_set_palette(vc_cons[i].d, color_table);
>  			}
>  		}
> Index: linux-2.6-vc/fs/compat_ioctl.c
> ===================================================================
> --- linux-2.6-vc.orig/fs/compat_ioctl.c	2005-01-14 22:15:55.903856867 +0100
> +++ linux-2.6-vc/fs/compat_ioctl.c	2005-01-14 22:18:36.161244179 +0100
> @@ -1650,7 +1650,7 @@ static int do_kdfontop_ioctl(unsigned in
>  	struct console_font_op op;
>  	struct console_font_op32 __user *fontop = compat_ptr(arg);
>  	int perm = vt_check(file), i;
> -	struct vt_struct *vt;
> +	struct vc_data *vc;
>  	
>  	if (perm < 0) return perm;
>  	
> @@ -1660,9 +1660,10 @@ static int do_kdfontop_ioctl(unsigned in
>  		return -EPERM;
>  	op.data = compat_ptr(((struct console_font_op32 *)&op)->data);
>  	op.flags |= KD_FONT_FLAG_OLD;
> -	vt = (struct vt_struct *)((struct tty_struct *)file->private_data)->driver_data;
> -	i = con_font_op(vc_cons[vt->vc_num].d, &op);
> -	if (i) return i;
> +	vc = ((struct tty_struct *)file->private_data)->driver_data;
> +	i = con_font_op(vc, &op);
> +	if (i)
> +		return i;
>  	((struct console_font_op32 *)&op)->data = (unsigned long)op.data;
>  	if (copy_to_user(fontop, &op, sizeof(struct console_font_op32)))
>  		return -EFAULT;
> Index: linux-2.6-vc/include/linux/console_struct.h
> ===================================================================
> --- linux-2.6-vc.orig/include/linux/console_struct.h	2005-01-14 22:12:13.401194838 +0100
> +++ linux-2.6-vc/include/linux/console_struct.h	2005-01-14 22:18:36.161244179 +0100
> @@ -26,6 +26,7 @@ struct vc_data {
>  	const struct consw *vc_sw;
>  	unsigned short	*vc_screenbuf;		/* In-memory character/attribute buffer */
>  	unsigned int	vc_screenbuf_size;
> +	unsigned char	vc_mode;		/* KD_TEXT, ... */
>  	/* attributes for all characters on screen */
>  	unsigned char	vc_attr;		/* Current attributes */
>  	unsigned char	vc_def_color;		/* Default colors */
> @@ -48,6 +49,11 @@ struct vc_data {
>  	unsigned int	vc_state;		/* Escape sequence parser state */
>  	unsigned int	vc_npar,vc_par[NPAR];	/* Parameters of current escape sequence */
>  	struct tty_struct *vc_tty;		/* TTY we are attached to */
> +	/* data for manual vt switching */
> +	struct vt_mode	vt_mode;
> +	int		vt_pid;
> +	int		vt_newvt;
> +	wait_queue_head_t paste_wait;
>  	/* mode flags */
>  	unsigned int	vc_charset	: 1;	/* Character set G0 / G1 */
>  	unsigned int	vc_s_charset	: 1;	/* Saved character set */
> @@ -89,7 +95,6 @@ struct vc_data {
>  	struct vc_data **vc_display_fg;		/* [!] Ptr to var holding fg console for this display */
>  	unsigned long	vc_uni_pagedir;
>  	unsigned long	*vc_uni_pagedir_loc;  /* [!] Location of uni_pagedir variable for this console */
> -	struct vt_struct *vc_vt;
>  	/* additional information is in vt_kern.h */
>  };
>  
> Index: linux-2.6-vc/include/linux/vt_kern.h
> ===================================================================
> --- linux-2.6-vc.orig/include/linux/vt_kern.h	2005-01-14 22:15:55.895858245 +0100
> +++ linux-2.6-vc/include/linux/vt_kern.h	2005-01-14 22:18:36.162244007 +0100
> @@ -25,15 +25,6 @@
>  #define BROKEN_GRAPHICS_PROGRAMS 1
>  #endif
>  
> -extern struct vt_struct {
> -	int vc_num;				/* The console number */
> -	unsigned char	vc_mode;		/* KD_TEXT, ... */
> -	struct vt_mode	vt_mode;
> -	int		vt_pid;
> -	int		vt_newvt;
> -	wait_queue_head_t paste_wait;
> -} *vt_cons[MAX_NR_CONSOLES];
> -
>  extern void kd_mksound(unsigned int hz, unsigned int ticks);
>  extern int kbd_rate(struct kbd_repeat *rep);
>  
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
