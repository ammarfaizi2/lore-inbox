Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132526AbRDOXyc>; Sun, 15 Apr 2001 19:54:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132514AbRDOXyX>; Sun, 15 Apr 2001 19:54:23 -0400
Received: from draco.cus.cam.ac.uk ([131.111.8.18]:64745 "EHLO
	draco.cus.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S132142AbRDOXyG>; Sun, 15 Apr 2001 19:54:06 -0400
Message-Id: <5.0.2.1.2.20010416005432.00ac81a0@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.0.2
Date: Mon, 16 Apr 2001 00:55:49 +0100
To: esr@thyrsus.com
From: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Re: CML2 1.1.0 bug and snailspeed
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20010415135906.A5501@thyrsus.com>
In-Reply-To: <5.0.2.1.2.20010415114319.00b13350@pop.cus.cam.ac.uk>
 <Pine.SOL.3.96.1010414174944.810A-100000@libra.cus.cam.ac.uk>
 <002601c0c4fb$c7e54260$0201a8c0@home>
 <Pine.SOL.3.96.1010414174944.810A-100000@libra.cus.cam.ac.uk>
 <20010414135618.C10538@thyrsus.com>
 <5.0.2.1.2.20010415114319.00b13350@pop.cus.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 18:59 15/04/2001, Eric S. Raymond wrote:
>Anton Altaparmakov <aia21@cam.ac.uk>:
> > At 18:56 14/04/2001, Eric S. Raymond wrote:
> > >Anton Altaparmakov <aia21@cus.cam.ac.uk>:
> > > > I found a bug: In "Intel and compatible 80x86 processor options", 
> "Intel
> > > > and compatible 80x86 processor types" I press "y" on "Pentium Classic"
> > > > option and it activates Penitum-III as well as Pentium Classic 
> options at
> > > > the same time!?! Tried to play around switching to something else 
> and then
> > > > onto Pentium Classic again and it enabled Pentium Classic and Pentium
> > > > Pro/Celeron/Pentium II (NEW) this time! Something is very wrong here.
> > >
> > >Rules file bug, probably.  I'll investigate this afternoon.
> >
> > Just to say that this bug still exists in CML2 1.1.1 but it is sometimes
> > hidden, i.e. you only see a "Y" on one of the options but when you select
> > another option, it sometimes says that TWO other options were set to "n"
> > implying that two options were Y before... I also still see random two
> > options being Y when playing with Pentium Classic selection (right now I
> > see Pentium Classic and Pentium-4 at the same time being Y on my screen)...
>
>I can't reproduce this in 1.1.2.  Here's a ttyconfig run, after "v 2" to set
>the verbose flag.

I can't reproduce it with ttyconfig either. But here is how to reproduce it 
reliably with menuconfig:

make mrproper
rm .config
rm config.out
make menuconfig
down
down
right
right
[Now in cpu selection have a Y next to M686.]
down to M586TSC
y
msg: M686=n (deduced from M586TSC)
enter to dismis msg
up
[now at M586]
y
msg: M586TSC=n (deduced from M586)
enter to dismis msg
down
[now back at M586TSC]
y
msg: M586=n (deduced from M586TSC)
enter to dismis msg
[now have a Y for both M586TSC and M686]
y
[nothing happens, as it is already 'y' it's expected]
down
[now notice colouring: M586TSC is green while M686 is grey like the rest]
down
[now at M686 which has the second y but is grey]
y
[nothing happens, as it is 'y' it's expected, but it shouldn't be 'y']
down
[now at MPENTIUMIII]
y
msg: M586TSC=n (deduced from MPENTIUMIII)
      M686=n (deduced from MPENTIUMIII)
enter to dismis msg
[only one Y left at expected position MPENTIUMIII]

I cannot reproduce any of this using make ttyconfig I am afraid...

The above in/output was with CML2 1.1.2.

There must be something... Can you reproduce this? I gave you all 
keypresses I used. I can reproduce it every time.

If I press 'x' after the two 'Y' have appeared at the same time and look at 
the generated .config it says:

# Intel and compatible 80x86 processor types
#
# CONFIG_M386 is not set
# CONFIG_M486 is not set
# CONFIG_M586 is not set
CONFIG_M586TSC=y
# CONFIG_M586MMX is not set
CONFIG_M686=y
# CONFIG_MPENTIUMIII is not set
# CONFIG_MPENTIUM4 is not set
# CONFIG_MK6 is not set
# CONFIG_MK7 is not set
# CONFIG_MCRUSOE is not set
# CONFIG_MWINCHIPC6 is not set
# CONFIG_MWINCHIP2 is not set
# CONFIG_MWINCHIP3D is not set
# CONFIG_MCYRIXIII is not set

And config.out contains:

# Intel and compatible 80x86 processor types
#
CONFIG_M386=n
CONFIG_M486=n
CONFIG_M586=n
CONFIG_M586TSC=y
CONFIG_M586MMX=n
CONFIG_M686=y
CONFIG_MPENTIUMIII=n
CONFIG_MPENTIUM4=n
CONFIG_MK6=n
CONFIG_MK7=n
CONFIG_MCRUSOE=n
CONFIG_MWINCHIPC6=n
CONFIG_MWINCHIP2=n
CONFIG_MWINCHIP3D=n
CONFIG_MCYRIXIII=n

This shows quite cleary that the state really is messed up indeed.

Let me know if you cannot reproduce this stil...

If there is anything I can help to narrow this down let me know (I don't 
know any Python I am afraid). Once I have my permanent netconnection back 
to home (will take a few days) I can give you a ssh shell account on this 
system if it would be helpful. At the moment the only interaction with the 
world is using a floppy disk or my Windows box and the modem in my Nokia 
7110... )-:

Best regards,

         Anton


-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS Maintainer / WWW: http://sourceforge.net/projects/linux-ntfs/
ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/

