Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279231AbRJZVYQ>; Fri, 26 Oct 2001 17:24:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279277AbRJZVYI>; Fri, 26 Oct 2001 17:24:08 -0400
Received: from mpdr0.detroit.mi.ameritech.net ([206.141.239.206]:32167 "EHLO
	mailhost.det.ameritech.net") by vger.kernel.org with ESMTP
	id <S279231AbRJZVXz>; Fri, 26 Oct 2001 17:23:55 -0400
Date: Fri, 26 Oct 2001 17:28:08 -0400 (EDT)
From: volodya@mindspring.com
Reply-To: volodya@mindspring.com
To: Gerd Knorr <kraxel@bytesex.org>
cc: video4linux-list@redhat.com, livid-gatos@linuxvideo.org,
        linux-kernel@vger.kernel.org
Subject: Re: [V4L] Re: [RFC] alternative kernel multimedia API
In-Reply-To: <200110261752.f9QHqxoM007951@bytesex.masq.in-berlin.de>
Message-ID: <Pine.LNX.4.20.0110261611500.12062-100000@node2.localnet.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 26 Oct 2001, Gerd Knorr wrote:

> > > what exactly is bad with the v4l2 controls?
> >  
> >  a) no way to use them to set non-integer data (like gamma tables)
> 
> Yes, they aren't designed for complex stuff.  They can do boolean,
> multiple choice and integer options.  These ones an application can
> easily present a reasonable GUI to the user without knowing what the
> control exactly is good for.  For more complex stuff like gamma tables
> (list of integers?) it is IMHO nearly impossible to build a reasonable
> GUI without knowing what these values are actually good for.  Or even
> know whenever it is useful to build a GUI for it or not.

First of all such a GUI is relatively easy to build: see gamma controls in
XV. Secondly, you are presenting a shaky argument: GUI is hard to built
hence do not let user adjust them at all..

> 
> >  b) labels are limited to 32 chars, no way to provide "comment" fields.
> >    (I would like the driver to provide a short label and longer,
> >     user-readable and understable comment field).
> 
> IMHO this isn't the job of the device driver.  Think about translations
> of these descriptions for example ...
> 

I think it is a job of the interface presented to the user. Since we want
the application to find this information from the driver it should know
it.

> >  c) no way to present control dependencies.
> 
> I don't see how your approach handles this.

Ahh, it is not there yet. I did not want to do it until there is a simple
driver to experiment with. It would be along the lines of
HUE_DEPENDENT_ON=....

> 
> >    For example in ATI cards there are several ways you can control gamma:
> >    gamma table, gamma overlay setting, gamma setting in the decoder chip.
> >    same goes for brightness. I would rather expose all the controls and
> >    show their relationship then bundle them up in one control
> 
> ... and thus trying to make the driver tell the applications how the GUI
> should present the controls to the user?

No, but allow the driver to expose the structure to the application. 

> 
> > > Ok, you replace the '#define V4L2_CID_HUE 0x???' with the magic string
> > > "HUE" then.  The point is?
> >  
> >  ioctl are kernel specific. My scheme proposes a set of mmaped buffers and
> >  character stream. The plus is that I can make Xmultimedia extension that
> >  also presents a set of shared buffers and character stream. The
> >  application code will be exactly the same.
> 
> That's your main point I assume?  You are trying to kill the ioctls
> because you want to use the same protocol between application + driver
> and application + other application (say a X-Server)?
> 

One of them. The cards I am writing v4l driver for are graphics cards with
integrated capture. You get:
  * v4l/v4l2 capture
  * Xv video overlay
  * interfaces not supported by current infrastructure

This is too complex, if you consider that all these things do is adjust
some values and transfer chunks of data.

> >  Additionally nonone will need to include kernel headers to compile the
> >  application.
> 
> Why do you want to avoid this?
> 

So I can distribute the driver and the application to use it and not
depend on the kernel version.

> >  Also magic string HUE is a bigger namespace then an
> >  integer number. 
> 
> I doubt we will ever run out of space with 2^32 integer numbers.  I have
> yet to see a v4l2 driver which has more than 2^8 controls ...
> 

We did run out of TCP/IP addresses and major/minor numbers. I can see
myself introducing GAMMA_xxx which start from 0x10000000 and go another
0x1000 numbers.

> > > >         * be compatible with a wide range of applications
> > > 
> > > ???
> > > Sorry, but I don't see why your approach handles this better than v4l2.
> >  
> >  Since the application accesses the driver symbolically they only have to
> >  worry about agreeing on semantics. For example the driver can layout its
> >  control structs any way it likes (say, to mirror hardware registers) and 
> >  the application will bind to them. 
> 
> I don't see any difference to v4l2 here ...
> 
> >  Also, mmaped buffers + character device fits a larger category then just
> >  the devices mentioned in v4l2 specifications. Granted the specification
> >  can be extended, but the new driver will have to distribute not only its
> >  source but a patch to the kernel headers. The scheme will avoid this.
> 
> And why this is better?  You likely still have to teach the applications
> about the new features of the driver if you actually want to use them
> (unless there are just a few new controls, but this case can easily
> handled with v4l2 too).
> 

You don't have to invent a new kernel header just to support a new set of
devices.

> > > >         * introduce support for new features without the need to modify
> > > >           kernel interfaces
> > > 
> > > Hmm.  I don't like the idea to add new stuff that easily.  People tend
> > > to do quick&dirty hacks + crazy stuff with it, leading to more
> > > incompatibilies between drivers and applications.
> >  
> >  And people will always be able to write a driver outside video4linux
> >  framework. In fact, plenty of drivers and applications are incompatible as
> >  is. The same is true about audio drivers. 
> 
> Yes, these incompatibility issues are bad.  But I doubt the situation
> will become better if every driver can easily add new stuff.
> 

If this does not interfere with other drivers -  yes.

> >  The compatibility is achived best by specifications that are clear and
> >  easy to implement. This proposal helps it by providing a well defined
> >  interface and by separating semantic meaning from actual interface. 
> 
> The semantic needs to be documented too, otherwise it easily gets worse
> than v4l2.  One big plus for v4l2 is that it actually has very good API
> specs.

v4l2 is quite a lot bettern than v4l. But it is quite static. Think about
what needs to be done to enable gamma tables for video out - this is not
trivial..

> 
> >  First the internal kernel library will insure that the control interface
> >  is standard across drivers. Secondly, the drivers are free to use whatever
> >  fields they want - no restriction their.  Thirdly, the way the applications
> >  know they deal, say, with a grabber device is when the driver says it
> >  supports a certain INTERFACE_CLASS. Hence, to make sure the drivers
> >  behave, all we have to do is bar any driver which declares itself
> >  compliant with a certain INTERFACE_CLASS but isn't from entering the
> >  kernel.
> 
> I don't see how this is different from the v4l2 ioctl interface.  We
> have capability flags, ...
> 
> >  And the added advantage is that we can have many INTERFACE_CLASSes
> >  which vary in implementation difficulty, so that BASIC_GRABBER-YUV422
> >  would be very easy to implement (just expose the buffers) and something
> >  more advanced could be added later. This solves the conflict of people
> >  wanting to have _some_ driver and the time consumption of writing a driver
> >  that supports all features.
> 
> I doubt this fixes the problem (driver devel time) you've mentioned.
> Most of the time of the driver development is needed for the code which
> talks to the hardware.  Building a simple v4l(2) ioctl interface which
> just says "I can nothing but capture, and the format list is YUV422" is
> easy compared to the other work which needs to be done for a working
> driver.  v4l(2) doesn't force you to wait with the release until you
> have a full-featured driver ...

It's not. What I want to be able to do is to release a driver that
supports basic functionality plus a bunch of device-specific stuff for
which no API exists. Then, with more experience, we can make an API. 
With current approach we make an API first, and then write the
driver. That's why we need v4l2: v4l was an API designed for bt848 cards
which was impossible to extend without breaking applications.

> 
> > > >  The last point is the very important in my opinion. For example, in
> > > >  current specification, v4l2 has no support for TV-out in graphics cards.
> > > >  It has no support for setting complex parameters like gamma tables. 
> > > >  Using memory-mapped buffers requires device specific ioctls.
> > > 
> > > Which device specific ioctls?  They are common for _all_ v4l2 devices.
> >  
> >  Quote from http://www.thedirks.org/v4l2/v4l2dev.htm :
> >  
> >  A common use for memory-mapped buffers is for streaming data to and from
> >  drivers with minimum overhead. Drivers will maintain internal queues of
> >  buffers and process them asynchonously. The ioctl commands for doing that
> >  are described in the device-specific documents. Memory-mapping can also be
> >  used for a variety of other purposes. Drivers can define hardware-specific
> >  memory buffer types if needed. Use V4L2_BUF_TYPE_PRIVATE_BASE and greater
> >  values for such buffer types. 
> 
> Ok, for different device types.  Currently only capture drivers exist
> for v4l2 btw.  I doubt that your application will use the _same_ code
> path for a _different_ device type.
> 

A good deal of the code path could be preserved. What I want more is to
eliminate patching generic kernel interfaces to implement support
for new devices.

> > > >  The goal is to create an interface that does not rely on structures
> > > >  defined in kernel headers for communication. 
> > > 
> > > Why do you want to do that?
> >  
> >   * not elegant
> 
> "elegant" is hardly a argument because it is subjective.
> 

But explains why I want it ;)

> >   * kernel structures force a specific model onto a driver
> 
> The control strings you want to read() and write() to the driver do
> exactly the same, because they must have some clear defined semantic to
> make the whole model actually workable.
> 

The benifit is that we dont have to define it in the kernel headers. Right
now if I want to add a new ioctl I have tons of problems:

      * how do I communicate to the application source the new structs
        I am using ?
      * what do I do if someone uses the same ioctl in the kernel source
      * what happens if I want to add a new field during driver
        development ? (users will see crashing applications..)

> >   * can cause problems with different compilers
> 
> Then your compiler is buggy.

No, I may have simply used different compilers for the kernel and the
application.

> 
> >   * confuse applications when a driver does not implement a field
> 
> With v4l2 controls this shouldn't be a issue any more.

What if the driver does not support counting dropped frames ? What if
there is a control with no min/max limits ?

> 
> >  However, this is hard to implement with ioctl's as they rely on fixed
> >  length structures. You would have to call first to find out the size of
> >  the buffer you need (which the driver would have to compute) and then the
> >  second time to get the data. Eeeks.
> 
> Wrong.  Look at the specs for the v4l2 controls.

Can I return a string as a value ? (For a device specific control).
Can I set/read gamma values ?

> 
> >  Now what is left are the structs describing the format of memory buffers. 
> >  But the driver typically has this info in a struct itself. Instead of
> >  getting it via ioctl simply mmap the area - you'll be getting the exact
> >  same information yourself with less context switches.
> 
> read() + write() need context switches too.  And ioctl() can actually
> pass informations in both directions, there are cases where you need
> _more_ context switches with read()/write() than with ioctl() because
> with ioctl one system calls does the job, but with read()/write() you
> need two:  one for the request and one to get back the actual data.
> 

control interface is not meant to be high bandwidth. this pefectly fine +
the benifits mentioned earlier.

> >  This gets rid of the structs. 
> 
> Using strings instead adds a overhead to both driver and applications
> for string parsing.  And the application likely puts the parsed data
> into a struct again anyway ...
> 

I don't think this true as parsing is really not that hard. I don't expect
you to believe me though until there is some code to work with.

> >  What is left of v4l now are synchronization ioctls. But we can replace
> >  them with read/writes on the control device. With the added benifit that
> >  we can select on it to wait for an event.
> 
> v4l2 expects drivers to support select too, so you can wait for your
> capture requests using select.

Which means one more thing in the driver to support.

                         Vladimir Dergachev

> 
>   Gerd
> 
> -- 
> Netscape is unable to locate the server localhost:8000.
> Please check the server name and try again.
> 


