Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261724AbTJ1Wpi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Oct 2003 17:45:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261773AbTJ1Wpi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Oct 2003 17:45:38 -0500
Received: from mail.kroah.org ([65.200.24.183]:33693 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261724AbTJ1WpQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Oct 2003 17:45:16 -0500
Date: Tue, 28 Oct 2003 14:44:16 -0800
From: Greg KH <greg@kroah.com>
To: Steven Dake <sdake@mvista.com>
Cc: Lars Marowsky-Bree <lmb@suse.de>, Mark Bellon <mbellon@mvista.com>,
       linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
       linux-hotplug-devel@lists.sourceforge.net
Subject: Re: ANNOUNCE: User-space System Device Enumation (uSDE)
Message-ID: <20031028224416.GA8671@kroah.com>
References: <3F9D82F0.4000307@mvista.com> <20031027210054.GR24286@marowsky-bree.de> <3F9D8AAA.7010308@mvista.com> <20031028110034.GG30725@marowsky-bree.de> <1067364727.4612.359.camel@persist.az.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1067364727.4612.359.camel@persist.az.mvista.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 28, 2003 at 11:12:07AM -0700, Steven Dake wrote:
> On Tue, 2003-10-28 at 04:00, Lars Marowsky-Bree wrote:
> > On 2003-10-27T14:14:18,
> >    Mark Bellon <mbellon@mvista.com> said:
> > 
> > > The uSDE and udev are simlar in some respects. The uSDE allows for 
> > > complete control of the policy handling a device - not just its naming. 
> > 
> > Well, so could udev in theory, and I had this plan to enhance it to do
> > so for the specific case of multipathing one day in the not too distant
> > future (ie, before q1/04).
> > 
> > In as far as I can see, udev and uSDE really do not have too different
> > goals. Competition is good, but only if they explore distinct approaches
> > ;-)
> > 
> There are several distinct approaches which have been enumerated in
> other mails.
> 
> Since this point has not been addressed, I'd like to focus on the major
> difference in philosophy.
> 
> SDE places all policy in the hands of the policy developer in a seperate
> policy program.  udev places the policies in the main processing loop of
> the system, effectively implementing whatever policy is desired by the
> udev maintainers.

What do you mean by "policy"?

If you are saying that SDE allows programmers the ability to write new
programs to plug into your framework to create new types of policies,
then I understand that.  Your loadable plugins look like they support
that.  But they require a dynamic loader :)

What udev is doing is trying to provide a flexible policy that will work
for everyone, with a heirchy of rules that can be easily controlled and
changed by anyone who can operate a text editor (and soon to be changed
by GUI applications, like the HAL project).

I have not heard of any situation in which the current udev set of rules
do not work out for them.  And if you can think of one, can't it be
covered by the CALLOUT rule?  For example, someone has sent me a small
userspace program that works with the CALLOUT rule that handles
multipath devices by talking to the dm code.  Now that's pretty
flexible.

If you (or anyone else) thinks of something that the existing udev rules
do not handle, please let me know.  If it's too complex, then yes, the
user should use write their own SDE plugin.  But remember, 99.9% of the
people out there just want the LSB device names, with possibly a
persistent entry for their digital camera and USB joystick, which udev
handles just fine today.

For people with 4000 real scsi disks, udev also works well.  That seems
to cover the wide range of users.

> Without seperating policies from the core executive of device naming
> system, the core of udev suffers from the same issues as placing policy
> in the kernel suffers.   Lack of maintainability, lack of user-defined
> functionality, bloat, etc.

Easy Separation?  Hm, in looking at udev, if you just replace 2 .c files
with your new naming scheme, everything works just fine.

And if you want to go down the path of accusations about lack of
maintainability, bloat, etc. I will be glad to point people at your tree
and then they can see these kinds of numbers:

For SDE:
$ find . -type f | egrep '[.c|.h]$' | xargs wc -l | tail -1
  57328 total

Wow, you build 18 shared libraries:
$ find . -type f | grep '\.so' | wc
     18      18     625

For udev:
$ find . -type f | egrep '[.c|.h]$' | xargs wc -l | tail -1
  17632 total

And that includes all of klibc, which really is not fair for udev to
calculate.  So let's just look at the udev code size:
$ ls | egrep '[.c|.h]$' | xargs wc -l | tail -1
   2613 total

And to be complete, let's add the totals of libsysfs and tdb, but to be
fair any udev developer never has to look into those files:

libsysfs is this big:
   3798 total

And tdb is this big:
   2679 total

So adding those numbers up we get these kinds of numbers for size of the
.c and .h files in the different projects:
	SDE:	57328 lines
	udev:	 9090 lines

That makes SDE over 6 times bigger in source code alone than all of
udev (including tdb and libsysfs).

I can compare executable size too, if you really want to still claim
that udev is suffering from "lack of maintainability and bloat" if you
really want :)

Oh, any reason you all haven't shown a working uSDE system in public
anywhere?

thanks,

greg k-h

p.s. yes, I know lines of code is a horrible metric, and doesn't really
mean squat.  I just want to point out the huge size difference between
the current state of udev and SDE, with pretty much identical
functionality from what I can tell.
