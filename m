Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265598AbRFWCgV>; Fri, 22 Jun 2001 22:36:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265599AbRFWCgL>; Fri, 22 Jun 2001 22:36:11 -0400
Received: from aslan.scsiguy.com ([63.229.232.106]:9482 "EHLO
	aslan.scsiguy.com") by vger.kernel.org with ESMTP
	id <S265598AbRFWCgB>; Fri, 22 Jun 2001 22:36:01 -0400
Message-Id: <200106230234.f5N2YhU82475@aslan.scsiguy.com>
To: Keith Owens <kaos@ocs.com.au>
cc: linux-kernel@vger.kernel.org
Subject: Re: Cleanup kbuild for aic7xxx 
In-Reply-To: Your message of "Sat, 23 Jun 2001 10:50:28 +1000."
             <10972.993257428@ocs3.ocs-net> 
Date: Fri, 22 Jun 2001 20:34:43 -0600
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>On Fri, 22 Jun 2001 13:39:45 -0600, 
>"Justin T. Gibbs" <gibbs@scsiguy.com> wrote:
>>>The existing build process for aic7xxx on Linux has several problems.
>>>
>>>* Users have to manually select "rebuild firmware".  Relying on users
>>>  to perform any action other than make *config is unacceptable.  It is
>>>  far too error prone.
>>
>>Users don't have to manually select "rebuild firmware".  They can
>>rely on the generated files already in the aic7xxx directory.  This
>>is why the option defaults to off.
>
>You rely on a timestamp check to tell the users "suggest you rebuild
>firmware".  That timestamp check is inherently unreliable when files
>are both generated and shipped.

Files are only shipped unless the user decides to build the firmware.
When I send patches to distributers or Linus, or Alan, the firmware
is always "shipped" from me the vendor.

>>>* Rebuilding the firmware requires lex, yacc and libdb.  Not everybody
>>>  has these installed.
>>
>>Then they shouldn't check the box "rebuild firmware".
>
>See above.  Users think they need to turn on the firmware build, then
>complain when it breaks.

Then kill the warning.  As you note below, most people ignore it even
when it properly indicates pilot error.

>>>* The check for which libdb to use assumes that the presence of a db.h
>>>  is enough, but the overlap between glibc-devel and dbx-devel packages
>>>  means that finding a db.h is not enough, you have to confirm that the
>>>  corresponding libdb exists.
>>
>>Such is Linux.  Those who understand what it means to rebuild the
>>firmware will have the necessary tools, check the box in config,
>>and have it work.
>
>Wrong.  Such is the way it _used_ to be.  As the use of Linux expands,
>more and more people are building their own kernels without knowing all
>the internals.  This is good, we get more users.  But kernel build code
>can no longer assume that anybody building a kernel is automatically an
>expert.

I disagree.  Users that don't understand about patches and build
dependencies should either rely on prebuilt binaries, or be willing
to learn as they experiment with their system.  I spend enough of my
time dealing with people who don't understand SCSI concepts such
as termination to not have any spare to explain to them why their
distribution is deficient or what a patch file does.

>>>* It checks if the firmware is up to date by comparing the timestamps
>>>  on aic7xxx_seq.h and aic7xxx_reg.h against aic7xxx.seq and
>>>  aic7xxx.reg.  Alas, when a patch hits those files there is no
>>>  guarantee which order the files are listed in the patch so the final
>>>  timestamp order is unreliable.  diff lists files in alphabetical
>>>  order but other source repository systems can generate patches in any
>>>  order.  This is a problem for all generated files, not just aic7xxx.
>>
>>So you might get a harmless warning if you haven't checked the box.  This
>>is not fatal and I have yet to hear one complaint about it.
>
>http://marc.theaimsgroup.com/?l=linux-kernel&m=99124017310488&w=2
>was fatal, you even replied to it.

And this particular problem was pilot error (improperly patched or
corrupted system).  Tell me again how your scheme deals with that?

>>>* Shipping files which are also overwritten by users causes problems
>>>  for source control systems and can cause spurious differences when
>>>  generating patches.  This is a problem for all generated files, not
>>>  just aic7xxx.
>>
>>Those using revision control should know how to use revision control.
>>The driver is developed under revision control and the current setup
>>causes me no grief.  Of course, I don't keep the generated files in
>>revision control because there is no benefit in doing so.
>
>Users take patches from Linus or Alan Cox which include the generated
>patches and add the patches to local source repositories.  That
>includes the generated files.  If it comes from Linus or AC it is a
>"master" copy.  End users do not have the luxury of excluding the
>generated files from revision control because it is not their input.
>And if they do exclude the files then their users are forced to
>generate the firmware.  Excluding the aic7xxx generated files from
>source revision works for you because you always generate the firmware,
>it does not work for anybody else.
>
>>For those
>>that decide to keep the generated files in revision control, they
>>should pull any update to the generated files from the vendor (they
>>are always provided in my patches) and *never check the box*.
>
>Users must not be forced to go hunting for files from a vendor when the
>rst of the code is in the kernel.  Especially when that vendor is not
>listed in MAINTAINERS and there is no contact data in the aic7xxx
>directory.

You seem to completely misunderstand what I said above.  Either you
decide to take the generated firmware, included in both the AC and
Linus kernels, as is, or you are a developer that wants to regenerate
it.  In the first case, you treat the generated files like any other.
In the later, as a developer, you may or may not exclude the files
from revision control depending on what works for you.  My assumption
is that 99% of the people using Linux will never want to hack
the firmware or rebuild it.  They can put the generated files in revision
control and never know the difference.

My comment above about getting the firmware from the vendor applies to
people like Alan, Linus, Red Hat, SuSE, and anyone else that chooses to
update the driver by pulling it from my site.  I am the vendor.

>>>The patch below fixes all of the above issues.  It does not touch the
>>>aic7xxx code nor sequencer input, just the generated files and the
>>>kbuild related files.  The patch is approx 100Kb but most of it is the
>>>rename of aic7xxx_{seq,reg}.h to aic7xxx_{seq,reg}.h_shipped.
>>
>>I don't see this as an improvement.
>
>I do, and I am the kernel build maintainer.  I don't tell you how to
>code aic7xxx drivers, but I can and will fix kbuild problems.  The
>current aic7xxx kbuild is a problem.

How is it a problem?  Remove the dependency checks from the current
setup (i.e. can never give a warning unless you check the box) and you
have the *exact same thing*.  All you have done additionally is move
the generated file to another name and obfuscated how to build the
firmware.

>>>After applying this patch, normal users will not have to worry about
>>>generating aic7xxx firmware.
>>
>>This is already true today.
>
>Not true, the timestamp check produces spurious prompts.

Then remove them.

>>>In particular they will not have to
>>>select "rebuild firmware" nor will they need lex, yacc or libdb.
>>
>>Already true today.
>
>Wrong.  See
>http://marc.theaimsgroup.com/?l=linux-kernel&m=99323170127833&w=2

An improperly patched kernel will not function for any of a number
of reasons.  This was no different.  The file is, after all, just
a header file and a header file out of sync with the code that depends
on it can be fatal.

>>>Only people who change one of these files
>>
>>Today, this only applies to those that *check the rebuild firmware*
>>box.
>
>Which the broken timestamp check encourages people to do.

Remove the check.

>>What again are you trying to fix?  It looks to me like you are simply
>>trying to make it harder for people actually working on the aic7xxx
>>driver to have proper dependencies.
>
>The patch still works for anybody changing the aic7xxx firmware or the
>aicasm code.

No, it removes the ability to include dependency checks to build the
firmware in a standard build.  No longer can a developer check the
box in their config, forget about it, and merily go on doing a straight
build from the top level.  They now have to either remember the new
manual step, or add their own script or alias to remember it for them.
If the build system is going to support the firmware at all, it should
do it in a documented and easy to find way.

>Any change to the generated files or the aicasm files now
>forces a rebuild, the option is not required.  Only people changing
>aic7xxx firmware are affected, instead of everybody.

What about a change to the firmware source?  This changes much more
rapidly than the tools that build it and who would manually touch the
generated file other than to perform a vendor update?  This makes the
dependencies that you leave intact useless.

>Bottom line: the current method relies on unreliable timestamps,

Only in the case of generating a warning.  I have no problem with
simply removing all dependency checks unless you check the rebuild
firmware box.

>The new method is clean.

Its your code and your idea.  Of course it's clean.

>And as kbuild maintainer, that is the way I want it to be done.

Well, if nothing about the build is open for discussion, you should
have just said so up front.  I wouldn't have wasted so much time
responding to you.

--
Justin
