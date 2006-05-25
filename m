Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964812AbWEYGeo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964812AbWEYGeo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 May 2006 02:34:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965026AbWEYGeo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 May 2006 02:34:44 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:46354 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S964812AbWEYGek (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 May 2006 02:34:40 -0400
Date: Thu, 25 May 2006 08:34:15 +0200
From: Willy TARREAU <willy@w.ods.org>
To: Steve Clark <sclark@netwolves.com>
Cc: Steve Clark <sclark@dev.netwolves.com>, linux-kernel@vger.kernel.org,
       uClinux development list <uclinux-dev@uclinux.org>
Subject: Re: uclinux 2.4.32 panic
Message-ID: <20060525063414.GA249@w.ods.org>
References: <44746064.30607@netwolves.com> <20060524201030.GU11191@w.ods.org> <4474CF11.4090007@netwolves.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4474CF11.4090007@netwolves.com>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 24, 2006 at 05:24:33PM -0400, Steve Clark wrote:
(...)
> >>>>LR;  008727cc <rs_write+148/294>
> >>
> >>>>PC;  0090e5fc <memmove+25c/460>   <=====
> >>
> >>Trace; 0090e3a0 <memcpy+0/0>
> >>Trace; 008727cc <rs_write+148/294>
> >>
> >>>>r8; 00956228 <tmp_buf+0/1000>
> >>
> >>Trace; 00872684 <rs_write+0/294>
(...)

> The hardware is the ActionTec DualPC Modem it has a conexant cx82100 
> arm processor.
> I can reproduce it at will by connecting to the internet and running 
> nttcp thru it at the same time
> I am scping file both ways from and to, and then finally starting a 
> getty on /dev/ttyS0, the modem is
> at ttyS1 and also ttyS0 is where all the kernel printk messages come out.
> 
> When I start the getty if I have all the other traffic going it 
> usually will panic in under a minute. IF I don't
> have the getty running it will run for hours and not panic.
> 
> 
> 
> 2.4.32-uc0 with patches from
> http://www.bettina-attack.de/jonny/view.php/projects/uclinux_on_cx82100/

Well, at least the cnxtserial.c file looks suspicious to me :

static int rs_write(struct tty_struct * tty, int from_user,
                    const unsigned char *buf, int count)
{
        int     c, total = 0;
        unsigned long flags;
        struct cnxt_serial *info = (struct cnxt_serial *)tty->driver_data;
                                                         ^^^^^

        if (serial_paranoia_check(info,tty->device, "rs_write"))
                                       ^^^^^
          return 0;

        if (!tty || !info->xmit_buf)
          return 0;

=> tty already referenced twice before the check. Either the check is
   useless, or the person who wrote it had a good reason for it which
   was not considered when writing the two lines above. I would suggest
   to start from something like this :

static int rs_write(struct tty_struct * tty, int from_user,
                    const unsigned char *buf, int count)
{
        int     c, total = 0;
        unsigned long flags;
        struct cnxt_serial *info;

        if (!tty)
        	return 0;

        info = (struct cnxt_serial *)tty->driver_data;
        if (serial_paranoia_check(info, tty->device, "rs_write"))
        	return 0;

        if (!info->xmit_buf)
        	return 0;


Further :

          c = MIN(count, MIN(SERIAL_XMIT_SIZE - info->xmit_cnt - 1,
                             SERIAL_XMIT_SIZE - info->xmit_head));
          if (c <= 0)
            break;

=> info->xmit_cnt and info->xmit_head are signed ints. If you encounter
   memory corruption (eg: during your ethernet transfers) and those get
   negative, nothing prevents the buffer from being overwritten past the
   end.

Further :

          if (from_user) {
            down(&tmp_buf_sem);
            copy_from_user(tmp_buf, buf, c);
            c = MIN(c, MIN(SERIAL_XMIT_SIZE - info->xmit_cnt - 1,
                           SERIAL_XMIT_SIZE - info->xmit_head));
        ^^^^^^^^^^^^^^^^^^
            memcpy(info->xmit_buf + info->xmit_head, tmp_buf, c);
            up(&tmp_buf_sem);
          } else

=> What the hell is this ? c was assigned the same value above, so
   we get :
   c = MIN(MIN(count, MIN(SERIAL_XMIT_SIZE - info->xmit_cnt - 1,
                       SERIAL_XMIT_SIZE - info->xmit_head)),
                      MIN(SERIAL_XMIT_SIZE - info->xmit_cnt - 1,
                       SERIAL_XMIT_SIZE - info->xmit_head));

   I'm not sure this was what the developper originally intented to do,
   but although useless, it does not seem incorrect. However, I don't
   know if he wanted to further reduce the buffer for any reason.

Also, it appears that nothing prevents any code running outside the
loop from changing info->xmit_buf between the restore_flags() and
the cli(). I don't know if this is functionnaly possible, but at
least it is possible by memory corruption (eg: padding too large
for a packet and writing zeroes past the end of one buffer).

You should definitely add printks or at least double checks
everywhere within this loop I think.

That's all I can tell, I don't know this platform at all.

Regards,
Willy

