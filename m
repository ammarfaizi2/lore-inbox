Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272324AbRH3QoN>; Thu, 30 Aug 2001 12:44:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272326AbRH3QoE>; Thu, 30 Aug 2001 12:44:04 -0400
Received: from smtp7.us.dell.com ([143.166.224.233]:39176 "EHLO
	smtp7.us.dell.com") by vger.kernel.org with ESMTP
	id <S272324AbRH3Qnp>; Thu, 30 Aug 2001 12:43:45 -0400
Date: Thu, 30 Aug 2001 11:44:02 -0500 (CDT)
From: Michael E Brown <michael_e_brown@dell.com>
X-X-Sender: <mebrown@blap.linuxdev.us.dell.com>
Reply-To: Michael E Brown <michael_e_brown@dell.com>
To: Ben LaHaise <bcrl@redhat.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] blkgetsize64 ioctl
In-Reply-To: <Pine.LNX.4.33.0108301222010.12593-100000@toomuch.toronto.redhat.com>
Message-ID: <Pine.LNX.4.33.0108301131070.1213-100000@blap.linuxdev.us.dell.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm sorry, but I am the one who wrote the ioctl. And I have to admit my
shortcomings. I looked at fs/block_dev.c and it is a big, ugly, quagmire
of code to somebody who isn't a deep kernel-guru. If I were to have tried
that and made some kind of mistake, it would have affected more people
(everybody). As it is, my code is limited to a limited-use ioctl. If there
is a bug in my code there, it will A) be easier for people to find, and B)
affect fewer people.

The next point I would like to make is this: I was adding code to patch
over a hole in the existing API, not trying to create a whole new API, or
fix the exising API in a way that made it incompatible with previous
versions. As for your *trivial* UGLY hack for fs/block_dev.c, how likely
do you think it would be for that to get accepted by Linux, Alan, et al.
At least with the IOCTL, the code stays separate and can be easily
maintained separately from the main kernel until it either gets integrated
or a better API comes along. A *trivial* UGLY hack for fs/block_dev.c
would be harder to maintain for a longer term as a separate entity.

The great thing about the IOCTL is that I have written all of my code that
uses the IOCTL in such a manner that it tries to access the last block
of the disk and only falls back to the IOCTL if there is an error trying
to go through the normal API. So, feel free to fix the block_dev.c API,
and then all of the programs that I wrote which use that IOCTL will no
longer use it. You can then drop the IOCTL entirely.

And your last point about risking unexpected disk-io due to an incorrect
IOCTL, I would say that is a pretty unlikely in practice. First, I do
parameter checking on what was passed to the IOCTL, and if things don't
match, no io is done. Second, how likely is it that you a) call ioctl with
a (disk) block device, b) pass the wrong ioctl, c) pass along enough data
to pass the checks in the ioctl, and d) pass along a valid pointer to 512
bytes of data to overwrite something?

--
Michael

On Thu, 30 Aug 2001, Ben LaHaise wrote:

> On Thu, 30 Aug 2001, Michael E Brown wrote:
>
> > In reference to the ia64 ioctls:  I'm sorry, but disk access APIs that
> > don't allow access to the whole disk are what is broken. These ioctls
> > would not be necessary if you could actually write to the last sector of
> > an odd-sized disk. Have you read the comments surrounding this ioctl?
>
> Were people's heads on backwards when they wrote the ioctl?  Quite simply:
> if an ugly hack has to be put in place, put it in the right place.  In
> this case, it would have been *trivial* to put the UGLY hack in
> fs/block_dev.c and just make read/write transparently able to access the
> end of the disk.  No adding crap to the API, and certainly not risking
> truely unexpected disk io due to an incorrect ioctl.
>
> 		-ben
>
>

-- 
Michael Brown
Linux OS Development
Dell Computer Corp

  If each of us have one object, and we exchange them,
     then each of us still has one object.
  If each of us have one idea,   and we exchange them,
     then each of us now has two ideas.


