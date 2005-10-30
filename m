Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932402AbVJ3X0n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932402AbVJ3X0n (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Oct 2005 18:26:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932404AbVJ3X0n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Oct 2005 18:26:43 -0500
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:12231
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S932402AbVJ3X0m convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Oct 2005 18:26:42 -0500
From: Rob Landley <rob@landley.net>
Organization: Boundaries Unlimited
To: Daniele Orlandi <daniele@orlandi.com>
Subject: Re: An idea on devfs vs. udev
Date: Sun, 30 Oct 2005 15:57:28 -0600
User-Agent: KMail/1.8
Cc: linux-kernel@vger.kernel.org
References: <200510301907.11860.daniele@orlandi.com>
In-Reply-To: <200510301907.11860.daniele@orlandi.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200510301557.29024.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 30 October 2005 12:07, Daniele Orlandi wrote:
> Disclaimer: My knowledge about devfs/udev/sysfs is superficial,

Agreed.

> I see /dev as an abstraction layer above /sys, where udev implements the
> abstraction.

1) /sys/block/thingy/dev is a _text_file_, not a device node.  It indicates 
the major/minor, but you can't access the device through it.

2) Sysfs contains no permissions or ownership info.

A dozen-line shell can "find /sys -name dev", call sed 's/:.*//' and sed 
'/.*://' on each entry to get the major and minor numbers, and do a mknod for 
each (everything starting /sys/block takes b, the rest take c), and viola 
you've populated dev.  Except everything belongs to root and is chmod 700, 
this is _dog_ slow (even populating the standard 100 or so entries can take 5 
seconds on a 2 ghz machine), and doesn't handle adding/removing devices after 
boot.  But it's quick and dirty.

> Embedded people say "We don't need that kind of abstraction, we are ok with
> working at the lower level".

I maintain a half-dozen busybox applets.  The really crazy embedded people are 
yanking out /proc and /sys both (to save space), and using matt mackall's 
-tiny tree with the kamikazi lobotomy options enabled.

> So, why cannot we substitute the "dev" file within /sys with the actual
> device file?

A) Go look at this thing:
http://kerneltrap.org/node/5347

B) Getting permissions and ownership right is A) policy, B) a security issue.  
(Who owns what?  Well what users are on _your_ system?)

> This is *not* meant to be alternative to udev, just a possibility for
> people who cannot run hotplug/udev

Who?  This is a bit like saying "people who can't run ksoftirqd".  It's 
transient bootup code with tiny memory requirements and a reasonable disk 
footprint.

I'm pondering adding a micro-udev to busybox (it's fairly far down on the todo 
list).  It turns out udev is smaller than it seems because it block copies 
code out of klibc and libsysfs (yes, having a standard interface library to 
sysfs is _such_ a good idea we should fork our own copy and bundle it.  After 
all, that's what shared libaries are for...)  And once you chop out all that, 
90% of what's left is _still_ optional (try "grep ' main(' *.c'" and notice 
we have 12 separate occurrences of main().  For something that needs at most 
two (bootup and hotplug) and the bootup version can be a command line option.  
You don't need udevinfo, udevmonitor, udevsend, or udevtest.)  Add in the 
fact that udev/udevd use a gratuitous database that can be ditched, and then 
contemplate simplifying the config file (cut down the parser, and embedded 
users should NOT need a rules compiler; dunno whether it's worth it to keep 
the same config file syntax or come up with something tiny and dumb for 
embedded use)...

I'm not knocking it (much), just saying a busybox version could theoretically 
be stripped way the heck down.  (Not sure how small yet because I haven't 
done the work.  My busybox time is likely to go down in future because this 
is a hobby and I need to go find something to get paid to do again, which is 
always time consumping. :)  I keep dreaming somebody might someday sponsor 
work on busybox, but embedded device people are understandably pretty cheap.)

> and still want to access dynamic devices 
> and are prepared to adapt their software and libraries to another scheme.

function makedev
{
  j=`echo "$1" | sed 's .*/\(.*\)/dev \1 '`
  minor=`cat "$1" | sed 's .*:  '`
  major=`cat "$1" | sed 's :.*  '`
  mknod tmpdir/"$j" $2 $major $minor
}

for i in `find /sys/block -name "dev"`
do
  makedev -m 700 $i b $major $minor
  echo -n b
done

for i in `find /sys/class -name "dev"`
do
  makedev -m 700 $i c $major $minor
  echo -n c
done

You think implementing that in C would take more than 4k?

> Bye,

Rob
