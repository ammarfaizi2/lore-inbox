Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279873AbRJ3FZn>; Tue, 30 Oct 2001 00:25:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279875AbRJ3FZe>; Tue, 30 Oct 2001 00:25:34 -0500
Received: from mpdr0.detroit.mi.ameritech.net ([206.141.239.206]:1766 "EHLO
	mailhost.det.ameritech.net") by vger.kernel.org with ESMTP
	id <S279873AbRJ3FZR>; Tue, 30 Oct 2001 00:25:17 -0500
Date: Mon, 29 Oct 2001 08:21:21 -0500 (EST)
From: volodya@mindspring.com
Reply-To: volodya@mindspring.com
To: Gerd Knorr <kraxel@bytesex.org>
cc: video4linux-list@redhat.com, livid-gatos@linuxvideo.org,
        linux-kernel@vger.kernel.org
Subject: Re: [V4L] Re: [RFC] alternative kernel multimedia API
In-Reply-To: <20011029134034.A9113@bytesex.org>
Message-ID: <Pine.LNX.4.20.0110290807280.17469-100000@node2.localnet.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 29 Oct 2001, Gerd Knorr wrote:

> > > GUI without knowing what these values are actually good for.  Or even
> > > know whenever it is useful to build a GUI for it or not.
> > 
> > First of all such a GUI is relatively easy to build: see gamma controls in
> > XV. Secondly, you are presenting a shaky argument: GUI is hard to built
> > hence do not let user adjust them at all..
> 
> There are cases where it is quite useless to build a GUI:  If you have a
> device with hardware compression support and want to set DCT
> coefficients for example.  It is (like gamma table) just a list of
> values, but you certainly don't want present the same GUI for them to
> the user.  For the DCT coefficients it probably would be reasonable to
> present no GUI at all, or let the user only pick one of a few reasonable
> choices.
> 

Well, I am not saying that GUI needs to be presented for everything that
can be adjusted, at least not unless requested explicitly by the user.

> > > I don't see how your approach handles this.
> > 
> > Ahh, it is not there yet. I did not want to do it until there is a simple
> > driver to experiment with. It would be along the lines of
> > HUE_DEPENDENT_ON=....
> 
> And this means?  If hue depends on foo, the application should read back
> the hue value and update the GUI if foo has changed?

Let me do it with mixers ;)

VOLUME1

VOLUME2

VOLUME2_DEPENDENT_ON=MIXER1

This means that VOLUME2 is the master control of VOLUME1.

Perhaps I should change it to VOLUME1_MASTER=VOLUME2 ...

> 
> > > >  Additionally nonone will need to include kernel headers to compile the
> > > >  application.
> > > 
> > > Why do you want to avoid this?
> > > 
> > 
> > So I can distribute the driver and the application to use it and not
> > depend on the kernel version.
> 
> The exported API must not depend on the kernel version.  If the API
> changes in a way which isn't backward compatible, it is a kernel bug.

I already got a report from the user that in his kernel
video_register_device has 2 arguments and not 3. This is pain to deal with
in drivers distributed separately from kernel tree.

> 
> > > >  Also, mmaped buffers + character device fits a larger category then just
> > > >  the devices mentioned in v4l2 specifications. Granted the specification
> > > >  can be extended, but the new driver will have to distribute not only its
> > > >  source but a patch to the kernel headers. The scheme will avoid this.
> > > 
> > > And why this is better?  You likely still have to teach the applications
> > > about the new features of the driver if you actually want to use them
> > > (unless there are just a few new controls, but this case can easily
> > > handled with v4l2 too).
> > 
> > You don't have to invent a new kernel header just to support a new set of
> > devices.
> 
> I can't see why it is a problem to add a new header or new ioctls to
> a existing header file.  I like it this way, because the kernel headers
> with all the #defines and structs are providing at least a minimum of
> documentation.  I do often read header files when programming stuff.
> 

Because we don't know which interface is best until we experiment with
it. And I can't experiment without people being able to test. And the
easier it is to compile and install code the more testers (and developers
!) we get.

> > v4l2 is quite a lot bettern than v4l. But it is quite static.
> 
> I consider a static API a good thing.  Code often lives for years, and
> it is nice if your five year old source code build and works just fine
> ...
> 

This sounds more as an argument between assembler and C. Each has its
place.

> > Think about
> > what needs to be done to enable gamma tables for video out - this is not
> > trivial..
> 
> Yes, we'll basically need new v4l2 ioctls for it.
> 
> > > I doubt this fixes the problem (driver devel time) you've mentioned.
> > > Most of the time of the driver development is needed for the code which
> > > talks to the hardware.  Building a simple v4l(2) ioctl interface which
> > > just says "I can nothing but capture, and the format list is YUV422" is
> > > easy compared to the other work which needs to be done for a working
> > > driver.  v4l(2) doesn't force you to wait with the release until you
> > > have a full-featured driver ...
> > 
> > It's not. What I want to be able to do is to release a driver that
> > supports basic functionality plus a bunch of device-specific stuff for
> > which no API exists. Then, with more experience, we can make an API. 
> 
> Nobody stops you from creating some temporary device-specific ioctls for
> playing and testing ...
> 
> Of course old applications don't know about the new stuff (neither the
> temporary nor the final versions which make in into the official API
> some day maybe).  But I don't see how your approach handles this better:
> Applications still need to be hacked to use the new stuff ...
> 

The way you write device specific appliacation is by including kernel
headers. If the stuff we want is not there makes a lot trouble for
installing and maintaining code.

> 
> > > >   * kernel structures force a specific model onto a driver
> > > 
> > > The control strings you want to read() and write() to the driver do
> > > exactly the same, because they must have some clear defined semantic to
> > > make the whole model actually workable.
> > > 
> > 
> > The benifit is that we dont have to define it in the kernel headers. Right
> > now if I want to add a new ioctl I have tons of problems:
> > 
> >       * how do I communicate to the application source the new structs
> >         I am using ?
> 
> You can't.  But I don't see why this is a issue:  The only thing a
> application can handle easily are controls like contrast/hue where the
> only thing a application needs to do is to map it to a GUI and let the
> user understand and adjust stuff.  The other stuff has way to much
> non-trivial dependences, I doubt a application can blindly use new
> driver features.
> 

Have you ever thought that the reason we only use these controls is
because they are the only ones easy to implement now ?

> >       * what do I do if someone uses the same ioctl in the kernel source
> 
> ???

Same ioctl number, in the kernel headers..

> 
> >       * what happens if I want to add a new field during driver
> >         development ? (users will see crashing applications..)
> 
> No.
> 
> v4l2 has a few reserved[x] in the structs to allow such extentions
> without breaking binary comparibility.
> 
> If you add a new field to a struct the ioctl magic number changes
> because the size of the struct has changed.  This can be used to add new
> fields without breaking stuff (althrought it starts to become ugly here,
> drivers have to support both old and new versions of the ioctl).  Look
> at SOUND_MIXER_INFO vs. SOUND_OLD_MIXER_INFO in linux/soundcard.h for a
> example.
> 

And then we run out of them.. and we can run out of magic number too.. 

> > > >   * can cause problems with different compilers
> > > 
> > > Then your compiler is buggy.
> > 
> > No, I may have simply used different compilers for the kernel and the
> > application.
> 
> I doubt that.

You are kidding, aren't you ? Most distributions now come out with egcs
compiler 1.1.x "recommended for compiling" kernels and something newer.

> 
> > > >   * confuse applications when a driver does not implement a field
> > > 
> > > With v4l2 controls this shouldn't be a issue any more.
> > 
> > What if the driver does not support counting dropped frames ?
> 
> -EINVAL or something like that.

But supports every other field.

> 
> > What if there is a control with no min/max limits ?
> 
> Do you have a example?
> 

Overlay color key - this is basically an RGB pixel value.


> > > >  However, this is hard to implement with ioctl's as they rely on fixed
> > > >  length structures. You would have to call first to find out the size of
> > > >  the buffer you need (which the driver would have to compute) and then the
> > > >  second time to get the data. Eeeks.
> > > 
> > > Wrong.  Look at the specs for the v4l2 controls.
> > 
> > Can I return a string as a value ?  (For a device specific control).
> 
> Multiple choice controls have strings for each value.
> 

With no way to pass strings (and their meaning) from the driver to the
user applications.

> > Can I set/read gamma values ?
> 
> Gamma values yes (tables no).
> 
> > > >  them with read/writes on the control device. With the added benifit that
> > > >  we can select on it to wait for an event.
> > > 
> > > v4l2 expects drivers to support select too, so you can wait for your
> > > capture requests using select.
> > 
> > Which means one more thing in the driver to support.
> 
> Of course a driver needs some code to support select(), it doesn't work
> with black magic.  What else do you expect?

I would prefer minimum effort on the part of driver writer ;) At the
moment all I see in bttv and my own code for select is looking on some
already existing fields. Heck, the code is very similar to what needs to
be checked for a blocking/non-blocking read. Why duplicate it ?

Also, v4l select will not work (as far as I understand) when the driver is
using memory-mapped buffers.

                        Vladimir Dergachev

> 
>   Gerd
> 

