Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265700AbRFZE2P>; Tue, 26 Jun 2001 00:28:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265712AbRFZE2G>; Tue, 26 Jun 2001 00:28:06 -0400
Received: from aslan.scsiguy.com ([63.229.232.106]:27396 "EHLO
	aslan.scsiguy.com") by vger.kernel.org with ESMTP
	id <S265700AbRFZE2D>; Tue, 26 Jun 2001 00:28:03 -0400
Message-Id: <200106260427.f5Q4RlU13204@aslan.scsiguy.com>
To: Keith Owens <kaos@ocs.com.au>
cc: linux-kernel@vger.kernel.org
Subject: Re: Cleanup kbuild for aic7xxx 
In-Reply-To: Your message of "Tue, 26 Jun 2001 12:34:03 +1000."
             <5557.993522843@kao2.melbourne.sgi.com> 
Date: Mon, 25 Jun 2001 22:27:47 -0600
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>I think this is the crux of our where we disagree.  The generated file
>>in this case should only be overwritten by those developing the driver.
>>We've already agreed that the mechanism used in 6.1.5 of the aic7xxx
>>driver (always regenerage) cannot work.  Therefore the predominant
>>case, and in my opinion the only case you need to concern yourself with,
>>is building the kernel from the vendor generated file.
>>
>>In this scenario, I would argue that overwriting the files in place
>>is the correct strategy.  For the developer that choses to build
>>the firmware, timestamp based "up to date" behavior is correct,
>>the last firmware file you've generated/tested is already in the correct
>>place for generating patches, and, as a developer, you understand
>>how to use your revision control software so the fact that this file
>>is generated is not a concern.
>
>I think you are missing an important point.  Once the developer issues
>a patch, that patch becomes part of everyone's source tree.  So
>_everyone_ ends up changing the generated files, at which point they
>run into the timestamp and source repository problems.

No they don't.  Post 6.1.13, the warnings will disappear.  Timestamp
dependencies between the firmware source and the generated files
will not exist unless you check the rebuild firmware box.  The only
dependencies that do exist are on the timestamp of the generated firmware
relative to the rest of the kernel driver.  This is the exact dependency
you want to apply to the general user.  If you update the firmware image
(from the vendor or somewhere else), the kernel driver is rebuilt.
Just like aic7xxx_old.  Just like the qlogic drivers when the vendor
drops some new firmware.  Just like any other file that depends on
a header.

>Overwriting in
>place works for the developer but it causes problems for the rest of
>the world.  The rest of the world can never guarantee that their
>timestamps match the developer's timestamps, in fact you can almost
>guarantee that they don't.

The timestamp dependencies between the firmware source and the generated
files *do not matter*.  The common user cannot rebuild the firmware anyway,
so having this check serves no purpose.  When has this scheme failed for
aic7xxxx_old?  The qlogic drivers?  The Tigon drivers?  It hasn't.  Post
6.1.5 we are using the exact same scheme in the new aic7xxx driver as
has been used successfully numerous times.  The only reason that this
scenario is at all different is that I introduced a bug by ever attempting
to build the firmware by default.  That bug has been corrected.  The SGI
tree is being corrected.  Where is the problem?

><emp>
>  Any timestamp check in kbuild is unreliable when generated files are
>  shipped and then updated in place, even if nobody except the
>  maintainer ever changes the generated file.  Distributing a patch has
>  exactly the same effect on timestamps as changing the generated file.
></emp>

If no-one but the maintainer ever checks the box to rebuild the firmware,
how is this scheme any different than the drivers I've listed above.
The dependencies all seem to work as expected.  If the generated firmware
is updated, via patch or full file replacement, the build works as intended.

>You want timestamp checks for aic7xxx firmware, but including those
>checks in kbuild will hit everyone else the moment they apply your
>latest patch.

That's not true.  Starting in my second reply to you on this subject
I have repeatedly said, "Then kill the warning [in the default case]".
The only dependency I want in the default case is:

$(AIC7XXX_OBJS): aic7xxx_seq.h aic7xxx_reg.h

Other than a non-fatal warning, this is what users have today.  This,
timestamp based dependency, is correct, works on any system that can
build a Linux kernel, and completely handles the default case of
generated files only being updated via patch or full file replacement.

>We either fix the dependency problem so it works for
>everyone or we remove all dependency checking on aic7xxx firmware
>generation.

Exactly.  No dependency checking on the generated firmware.  This is
what I've been advocating since my second reply to you.

>Fixing the problem for everyone is my preferred option
>because it gives better support for people working on the firmware.

As the maintainer who does arguably all of the work on the firmware,
I believe it will make my job more difficult.  Do I count?  8-)

>Timestamps on generated and shipped files cannot reliably detect if
>"base" and "gen" are in sync or not, hence the use of md5sum.

I find the extra machinery and complication to the build process overkill
relative to this danger.  You also increase the number of generated files
that are shipped.  I'd much rather just refine what is there now (i.e.
kill the warnings) than complicate things further.

--
Justin
