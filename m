Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265900AbRFYSXC>; Mon, 25 Jun 2001 14:23:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265898AbRFYSWm>; Mon, 25 Jun 2001 14:22:42 -0400
Received: from aslan.scsiguy.com ([63.229.232.106]:20242 "EHLO
	aslan.scsiguy.com") by vger.kernel.org with ESMTP
	id <S265900AbRFYSWk>; Mon, 25 Jun 2001 14:22:40 -0400
Message-Id: <200106251822.f5PIMTU05229@aslan.scsiguy.com>
To: Keith Owens <kaos@ocs.com.au>
cc: linux-kernel@vger.kernel.org
Subject: Re: Cleanup kbuild for aic7xxx 
In-Reply-To: Your message of "Sat, 23 Jun 2001 15:22:43 +1000."
             <13603.993273763@ocs3.ocs-net> 
Date: Mon, 25 Jun 2001 12:22:29 -0600
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Ignoring aic7xxx for the moment, kernel build has problems with _all_
>files that are both generated and shipped.  Perhaps if I explain the
>problems, you will understand why the changes were done.

Okay.

>Suppose you have files "base" and "gen" where "gen" is generated from
>"base".  In the ideal case only "base" is shipped and all users create
>"gen" on their own system.  That covers most generated files and has no
>timestamp or source repository problems.

Okay.

>OTOH suppose the process to convert "base" to "gen" requires utilities
>that not every user is expected to install.  Then it makes sense to
>ship "gen" as well as "base" but it must be done so that it satisfies
>several kbuild requirements.
>
>(1) All kernel source trees from the top level maintainers (LT, AC, DM)
>    must be complete.
>
>    Users must not have to have to search other sites for missing
>    headers or sources.  The fact that several architectures will not
>    work out of the box which violates this requirement is no excuse
>    for ignoring it.
>
>    This means that "gen" must be included in LT, AC and DM trees.
>    Anybody wanting to maintain their own patches against a master tree
>    or to supply a source tree for downstream users must therefore
>    include "gen" in their source control system.  Omit "gen" and
>    downstream users are forced to generate it which defeats the
>    purpose of shipping it.

Sure.

>(2) Generated files must not be overwritten in place.
>
>    When "gen" is shipped and also overwritten in place then anybody
>    who regenerates the file (for whatever reason) runs the risk of
>    spurious differences appearing in their patches.  Particularly when
>    the generating process depends on tools which can vary from one
>    user to another.
>
>    For example, the collating order of identically keyed entries in a
>    db database depends on the version of libdb, this has already
>    generated a spurious patch against aic7xxx in the -ac tree.  The
>    order of sort entries for text depends on the user's locale.  When
>    you rely on external tools you can never guarantee that every
>    user's version of those tools will produce exactly the same output
>    as your version.  The result can be logically identical but be
>    physically different, diff only cares about physical differences,
>    hence the spurious patches.
>
>    Some source control systems mark the master files as read only to
>    prevent accidental editing of the inputs, you have to register that
>    you want to modify the file before you can edit it.  Any generated
>    file that is overwritten in place will break on these systems.
>
>    When generated files are overwritten in place it adds uncertainty
>    when you are building multiple kernels from a single source tree.
>    If the previous compile overwrote "gen", is the result always valid
>    for the next compile?  If make mrproper does not reset to a
>    pristine kernel then the results are unreliable.  make mrproper can
>    only erase generated files, it cannot reset them to their shipped
>    state unless shipped and generated are separate files.
>
>    The only solution to the problems above is to ship "gen" as
>    "gen_shipped" and either copy "gen_shipped" to "gen" (no special
>    tools required) or ignore "gen_shipped" and generate "gen" directly
>    from "base" (needs special tools).  Never overwrite generated files
>    in place.

I think this is the crux of our where we disagree.  The generated file
in this case should only be overwritten by those developing the driver.
We've already agreed that the mechanism used in 6.1.5 of the aic7xxx
driver (always regenerage) cannot work.  Therefore the predominant
case, and in my opinion the only case you need to concern yourself with,
is building the kernel from the vendor generated file.

Consider for a moment, the "old" aic7xxx driver.  It does not ship with
the tools to rebuild its firmware even though it does ship with firmware
source.  There has never been the option to rebuild the firmware so no-one
has.  The build system doesn't attempt to verify that the firmware is
up to date via an MD5 checksum or by any other means.  The generated
firmware file is treated like a regular old header file that came from
the vendor (i.e. Doug Ledford).

The only issue with the above case was the occasional post from the
brave soul that wanted to hack the firmware themselves.  Rather than
force them to scour the web looking for how to update the firmware
(the usual result was a hit on aicasm in the FreeBSD distribution which
they then ported to Linux), I chose to ship the tools and optionally
have them integrated into the build.

In this scenario, I would argue that overwriting the files in place
is the correct strategy.  For the developer that choses to build
the firmware, timestamp based "up to date" behavior is correct,
the last firmware file you've generated/tested is already in the correct
place for generating patches, and, as a developer, you understand
how to use your revision control software so the fact that this file
is generated is not a concern.

>(3) Files must not be generated unless the user changes something
>    related to "gen", users who are not working on "gen" must not be
>    forced to regenerate, they may not have the tools.  This is an
>    obvious statement but how do you check if they have changed
>    anything?

If they don't have the tools, checking to see if they have changed
something is worthless.  If they do have the tools and understand the
consequences of what they are doing, they can check a box during
config.  If you care about dependencies (i.e. you are a developer),
timestamp based dependencies are certainly sufficient.  You may get
one extra build after a patch, but the build will succeed.

>(4) Users who are working on "base" must be supported by kbuild.
>
>    Not only must kbuild protect users who are not working on "base",
>    it must also support those who are working on "base".  They should
>    not have to explicitly make anything, it should be automatic.
>
>    The only thing that cannot be easily automated is the generation of
>    the shipped files and their md5sums, only the coder knows when they
>    are about to ship the files.

The assumption should be that the generated firmware is destined to
be shipped.  Those fixing firmware bugs will want to get their changes
tested by others.  Those requiring special firmware behavior will
ship those changes in their produce or internal kernel release.

>The current aic7xxx kbuild violates (1)-(3).

1 is only violated for distributions that were caught up by the build
behavior in 6.1.5.  This behavior was a bug and that bug has been corrected.
The only distributor I know of that *may* have been affected by this is SGI.
I'll be contacting them to fix their distribution.

2 is not an issue unless you happen to have an uncorrected tree from SGI.
Bulding the firmware was only a requirement for a short time in the new
driver, and has never been a requirement for the old driver.  I think
the sucess of the old driver validates that this scheme works without
any of the complexity of your proposal.

3 is not violated now either.  The build system may offer a warning,
but I have no concern with having that warning removed.  If anything,
your proposed scheme makes it more difficult to get the proper depency
semantics if you are really tryin to work on the firmware - the release
process is now separated from the standard build.  I contend that the
only reason people have been building the firmware is due to fallout
related to the old build scheme.  The new scheme avoids this, in effect,
by moving/deleting files forcing the correction of a few screwed up
revision control repositories.  Email to the distributors seems a much
simpler way to correct this last remaining problem.

--
Justin
