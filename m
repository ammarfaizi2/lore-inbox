Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292371AbSBUNYy>; Thu, 21 Feb 2002 08:24:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292292AbSBUNYt>; Thu, 21 Feb 2002 08:24:49 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:28932 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S292371AbSBUNY3>; Thu, 21 Feb 2002 08:24:29 -0500
Subject: Re: [DRIVER][RFC] SC1200 Watchdog driver
To: zwane@linux.realnet.co.sz (Zwane Mwaikambo)
Date: Thu, 21 Feb 2002 13:37:40 +0000 (GMT)
Cc: wingel@acolyte.hack.org (Christer Weinigel), wingel@nano-system.com,
        jgarzik@mandrakesoft.com, roy@karlsbakk.net, alan@lxorguk.ukuu.org.uk,
        linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0202211404380.7649-100000@netfinity.realnet.co.sz> from "Zwane Mwaikambo" at Feb 21, 2002 02:07:36 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16dtPo-0006vd-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Put the GETTIMEOUT stuff in an ioctl, heres my current version, it 
> implements a number of the ioctls as well as the reboot notifier and 
> semaphores for locking.

Aside from the other comments Jeff made its got one bug that I only noticed
because I fixed it in a pile of other stuff 8)

> /* Write to Data Register */
> static inline void sc1200wdt_write_data(unsigned char index, unsigned char data)
> {
> 	outb_p(index, PMIR);
> 	outb(data, PMDR);
> }

two instruction sequence

> 		case WDIOC_KEEPALIVE:
> 			sc1200wdt_write_data(WDTO, timeout);
> 			return 0;

open
fork
ioctl from two processes one per cpu at the same time

> static int sc1200wdt_release(struct inode *inode, struct file *file)
> {
> 	/* Disable it on the way out */
> 	sc1200wdt_write_data(WDTO, 0);
> 	up(&open_sem);

NOWAYOUT support is missing - trivial to fix. Just remember to MOD_INC_USE..
on the nowayout path

> static int sc1200wdt_notify_sys(struct notifier_block *this, unsigned long code, void *unused)
> {
> 	if (code == SYS_DOWN || code == SYS_HALT)
> 		sc1200wdt_write_data(WDTO, 0);

Ditto on the nowayout

Alan in pedantic mode

