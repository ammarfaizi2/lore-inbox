Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316591AbSFKAb4>; Mon, 10 Jun 2002 20:31:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316588AbSFKAb4>; Mon, 10 Jun 2002 20:31:56 -0400
Received: from 12-224-36-73.client.attbi.com ([12.224.36.73]:30216 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S316587AbSFKAbx>;
	Mon, 10 Jun 2002 20:31:53 -0400
Date: Mon, 10 Jun 2002 17:28:11 -0700
From: Greg KH <greg@kroah.com>
To: Dawson Engler <engler@csl.Stanford.EDU>
Cc: linux-kernel@vger.kernel.org, mc@cs.Stanford.EDU
Subject: Re: [CHECKER] 36 missing return code checks in 2.4.17
Message-ID: <20020611002811.GE5202@kroah.com>
In-Reply-To: <200206100354.UAA17024@csl.Stanford.EDU>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.2.21 (i586)
Reply-By: Mon, 13 May 2002 22:08:53 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 09, 2002 at 08:54:44PM -0700, Dawson Engler wrote:
> ---------------------------------------------------------
> [BUG] usb_control_msg calls kmalloc, which can fail.
> /u2/engler/mc/oses/linux/2.4.17/drivers/usb/serial/keyspan_pda.c:355:keyspan_pda_break_ctl: ERROR:CHECK_ERR: ignored call 'usb_control_msg' [COUNTER=usb_control_msg] [fit=2] [fit_fn=1] [fn_ex=0] [fn_counter=1] [ex=165] [counter=3] [z = 1.91157927859293] [fn-z = -4.35889894354067]
> 	else
> 		value = 0; /* clear break */
> 	usb_control_msg(serial->dev, usb_sndctrlpipe(serial->dev, 0),
> 			4, /* set break */
> 			USB_TYPE_VENDOR | USB_RECIP_INTERFACE | USB_DIR_OUT,
> 
> Error --->
> 			value, 0, NULL, 0, 2*HZ);
> 	/* there is something funky about this.. the TCSBRK that 'cu' performs
> 	   ought to translate into a break_ctl(-1),break_ctl(0) pair HZ/4
> 	   seconds apart, but it feels like the break sent isn't as long as it
> ---------------------------------------------------------

Good catch, I'll fix this.

> [BUG]
> /u2/engler/mc/oses/linux/2.4.17/drivers/usb/serial/keyspan_pda.c:218:keyspan_pda_request_unthrottle: ERROR:CHECK_ERR: ignored call 'usb_control_msg' [COUNTER=usb_control_msg] [fit=2] [fit_fn=2] [fn_ex=0] [fn_counter=1] [ex=165] [counter=3] [z = 1.91157927859293] [fn-z = -4.35889894354067]
> 			     | USB_DIR_OUT,
> 			     16, /* value: threshold */
> 			     0, /* index */
> 			     NULL,
> 			     0,
> 
> Error --->
> 			     2*HZ);
> 	MOD_DEC_USE_COUNT;
> }
> 
> ---------------------------------------------------------

Again, I'll fix this.

> [BUG]
> /u2/engler/mc/oses/linux/2.4.17/drivers/usb/serial/ftdi_sio.c:342:ftdi_sio_open: ERROR:CHECK_ERR: ignored call 'usb_control_msg' [COUNTER=usb_control_msg] [fit=2] [fit_fn=3] [fn_ex=0] [fn_counter=1] [ex=165] [counter=3] [z = 1.91157927859293] [fn-z = -4.35889894354067]
> 		/* No error checking for this (will get errors later anyway) */
> 		/* See ftdi_sio.h for description of what is reset */
> 		usb_control_msg(serial->dev, usb_sndctrlpipe(serial->dev, 0),
> 				FTDI_SIO_RESET_REQUEST, FTDI_SIO_RESET_REQUEST_TYPE, 
> 				FTDI_SIO_RESET_SIO, 
> 
> Error --->
> 				0, buf, 0, WDR_TIMEOUT);
> 
> 		/* Setup termios defaults. According to tty_io.c the 
> 		   settings are driver specific */
> ---------------------------------------------------------

Not a problem (see the comment)

> ---------------------------------------------------------
> [BUG] 133 checks can't be wrong.
> /u2/engler/mc/oses/linux/2.4.17/drivers/usb/printer.c:432:usblp_write: ERROR:CHECK_ERR: ignored call 'usb_submit_urb' [COUNTER=usb_submit_urb] [fit=6] [fit_fn=1] [fn_ex=0] [fn_counter=1] [ex=133] [counter=3] [z = 1.4950900031928] [fn-z = -4.35889894354067]
> 
> 		if (copy_from_user(usblp->writeurb.transfer_buffer, buffer + writecount,
> 				usblp->writeurb.transfer_buffer_length)) return -EFAULT;
> 
> 		usblp->writeurb.dev = usblp->dev;
> 
> Error --->
> 		usb_submit_urb(&usblp->writeurb);
> 		up (&usblp->sem);
> 	}
> 
> ---------------------------------------------------------

I'll fix this too.

> [BUG] can they?
> /u2/engler/mc/oses/linux/2.4.17/drivers/usb/printer.c:482:usblp_read: ERROR:CHECK_ERR: ignored call 'usb_submit_urb' [COUNTER=usb_submit_urb] [fit=6] [fit_fn=2] [fn_ex=0] [fn_counter=2] [ex=133] [counter=3] [z = 1.4950900031928] [fn-z = -6.16441400296897]
> 	if (usblp->readurb.status) {
> 		err("usblp%d: error %d reading from printer",
> 			usblp->minor, usblp->readurb.status);
> 		usblp->readurb.dev = usblp->dev;
>  		usblp->readcount = 0;
> 
> Error --->
> 		usb_submit_urb(&usblp->readurb);
> 		count = -EIO;
> 		goto done;
> 	}
> ---------------------------------------------------------

Again, this should be fixed.

> [BUG] probable bug.
> /u2/engler/mc/oses/linux/2.4.17/drivers/usb/printer.c:498:usblp_read: ERROR:CHECK_ERR: ignored call 'usb_submit_urb' [COUNTER=usb_submit_urb] [fit=6] [fit_fn=2] [fn_ex=0] [fn_counter=2] [ex=133] [counter=3] [z = 1.4950900031928] [fn-z = -6.16441400296897]
> 	}
> 
> 	if ((usblp->readcount += count) == usblp->readurb.actual_length) {
> 		usblp->readcount = 0;
> 		usblp->readurb.dev = usblp->dev;
> 
> Error --->
> 		usb_submit_urb(&usblp->readurb);
> 	}
> 
> done:
> ---------------------------------------------------------

And finally, I'll fix this one too.

Thanks for finding these, potential problems.

greg k-h
