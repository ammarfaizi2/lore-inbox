Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263942AbTCVWjZ>; Sat, 22 Mar 2003 17:39:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263946AbTCVWjY>; Sat, 22 Mar 2003 17:39:24 -0500
Received: from main.gmane.org ([80.91.224.249]:2526 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id <S263942AbTCVWjO>;
	Sat, 22 Mar 2003 17:39:14 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Nicholas Wourms <dragon@gentoo.org>
Subject: Re: small devfs patch for 2.5.65, plan to replace /sbin/hotplug
Date: Sat, 22 Mar 2003 17:43:50 -0500
Message-ID: <3E7CE726.7080805@gentoo.org>
References: <20030322152550Z262038-25575+35093@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@main.gmane.org
Cc: kpfleming@cox.net
User-Agent: Mozilla/5.0 (Windows; U; Win 9x 4.90; en-US; rv:1.0.2) Gecko/20030208 Netscape/7.02
X-Accept-Language: en-us, en
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jordan.breeding@attbi.com wrote:
>>On Fri, 21 Mar 2003, Kevin P. Fleming wrote [lines rewrapped 
>>to fit 80 columns]:
>>
>>>Adam J. Richter wrote:
>>>
>>>Are you still considering smalldevfs for 2.6 inclusion?
>>
>>	Yes.  Andrew Morton has been very supportive of it and
>>just wants some more support for backward compatible names, perhaps
>>something as simple as shipping devfs_helper with an optional tar file
>>that could be unpacked in /dev as part of the boot process (along with
>>some documentation on setting this up), or a sample /etc/devfs.conf
>>for creating legacy names dynamically as needed.
> 
> 
>   I would like the idea of a sample /etc/devfsd.conf much better for one
> reason, the whole point of devfs (at least to me) is to stop cluttering /dev
> with entries for devices which aren't even present, an /etc/devfsd.conf would
> still only create compatability file for nodes which are present, unless I am
> missing something an optional tar file would have to contain every possible
> compatible device name and would create the same mess which some distros have
> in /dev right now.  That said, I really like the idea of having compatible device
> names at least for a while so things like `cdrdao read-toc --device 2,4,0 toc_file`
> will stop complaining when the version of libscg it is using can't find a /dev/sg?
> device to play with.  Most boot time issues are easy to solve with smalldevfs, but
> it's the problems like cdrdao which are harder to solve, especially when the real
> problem is in a library it builds and uses and the library is at least fairly complex.
> 
> 
>>>If not, then
>>>I'd like to discuss with you (and Greg KH) the possibility of just
>>>eliminating devfs entirely, and moving to a userspace version that is
>>>driven entirely by /sbin/hotplug.
>>
>>	Even though I expect small devfs to get into both 2.6 and 2.7,
>>I would still be interested in discussing a userspace scheme.  When and
>>if such a scheme became reasonably reliable working code, I might
>>suppport removing devfs, depending on how it turned out.
>>
>>
>>>There are already adequate hotplug events generated in 2.5.65+
>>
>>	You need lookup events, so that you can, for example, load
>>the floppy driver when the user looks up "/dev/floppy/0".
>>
>><some text cut to keep this short>
>>
>>	In fs/devfs, I split interface.c from fs.c for this reason.
>>There is nothing specific to the devfs filesystem implemention in
>>interface.c.  You could conceivably set devfs_vfsmnt to any valid
>>vfsmnt, and device nodes would be created and deleted in that file
>>system.  The only obstacle with doing that on a disk filesystem is the
>>bootstrapping problem of mounting the filesystem in the first place.
>>I can think of only three special properties that the ramfs variant
>>in fs/defs/fs.c implements:
>>
>>	1. It calls /sbin/devfs_helper for certain events.
>>	2. It can be instantiated early.
>>	3. It implements a single instance filesystem, so that the
>>	   contents of devfs are remembered if you unmount devfs
>>	   and remount it somewhere else.
>>
> 
> 
>   I would like to chime in on the issue of devfs (small or regular)
> versus doing everything in user-space.  It is nice that people are willing
> to try and shrink the kernel and get some things into user-space, but as long
> as Linux still has the possibility of build a completely monolithic, non-modular,
> no initramfs kernel I would like to see devfs hang around as an option for people
> who like /dev to only contain devices they have.  I for one always just build my
> kernels as monolithic and hate using initramfs (I think changing /etc/fstab and
> /boot/grub/grub.conf is much easier than also having to rebuild an initrd just
> to change what type of journaling ext3 is performing on /).  I am usually not
> a big believer in things _needing_ to stay in the kernel but I think that a case
> can be made that devfs should stay in the kernel so that people can have a choice
> of whether or not to use initramfs.  I think if we could have an in kernel version
> _and_ a userspace version and allow people to choose one or the other it would
> probably make the greatest number of people happy in the simplest way.  Anyway,
> just my two cents.

I don't understand the need for this.  It seems to me, upon 
first inspection, to be another one of those "remove the 
code to shave some KB off the kernel source tarball size" 
type of things.  Even if it isn't that, it sure seems like a 
step backwards for linux.  I recall that the whole point of 
devfs was to eliminate the need for userland programs which 
required manual intervention.  It also disturbs me that this 
so-called userspace program provides less 
features/functionality then devfsd did.

Why would I complain?  Simple, devfs has been around for 
awhile, and IMHO has finally started to settle in as 
seasoned means of dealing with /dev.  For instance, we 
encourage our users to use devfs, because it allows us 
greater control and a finer grain of tuning for each users 
profile during boot-up.  It is rather convienient to have a 
silent daemon which handles all the necessary configuration 
in the background.  It's nice to have something which is 
live and can be changed w/o user intervention.  Your change 
would mean that we'd have to rewrite an entire system just 
because you decided that the kernel could do with a few 
hundred less KB.  It isn't just us, either.  I'm sure many 
out there in distro/user land might be at least annoyed 
about the approach you are taking.  There are many other 
reasons why this is not a good idea, most of which Jordan 
seems to have covered, so I will spare repeating them.

The more reasonable approach, at least to me, is the current 
clean up that HCH is doing.  He's reducing the devfs impact 
on the kernel and centralizing it into private source files 
without sacraficing much (if any) compatibility & 
functionality.  Why not work towards this route instead?  At 
the very least, give people a choice as to which 
implementation (big or small) they want use. If you don't 
like it, then don't compile it.  But don't remove it for 
others just to save some piddling space.

So, I advocate strongly that Linus should not apply this 
patch!  Of course, feel free to disagree...

Cheers,
Nicholas

P.S. - Not crossposting to hotplug as my discussion doesn't 
concern it.


