Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932139AbWF3W6Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932139AbWF3W6Y (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jun 2006 18:58:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932188AbWF3W6Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jun 2006 18:58:24 -0400
Received: from hobbit.corpit.ru ([81.13.94.6]:2910 "EHLO hobbit.corpit.ru")
	by vger.kernel.org with ESMTP id S932139AbWF3W6X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jun 2006 18:58:23 -0400
Message-ID: <44A5AC85.5010104@tls.msk.ru>
Date: Sat, 01 Jul 2006 02:58:13 +0400
From: Michael Tokarev <mjt@tls.msk.ru>
Organization: Telecom Service, JSC
User-Agent: Mail/News 1.5 (X11/20060318)
MIME-Version: 1.0
To: "H. Peter Anvin" <hpa@zytor.com>
CC: Gerd Hoffmann <kraxel@suse.de>, Milton Miller <miltonm@bga.com>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: klibc and what's the next step?
References: <Pine.LNX.4.64.0606271316220.17704@scrub.home> <f5e0f599448456bcbf2699994f0bbc76@bga.com> <Pine.LNX.4.64.0606290117220.17704@scrub.home> <200606290034.k5T0YkCw028911@terminus.zytor.com> <Pine.LNX.4.64.0606300038410.12900@scrub.home> <44A4DA33.5050707@suse.de> <44A568B5.3000208@zytor.com>
In-Reply-To: <44A568B5.3000208@zytor.com>
X-Enigmail-Version: 0.94.0.0
OpenPGP: id=4F9CF57E
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

H. Peter Anvin wrote:
> Gerd Hoffmann wrote:
>>   Hi,
>>
>>> As it looks like it's distribution which are mostly interested in
>>> this. Have you talked with any distribution maintainer to find out
>>> what they need and what they want to put initramfs? What are the
>>> exact problems which distributions have and how do you want to solve
>>> them?
>>
>> Well, we already have an initramfs, and it can do quite some stuff the
>> current kernel doesn't do.  Here is a (probably incomplete) list:
>>
>>   * load kernel modules needed to access and mount the root filesystem
>>     (block device driver, filesystem module, device mapper, ...)
>>   * raid/lvm2/evms setup.
>>   * iscsi setup.
>>   * fsck root filesystem before mounting it.
>>   * setup /dev in tmpfs (using udev).
>>
>>> How do we avoid having to split all utils into a klibc version and
>>> the normal version?
>>
>> That is a big question.  Latest suse doesn't use klibc any more.  Older
>> versions had a bunch of static klibc-based binaries for some utilities,
>> i.e. insmod, udev, sh.  Sometimes you needed glibc because one of the
>> tools needed in initramfs had no klibc-version (rootfs-on-lvm case for
>> example).  After adding the "fsck rootfs" feature (I think) we had glibc
>> on the initramfs in almost all cases.  So if you end up with glibc in
>> initramfs anyway, what is the point of having klibc?
> 
> For a "big" distribution that runs on modern kernels, then by all means,
> build something around glibc.  The additional disk space and memory is a
> proverbial drop in the bucket.
> 
> However, I don't think it's realistic for smaller systems.

Small systems don't build regular tools with glibc (at least the ones which
are "very small" - something like uclibc or ...) -- so it's logical to use
that same uclibc for initramfs too -- maybe because it's very likely some
other tool will be needed for bootstrapping, or because it's illogical to
have different tools doing the same task, or just because when booting,
a device usually have enouth resources (mostly memory) to run that stuff
from initramfs - eg my d-link g604 router with 16mb ram - uclibc and all
the boot utils will fit perfectly into memory, wich (the memory) will later
be freed and used by real daemons).

I can say about "normal" but old/underpowered PCs - like several i486 boxes
we use here either as X-terms or small routers or whatever.  It's perfectly
ok to use glibc here when booting if the system uses glibc normally, or use
uclibc in initramfs if the system uses uclibc normally, or... whatever.
An initrd with bash(!!), ifconfig, module-init-tools, and some more utils
(yes yes I know about busybox! :), all linked with glibc (and ncurses etc)
is about 4megs in size.  Even with only 8 megs of ram it will boot, and
after mounting real root all that 4 megs will be freed anyway.

So... which smaller systems you're talking about?

Well yes. Ok. Embedded stuff still (like my d-link router).  Currently it's
running 2.4 kernel, and there's no initrd/initramfs there, -- it boots off
a directly-addressible flash memory, jffs.  If there will be no code to
mount root in the kernel, initramfs will be needed, and the smaller it is,
the better (because flas space is also limited, here it's only 4mb).  And
there, maybe very small set of utils linked with klibc or dietlibc will
help (hopefully it all will not be much larger than current in-kernel
code).  But this sort of devices is special (usually requires alot of 3rd
party kernel patches for custom hardware), and the amount of utils needed
is so small.. oh well.  I suspect initramfs will be custom-built in such
cases.

What I'm trying to say, and tried to say several times already, is:
once all that code is removed from kernel space, and initramfs (either
"internal" or "external", ie, built as part of kernel or elsewhere)
becomes mandatory, there's little reason to have all that stuff inside
the kernel sources.  Except one: backward compatibility, so someone who
did not use initramfs explicitly will not use it with new kernel too
(which I personally don't see as a big issue, since almost all major
kernel change requires some new tools/infrastructure anyway).

Ie, most distros are already using initrd/initramfs (and some already
don't use in-kernel code), and the fact that kernel now supplies something
similar does not matter anymore, because "our (distro) initramfs", which
already worked for quite some time, and our users are used to it etc,
already does all what we need (either with glibc or something else).
So there's no need for them to use libc provided inside kernel, it
only makes things worse.

Worse because.  As you mentioned, klibc keeps compatibility cruft
at minimum, ie, some more recent kernel will need different klibc,
which, in turn, will not work on another kernel.  So.. how many
copies of the same utility is to keep?  Or maybe require sources
of every utility used during boot time to be here when compiling
the kernel, to recompile it with the klibc which goes with this
kernel?  And bundle all mdadm, lvm, iscsi etc stuff into kernel
rpm/deb package (without an ability to have custom user-supplied
executables in initramfs) ??

Yes, it'd be nice to have somehow standartized boot process.  But
umm..  that will require half an operating system to go with kernel
(eg, mdadm with its config file, which is /etc/mdadm/mdadm.conf on
Debian and /etc/mdadm.conf on other systems; and I do prefer to have
mdadm instead of mdassemble because it's impossible to do anything
with the latter if something goes wrong).

Kernel provides good (simple and clean) infrastructure for booting.
cpio archive, you just build it, by adding all the tools you think
are needed there, create /init, and voila.  It's enouth.  Yes some
tools are needed to be there, like kinit and parts of it, but even
kinit isn't really necessary, because the other tools providing
the same functionality already exists - there's almost(*) nothing
special in initramfs compared with regular root.

So the whole thing, as I see it, is just for backwards compatibility
for people who do NOT use initrd/initramfs.  And all the discussions
so far made this my opinion stronger...  So now I'm even thinking
about kinit (and parts thereof) as a compatibility layer, not only
klibc as before (if included into kernel source, that is.  I'm not
at all arguing against them being separate projects).

(*) One tiny thing which always bothered me: logging.  I'd love to
have all the boot messages (from initramfs) logged somewhere.  klibc
implements syslog() as writing to kernel log buffer, which partially
solves this.  It'd be better IMHO to have whole console redirected
(or tee'd) into that log buffer instead, up to some explicit knob
is hit, or by using some daemon which grabs the console and is able
to return it all (and terminate) when requested.  It's not only
initramfs issue, but early "regular" boot procedure is also affected
(everything before syslogd is started).  Some distros solves this
prob (eg bootlogd (if memory serves me right) on RedHat), but quite
often in some.. klugy way.  But that's another story.

/mjt
