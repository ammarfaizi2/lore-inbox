Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129444AbRCBT3k>; Fri, 2 Mar 2001 14:29:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129453AbRCBT3a>; Fri, 2 Mar 2001 14:29:30 -0500
Received: from ip164-208.fli-ykh.psinet.ne.jp ([210.129.164.208]:46789 "EHLO
	standard.erephon") by vger.kernel.org with ESMTP id <S129443AbRCBT3L>;
	Fri, 2 Mar 2001 14:29:11 -0500
Message-ID: <3A9FF46A.27443273@yk.rim.or.jp>
Date: Sat, 03 Mar 2001 04:28:42 +0900
From: Ishikawa <ishikawa@yk.rim.or.jp>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2 i686)
X-Accept-Language: ja, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
CC: Douglas Gilbert <dougg@torque.net>, rgooch@atnf.csiro.au
Subject: Found out why "sg" was loaded automagically. Re: devfs: "cd" device not 
 showing up initially.
In-Reply-To: <3A8595DC.B33CB0B2@torque.net> <3A874BE2.51C58711@yk.rim.or.jp>
Content-Type: text/plain; charset=iso-2022-jp
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Some time ago,  I posted a question concerning
the device name "cd" (module sr_mod) not appearing automatically
under my 2.4.x devfs/devfsd configuration.
However,  "generic"  (module sg) does appear
automagically.  This confused me a bit.

The subject I used back then was like
"devfs: "cd" device not showing up initially.

Doug Gilbert was kind enough to explain to me
that the module loading needed  be done explicitly
for sr_mod so that "cd" entries were registered by
devfs/devfsd. Then I came to wonder why
"generic" registeted by the module sg showed up.
I thought that I was not calling for automatic loading
of "sg" myself.
After a bit of exchange, Doug even went so far as to read
my config files to check for obvious mistakes, and we
could not find one.

It took me a while to figure out why "sg" was inserted
automatically.
The cause had nothing to do with devfs/devfsd interaction.

I found the answer today.

Short answer:

On my Debian GNU/Linux PC,
/etc/rcS.d/S20modutils (a symlink to /etc/init.d/modutils )
calls modprobe to install modules listed in
a file called  /etc/modules at boot time,
and "sg" was listed there.
(I don't know / have forgotten why "sg" is listed there.)

I didn't realize that Debian uses this /etc/modules file as part
of its grand module configuration scheme.
(Or I have forgotten about this completely.)

--- somewhat longer description.

I followed the suggestions given by various
parties after my post, and when I inserted  the
printk() inside a few scsi-related modules as
suggested by Doug Gilbert, the problem became immediately apparent.
The module "sg" was inserted by "modprobe", which in
turn was called from "S20modutils".
(swapon had nothing to do with the "sg" loading  as I recently  suspected.)

[I was going to insert "echo this is $0 or something to that effect in all of the
init script files to see where the sg loading was taking place, but
embedding the printk in a few C source files was easiter and so I tried it first.]

After seeing the message in dmesg output (now I use 128KB buffer
for printk to capture all the devfs/devfsd interaction debug messages),
I had to read /etc/init.d/S20modutils to find out why.
It turns out the Debian module init  script uses /etc/modules
to list kernel module names that need to be inserted at boot up time.
And, for reasons unknown to me (now), the name "sg" was there (!).

I should have realized that something was amiss when
lsmod showed unused modules as in

 tmscsim                29920   0  (unused)
 sg                     25728   0  (unused)
 nls_cp437               4384   0  (unused)
 hpfs                   69216   0  (unused)

tmscsim is where the CD changer is located.
Until I manually mount a CD in there, the
module is unused. But what about other threes?
Forgetting about "sg", I had a nagging suspition
especially about  the last two entries.
Why are they loaded at all? I could not figure
out why until today. These are also listed
in /etc/modules, and "auto" is not given.
So kerneld is not started at boot time...

FYO, just to show what the lsmod output looks like after
mounting a CD in nakamichi changer.

>duron:/home/ishikawa# mount /dev/scsi/host1/bus0/target6/lun0/cd /mnt2
>mount: special device /dev/scsi/host1/bus0/target6/lun0/cd does not exist
(* Oops I have forgotten the manual loading of sr_mod.o *)
>duron:/home/ishikawa# mkdir /mnt2
>mkdir: cannot create directory `/mnt2': File exists
>duron:/home/ishikawa# modprobe sr_mod
>duron:/home/ishikawa# mount /dev/scsi/host1/bus0/target6/lun0/cd /mnt2
>mount: block device /dev/scsi/host1/bus0/target6/lun0/cd is write-protected, mounting read-only
>duron:/home/ishikawa# lsmod
>Module                  Size  Used by
>isofs                  19280   1  (autoclean)
>sr_mod                 13200   1
>cdrom                  26912   0  [sr_mod]
>tmscsim                29920   1
>sg                     25728   0  (unused)
>nls_cp437               4384   0  (unused)
>hpfs                   69216   0  (unused)
>duron:/home/ishikawa# ls /mnt2
>Copyright  Solaris_2.7
>duron:/home/ishikawa#

This final answer that I am posting today only shows that I have been using
module loading under linux for quite a long time
without understanding its implementation ver well.
(The first time I used module loading was to re-order the scsi host scanning
about three or four years ago.
Using module was one of the few wasy aside from
physically swaping bus slots to change the scaned order of host adaptors back then.
The original kernel/distribution that I used then was
the one that came Yggrdrasil 1994,  but I had upgraded
various pieces to use more modern kernel and tools.
I switched to Debian about two or three years ago.
Now I figure I must have have bumped into this module
configuration issues back when I switched to Debian,
but I  must have taken care of them quickly
and forgotten about them completely if so.)

So anyway, this finally has answered my question that originated from
my observation about device name registration
under devfsd, module loading caused by devfsd, and
the module configuration mechanism under Debian GNU/Linux.

Below is attached in the hope that the quirks of debian module handling (or
good feature) will be more widely known amongkernel hackers so that
it would be easier to diagnose some questions from the
clueless Debian distribution users regarding modules.

Usually, the Debian's excellent package system
takes care of these details (for me at least), and
I have not encountered much difficulty before.
But this time, I am experimenting with
the kernel 2.4.x and devfs/devfsd before
the stable Debian distribution incorporates them.

Thanks to all people  for the helpful tips.

Happy Hacking

Chiaki Ishikawa

Usage of /etc/modules in Debian GNU/Linux:

Debian's modutils script reads /etc/modules
file to load modules at boot time.
But the generic documentation about module use
distributed in /usr/src/linux/Documentation  doesn't mention
this Debian-specific file at all.
Grepping the files with /etc/modules and excluding /etc/modules.conf
resulted in only three hits and they refer to different entity (/etc/modules
being a directory where the modules are stored, it seems.)

This gets me confused, and I needed to read the various documents to see if what I gather
from reading S20modutils is correct.

man modules

produced a very short explanation of /etc/modules.

   Quote: "The /etc/modules file contains the names of
    kernel modules that are to be loaded at boot time, one
    per line."

   To summarize, the special entry
   "auto" forces the use of kerneld at boot time.
   Without it, it seems that when the initlevel
   changes to 2, 3, 4 or 5, the kerneld is invoked.

I need to see if this is indeed Debian specific.
If so, this might explain why no one mentions the apparent
/etc/modules (instead of /etc/modules.conf, etc.)
when I raised my question about "sg" being loaded seemingly
without my calling for it.

Before writing this memo, I tried to see if other
distributions use similar mechanisms ("What is this
/etc/modules?" was my first reaction after looking
the modutils init script.) and after
reading the following pages found doing web search,
I am fairly convinced that this /etc/modules file is Debian-only concoction.
Debian distribution is trying to be clever using
/etc/modules and it seems to work most of the time, but
sometimes this could lead to user confusion.
(It is like offering nice GUI for configuration management without
the user/operator realizing what gos underneath.
Please don't think I am disparaging Debian. It is excellent distribution
and that is why I use it now.)

/etc/modules.conf is also not to be manually edited under Degian GNU/Linux.
Instead module developers are encouraged to create
entry files under the directory /etc/modutils
to be combined and inseted into the final /etc/modules.conf.
Running modconf(?) seems to integrate all the entry files into
the final /etc/modules.conf...
My system has these entries below /etc/modutils now.

duron:/home/ishikawa# ls -l /etc/modutils
total 32
-rw-r--r--    1 root     root          432 Nov 23 02:05 0keep
-rw-r--r--    1 root     root         1146 Nov 13 22:37 aliases
drwxr-xr-x    2 root     root         4096 Dec  1 03:53 arch
-rw-r--r--    1 root     root         2753 Sep 12 05:41 devfsd
-rw-r--r--    1 root     root          260 Dec 25  1999 paths
-rw-r--r--    1 root     root           37 Dec 24  1998 pcmcia
-rw-r--r--    1 root     root          117 Jan 21  2000 raidtools
-rw-r--r--    1 root     root          494 May  9  2000 setserial


Yes, most of the time, Debian's great packaging system
takes care these details automatically, so we don't need
to dive into these details.
This time, I was experimenting with devfs/devfsd before
the stable release of Debian incorporates devfs yet.
Being a curious type, I could not help wondering
why "sg" was loaded automagically, and found out
that I didn't know much about Debian's own module config
mechanism at all!

cf. pages I found after google search Debian /etc/modules

Some exchanges concerning this on debian-user mailing list:
    http://www.geocrawler.com/archives/3/199/2000/7/50/4119224/
    http://www.geocrawler.com/archives/3/199/2000/7/50/4119745/

A page about module usage (generic explanation, but it has a
caveat abut Debain near the end.)
    http://www.users.dircon.co.uk/~trix/Raven/EyeView/SSR02/SSR02-10.htm

One posting to lpi-discuss mailing list (I think this is where
the discussion on the proposed Linux professional certificate
of a sort is done. A paragraph mentions the inter-distribution
differences of various config files related to modules.
Wish I had known
about the differences in advance.)
    http://www.lpi.org/archives/lpi-discuss/2000-02/msg00003.html

One user of filesystem coda was also confused initially
but figured it out about how Debian module config system worked.
    http://www.coda.cs.cmu.edu/maillists/codalist-2000/0337.html

One post to a mailing list where the debian way of module
loading, /etc/modules, is mentioend very briefly. Long URL.

http://faqchest.dynhost.com/linux/KPLUG/kplug-00/kplug-0010/kplug-001014/kplug00101608_14774.html

PS: my original comment about the
devfs readme file under /usr/src/linux/Documentation/fs/devfs is still valid.
The device names are not quite up to date  and match the currently used ones.
I wonder if someone in the know can upgrade at least the  device names in the file.

[end of mail.]


