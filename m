Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261411AbUBNIuw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Feb 2004 03:50:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261500AbUBNIuw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Feb 2004 03:50:52 -0500
Received: from h24-82-88-106.vf.shawcable.net ([24.82.88.106]:50080 "HELO
	tinyvaio.nome.ca") by vger.kernel.org with SMTP id S261411AbUBNIuq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Feb 2004 03:50:46 -0500
Date: Sat, 14 Feb 2004 00:51:11 -0800
From: Mike Bell <kernel@mikebell.org>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: devfs vs udev, thoughts from a devfs user
Message-ID: <20040214085110.GG5649@tinyvaio.nome.ca>
References: <20040210113417.GD4421@tinyvaio.nome.ca> <20040210170157.GA27421@kroah.com> <20040210171337.GK4421@tinyvaio.nome.ca> <20040210172552.GB27779@kroah.com> <20040210174603.GL4421@tinyvaio.nome.ca> <20040210181242.GH28111@kroah.com> <20040210182943.GO4421@tinyvaio.nome.ca> <20040213211920.GH14048@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040213211920.GH14048@kroah.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 13, 2004 at 01:19:20PM -0800, Greg KH wrote:
> > That's a pretty minor difference, from the kernel's point of view. It's
> > basically putting the same numbers in different fields.
> 
> Heh, that's a HUGE difference!

Only from userspace's point of view. To the kernel, it's basically the
same thing.

Now keeping in mind again that I'm not advocating putting device nodes
into sysfs, what about a little thought experiment. Supposing you did
replace sysfs's major:minor text file with a real device node, which I
contest is basically the same thing for the kernel. You've got yourself
devfs right there. Sure, the names are unusably long for actual /dev
use, but when it comes down to it that's all it is. Your kernel now
creates all your device nodes for you automatically, just like that.

Now, here's a question. What's wrong with taking those and splitting
them into a new filesystem? As I see it, part of the reason procfs
became such a nightmare was because people thought there could be only
one kernel-generated filesystem and put everything in there. Linux
is moving a lot of the silly magic values out of proc and into sysfs
where they make more sense. Great! But what about stuff that doesn't
really fit into sysfs as it is right now? Should we take sysfs's clean
interface and extend it with special cases until it's the ugly mess proc
is? Or leave everything that doesn't fit cleanly into sysfs in proc,
making proc a sort of special-cases wasteland?

Alternativly, why not say that there doesn't need to be just one or two
kernel-exported filesystems, and instead make a sort of library for
exporting kernel information via fake filesystems (I can't remember, has
this already been done?), and make one for every purpose - that does one
thing and does it well? procfs could do processes and processes alone. A
seperate filesystem could handle sysctls, sysfs could focus on devices
and how they're attached to the system as it (mostly) does now. And then
devfs is just one more filesystem of many. I'm not a kernel hacker, but
if they all share common code so functionality isn't duplicated (ie,
procfs and sysfs and whatever else use the same mechanisms to write
stuff instead of each doing the exact same thing with their own code) I
don't see why it would neccessarily be more than a miniscule overhead,
like what's imposed by using lots of small partitions instead of one
giant /.

So yeah, that's a rather longwinded way of saying "Sure, it can be done
in sysfs. That's not the question, the question is whether sysfs is the
BEST place to do it." If elsewhere gets you more functionality, I'd say
no. It all comes down to the overhead of a new kernel filesystem versus
the benefits you get. And while the only way to really know would be to
code it, I think kernel filesystems could be made very cheap. Maybe even
resulting in a net reduction in memory use as /proc is cleaned up. So it
wouldn't take much added functionality to make it worth the while.


>  - you get /sbin/hotplug calls for "free" too.  Yes, you can config this
>    out, but the added benefits of hotplug calls far outweigh any memory
>    savings you get for not enabling this option (embedded systems not
>    included.)

How do you figure that's free? hotplug's a great feature, nothing
against it, but as far as I know the vast majority of installations
aren't making use of it right now. So how does it become free if you're
taking something that can be turned off, which you aren't using right
now, and using it for udev? I'm very confused by the way you define free
and not free, it seems to be a sort of "I like this interface, so I
would have enabled whether I was using it or not, therefore it's
effectivly free!" system. :)

> So, if you put hotplug and sysfs together, udev can control your /dev.
> And it can provide persistent device naming, which on its own, devfs can
> not.

Absolutely. But again, you're talking about udev and devfs, when you
should talk about udev and devfsd. The question isn't whether it can be
done using udev (though there are still several things a devfs can do
that to my knowledge udev can't) but whether it is the BEST way of doing
it. As I see it, whether you call it udev or devfsd it's a userspace
daemon that handles names (whether alternate or not) and permissions and
the like. The question isn't udev versus devfs, it's what is the
cleanest and best interface for this userspace daemon (which you need in
any configuration) to use to talk to the kernel? When I object to udev,
it's not to the idea of a userspace daemon that manages permissions,
I don't see how you can do away with that. It's to the way udev talks to
the kernel, and on a non-technical front the way your perceptions of
udev versus devfs result in what I see as misleading "udev versus devfs"
claims.

> Not at all.  sysfs has 1001 goals at the least.  So many different
> people are using it for different things that it's really amazing to me.
> It also shows how powerful and how correct the model of it is.

I didn't say sysfs was there only to serve udev. I said they're both
accomplishing one common goal. So what if sysfs does 1001 other things
as well? Does that mean I can tack some lame-brained extension on to
sysfs and say "hey look, you may hate what I'm doing, but sysfs does
1001 other things as well, and they're all good, therefore what I'm
doing is good as well"?

Again, I like sysfs. At least most of it, I'm a bit concerned about
stuff like /sys/power/disk and /sys/fs. That seems a lot like the thin
end of the wedge toward what /proc became. Sure, you've got the
one-value-per-file, which is a great cleanup, but if that keeps going
we may wind up with the same insane namespace pollution we've got in
/proc right now, ie we've solved only half the problem of /proc. sysfs's
core undoubtedly had the right idea though, the values in it all make
sense in how they're layed out.

> And as stated above, you always get sysfs in your kernel (unless you are
> running the -tiny tree...)

So what happens if that particular patch makes it into the mainline
kernel? To me saying sysfs is free isn't a good argument, even though I
like it and include it in all my kernels (despite the fact I don't use
udev).



On an only semi-related note, I've been thinking about the whole "naming
policy in the kernel" thing. This is only tangentally related to my
comments about udev and devfs, but I'm wondering if anyone REALLY needs
to be able to specify non-default names for devices.

For instance, does anyone out there modify their BSD system to have more
linuxy device names, or vice-versa? Or when people talk about not
setting naming policy for dev in the kernel, are they REALLY saying "I
don't like the scheme you thought up"?

As I've said before, no one objects to sysfs's naming in the kernel, no
one wants to assign every sysfs node a number and keep the names out of
the kernel. Same for any number of interfaces that the kernel exports.
Why is dev special? Would devfs has been more popular if it had been
more conservative with its naming scheme?

Do we really need more than one layout for /dev? Or are objections based
less around the need for everyone's dev to be different, and more around
people not having agreed on one good layout yet? I'm of the opinion that
one common layout for /dev is a GOOD thing, it makes things predictable
between systems. Do you want to be completely unable to guess what
device your mouse is, because distribution X uses one name while Y uses
another? I heard that udev gives one common dev layout (LSB) but the
kernel could do the same. The difference is that udev makes it much
easier to completely replace the LSB layout with a different one. But
do any people really need completely different layouts so badly that we
should be making that need one of the key architectural design points?
(It's right there in udev_vs_devfs, number one of three design points.)

Sure there are cases where you might need one or two alternate device
names (like classifying your devices in some completely non-obvious way,
say /dev/PrintersWithinWalkingDistance/ and
/dev/PrintersOnTheOtherSideOfTheOffice) but is that something you need
to focus on, or could it be better handled with symlinks, or "as well
as" device nodes?

Assuming for the moment udev is the right way to go, /dev management
wise, and LSB is the best /dev layout imaginable, mightn't it make sense
to actually make it HARDER to override LSB defaults so people are
encouraged to use the symlinks method, and so the various distributions
don't drift apart? Freedom of choice is all well and good, but that
doesn't mean you should optimise for chaos.

