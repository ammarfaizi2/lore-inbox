Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263449AbTFTQvj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jun 2003 12:51:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263428AbTFTQts
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jun 2003 12:49:48 -0400
Received: from pcp701542pcs.bowie01.md.comcast.net ([68.50.82.18]:63503 "EHLO
	lucifer.gotontheinter.net") by vger.kernel.org with ESMTP
	id S263458AbTFTQtE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jun 2003 12:49:04 -0400
Subject: Re: [PATCH] to "Disable Trackpad while typing" patch
From: Disconnect <kernel@gotontheinter.net>
To: Torsten Foertsch <torsten.foertsch@gmx.net>
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <200306201818.40805.torsten.foertsch@gmx.net>
References: <200306201818.40805.torsten.foertsch@gmx.net>
Content-Type: text/plain; charset=ISO-8859-1
Message-Id: <1056128080.17756.38.camel@slappy>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.3.92 (Preview Release)
Date: 20 Jun 2003 12:54:40 -0400
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is this a patch against a patch (instead of against modified pc_keyb.c)
or did the mailer just chew it up badly?

That is exactly the problem I had with that patch; what are the chances
of resending it as an attachment, patched against the modified
pc_keyb.c?  That'd seriously speed its integration with -dis5 ;)

On Fri, 2003-06-20 at 12:18, Torsten Foertsch wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> see http://marc.theaimsgroup.com/?l=linux-kernel&m=105182586512456&w=2
> 
> I have encountered problems with that patch. If the mouse is sending events 
> while the delay timeout is being reached X11 reports spurious mouse events. 
> I.e. you are moving the mouse continuously after hitting a key. My mouse 
> often jumps to the right upper corner of the screen and reports some clicks 
> there.
> 
> Mouse events consist of sequences of 3-4 bytes (normal PS/2 mouses 3 bytes, 
> wheel mouses 4 bytes) see
>   http://panda.cs.ndsu.nodak.edu/%7Eachapwes/PICmicro/mouse/mouse.html
> 
> But with the original patch the first accepted bytes after the timeout can be 
> out of that order. So, X11 reads the 2nd or 3rd byte of the actual mouse 
> movement as 1st byte.
> 
> The patch below implements 2 solutions for the problem:
> 
> 1. If TRACKPAD_RESET_IF_ACTIVITY_DURING_DELAY is defined it sends a RESET 
> command to the mouse after the timeout if there were mouse events during the 
> delay interval.
> 
> 2. If TRACKPAD_RESET_IF_ACTIVITY_DURING_DELAY is not defined it skips chunks 
> of 3*4=12 bytes of mouse input.
> 
> I am not certain what the "right" solution is. Case 2 is the better one in my 
> opinion because after a RESET even a wheel mouse will be in "normal" mode 
> sending 3 bytes per event. Further case 2 seems to be more responsive.
> 
> Torsten
> 
> - --- drivers/char/pc_keyb.c.orig	2003-06-20 08:10:41.000000000 +0000
> +++ drivers/char/pc_keyb.c	2003-06-20 15:45:01.000000000 +0000
> @@ -18,6 +18,9 @@
>   * notebooks with a PS/2 trackpad.
>   * Hans-Georg Thien <1682-600@onlinehome.de> 2003-04-30.
>   *
> + * Improvements to the "disable trackpad while typing" feature.
> + * Torsten Förtsch <torsten.foertsch@gmx.net> 2003-06-20.
> + *
>   */
>  
>  #include <linux/config.h>
> @@ -109,6 +112,11 @@
>  
>  #ifdef CONFIG_DISABLE_TRACKPAD_WHILE_TYPING
>  
> +# ifdef TRACKPAD_RESET_IF_ACTIVITY_DURING_DELAY
> +static int trackpad_activity_during_delay = 0;
> +# else
> +static int trackpad_skipped_events = 0;
> +# endif
>  static int last_kbd_event = 0;     /* timestamp of last kbd event */
>  static int last_kbd_scancode = 0; 
>  static int trackpad_disable = 0;
> @@ -566,7 +574,12 @@
>  		mouse_reply_expected = 0;
>  	}
>  	else if(scancode == AUX_RECONNECT2 && prev_code == AUX_RECONNECT1
> - -		&& aux_reconnect) {
> +# ifdef TRACKPAD_RESET_IF_ACTIVITY_DURING_DELAY
> +		&& (aux_reconnect||trackpad_activity_during_delay)
> +# else
> +		&& aux_reconnect
> +# endif
> +		) {
>  		printk (KERN_INFO "PS/2 mouse reconnect detected\n");
>  		queue->head = queue->tail = 0;	/* Flush input queue */
>  		__aux_write_ack(AUX_ENABLE_DEV);  /* ping the mouse :) */
> @@ -577,8 +590,25 @@
>          if (trackpad_disable) return;
>  
>          if (!test_bit(last_kbd_scancode, trackpad_escape)) {
> - -                  /* do nothing if time since last kbd event is less then 
> trackpad_delay */
> - -                  if (abs(jiffies - last_kbd_event) < trackpad_delay) return;
> +	  /* do nothing if time since last kbd event is less then trackpad_delay */
> +# ifdef TRACKPAD_RESET_IF_ACTIVITY_DURING_DELAY
> +	  if (abs(jiffies - last_kbd_event) < trackpad_delay) {
> +	    trackpad_activity_during_delay=1;
> +	    return;
> +	  }
> +	  if( trackpad_activity_during_delay ) {
> +	    trackpad_activity_during_delay=0;
> +	    aux_write_ack(AUX_RESET);
> +	    return;
> +	  }
> +# else
> +	  if (abs(jiffies - last_kbd_event) < trackpad_delay ||
> +	      trackpad_skipped_events%12) {
> +	    trackpad_skipped_events++;
> +	    return;
> +	  }
> +	  trackpad_skipped_events=0;
> +# endif
>          }
>  #endif
>  
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.0.7 (GNU/Linux)
> 
> iD8DBQE+8zPgwicyCTir8T4RAnK4AJ47UCVKgWHl9lBCbgXxTQFa96wkhgCfSxLj
> g4kfxOe+q3hpCzaqkm4m2Cg=
> =8/AI
> -----END PGP SIGNATURE-----
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

