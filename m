Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278667AbRJZPtG>; Fri, 26 Oct 2001 11:49:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278666AbRJZPst>; Fri, 26 Oct 2001 11:48:49 -0400
Received: from mpdr0.detroit.mi.ameritech.net ([206.141.239.206]:41205 "EHLO
	mailhost.det.ameritech.net") by vger.kernel.org with ESMTP
	id <S278658AbRJZPsl>; Fri, 26 Oct 2001 11:48:41 -0400
Date: Fri, 26 Oct 2001 11:19:07 -0400 (EDT)
From: volodya@mindspring.com
Reply-To: volodya@mindspring.com
To: video4linux-list@redhat.com, livid-gatos@linuxvideo.org,
        linux-kernel@vger.kernel.org
Subject: Re: [V4L] Re: [RFC] alternative kernel multimedia API
In-Reply-To: <slrn9tiq3v.69j.kraxel@bytesex.org>
Message-ID: <Pine.LNX.4.20.0110261037080.11540-100000@node2.localnet.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 26 Oct 2001, Gerd Knorr wrote:

> > > I would like to see a detailed explanation of how the capabilities 
> > > differ from those of v4l2.
> >  
> >  The major difference is in increased flexibility and stability of
> >  kernel-user space interface.
> >  
> >  On the application side:
> >         * ability to utilize advanced driver features without explicit
> >           knowledge of their behaviour
> >         * wider compatibility without the need for recompile
> 
> what exactly is bad with the v4l2 controls?

a) no way to use them to set non-integer data (like gamma tables)
b) labels are limited to 32 chars, no way to provide "comment" fields.
  (I would like the driver to provide a short label and longer,
   user-readable and understable comment field).
c) no way to present control dependencies.
  For example in ATI cards there are several ways you can control gamma:
  gamma table, gamma overlay setting, gamma setting in the decoder chip.
  same goes for brightness. I would rather expose all the controls and
  show their relationship then bundle them up in one control
  (as to why this is relevant to kernel and not only Xv see below)

> 
> >  On the kernel side:
> >         * elimination of interfaced specific headers
> 
> Ok, you replace the '#define V4L2_CID_HUE 0x???' with the magic string
> "HUE" then.  The point is?

ioctl are kernel specific. My scheme proposes a set of mmaped buffers and
character stream. The plus is that I can make Xmultimedia extension that
also presents a set of shared buffers and character stream. The
application code will be exactly the same.

Additionally nonone will need to include kernel headers to compile the
application. Also magic string HUE is a bigger namespace then an
integer number. 

> 
> >  On the driver side:
> >         * be compatible with a wide range of applications
> 
> ???
> Sorry, but I don't see why your approach handles this better than v4l2.

Since the application accesses the driver symbolically they only have to
worry about agreeing on semantics. For example the driver can layout its
control structs any way it likes (say, to mirror hardware registers) and 
the application will bind to them. 

Also, mmaped buffers + character device fits a larger category then just
the devices mentioned in v4l2 specifications. Granted the specification
can be extended, but the new driver will have to distribute not only its
source but a patch to the kernel headers. The scheme will avoid this.

> 
> >         * introduce support for new features without the need to modify
> >           kernel interfaces
> 
> Hmm.  I don't like the idea to add new stuff that easily.  People tend
> to do quick&dirty hacks + crazy stuff with it, leading to more
> incompatibilies between drivers and applications.

And people will always be able to write a driver outside video4linux
framework. In fact, plenty of drivers and applications are incompatible as
is. The same is true about audio drivers. 

The compatibility is achived best by specifications that are clear and
easy to implement. This proposal helps it by providing a well defined
interface and by separating semantic meaning from actual interface. 
First the internal kernel library will insure that the control interface
is standard across drivers. Secondly, the drivers are free to use whatever
fields they want - no restriction their. Thirdly, the way the applications
know they deal, say, with a grabber device is when the driver says it
supports a certain INTERFACE_CLASS. Hence, to make sure the drivers
behave, all we have to do is bar any driver which declares itself
compliant with a certain INTERFACE_CLASS but isn't from entering the
kernel. And the added advantage is that we can have many INTERFACE_CLASSes
which vary in implementation difficulty, so that BASIC_GRABBER-YUV422
would be very easy to implement (just expose the buffers) and something
more advanced could be added later. This solves the conflict of people
wanting to have _some_ driver and the time consumption of writing a driver
that supports all features.

> 
> >  The last point is the very important in my opinion. For example, in
> >  current specification, v4l2 has no support for TV-out in graphics cards.
> >  It has no support for setting complex parameters like gamma tables. 
> >  Using memory-mapped buffers requires device specific ioctls.
> 
> Which device specific ioctls?  They are common for _all_ v4l2 devices.

Quote from http://www.thedirks.org/v4l2/v4l2dev.htm :

A common use for memory-mapped buffers is for streaming data to and from
drivers with minimum overhead. Drivers will maintain internal queues of
buffers and process them asynchonously. The ioctl commands for doing that
are described in the device-specific documents. Memory-mapping can also be
used for a variety of other purposes. Drivers can define hardware-specific
memory buffer types if needed. Use V4L2_BUF_TYPE_PRIVATE_BASE and greater
values for such buffer types. 


> 
> >  The goal is to create an interface that does not rely on structures
> >  defined in kernel headers for communication. 
> 
> Why do you want to do that?

 * not elegant
 * kernel structures force a specific model onto a driver
 * can cause problems with different compilers
 * confuse applications when a driver does not implement a field

Here is another way one may arrive at this kind of interface:
 
Consider capability flags. Wouldn't it be nice to have the driver present
them symbolically instead of bits ? Besides everything else you get around
the issue of running out of bits when adding new ones. 

So you can query device and get a string of the form:

 PREVIEW,SELECT,TUNER

However, this is hard to implement with ioctl's as they rely on fixed
length structures. You would have to call first to find out the size of
the buffer you need (which the driver would have to compute) and then the
second time to get the data. Eeeks. Instead just make a device and let the
application do something like:

write:  ?QUERY_CAPABILITY\n
read: PREVIEW,SELECT,TUNER

Much better, ha ? Now if you agree that this is nice we can use the same
scheme for other things. For example the whole control (i.e. hue,
etc) query can be done thru this device. No need for structs. Same goes
for width,height,picture format etc. 

Now what is left are the structs describing the format of memory buffers. 
But the driver typically has this info in a struct itself. Instead of
getting it via ioctl simply mmap the area - you'll be getting the exact
same information yourself with less context switches.

This gets rid of the structs. 

What is left of v4l now are synchronization ioctls. But we can replace
them with read/writes on the control device. With the added benifit that
we can select on it to wait for an event.

                      Vladimir Dergachev

> 
>   Gerd
> 
> -- 
> Netscape is unable to locate the server localhost:8000.
> Please check the server name and try again.
> 
> 
> 
> _______________________________________________
> Video4linux-list mailing list
> Video4linux-list@redhat.com
> https://listman.redhat.com/mailman/listinfo/video4linux-list
> 



