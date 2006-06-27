Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030213AbWF1CTj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030213AbWF1CTj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 22:19:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030337AbWF1CTi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 22:19:38 -0400
Received: from sullivan.realtime.net ([205.238.132.76]:24077 "EHLO
	sullivan.realtime.net") by vger.kernel.org with ESMTP
	id S1030213AbWF1CTi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 22:19:38 -0400
In-Reply-To: <Pine.LNX.4.64.0606271316220.17704@scrub.home>
References: <Pine.LNX.4.64.0606271316220.17704@scrub.home>
Message-Id: <f5e0f599448456bcbf2699994f0bbc76@bga.com>
From: Milton Miller <miltonm@bga.com>
Subject: Re: klibc and what's the next step?
Date: Tue, 27 Jun 2006 14:47:22 -0500
To: LKML <linux-kernel@vger.kernel.org>, Roman Zippel <zippel@linux-m68k.org>,
       "H. Peter Anvin" <hpa@zytor.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[I'm not on the list, apologies for dropping anyone from to:]

On Jun 27, 2006, at 8:11 AM, Roman Zippel wrote:
>
> Hi,
>
> On Sun, 25 Jun 2006, H. Peter Anvin wrote:
>
>> The majority of the patches are independent in the sense that they
>> should apply independently, but Makefile/Kbuild files may have to be
>> adjusted to build a partially patched tree.
>
> I could now repeat all the concerns I already mentioned, why it 
> shouldn't
> be merged as is (that doesn't mean it shouldn't be merged at all!), but
> they have been pretty much ignored anyway...

I'm guessing these threads?

http://marc.theaimsgroup.com/?l=linux-kernel&m=114946240404001&w=2
http://marc.theaimsgroup.com/?l=linux-kernel&m=114967046318388&w=2


>
> What I'm more interested in is basically answering the question and 
> where
> I hope to provoke a bit broader discussion: "What's next?"
>
> Until recently for most developers klibc was not much more than a cool
> idea, but now we have the first incarnation and now we have to do a
> reality check of how it solves our problems. To say it drastically the
> current patch set as it is does not solve a single real problem yet, it
> only moves them from the kernel to kinit, which may be the first step 
> but
> where to?
>
> So what problems are we going to solve now and how? The amount of
> discussion so far is not exactly encouraging. If nobody cares, then 
> there
> don't seem to be any real problems, so why should it be merged at all? 
> Are
> shiny new features more important than functionality?

Let me see if I can summarize:

* There is concern about how much is bloat, where do we draw the line 
for in-kernel

* There is concern about duplicating user space utilities.  We moved 
the kernel broken md assemble instead of getting the current one from 
mdadm, and that should be part of mdadm package.

* There is concern that distros won't want to use this anyways -- They 
need more features and use a bigger library than klibc provides.

* Let me propose one:  Even with kinit in the kernel, users will still 
be broken because they will use there existing external initramfs.  
This means we can't move stuff like opening /dev/console to kinit.

* Some distributions are already using klibc and have been.  They see 
the reason to merge is to have the canonical api with the kernel to 
avoid version mismatch.


Ok, now let me make a radical proposal:

1_  Create the utilities in klibc distribution.

2.  A new Kbuild (Makefile) variable, features-y, declares what initrd 
features are required because they were removed from the kernel but 
configured.

3.  Create a file containing the feature list of the initrd.  Maybe a 
directory of files so we don't get overwrite problems.

4.  Have the build system parse the built-in initramfs, extract the 
feature file(s), and fail if it does not contain the magic strings 
required as defined by the Makefiles.

5.  Require features being removed have the user space tested and 
checked into a release of the kinit distribution before merging the 
removal.

Distros would just create a feature file claiming what their initrd 
loaded initramfs build script will create and point 
CONFIG_INITRAMFS_SOURCE to include that.  The whole initramfs doesn't 
have to be put in the kernel, just the feature files.

Yes, i said kinit distribution.   While it needs to build against 
klibc, it may or may not be part of that package.


> So anyone who likes to see klibc merged, because it will solve some 
> kind
> of problem for him, please speak up now. Without this information it's
> hard to judge whether we're going to solve the right problems.
>
> Peter, it would really help if you describe your own plans, how you 
> want
> to go forward with it, otherwise it leaves a huge amount of uncertainty
> and since this is a rather big change, I think it's a real good idea to
> reduce this uncertainty, so we know what to expect and everyone can 
> better
> evaluate how these changes will effect him.

I guess this would be a statement on maintaining kinit / klibc 
development.

> Right now these patches are
> devoid of any documentation, which make it hard for everyone to judge 
> them
> (and what is IMO the main reason for the current uncomfortable 
> silence).

The Kconfig variables for klibc have no help.

Was the Kbuild documetation updated to mention $(klibc)= ?

>
> Feel free to flame me now for making it so difficult, but I'm convinced
> it's better for everyone to make this step (even if it's the right one)
> with more information than we have right now...
>
> bye, Roman
>
>

milton
