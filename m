Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279243AbRJ2MOn>; Mon, 29 Oct 2001 07:14:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279250AbRJ2MOe>; Mon, 29 Oct 2001 07:14:34 -0500
Received: from gnu.in-berlin.de ([192.109.42.4]:58633 "EHLO gnu.in-berlin.de")
	by vger.kernel.org with ESMTP id <S279261AbRJ2MO1>;
	Mon, 29 Oct 2001 07:14:27 -0500
X-Envelope-From: kraxel@bytesex.org
Date: Mon, 29 Oct 2001 13:40:34 +0100
From: Gerd Knorr <kraxel@bytesex.org>
To: volodya@mindspring.com
Cc: video4linux-list@redhat.com, livid-gatos@linuxvideo.org,
        linux-kernel@vger.kernel.org
Subject: Re: [V4L] Re: [RFC] alternative kernel multimedia API
Message-ID: <20011029134034.A9113@bytesex.org>
In-Reply-To: <200110261752.f9QHqxoM007951@bytesex.masq.in-berlin.de> <Pine.LNX.4.20.0110261611500.12062-100000@node2.localnet.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.20.0110261611500.12062-100000@node2.localnet.net>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > GUI without knowing what these values are actually good for.  Or even
> > know whenever it is useful to build a GUI for it or not.
> 
> First of all such a GUI is relatively easy to build: see gamma controls in
> XV. Secondly, you are presenting a shaky argument: GUI is hard to built
> hence do not let user adjust them at all..

There are cases where it is quite useless to build a GUI:  If you have a
device with hardware compression support and want to set DCT
coefficients for example.  It is (like gamma table) just a list of
values, but you certainly don't want present the same GUI for them to
the user.  For the DCT coefficients it probably would be reasonable to
present no GUI at all, or let the user only pick one of a few reasonable
choices.

> > I don't see how your approach handles this.
> 
> Ahh, it is not there yet. I did not want to do it until there is a simple
> driver to experiment with. It would be along the lines of
> HUE_DEPENDENT_ON=....

And this means?  If hue depends on foo, the application should read back
the hue value and update the GUI if foo has changed?

> > >  Additionally nonone will need to include kernel headers to compile the
> > >  application.
> > 
> > Why do you want to avoid this?
> > 
> 
> So I can distribute the driver and the application to use it and not
> depend on the kernel version.

The exported API must not depend on the kernel version.  If the API
changes in a way which isn't backward compatible, it is a kernel bug.

> > >  Also, mmaped buffers + character device fits a larger category then just
> > >  the devices mentioned in v4l2 specifications. Granted the specification
> > >  can be extended, but the new driver will have to distribute not only its
> > >  source but a patch to the kernel headers. The scheme will avoid this.
> > 
> > And why this is better?  You likely still have to teach the applications
> > about the new features of the driver if you actually want to use them
> > (unless there are just a few new controls, but this case can easily
> > handled with v4l2 too).
> 
> You don't have to invent a new kernel header just to support a new set of
> devices.

I can't see why it is a problem to add a new header or new ioctls to
a existing header file.  I like it this way, because the kernel headers
with all the #defines and structs are providing at least a minimum of
documentation.  I do often read header files when programming stuff.

> v4l2 is quite a lot bettern than v4l. But it is quite static.

I consider a static API a good thing.  Code often lives for years, and
it is nice if your five year old source code build and works just fine
...

> Think about
> what needs to be done to enable gamma tables for video out - this is not
> trivial..

Yes, we'll basically need new v4l2 ioctls for it.

> > I doubt this fixes the problem (driver devel time) you've mentioned.
> > Most of the time of the driver development is needed for the code which
> > talks to the hardware.  Building a simple v4l(2) ioctl interface which
> > just says "I can nothing but capture, and the format list is YUV422" is
> > easy compared to the other work which needs to be done for a working
> > driver.  v4l(2) doesn't force you to wait with the release until you
> > have a full-featured driver ...
> 
> It's not. What I want to be able to do is to release a driver that
> supports basic functionality plus a bunch of device-specific stuff for
> which no API exists. Then, with more experience, we can make an API. 

Nobody stops you from creating some temporary device-specific ioctls for
playing and testing ...

Of course old applications don't know about the new stuff (neither the
temporary nor the final versions which make in into the official API
some day maybe).  But I don't see how your approach handles this better:
Applications still need to be hacked to use the new stuff ...


> > >   * kernel structures force a specific model onto a driver
> > 
> > The control strings you want to read() and write() to the driver do
> > exactly the same, because they must have some clear defined semantic to
> > make the whole model actually workable.
> > 
> 
> The benifit is that we dont have to define it in the kernel headers. Right
> now if I want to add a new ioctl I have tons of problems:
> 
>       * how do I communicate to the application source the new structs
>         I am using ?

You can't.  But I don't see why this is a issue:  The only thing a
application can handle easily are controls like contrast/hue where the
only thing a application needs to do is to map it to a GUI and let the
user understand and adjust stuff.  The other stuff has way to much
non-trivial dependences, I doubt a application can blindly use new
driver features.

>       * what do I do if someone uses the same ioctl in the kernel source

???

>       * what happens if I want to add a new field during driver
>         development ? (users will see crashing applications..)

No.

v4l2 has a few reserved[x] in the structs to allow such extentions
without breaking binary comparibility.

If you add a new field to a struct the ioctl magic number changes
because the size of the struct has changed.  This can be used to add new
fields without breaking stuff (althrought it starts to become ugly here,
drivers have to support both old and new versions of the ioctl).  Look
at SOUND_MIXER_INFO vs. SOUND_OLD_MIXER_INFO in linux/soundcard.h for a
example.

> > >   * can cause problems with different compilers
> > 
> > Then your compiler is buggy.
> 
> No, I may have simply used different compilers for the kernel and the
> application.

I doubt that.

> > >   * confuse applications when a driver does not implement a field
> > 
> > With v4l2 controls this shouldn't be a issue any more.
> 
> What if the driver does not support counting dropped frames ?

-EINVAL or something like that.

> What if there is a control with no min/max limits ?

Do you have a example?

> > >  However, this is hard to implement with ioctl's as they rely on fixed
> > >  length structures. You would have to call first to find out the size of
> > >  the buffer you need (which the driver would have to compute) and then the
> > >  second time to get the data. Eeeks.
> > 
> > Wrong.  Look at the specs for the v4l2 controls.
> 
> Can I return a string as a value ?  (For a device specific control).

Multiple choice controls have strings for each value.

> Can I set/read gamma values ?

Gamma values yes (tables no).

> > >  them with read/writes on the control device. With the added benifit that
> > >  we can select on it to wait for an event.
> > 
> > v4l2 expects drivers to support select too, so you can wait for your
> > capture requests using select.
> 
> Which means one more thing in the driver to support.

Of course a driver needs some code to support select(), it doesn't work
with black magic.  What else do you expect?

  Gerd

