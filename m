Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261234AbUDNTK6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 15:10:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261300AbUDNTK6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 15:10:58 -0400
Received: from out010pub.verizon.net ([206.46.170.133]:48617 "EHLO
	out010.verizon.net") by vger.kernel.org with ESMTP id S261234AbUDNTKx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 15:10:53 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: Dave Jones <davej@redhat.com>, walt <wa1ter@myrealbox.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6.5-bk]  'modules_install' failed to install modules
Date: Wed, 14 Apr 2004 15:10:51 -0400
User-Agent: KMail/1.6
References: <407D5B7F.107@myrealbox.com> <20040414161827.GA2229@mars.ravnborg.org> <20040414170010.GA23419@redhat.com>
In-Reply-To: <20040414170010.GA23419@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200404141510.51795.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out010.verizon.net from [151.205.62.48] at Wed, 14 Apr 2004 14:10:52 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 14 April 2004 13:00, Dave Jones wrote:
>On Wed, Apr 14, 2004 at 06:18:27PM +0200, Sam Ravnborg wrote:
> > On Wed, Apr 14, 2004 at 08:40:47AM -0700, walt wrote:
> > > I pulled the latest changesets just now and found this weird
> > > behavior:
> > >
> > > 'make' and 'make install' worked as expected, but 'make
> > > modules_install' just deleted all the old modules, ran depmod,
> > > and then installed no new modules -- nothing.
> > >
> > > I finally found that doing another 'make' fixed whatever the
> > > problem was and allowed modules_install to work properly the
> > > second time.
> > >
> > > This happened on two different machines, so I'm fairly sure it
> > > wasn't just me having a brainfart.
> >
> > This is my second report about this.
> > But you gave some new info "work properly the second time".
> > This was not the case for the other person.
>
>Make this the third.  I just saw it happen here too.
>'make bzImage ; make modules ; make modules_install' fails in the
> above way. Doing a 'make' seems to work.
>
>		Dave
I'm a great believer in scripting this stuff out, saves me from my own 
typu's.  My "makeit" script seems to have worked ok, and it does 
seperate makes for bzImage, modules, and modules_install.  However, 
IIRC it does do some other work between making modules, and the make 
modules_install.  I had to re-arrange things a bit so the final 
depmod was clean.

I don't know if this is how you are supposed to do it, but here is how 
I do it, please critique:

------------makeit-----------
#!/bin/sh
## this script assumes you have downloaded, unpacked and linked 
kernel-whatever.version
## First, set the version string to match the Makefile setting
VER=2.6.5-bk1

# I've re-arranged this to be one contiguous command line, because 
# this way if there is an error, it dies right there instead of making
# you scroll back 700k in the shell's history to check for errors.
# And, due to changes in the 2.6 way of doing things, the System.map
# stuff has been moved to a point BEFORE the make modules_install
# because it (apparently) now has a self-contained depmod command.

# Also, one should make sure the DEPMOD declaration in the Makefile
# is NOT hard coded pathwise, so it will find the newer, 2.6 version
# of depmod, that bit me several times.

make clean && \
echo && \
echo && \
echo makeing bzImage && \
make -j4 bzImage && \
echo && \
echo && \
echo Now making modules && \
echo && \
echo && \
make modules && \
echo &&
echo removeing /boot/vmlinuz-$VER-old && \
rm -f /boot/vmlinuz-$VER-old && \
echo touching vmlinuz-$VER && \
touch /boot/vmlinuz-$VER && \
echo mv-ing /boot/vmlinuz-$VER /boot/vmlinuz-$VER-old && \
mv -f /boot/vmlinuz-$VER /boot/vmlinuz-$VER-old && \
echo copying bzImage to /boot/vmlinuz-$VER && \
cp -f arch/i386/boot/bzImage /boot/vmlinuz-$VER && \
echo removeing old lib/modules/$VER.old && \
rm -fR /lib/modules/$VER.old && \
echo touching /lib/modules/$VER && \
touch /lib/modules/$VER && \
echo moving /lib/modules/$VER to /lib/modules/$VER.old && \
mv -f /lib/modules/$VER /lib/modules/$VER.old && \
echo cleaning up in /boot && \
rm -f /boot/System.map /boot/System.map-$VER && \
echo copying in new System.map && \
cp -f System.map /boot/System.map-$VER && \
echo cd-ing to /boot && \
cd /boot && \
echo doing the link of System.map-$VER to System.map && \
ln -s System.map-$VER System.map && \
echo cd-ing back to /usr/src/linux-2.6 to do the modules_install && \
cd /usr/src/linux-2.6 && \
echo && \
echo make modules_install && \
echo && \
make modules_install && \
depmod -ae -F System.map $VER && \
echo All done! reboot after fixing lilo or grub.conf
-----------------------

If the above is incorrect, I'd appreciate some pointers on how to 
improve it.

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.22% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attornies please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.
