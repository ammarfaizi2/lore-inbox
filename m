Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263577AbUCYTle (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Mar 2004 14:41:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263591AbUCYTle
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Mar 2004 14:41:34 -0500
Received: from h190n2fls306o1003.telia.com ([81.224.179.190]:10987 "EHLO
	Athlon1.hemma.se") by vger.kernel.org with ESMTP id S263577AbUCYTl3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Mar 2004 14:41:29 -0500
Message-ID: <406335BB.1050601@am.chalmers.se>
Date: Thu, 25 Mar 2004 20:40:43 +0100
From: Thomas Svedberg <thsv@am.chalmers.se>
User-Agent: Mozilla Thunderbird 0.5+ (X11/20040309)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: eric.valette@free.fr
Cc: akpm@osdl.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.5-rc2-mm2 still does not boot but it progress : seems to
 be console font related
References: <406172C9.8000706@free.fr> <406302A9.8030805@am.chalmers.se> <40630BC0.2090807@free.fr>
In-Reply-To: <40630BC0.2090807@free.fr>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric Valette wrote:
> Thomas Svedberg wrote:
> 
>> I have these hangs as well, just tried 2.6.5-rc2-mm3 and they are 
>> still there.
>> However setting video=radeonfb:off as boot parameter solves the 
>> problem, if this can be of any help.
>> More info on request.
> 
> 
> Yes because the console-screen.sh shell script checks for /dev/fb. Could 
> you try the patceh suggested by Andrew in this thread (I'm not sure it 
> is in mm3). I attached it for your convenience.

I must have missed it, an yes it fixes the problem.
(I tried it on top of -mm3)

/Thomas

> 
> ------------------------------------------------------------------------
> 
> diff -puN drivers/char/vt.c~a drivers/char/vt.c
> --- 25/drivers/char/vt.c~a	2004-03-24 09:49:10.285591688 -0800
> +++ 25-akpm/drivers/char/vt.c	2004-03-24 09:50:54.355770616 -0800
> @@ -2471,10 +2471,13 @@ static int con_open(struct tty_struct *t
>  				tty->winsize.ws_row = video_num_lines;
>  				tty->winsize.ws_col = video_num_columns;
>  			}
> +			release_console_sem();
>  			vcs_make_devfs(tty);
> +			goto out;
>  		}
>  	}
>  	release_console_sem();
> +out:
>  	return ret;
>  }
>  
> @@ -2484,11 +2487,13 @@ static void con_close(struct tty_struct 
>  	if (tty && tty->count == 1) {
>  		struct vt_struct *vt;
>  
> -		vcs_remove_devfs(tty);
>  		vt = tty->driver_data;
>  		if (vt)
>  			vc_cons[vt->vc_num].d->vc_tty = NULL;
>  		tty->driver_data = 0;
> +		release_console_sem();
> +		vcs_remove_devfs(tty);
> +		return;
>  	}
>  	release_console_sem();
>  }
> 
> _
> 
> 


.......................................................................
  Thomas Svedberg
  Department of Applied Mechanics
  Chalmers University of Technology

  Address: S-412 96 Göteborg, SWEDEN
  E-mail : thsv@bigfoot.com, thsv@am.chalmers.se
  Phone  : +46 31 772 1522
  Fax    : +46 31 772 3827
.......................................................................
