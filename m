Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316595AbSGLPpA>; Fri, 12 Jul 2002 11:45:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316598AbSGLPo7>; Fri, 12 Jul 2002 11:44:59 -0400
Received: from modemcable166.48-200-24.mtl.mc.videotron.ca ([24.200.48.166]:57540
	"EHLO xanadu.home") by vger.kernel.org with ESMTP
	id <S316595AbSGLPo5>; Fri, 12 Jul 2002 11:44:57 -0400
Date: Fri, 12 Jul 2002 11:46:47 -0400 (EDT)
From: Nicolas Pitre <nico@cam.org>
X-X-Sender: nico@xanadu.home
To: Kirk Reiser <kirk@braille.uwo.ca>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: Advice saught on math functions
In-Reply-To: <x7ptxtdmnc.fsf@speech.braille.uwo.ca>
Message-ID: <Pine.LNX.4.44.0207121102230.25178-100000@xanadu.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12 Jul 2002, Kirk Reiser wrote:

> Alan Cox <alan@lxorguk.ukuu.org.uk> writes:
> 
> > Maybe you should do this in user space ? Certainly the more I talk to people
> > like Nicholas Pitre the more it seems to me that most of the kernel side
> > stuff is the wrong approach.
> 
> I agree, except for providing access from the very beginning.  If
> access can be provided which would never leave the blind user without
> speech with a user space solution this would be ideal.

This is certainly possible.  This is how I've been accessing Linux (with 
both modes i.e. speech and braille).  We've added support to BRLTTY so it 
can replace /sbin/init to be the very first user process to run and then 
fork the real init binary.  This is also how we modify Red Hat installation 
bootdisks.

> > Instead would it not be better to
> > 
> > -	Fix select on /dev/vcsa to work
> > -	During init start up after init processes are running have
> > 	the init tasks (or for that matter the kernel) fire up the
> > 	speech helper
> 
> Can you give me more details?  I certainly don't mind looking into
> this as a possible solution.  

The /dev/vcsa0 device gives you the text content of the foreground virtual 
console as well as color attributes and cursor coordinates.  The BRLTTY 
daemon is polling that device to refresh the braille display or generate 
speech.  However it would be pretty easy to add select() support for it so 
not to have to poll the device.

Also, since the input API will now handle all kind of keyboards, you'll be 
able to get any keyboard events from within user space directly as well.  
This becomes really handy for speech-only solutions where the standard 
keyboard is the only way to control the screen review daemon.

> Are you willing to give up seeing
> anything on the screen until init gets started?

Of course!  The maintenance cost of a kernel space solution is simply too
high for the single benefit of actually having speech output while the
kernel is in the process of booting.  And yet with an initial ramdisk
(initrd) containing all the user space daemon for speech I'm pretty sure we
can have the kernel reach the init process (or the /linuxrc process for that
matter) without failing in 99.9% of the cases.  This gives you virtually the
same result as a kernel space solution.

> > The fact 95% of the speakup drivers are going to spontaneously go 
> > obsolete the moment serial ports vanish bothers me.

Also, we must admit that hardware speech synth are simply doomed to get 
obsoleted as software solutions are more and more available, affordable and 
convenient to use.  Those are also best run in user space where the access 
to the soundcard is best arbitrated.  This is also the only practical way to 
run speech access solutions on a Compaq iPAQ for example.

> I am getting a lot of pressure to make some sort of software synth
> solution available for folks that cannot afford a hardware synth or
> use a platform which doesn't support hardware synths.  I also have an
> over all philosophy which requires me to provide solutions that
> include speech and review capabilities from power up to power down.
> Open BIOS and Linux for the first time ever can provide a way for the
> blind community to not be a second class citizen to information
> access.  I am afraid that if I just take the emacspeak approach to
> accessibility then my community will stay beholding to others for
> their access to available information.  I am sorry about the soap-box
> preaching but it is a fundamental problem with just user space
> solutions.

Please _don't_ associate user space solutions with EmacSpeak!  While I'm a 
true believer in "do it in user space if it can be", I don't agree with the 
EmacSpeak philosophy.  There is a large gap in between where user space can 
be used universally without restricting yourself to the Emacs environment.

And again, with a proper initrd, you can have the kernel reach your user 
space speech daemon without any failure.  Most boot failures are due to 
wrong root devices and such but the final root fs gets mounted _after_ the 
initrd is run.

Of course you'll want to see what the kernel displayed during the boot 
process, but if you use /dev/vcsa0 you have access to the virtual console's 
scrollback buffer where all kernel messages can be seen and even the BIOS 
ones!  You therefore virtually get from startup to shutdown speech access 
and all from user space.

And probably the nicest thing about user space solutions: the old 1995 
BRLTTY binary still runs fine on a 2.5.x kernel!


Nicolas

