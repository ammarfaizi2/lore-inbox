Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279468AbRJ3J3r>; Tue, 30 Oct 2001 04:29:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279483AbRJ3J3i>; Tue, 30 Oct 2001 04:29:38 -0500
Received: from gnu.in-berlin.de ([192.109.42.4]:26383 "EHLO gnu.in-berlin.de")
	by vger.kernel.org with ESMTP id <S279468AbRJ3J30>;
	Tue, 30 Oct 2001 04:29:26 -0500
X-Envelope-From: kraxel@bytesex.org
Date: Tue, 30 Oct 2001 10:51:51 +0100
From: Gerd Knorr <kraxel@bytesex.org>
To: volodya@mindspring.com
Cc: video4linux-list@redhat.com, livid-gatos@linuxvideo.org,
        linux-kernel@vger.kernel.org
Subject: Re: [V4L] Re: [RFC] alternative kernel multimedia API
Message-ID: <20011030105151.A4545@bytesex.org>
In-Reply-To: <20011029134034.A9113@bytesex.org> <Pine.LNX.4.20.0110290807280.17469-100000@node2.localnet.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.20.0110290807280.17469-100000@node2.localnet.net>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > So I can distribute the driver and the application to use it and not
> > > depend on the kernel version.
> > 
> > The exported API must not depend on the kernel version.  If the API
> > changes in a way which isn't backward compatible, it is a kernel bug.
> 
> I already got a report from the user that in his kernel
> video_register_device has 2 arguments and not 3. This is pain to deal with
> in drivers distributed separately from kernel tree.

Internal kernel interfaces are another story, they are not fixed and are
allways subject to change and not limited to v4l.  See the major pci
subsystem changes from 2.2 => 2.4 for example.  The API visible to the
application matters, this must stay backward compatible.

> > I can't see why it is a problem to add a new header or new ioctls to
> > a existing header file.  I like it this way, because the kernel headers
> > with all the #defines and structs are providing at least a minimum of
> > documentation.  I do often read header files when programming stuff.
> > 
> 
> Because we don't know which interface is best until we experiment with
> it. And I can't experiment without people being able to test. And the
> easier it is to compile and install code the more testers (and developers
> !) we get.

I can't see why ioctls don't allow you to experiment.

> > Of course old applications don't know about the new stuff (neither the
> > temporary nor the final versions which make in into the official API
> > some day maybe).  But I don't see how your approach handles this better:
> > Applications still need to be hacked to use the new stuff ...
> > 
> 
> The way you write device specific appliacation is by including kernel
> headers. If the stuff we want is not there makes a lot trouble for
> installing and maintaining code.

No, it doesn't.  I never had trouble with xawtv.  I simply shipped a
private copy of videodev.h with the xawtv tarball (which allowed to
build it without hassle on 2.0.x systems which had no linux/videodev.h
yet).

> > You can't.  But I don't see why this is a issue:  The only thing a
> > application can handle easily are controls like contrast/hue where the
> > only thing a application needs to do is to map it to a GUI and let the
> > user understand and adjust stuff.  The other stuff has way to much
> > non-trivial dependences, I doubt a application can blindly use new
> > driver features.
> 
> Have you ever thought that the reason we only use these controls is
> because they are the only ones easy to implement now ?

I doubt this is just a implementation issue.  I don't believe in AI.

> > > > >   * can cause problems with different compilers
> > > > 
> > > > Then your compiler is buggy.
> > > 
> > > No, I may have simply used different compilers for the kernel and the
> > > application.
> > 
> > I doubt that.
> 
> You are kidding, aren't you ? Most distributions now come out with egcs
> compiler 1.1.x "recommended for compiling" kernels and something newer.

I doubt that this creates trouble, not that you might use different
compilers (I know RH ships or used to ship kgcc ...).

> > > What if the driver does not support counting dropped frames ?
> > 
> > -EINVAL or something like that.
> 
> But supports every other field.

Can't happen, there is VIDIOC_G_PERF only for this performance
monitoring ...

> > > What if there is a control with no min/max limits ?
> > 
> > Do you have a example?
> > 
> 
> Overlay color key - this is basically an RGB pixel value.

0x000000 => 0xffffff ?

> I would prefer minimum effort on the part of driver writer ;) At the
> moment all I see in bttv and my own code for select is looking on some
> already existing fields. Heck, the code is very similar to what needs to
> be checked for a blocking/non-blocking read. Why duplicate it ?

bttv's poll function is very short for exactly this reason.  Basically I
only have to call poll_wait with the (existing) wait queue which the IRQ
handler will wake up once the frame capture is finished.

> Also, v4l select will not work (as far as I understand) when the driver is
> using memory-mapped buffers.

v4l2 expects drivers to support select for the mmap() case too.

  Gerd

-- 
Netscape is unable to locate the server localhost:8000.
Please check the server name and try again.
