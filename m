Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261164AbREORY7>; Tue, 15 May 2001 13:24:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261167AbREORYu>; Tue, 15 May 2001 13:24:50 -0400
Received: from [206.14.214.140] ([206.14.214.140]:46852 "EHLO
	www.transvirtual.com") by vger.kernel.org with ESMTP
	id <S261216AbREORWv>; Tue, 15 May 2001 13:22:51 -0400
Date: Tue, 15 May 2001 10:21:47 -0700 (PDT)
From: James Simmons <jsimmons@transvirtual.com>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Neil Brown <neilb@cse.unsw.edu.au>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        "H. Peter Anvin" <hpa@transmeta.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        viro@math.psu.edu
Subject: Re: LANANA: To Pending Device Number Registrants
In-Reply-To: <Pine.LNX.4.21.0105150803230.1802-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.10.10105151002410.22038-100000@www.transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > Given a file handle 'X' how do I find out what ioctl groups I should apply to
> > it. So we can go from
> > 
> > 	if(MAJOR(st.st_rdev) == ST_MAJOR)
> > 		issue_scsi_ioctls
> > 	else if(MAJOR(st.st_rdev) == FTAPE_MAJOR)
> > 		issue_ftape_ioctls
> > 	else ..
> > 	else
> > 		error

[snip]..

> The fix, I think, is to make the ioctl commands much more regular. That is
> probably true in general, and fixing that would hopefully fix the need for
> horrible code like the above.

   I have to agree. We also ran into this problem for the framebuffer
layer. If you look in fb.h you see abunch of driver specific ioctl apart
of the standard ioctl space. One purposal I had was that we allocate the
first 50 to be "standard" ioctl calls which all drivers could support
and the rest driver specific. Well no one liked that. Now I look back I
agree. It was a bad idea. So what is the solution?

What I wish was done was the very first ioctl call was a generic ioctl
call to pass driver specific data. Basically you have something like this:

struct fb_driver_specific_data {
	__u32 magic_identifier;
	__u32 size_of_data_packet;
	char *data_buffer;
} 

ioctl(FBIO_DRIVER_SPECIFIC, struct fb_driver_specific_data);

This data would be passed to the driver. The driver would then valid it
and process the data. If not it would ignore it. Here you have just one
ioctl call that every driver could use but yet it can do driver specific
functionality.

   The rest of ioctl space would be "standard" ioctl calls that all
drivers or more than 90% could use. A good example is blanking. Pretty
much all graphics hardware supports this function. 
   Now what about extensions on these standard functionality. Again the
blanking function is a good example. Several handheld devices support back
and front lighting and you can control the level of brightness of the
screen. In this case you can expand the blanking function. You can promise
some sort of blanking can occur but you can't promise you can control the
brightness of the screen. If you ask a driver to do this and it can't
deliever you just let the user know you can't do it. Simple as that.

> doesn't look horrible, and I don't see why we couldn't expose the "driver
> name" for any file descriptor. We already do for some: "fstatfs()" is
> largely the same thing on another level.

I don't find that a bad thing either.

