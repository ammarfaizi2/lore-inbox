Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265680AbTCELOc>; Wed, 5 Mar 2003 06:14:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265809AbTCELOc>; Wed, 5 Mar 2003 06:14:32 -0500
Received: from smtp-1.hut.fi ([130.233.228.91]:19105 "EHLO smtp-1.hut.fi")
	by vger.kernel.org with ESMTP id <S265680AbTCELO2>;
	Wed, 5 Mar 2003 06:14:28 -0500
Date: Wed, 5 Mar 2003 13:24:54 +0200 (EET)
From: Dmitrii Tisnek <dima@cc.hut.fi>
To: linux-kernel@vger.kernel.org
cc: Uwe Reimann <linux-kernel@pulsar.homelinux.net>
Subject: Re: Direct access to parport
In-Reply-To: <Pine.LNX.4.52.0303042329450.18334@ally.lammerts.org>
Message-ID: <Pine.OSF.4.50.0303051253370.19819-100000@kosh.hut.fi>
References: <3E646091.6070004@pulsar.homelinux.net>
 <Pine.LNX.4.52.0303042329450.18334@ally.lammerts.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-RAVMilter-Version: 8.4.2(snapshot 20021217) (smtp-1.hut.fi)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[snip]
> On Tue, 4 Mar 2003, Uwe Reimann wrote:
> > I'd like to connect some self made hardware to the parallel port and
> > read the values of the dataline using linux. Can this be done in
> > userspace or do I have to write kernel code to do so? I'm currently
> > thinking of writing a device like lp, which in turn uses the parport
> > device. Does this sound like a good idea?

hi, I've done similar for t6963c, so I hope I can give some guidance :)

there are two things you can do from userland -

* access pc-style parallel port directly through inb/outb
  . works only on standard pc parallel port
  . most efficient (see below)
  . can only be done by root

* access raw parallel port through ppdev (CONFIG_PPDEV)
  . needs ppdev in kernel
  . access control by normal file permissions (default root only)
  . can be somewhat slower

* write a discipline driver, like lp
  . needs kernel module or patch
  . no real advantages over usermode


issues - speed:

the standard x86 parallel port hardware is still used through inb/outb,
whether you access it with inb/outb from usermode or you let kernel do it
for you (through ppdev or parallel port discipline).

inb and outb go though isa memory cycle (or are thes programmable
instructions?), I don't understand this fully, anyway, the fact is that no
matter how fast your cpu is, the time it takes to execute an inb or outb
is the same. Basically you, are limited to 300,000 outb's a second (not
sure about the exact number). No matter if it's 2.4 GHz P-4 or 100 MHz 486

ppdev special:
when you use ppdev you have to use two separate ioctl's - one to change
data direction (in case of bidirectional port) and all other control
lines/flags/etc, so if you need to change direction of data lines often,
this might mean your bandwidth is cut in half :(

irq special:
there's a provision for the parallel port hardware to send an irq when
status lines change (or some such), however you need to supply a module
parameter or kernel argument to enable this (on legacy x86 port at least),
because the logic that figures out the ioport apparantely doesn't dare to
enable the interrupt

thus if you want an interrupt it's same level of intrusiveness as
requiring a kernel module. yuck.

and without the interrupt you are destined to poll the parallel port
status. polling is a problem in it's own, because most kernel mechanisms
go through schedule, thus allowing only HZ precision (read 100 times a
second on standard x86).  If you want more frequent polls without
busywait, there's some info on the net about it.

issues - access:
inb/outb are only available to root, you could make a setuid program that
does ioperm() and then goes back to unpriviledged mode of course

ppdev is controlled by normal user/group and permission on
/dev/parports/0, etc, so it's quite usable

with your own parallel port discipline you can do anything you like

issue - portability:
inb/outb works only for x86 legacy hardware
ppdev and your a new parallel discipline should work on any paralle port
hardware.



Examples:

inb/outb - from whoever I\m replying to:
> #include <stdio.h>
> #include <sys/io.h>
>
> int main(int argc, char **argv)
> {
> 	int addr = 0x378;
>
> 	if(ioperm(addr, 3, 1) == -1) {
> 		perror("ioperm");
> 		exit(1);
> 	}
> 	printf("0x%02x\n", inb(addr + 1));
> }
>
> The ioperm() only works if you're root.
2nd argument is 3 because there are 3 registers in standard parallel port,
namely data, control and status (don't remember in which order). If you
wanna use something more advanced, like ECP or EPP, you'll have more
registers.

ppdev:
#include <sys/io.h>
#include <sys/ioctl.h>
void blah()
{
  fd = open("/dev/parports/0", O_RDWR);
  ioctl(fd, PPCLAIM, NULL);
  arg = IEEE1284_MODE_BYTE;
  ioctl(fd, PPSETMODE, &arg);

  unsigned char c = 13;
  int dir = 0;
  ioctl(fd, PPDATADIR, &dir);
  ioctl(fd, PPWDATA, &c);
}

you\ll have to read ppdev.c in the kernel sources to figure out the
ioctl's but it's not that bad :)



hope this helps,
dima
