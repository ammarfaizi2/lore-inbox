Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264265AbUARXX5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jan 2004 18:23:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264275AbUARXX4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jan 2004 18:23:56 -0500
Received: from pacific.moreton.com.au ([203.143.235.130]:13834 "EHLO
	dorfl.internal.moreton.com.au") by vger.kernel.org with ESMTP
	id S264265AbUARXXw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jan 2004 18:23:52 -0500
Message-ID: <400B156F.3050508@snapgear.com>
Date: Mon, 19 Jan 2004 09:23:27 +1000
From: Greg Ungerer <gerg@snapgear.com>
Organization: SnapGear
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Russell King <rmk+lkml@arm.linux.org.uk>
CC: linux-kernel@vger.kernel.org
Subject: Re: [2/3]
References: <Pine.LNX.4.44.0401131148070.18661-100000@eloth> <20040113113650.A2975@flint.arm.linux.org.uk> <20040113114948.B2975@flint.arm.linux.org.uk> <20040113171544.B7256@flint.arm.linux.org.uk> <20040113173352.D7256@flint.arm.linux.org.uk> <400A7F55.9060209@snapgear.com> <20040118154223.F19593@flint.arm.linux.org.uk>
In-Reply-To: <20040118154223.F19593@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Russel,

Russell King wrote:
> On Sun, Jan 18, 2004 at 10:43:01PM +1000, Greg Ungerer wrote:
>>Looks good for mcfserial.c. The only additional change I would
>>make is to remove the "rts", "dtr", and "val" variables from the
>>ioctl function - removing the TIOCM* cases means these variables
>>are no longer used.
> 
> 
> I agree for "rts" and "dtr", however "val" is still used - in
> TIOC[SG]ET422.  Here's a new patch for mcfserial.c

Oops, your right. This new patch looks good.

Regards
Greg



> ===== drivers/serial/mcfserial.c 1.17 vs edited =====
> --- 1.17/drivers/serial/mcfserial.c	Thu Jul  3 02:18:07 2003
> +++ edited/drivers/serial/mcfserial.c	Sun Jan 18 15:40:39 2004
> @@ -985,13 +985,49 @@
>  	local_irq_restore(flags);
>  }
>  
> +static int mcfrs_tiocmget(struct tty_struct *tty, struct file *file)
> +{
> +	struct mcf_serial * info = (struct mcf_serial *)tty->driver_data;
> +
> +	if (serial_paranoia_check(info, tty->name, __FUNCTION__))
> +		return -ENODEV;
> +	if (tty->flags & (1 << TTY_IO_ERROR))
> +		return -EIO;
> +
> +	return mcfrs_getsignals(info);
> +}
> +
> +static int mcfrs_tiocmset(struct tty_struct *tty, struct file *file,
> +			  unsigned int set, unsigned int clear)
> +{
> +	struct mcf_serial * info = (struct mcf_serial *)tty->driver_data;
> +	int rts = -1, dtr = -1;
> +
> +	if (serial_paranoia_check(info, tty->name, __FUNCTION__))
> +		return -ENODEV;
> +	if (tty->flags & (1 << TTY_IO_ERROR))
> +		return -EIO;
> +
> +	if (set & TIOCM_RTS)
> +		rts = 1;
> +	if (set & TIOCM_DTR)
> +		dtr = 1;
> +	if (clear & TIOCM_RTS)
> +		rts = 0;
> +	if (clear & TIOCM_DTR)
> +		dtr = 0;
> +
> +	mcfrs_setsignals(info, dtr, rts);
> +
> +	return 0;
> +}
> +
>  static int mcfrs_ioctl(struct tty_struct *tty, struct file * file,
>  		    unsigned int cmd, unsigned long arg)
>  {
>  	struct mcf_serial * info = (struct mcf_serial *)tty->driver_data;
>  	unsigned int val;
>  	int retval, error;
> -	int dtr, rts;
>  
>  	if (serial_paranoia_check(info, tty->name, "mcfrs_ioctl"))
>  		return -ENODEV;
> @@ -1059,45 +1095,6 @@
>  				    info, sizeof(struct mcf_serial));
>  			return 0;
>  			
> -		case TIOCMGET:
> -			if ((error = verify_area(VERIFY_WRITE, (void *) arg,
> -                            sizeof(unsigned int))))
> -                                return(error);
> -			val = mcfrs_getsignals(info);
> -			put_user(val, (unsigned int *) arg);
> -			break;
> -
> -                case TIOCMBIS:
> -			if ((error = verify_area(VERIFY_WRITE, (void *) arg,
> -                            sizeof(unsigned int))))
> -				return(error);
> -
> -			get_user(val, (unsigned int *) arg);
> -			rts = (val & TIOCM_RTS) ? 1 : -1;
> -			dtr = (val & TIOCM_DTR) ? 1 : -1;
> -			mcfrs_setsignals(info, dtr, rts);
> -			break;
> -
> -                case TIOCMBIC:
> -			if ((error = verify_area(VERIFY_WRITE, (void *) arg,
> -                            sizeof(unsigned int))))
> -				return(error);
> -			get_user(val, (unsigned int *) arg);
> -			rts = (val & TIOCM_RTS) ? 0 : -1;
> -			dtr = (val & TIOCM_DTR) ? 0 : -1;
> -			mcfrs_setsignals(info, dtr, rts);
> -			break;
> -
> -                case TIOCMSET:
> -			if ((error = verify_area(VERIFY_WRITE, (void *) arg,
> -                            sizeof(unsigned int))))
> -				return(error);
> -			get_user(val, (unsigned int *) arg);
> -			rts = (val & TIOCM_RTS) ? 1 : 0;
> -			dtr = (val & TIOCM_DTR) ? 1 : 0;
> -			mcfrs_setsignals(info, dtr, rts);
> -			break;
> -
>  #ifdef TIOCSET422
>  		case TIOCSET422:
>  			get_user(val, (unsigned int *) arg);
> @@ -1563,6 +1560,8 @@
>  	.start = mcfrs_start,
>  	.hangup = mcfrs_hangup,
>  	.read_proc = mcfrs_readproc,
> +	.tiocmget = mcfrs_tiocmget,
> +	.tiocmset = mcfrs_tiocmset,
>  };
>  
>  /* mcfrs_init inits the driver */
> 
> 

-- 
------------------------------------------------------------------------
Greg Ungerer  --  Chief Software Dude       EMAIL:     gerg@snapgear.com
SnapGear -- a CyberGuard Company            PHONE:       +61 7 3435 2888
825 Stanley St,                             FAX:         +61 7 3891 3630
Woolloongabba, QLD, 4102, Australia         WEB: http://www.SnapGear.com

