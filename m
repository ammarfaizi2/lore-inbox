Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263372AbRFAEte>; Fri, 1 Jun 2001 00:49:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263378AbRFAEtY>; Fri, 1 Jun 2001 00:49:24 -0400
Received: from csl.Stanford.EDU ([171.64.66.149]:24046 "EHLO csl.Stanford.EDU")
	by vger.kernel.org with ESMTP id <S263372AbRFAEtR>;
	Fri, 1 Jun 2001 00:49:17 -0400
From: Dawson Engler <engler@csl.Stanford.EDU>
Message-Id: <200106010449.VAA17373@csl.Stanford.EDU>
Subject: [CHECKER] 2.4.5-ac4 security holes
To: linux-kernel@vger.kernel.org
Date: Thu, 31 May 2001 21:49:14 -0700 (PDT)
Cc: mc@cs.Stanford.EDU
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

Here's a few apparent security holes in 2.4.5-ac4.  The biggest is in
fs/ioctl.c where it looks like a new option was added that seems to
write directly to the user pointer, essentially giving anyone complete
control over the machine.

4	|	drivers/net/wan/cosa.c
2	|	drivers/usb/bluetooth.c
1	|	drivers/isdn/eicon/linchr.c
1	|	drivers/sound/wavfront.c
1	|	fs/ioctl.c

---------------------------------------------------------
[BUG] looks really broken.
/u2/engler/mc/oses/linux/2.4.5-ac4/fs/ioctl.c:108:sys_ioctl: ERROR:PARAM:70:108: Deref tainted var 'arg' (tainted from line 70)
		case FIONCLEX:
			set_close_on_exec(fd, 0);
			break;

		case FIONBIO:
Start --->
			if ((error = get_user(on, (int *)arg)) != 0)

	... DELETED 32 lines ...


		case FIOQSIZE:
			if (S_ISDIR(filp->f_dentry->d_inode->i_mode) ||
			    S_ISREG(filp->f_dentry->d_inode->i_mode) ||
			    S_ISLNK(filp->f_dentry->d_inode->i_mode))
Error --->
				*(loff_t *)arg = inode_get_bytes(filp->f_dentry->d_inode);
			else
				error = -ENOTTY;
			break;

---------------------------------------------------------
[BUG] sure seems like it.  In general, all 4 dereferences seem pretty bad.
/u2/engler/mc/oses/linux/2.4.5-ac4/drivers/net/wan/cosa.c:1049:cosa_download: ERROR:PARAM:1046:1049: Deref tainted var 'd' (tainted from line 1046)
		return -EPERM;
	}

	if (get_user(addr, &(d->addr)) ||
	    __get_user(len, &(d->len)) ||
Start --->
	    __get_user(code, &(d->code)))
		return -EFAULT;

Error --->
	if (d->addr < 0 || d->addr > COSA_MAX_FIRMWARE_SIZE)
		return -EINVAL;
	if (d->len < 0 || d->len > COSA_MAX_FIRMWARE_SIZE)
		return -EINVAL;
---------------------------------------------------------
[BUG]  why copy it in then use the inital thing?
/u2/engler/mc/oses/linux/2.4.5-ac4/drivers/net/wan/cosa.c:1057:cosa_download: ERROR:PARAM:1046:1057: Deref tainted var 'd' (tainted from line 1046)
		return -EPERM;
	}

	if (get_user(addr, &(d->addr)) ||
	    __get_user(len, &(d->len)) ||
Start --->
	    __get_user(code, &(d->code)))
		return -EFAULT;

	if (d->addr < 0 || d->addr > COSA_MAX_FIRMWARE_SIZE)
		return -EINVAL;
	if (d->len < 0 || d->len > COSA_MAX_FIRMWARE_SIZE)
		return -EINVAL;

	/* If something fails, force the user to reset the card */
	cosa->firmware_status &= ~(COSA_FW_RESET|COSA_FW_DOWNLOAD);

Error --->
	if ((i=download(cosa, d->code, len, addr)) < 0) {
		printk(KERN_NOTICE "cosa%d: microcode download failed: %d\n",
			cosa->num, i);
		return -EIO;
---------------------------------------------------------
[BUG] seems retty clear
/u2/engler/mc/oses/linux/2.4.5-ac4/drivers/sound/wavfront.c:2049:wavefront_oss_ioctl: ERROR:PARAM:2072:2049: tainted var 'arg' (from line 2072) used as arg 0 to 'memcpy'
	int err;

	switch (cmd) {
	case SNDCTL_SYNTH_INFO:
		memcpy (&((char *) arg)[0], &wavefront_info,
Error --->
			sizeof (wavefront_info));

	... DELETED 17 lines ...

			return dev.freemem;
		}
		break;

	case SNDCTL_SYNTH_CONTROL:
Start --->
		copy_from_user (&wc, arg, sizeof (wc));

		if ((err = wavefront_synth_control (cmd, &wc)) == 0) {
			copy_to_user (arg, &wc, sizeof (wc));
---------------------------------------------------------
[BUG]  fixed in ac5, I believe.
/u2/engler/mc/oses/linux/2.4.5-ac4/drivers/usb/bluetooth.c:438:bluetooth_write: ERROR:PARAM:461:438: Deref tainted var 'buf' (tainted from line 461)
	}

#ifdef DEBUG
	printk (KERN_DEBUG __FILE__ ": " __FUNCTION__ " - length = %d, data = ", count);
	for (i = 0; i < count; ++i) {
Error --->
		printk ("%.2x ", buf[i]);

	... DELETED 17 lines ...

				err (__FUNCTION__ "- out of memory.");
				return -ENOMEM;
			}

			if (from_user)
Start --->
				copy_from_user (new_buffer, buf+1, count-1);
			else
				memcpy (new_buffer, buf+1, count-1);

---------------------------------------------------------
[BUG]
/u2/engler/mc/oses/linux/2.4.5-ac4/drivers/usb/bluetooth.c:431:bluetooth_write: ERROR:PARAM:461:431: Deref tainted var 'buf' (tainted from line 461)
	if (count == 0) {
		dbg(__FUNCTION__ " - write request of 0 bytes");
		return 0;
	}
	if (count == 1) {
Error --->
		dbg(__FUNCTION__ " - write request only included type %d", buf[0]);

	... DELETED 24 lines ...

				err (__FUNCTION__ "- out of memory.");
				return -ENOMEM;
			}

			if (from_user)
Start --->
				copy_from_user (new_buffer, buf+1, count-1);
			else
				memcpy (new_buffer, buf+1, count-1);

---------------------------------------------------------
[BUG] [RESURRECTED]  Should be fixed in ac5, though.
/u2/engler/mc/oses/linux/2.4.5-ac4/drivers/isdn/eicon/linchr.c:128:do_ioctl: ERROR:PARAM:60:128: tainted var 'arg' (from line 60) used as arg 0 to 'DivasGetList'
	mem_block_t mem_block;

	switch (command)
	{
		case DIA_IOCTL_CONFIG:
Start --->
			if (copy_from_user(&DivaConfig, (void *)arg, sizeof(dia_config_t)))

	... DELETED 62 lines ...

		case DIA_IOCTL_GET_LIST:
			DPRINTF(("divas: DIA_IOCTL_GET_LIST"));
			
			if (!verify_area(VERIFY_WRITE, (void *)arg, sizeof(dia_card_list_t)))
			{
Error --->
				DivasGetList((dia_card_list_t *)arg);
			}
			else
			{

