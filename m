Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751262AbWGHKiL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751262AbWGHKiL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jul 2006 06:38:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751272AbWGHKiL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jul 2006 06:38:11 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:32700 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1751262AbWGHKiK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jul 2006 06:38:10 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Nigel Cunningham <ncunningham@linuxmail.org>
Subject: Re: uswsusp history lesson [was Re: [Suspend2-devel] Re: swsusp / suspend2 reliability]
Date: Sat, 8 Jul 2006 12:38:16 +0200
User-Agent: KMail/1.9.3
Cc: Pavel Machek <pavel@ucw.cz>, suspend2-devel@lists.suspend2.net,
       Olivier Galibert <galibert@pobox.com>, grundig <grundig@teleline.es>,
       Avuton Olrich <avuton@gmail.com>, jan@rychter.com,
       linux-kernel@vger.kernel.org
References: <20060627133321.GB3019@elf.ucw.cz> <20060708002826.GD1700@elf.ucw.cz> <200607081342.40686.ncunningham@linuxmail.org>
In-Reply-To: <200607081342.40686.ncunningham@linuxmail.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607081238.16753.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Saturday 08 July 2006 05:42, Nigel Cunningham wrote:
> On Saturday 08 July 2006 10:28, Pavel Machek wrote:
> > I really looked at suspend2 hard, year or so ago, when I was pretty
> > tired of the flamewars. At that point I decided it is way too big to
> > be acceptable to mainline, and got that crazy idea about uswsusp, that
> > surprisingly worked out at the end.
> >
> > uswsusp makes suspend2 obsolete, and suspend2 now looks
> > misdesigned. It puts too much stuff into the kernel, you know that
> > already.
> 
> No, I don't. From my point of view, uswsusp is misdesigned, but suspend2 
> isn't. Suspend2 keeps the stuff that ought to be done by the kernel in the 
> kernel. It doesn't shift data out to userspace, only to copy it straight back 
> to the kernel for I/O. It will keep working even if userspace crashes and 
> burns. It leverages support for compression and encryption that's already in 
> the kernel. It does a real image of memory, not a half-pie attempt that 
> causes lots of faulting of pages etc post-resume.

I must say I completely disagree with the last sentence here.  AFAICT,
suspend2 does the following:
a) save LRU pages in the hope they won't be accesses after the system
has been snapshotted,
b) create the memory snapshot using the, now saved, LRU pages as additional
storage,
c) save the snapshot image created in b).

There are two problems here.  First, actually we are not sure if using LRU
pages as additional storage in b) is correct.  At least I've not seen any
argument supporting this except for "it has been tested for a long time
and nobody's reported any problems with it".  Second, in fact suspend2
saves two images, one consisting of LRU pages only and the second consisting
of the rest of memory.  Moreover, extra care must be taken while saving
LRU pages so that they don't get corrupted in the process and this makes
things quite complicated.

However, if we are sure that we can use LRU pages as additional storage in
b), they just can be included in the memory image without copying
and we only need some extra room for the other data and code.
If LRU pages take 50% of memory, this would allow us to create
a signle snapshot image as big as 75% of RAM (on x86_64).  IMO the
remaining 25% are not worth the increased complexity of suspend2,
especially that on 1 GB machine 75% of RAM is too much to save
for performance reasons (ie. the extra time you save by making the
system more responsive after resume is lost for saving and restoring
the image, even if compression is used).

Furthermore, I tried to measure how much time would actually be saved if
the images were greater than 50% of RAM (current swsusp's limit) and it
turned out to be 10% at the very last, with compression (on a 256MB box
with PII).

> If there's any misdesign in Suspend2, it's that I haven't made it a special
> case of checkpointing. But, of course, there's no support for checkpointing
> in the rest of the kernel at the moment anyway.
> 
> > From your point of view, uswsusp is misdesigned, too. It is too damn
> > hard to install. There's no way it could survive as a standalone patch
> > -- the way suspend2 survives. Fortunately, from distro point of view,
> > being hard to install does not matter that much. Distros already have
> > their own initrds, etc. And in the long term, distros matter, and I'm
> > quite confident I can make 90% distributions ship uswsusp + its
> > userland; cleaner kernel code matters, too, and maybe you'll agree
> > that if you only look at the kernel parts, uswsusp looks nicer.
> 
> It looks simple, I agree. But that's only because it's doing the minimum 
> required.

Again, I don't agree with this statement.  Moreover uswsusp (gosh, I _hate_
this name) is being developed on a regular basis, so I think it'll be doing
a bit more in the future.

> > Now, you are asking me to review 14000 lines of code. That's quite a
> > lot of code, and you did not exactly make reviewer's life easy. Also
> > reviews usually stop at first "fatal" problem, and you still drive
> > user interface from kernel. (Yes, drawing is done in userland, but
> > core user interface code is still in kernel). That is "fatal".
> 
> I agree that I didn't do the best job of making the reviewer's life easy. But 
> let's give me some credit. I did all those patches because I genuinely 
> thought that's what was requested the last time I submitted patches for 
> review. I didn't like splitting up the files into all those patches - it was 
> a lot of work and took a lot of time. But I did it because I wanted to do 
> what was asked and wanted to do what was necessary to get a good 
> implementation into the vanilla kernel.
> 
> Frankly, I'd rather be working on improving drivers and helping implement the 
> run-time power management than working on getting Suspend2 merged. But for 
> now, this is the immediate task.

Why so?

> I don't know why you see the user interface code as a problem. All the kernel 
> is doing is telling the userspace program, via a netlink socket, what's going 
> on and receiving messages from the userspace program sometimes.
> 
> > (Greg mentioned /proc usage being "fatal", too).
> 
> > Now... moving user interface into userland, and removing /proc usage
> > are big tasks, do you agree? And they will mean lot of changes, and
> > lot of new testing.
> 
> Removing /proc isn't a big task. It will affect the hibernate script far more 
> that the kernel code. The user interface is already in userland.
> 
> > Perhaps at this point right solution is to just drop suspend2
> > codebase, and do it again, this time in userland? Kernel
> > infrastructure is already there, and even if you wanted to replace
> > [u]swsusp by suspend2, you have to understand how the old code
> > works. (Another point you may like is that forking suspend.sf.net code
> > is relatively easy; so even if we disagree about coding style of the
> > userland parts, I can't veto it or something. And given that your only
> > problem is including all the possible features, I probably will not
> > have reason to stop you or something -- having all the features is
> > okay in userland).
> 
> I don't want to fork anything. I didn't fork swsusp to start with, and I don't 
> want to start forking things now. (If you want to debate that point, can you 
> check the mailing list archives on Sourceforge, Berlios and suspend2.net 
> first? You'll find that I just carried on where Florent left off).
> 
> > Now... switching to uswsusp kernel parts will make it slightly harder
> > to install in the short term (messing with initrd). OTOH there's at
> > least _chance_ to get to the point where suspend "just works" in
> > Linux, in the long term...
> >
> > (Of course, you can just ignore this and keep maintaining out-of-tree
> > suspend2. We'll also get to the point where it "just works"... it will
> > just take a little longer.)
> 
> With your current design, I don't see how you're ever going to get to the 
> level of functionality that Suspend2 has. I'm of course thinking of a full 
> image of memory (although Rafael's patch a while back looked hopeful there) 
> and support for other-than-just-one-swap-partition.

These are two different points.

Actually, as I said above, as soon as we are _sure_ that LRU pages are not
touched after the memory has been snapshotted, my patch will be mergeable
and we'll get the ability to create bigger images without the added
complexity.  [Apart from the fact that the whole memory image on a box with
more that 512 MB of RAM wouldn't make much sense, IMHO.]  The _only_ thing
needed here is an argument which you have to provide anyway to show that
suspend2 does the right thing.

As far as the support for ordinary files, swap files, etc. is concerned,
there's nothing to worry about.  It's comming.

Greetings,
Rafael
