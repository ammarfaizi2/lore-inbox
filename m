Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932378AbVKXRpk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932378AbVKXRpk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Nov 2005 12:45:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932432AbVKXRpk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Nov 2005 12:45:40 -0500
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:21707
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S932378AbVKXRpk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Nov 2005 12:45:40 -0500
From: Rob Landley <rob@landley.net>
Organization: Boundaries Unlimited
To: Roman Zippel <zippel@linux-m68k.org>
Subject: Re: [PATCH] make miniconfig (take 2)
Date: Thu, 24 Nov 2005 11:45:23 -0600
User-Agent: KMail/1.8
Cc: linux-kernel@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>
References: <200511170629.42389.rob@landley.net> <200511211006.48289.rob@landley.net> <Pine.LNX.4.61.0511241212030.1609@scrub.home>
In-Reply-To: <Pine.LNX.4.61.0511241212030.1609@scrub.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Message-Id: <200511241145.24037.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 24 November 2005 07:56, Roman Zippel wrote:
> Hi,
>
> On Mon, 21 Nov 2005, Rob Landley wrote:
> > Add "make miniconfig", plus documentation, plus the script that creates a
> > minimal mini.config from a normal .config file.
>
> The difference between miniconfig and allnoconfig is IMO too small to be
> really worth it right now.

I disagree, fairly strongly.  The technical difference may be small, but the 
conceptual difference is huge.

>From a user interface perspective, make miniconfig and make allnoconfig are 
two very different things.  Make allnoconfig is supposed to make a config 
where you answer "no" to all the questions.  The name is fairly intuitive.  
>From a user interface perspective, overloading it with miniconfig 
functionality kind of sucks.  When a user is supplying a miniconfig, what 
they're trying to accomplish is _different_ than what allnoconfig has 
traditionally done.  The fact that the same infrastructure can do both is an 
implementation detail.  Even if there were _no_ other changes, I'd urge 
adding it as a synonym that takes a different filename.

That's apart from the fact that allnoconfig doesn't return an error when you 
try to set nonexistent symbols (which makes sense for allnoconfig; any 
warnings there really aren't something a user is normally interested in).  Or 
that the pointless information it dumps to stdout buries any useful 
information going to stderr (again, for allnoconfig the warnings are only 
really of interest to developers).

Or the _big_ change, that miniconfig should _die_ if it can't find the 
mini.config file (because it has nothing to do), yet allnoconfig happily 
completes successfully.  That is the right thing for allnoconfig to do, and 
exactly the _wrong_ thing for miniconfig to do.  (It's especially problematic 
when specifying an alternate location for the file: if you typo it, there's 
no way to tell except by inspecting the verbose .config, or else finding out 
after you build that you built garbage.)

If your objection is to the size of the patch, I can make the patch bigger.  
Seems kind of counterproductive and something I was actually trying to 
_avoid_ doing.  (I didn't even rename KCONFIG_ALLSYMS, despite having to look 
the darn name up every single time I use it, because I was trying to keep the 
footprint down.)  But if the change isn't _big_ enough...

By the way, various other bits of the kernel build don't give me an error 
return when something goes wrong.  (For example, if a config 
CONFIG_INITRAMFS_SOURCE that doesn't exist, the build happily completes with 
an empty initramfs.  I have a to-do item to patch that, but it's a bit down 
on the list.  (Also, note that the fact you can specify things like 
CONFIG_INITRAMFS_SOURCE and CONFIG_LOG_BUF_SHIFT is obvious when talking 
about mini.config but an "aha" moment when talking about allno.config.  I 
like things that need fewer "aha" moments to understand.)

> If we go that path, this functionality should be integrated properly.

I've actually been using condensed configuration subsets since March 16 
(according to my build log http://www.landley.net/code/firmware/notes.html).  
I.E. I was already doing this eight months ago.  This functionality was 
already of use to me long before it came up on the list, and I think it would 
be something of larger utility if it were properly documented.

Which is why my first step was documenting the new way of doing things when 
2.6.15-rc1 broke something that had worked for me consistently ever since 
2.6.10.  (Of course I could have also documented how to work around the 
breakage by now sticking the symbols at the _start_ of the file.  But that 
wouldn't have been polite.)

The new "recommended" mechanism for doing what I wanted was not only entirely 
undocumented (and documenting it is where I noticed that the user interface 
sucked), but also the fact it was of use to me seemed largely accidental.  It 
was a side effect of a change that added variants like "allrandom.config".  
Keep in mind that I was moved to do this work because the way I'd _been_ 
performing this function for 8 months got broken by random outside 
developments.  So now it's a side effect of a _new_ set of things.  Wheee.

I'm all for future improvements.  My makemini.sh shell script sucks deeply, 
I'll be the first to acknowledge that.  But what I've proposed is a user 
interface I can document, one that meets my needs, and one I expect will be 
useful to others who are not deeply familiar with the configuration 
internals.

I could always treat the whole "make config" as something to be worked around 
with a wrapper script to give it a user interface based on the task humans 
are trying to do rather than how the plumbing happens to be laid out.  (The 
logical name for the new script would of course be "./configure".)  But I'd 
rather work _with_ the kernel than against it, and make it easier for others 
to do what I find useful.

I really do think this is an improvement from a user interface perspective, 
and the smallest change I could come up with from a technical perspective to 
meet my goals.

> What I have in mind is to create a new config file with a bit different
> format,

What's wrong with the format of mini.config?

> which is only read by kconfig.

So it would be different from the format of the busybox .config file, the 
uClibc .config file, or anybody else out there who's adopted the kernel's 
format over the past decade-plus?

> This one can also have a switch  
> "only save the minimum". The important part is that if this file exists,
> all kconfig front ends will use it and keep it properly uptodate.

I'd be quite happy if mini.config could be written directly by kconfig.  (It 
would do a much faster job than my dumb shrinker script.  I repeat: my 
shrinker script is crap.)

However, you seem to be forgetting that .config is read by the kernel build 
infrastructure.  The tools are generating what _used_ to be a human editable 
file. 

> 'make miniconfig' would then simply convert the current config to a
> minimized version.

So the new format would _not_ be a minimized version.  Uh-huh.  So there's 
still two versions...

So how would you make use of this new minimized version, then?  If somebody 
file attached one in a linux kernel message and a developer wanted to debug 
their issue?

> One problem I see with this how kconfig should behave, 
> when it's thrown into a new kernel release.

With mini.config, it's actually fairly portable between versions.  (As I said, 
it's worked for me since 2.6.10.)  It specifies the interesting symbols (the 
ones I'd specify in menuconfig), and then the dependencies should resolve 
themselves (which kconfig does right now).  New versions seldom drop or 
rename interesting features (if they did, make oldconfig wouldn't be of much 
use).  The simple fact is, mini.config doesn't specify anything particularly 
version specific.  The dependencies are in the stuff it _doesn't_ mention, it 
just says "I want this set of features" and any kernel newer than the one it 
was created on should have them unless they got obsoleted (which requires 
human intervention to fix anyway).

In fact, my old uml-config file from a few versions back still works in 2.6.15 
just fine.  It works as a mini.config, or it works if I append the .config 
generated by "make allnoconfig" file to _it_ rather than appending it to 
the .config, before running "make oldconfig" to clean it up.  That change was 
only required because some random code change the kconfig developers made 
broke it, because the behavior I was counting on was never intentional.

I'd like the behavior I'm relying on to be clearly intentional.  Not an 
accident that works until the next time the kconfig code is touched.

> Setting everything else to 'n' 
> is one possibility, but sometimes such options as CONFIG_SWAP are added,
> which one certainly wants enabled. Using the defaults would be a
> possibility, but they are currently massively abused (and I'll probably
> soon start a cleanup of them).

The miniconfigs I've been using (and the ones this patch uses) are based on 
allnoconfig.  This means that any features I don't specify, I probably don't 
want unless they're actually required.  That can be version independent.  
That's much less likely to introduce strange new things like devfs 
automounting 

> > 1) Documentation.
>
> This is of course always nice, but it would be even better, if it also
> included information about the other config targets, even it's mostly a
> place holder.

Why?  The target audience for miniconfig is people who want to save the work 
they did in menuconfig (and yes, configuring a kernel is work) without tons 
of extraneous version-dependent crap.  So they can give it to someone else 
who can see what options were important to them without having to pull up a 
GUI to interperet the data for them.  And so they can bring it forward to new 
versions.

And no, taking your 2.6.12 .config and running "make oldconfig" against it is 
_not_ a solution because any new symbols are set to the defaults out of 
defconfig, and a lot of those defaults are switched on.  So if you just run 
oldconfig (or make menuconfig and exit without dredging through each sub-menu 
looking for symbols marked "new", which isn't 100% reliable) you wind up with 
new extraneous crap accumulating in your config file with each version.

And no, you can't go `yes "n" | make oldconfig` because that goes into an 
endless loop when oldconfig prompts you for a number.  Been there, done 
that...

I don't personally _care_ about the other config targets.  They don't do what 
I'm trying to do here.  Conceptually, mini.config files are different 
from .config files because mini.config files are human editable and version 
independent.  Conventional .config files are neither.  I'm trying to document 
a useful technique which, to me, has _nothing_ to do with the rest of the 
plumbing changes you made.  It's a technique I was using long before the 
latest batch of changes, and your changes made it easier to promote it to a 
fully supported feature but it really doesn't seem to me that this technique 
was not what you had in mind when you made your changes.

I realise that you added allyes.config, allrandom.config, allmod.config, and 
so on.  But allnoconfig was the _only_ sane base for what I was trying to do.  
I did actually think this through, many moons ago.

defconfig changes from version to version.  New drivers show up for things you 
don't have.  Stuff you were using could go away simply because the defaults 
changed.  It's close to useless.

Allyesconfig and allmodconfig are not a sane base.  New drivers show up all 
the time so switching off everything you don't need is A) insanely verbose, 
B) not portable to new versions with new drivers.  And new stuff can show up 
that breaks you: devfs automounting, 

What's allrandom.config even for?  Maybe it's potentially a developer only 
thing to ensure that an allrandconfig kernel has the minimal set of options 
to potentially boot on your test hardware.  (Except that make allrandconfig 
is used almost exclusively to test _building_, not booting, because testing 
that hardware you don't have isn't found by the probes generally is not all 
that interesting of a test (and one you could pretty much do with 
allyesconfig or allmodconfig if you cared).  But maybe I could see the Linux 
Test Project guys potentially spending spare cycles on this.)  But again, 
completely different group of people than the audience for make miniconfig.

> bye, Roman

I have something working now, something a lot of thought went into.  I really 
do think it's a good idea...

Rob
-- 
Steve Ballmer: Innovation!  Inigo Montoya: You keep using that word.
I do not think it means what you think it means.
