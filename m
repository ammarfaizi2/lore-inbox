Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262058AbRFGRLF>; Thu, 7 Jun 2001 13:11:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262094AbRFGRK4>; Thu, 7 Jun 2001 13:10:56 -0400
Received: from www.transvirtual.com ([206.14.214.140]:4113 "EHLO
	www.transvirtual.com") by vger.kernel.org with ESMTP
	id <S262058AbRFGRKi>; Thu, 7 Jun 2001 13:10:38 -0400
Date: Thu, 7 Jun 2001 10:09:30 -0700 (PDT)
From: James Simmons <jsimmons@transvirtual.com>
To: Vojtech Pavlik <vojtech@suse.cz>
cc: Russell King <rmk@arm.linux.org.uk>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        tytso@mit.edu,
        Linux console project <linuxconsole-dev@lists.sourceforge.net>
Subject: Re: [driver] New life for Serial mice
In-Reply-To: <20010607082541.A166@suse.cz>
Message-ID: <Pine.LNX.4.10.10106070915250.10557-100000@transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > I ported it over to my tree. I will have to figure out how to incorporate
> > the input serial stuff without breaking all the input drivers we have. In
> > CVS we have alot of them. This will make life so much easier since all I
> > will have to do is change one file for changes I make to the tty layer. I
> > have improved andrew mortons console patch to work with multiple consoles
> > and for different types of console devices. Instead of altering all the 
> > console drivers I'm planning on intergrating the locking into the tty
> > layer. That patch is needed for serial devices as well as video terminals.
> > Your work might help speed up devleopement.
> 
> Sounds cute. Where do I find the result of your work?

For Russell's work I placed it in the ruby tree under linux/drivers/serial. No
changes have happened to it. Well at least not yet. What I like to see is:

serial_driver -> serial common code -----> serial tty 
				      |	
				      |--> serial input

For my one system I have for my only serial device a joystick. Do I really
need a serial terminal for this device. Termios changes to joystick, give
me a break. It just another layer of uneeded bloat. A nice clean design
like this would be really nice. The code is in CVS if you want to play
with it. 

As for the console lock it is already in CVS as well. Their are a few race
conditions dealing with printk and register_console to pound out but its
there and it works well. The basic changes I have made are the functions
acquire_console_sem and release_console_sem take a struct tty_driver
argument. This way we can flush one driver that was busy while printk was
running when the tty code finish doing what it was doing. Now when printk
gets called it attempts to write data to all the consoles if they already
not busy. This way it only locks out one console at a time. This way
serial console doesn't have to be locked waiting for fbcon to finish
printing to the console. A semaphore in struct tty_driver is shared with
struct console. The better news is now we can use IRQ/DMA based devices
for the console system. 

		

