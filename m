Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261302AbSJQLGt>; Thu, 17 Oct 2002 07:06:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261351AbSJQLGt>; Thu, 17 Oct 2002 07:06:49 -0400
Received: from [199.203.76.12] ([199.203.76.12]:36877 "EHLO
	optmail.optibase.com") by vger.kernel.org with ESMTP
	id <S261302AbSJQLGr>; Thu, 17 Oct 2002 07:06:47 -0400
Message-ID: <3DAE9B1D.5030600@optibase.com>
From: Constantine Gavrilov <const-g@optibase.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Problems implementing poll call
Date: Thu, 17 Oct 2002 13:12:29 +0200
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2655.55)
Content-Type: multipart/mixed;
	boundary="----_=_NextPart_000_01C275CD.669B6280"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_000_01C275CD.669B6280
Content-Type: text/plain;
	charset="iso-8859-1"


-- 
----------------------------------------
Constantine Gavrilov
Linux Leader
Optibase Ltd
7 Shenkar St, Herzliya 46120, Israel
Phone: (972-9)-970-9140
Fax:   (972-9)-958-6099
----------------------------------------




------_=_NextPart_000_01C275CD.669B6280
Content-Type: text/plain;
	name="let.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="let.txt"

Hi,

I have a problem implementing poll method.

I have written a driver for MPEG encoder card. The user-space SDK needs =
to be able to wait for a certain event that is reported by the =
interrupt handler. I have done it using ioctl method, like this:

	u32 timeout=3Dmilliseconds * HZ / 1000;

	set_bit(0, &dev->fintwait);
	if(test_bit(0, &dev->fintwait)) {
		interruptible_sleep_on_timeout(&dev->interrupt_queue,timeout);

		if (signal_pending(current)) {
			printk(KERN_ERR "optenc: IntWait restarted by signal\n");
			return -ERESTARTSYS;
		}

		if(test_bit(0, &dev->fintwait)) {
			printk(KERN_ERR "optenc: intwait timeout\n");
			..//returns wait timeout
		}
		else {
			...//returns wait OK
		}
	}
	//returns wait OK
=09
The interrupt handler wakes up the queue and updates dev->fintwait like =
this:

	clear_bit(0, &dev->fintwait);
	wake_up_interruptible(&dev->interrupt_queue);
=09

It worked very well for me. I wanted to implement the same wait using =
the poll method. So, my poll function looks like this:

unsigned int optenc_poll(struct file *filp, poll_table *wait_table)
{
	unsigned int mask =3D 0;
	struct mydev *dev =3D filp->private_data;
=09
	set_bit(0, &dev->fintwait);
	if(test_bit(0, &dev->fintwait)) {
		poll_wait(filp, &dev->interrupt_queue, wait_table);
		if(test_bit(0, &dev->fintwait))
			return mask;
		else {
			mask |=3D POLLIN |POLLRDNORM;
			return mask;
		}
	}
	else {
		mask |=3D POLLIN |POLLRDNORM;
		return mask;
	}
}

Seems straightforward and the same thing as above. But, I have the =
following problems:

a) I have a lot of calls with wait_table =3D NULL and poll_wait does =
not block. I always do select on one file descriptor only and I never =
use zero timeout, so I do not understand the reason for it.

b) Even when wait_table is not NULL, poll_wait returns before (!!) =
interrupt handler wakes up the queue. I have checked it with printk. It =
always like this:

	set_bit
	poll_wait
	poll_wait returns and test_bit is true
	wake_up and clear_bit

It is like poll_wait does not seem to block and I have spurious calles =
with wait_table =3D=3D NULL. Any ideas?


Just to verify, the user-space wait function looks like this :

BOOL Wait(int timeout)
{

	fd_set set;
	struct timeval tv;
	int retval;

	FD_ZERO(&set);
	FD_SET(fd, &set);
	tv.tv_sec =3D timeout/1000;
	tv.tv_usec =3D (timeout%1000)*1000;

	int rc=3Dselect(fd+1, &set, NULL, NULL, &tv);
	if(rc =3D=3D -1) {
		PERROR("select");
		return FALSE;
	}
	if(rc =3D=3D 1)
		return TRUE;
	else
		return FALSE;
}

I use 2.4.18-pre7ac1 and I have also checked stock RedHat's 2.4.9-34.

------_=_NextPart_000_01C275CD.669B6280--
