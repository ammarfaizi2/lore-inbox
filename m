Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265640AbRFWFXF>; Sat, 23 Jun 2001 01:23:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265641AbRFWFWz>; Sat, 23 Jun 2001 01:22:55 -0400
Received: from ppp0.ocs.com.au ([203.34.97.3]:39953 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S265640AbRFWFWv>;
	Sat, 23 Jun 2001 01:22:51 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: "Justin T. Gibbs" <gibbs@scsiguy.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Cleanup kbuild for aic7xxx 
In-Reply-To: Your message of "Fri, 22 Jun 2001 20:34:43 CST."
             <200106230234.f5N2YhU82475@aslan.scsiguy.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 23 Jun 2001 15:22:43 +1000
Message-ID: <13603.993273763@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am not refusing to make changes to aic7xxx kbuild but I do insist
that it satisfies the overall kernel requirements.  Justin, please try
my previous patch plus the Makefile update below and see if it causes
any significant problems for you as aic7xxx maintainer.

Ignoring aic7xxx for the moment, kernel build has problems with _all_
files that are both generated and shipped.  Perhaps if I explain the
problems, you will understand why the changes were done.

Suppose you have files "base" and "gen" where "gen" is generated from
"base".  In the ideal case only "base" is shipped and all users create
"gen" on their own system.  That covers most generated files and has no
timestamp or source repository problems.

OTOH suppose the process to convert "base" to "gen" requires utilities
that not every user is expected to install.  Then it makes sense to
ship "gen" as well as "base" but it must be done so that it satisfies
several kbuild requirements.

(1) All kernel source trees from the top level maintainers (LT, AC, DM)
    must be complete.

    Users must not have to have to search other sites for missing
    headers or sources.  The fact that several architectures will not
    work out of the box which violates this requirement is no excuse
    for ignoring it.

    This means that "gen" must be included in LT, AC and DM trees.
    Anybody wanting to maintain their own patches against a master tree
    or to supply a source tree for downstream users must therefore
    include "gen" in their source control system.  Omit "gen" and
    downstream users are forced to generate it which defeats the
    purpose of shipping it.

(2) Generated files must not be overwritten in place.

    When "gen" is shipped and also overwritten in place then anybody
    who regenerates the file (for whatever reason) runs the risk of
    spurious differences appearing in their patches.  Particularly when
    the generating process depends on tools which can vary from one
    user to another.

    For example, the collating order of identically keyed entries in a
    db database depends on the version of libdb, this has already
    generated a spurious patch against aic7xxx in the -ac tree.  The
    order of sort entries for text depends on the user's locale.  When
    you rely on external tools you can never guarantee that every
    user's version of those tools will produce exactly the same output
    as your version.  The result can be logically identical but be
    physically different, diff only cares about physical differences,
    hence the spurious patches.

    Some source control systems mark the master files as read only to
    prevent accidental editing of the inputs, you have to register that
    you want to modify the file before you can edit it.  Any generated
    file that is overwritten in place will break on these systems.

    When generated files are overwritten in place it adds uncertainty
    when you are building multiple kernels from a single source tree.
    If the previous compile overwrote "gen", is the result always valid
    for the next compile?  If make mrproper does not reset to a
    pristine kernel then the results are unreliable.  make mrproper can
    only erase generated files, it cannot reset them to their shipped
    state unless shipped and generated are separate files.

    The only solution to the problems above is to ship "gen" as
    "gen_shipped" and either copy "gen_shipped" to "gen" (no special
    tools required) or ignore "gen_shipped" and generate "gen" directly
    from "base" (needs special tools).  Never overwrite generated files
    in place.

(3) Files must not be generated unless the user changes something
    related to "gen", users who are not working on "gen" must not be
    forced to regenerate, they may not have the tools.  This is an
    obvious statement but how do you check if they have changed
    anything?

    You cannot rely on file timestamps when both "base" and
    "gen_shipped" are in the master source tree.  When the maintainer
    ships a new version of "base" and "gen_shipped", they eventually
    appear in top level patch sets.  When a user fetches a patch and
    applies it to their source tree, both "base" and "gen_shipped" get
    new timestamps, but which one is newer?  It depends on the order of
    the entries in the patch set, so you might have "base" being newer
    than "gen_shipped" (bad) or vice versa (good).  It all depends on
    how the patch set was generated and there is no defined order for
    files in a patch set, it varies from one source control system to
    another.  Even if the maintainer always send patches in the desired
    order, after they have gone through various source control systems,
    the final order is undefined.

    Since you cannot rely on timestamps, the only other option is to
    check if any of the related files have changed since they were
    shipped.  That is, the maintainer does an md5sum over the related
    files and ships the result as part of the patch, kbuild detects
    that a file has changed when its md5sum is different from the
    maintainer's copy.
    
    If any file related to "base" or "gen" has been changed (checked
    via md5sum) then the user must regenerate instead of relying on the
    shipped version.  This will only occur when the user is working on
    the files and they must have the additional tools.  Normal users
    are not affected.

(4) Users who are working on "base" must be supported by kbuild.

    Not only must kbuild protect users who are not working on "base",
    it must also support those who are working on "base".  They should
    not have to explicitly make anything, it should be automatic.

    The only thing that cannot be easily automated is the generation of
    the shipped files and their md5sums, only the coder knows when they
    are about to ship the files.


The current aic7xxx kbuild violates (1)-(3).  Not your fault, the
requirements have never really been documented.  My patch, with the
correction below, handles all 4 requirements.  The only extra work for
the aic7xxx maintainer is to

  cd drivers/scsi/aic7xxx
  sh make_sequencer ship

before generating the patch.  That type of action applies to everybody
who generates files that are also shipped.

After make_sequencer ship, any changes to the files in MD5SUMS will
automatically rebuild the firmware until the next make_sequencer ship,
satisfying requirement (4).  Or it will with the updated makefile
below.  This replaces drivers/scsi/aic7xxx/Makefile in my earlier
patch, with this addition, my patch supports all 4 requirements above.
Clean kbuild for aic7xxx developers and for end users, all automatic.

--- cut here
#
# drivers/scsi/aic7xxx/Makefile
#
# Makefile for the Linux aic7xxx SCSI driver.
#

O_TARGET := aic7xxx_mod.o
obj-m	:= $(O_TARGET)

# Platform Specific Files
AIC7XXX_OBJS = aic7xxx_linux.o aic7xxx_linux_pci.o
AIC7XXX_OBJS += aic7xxx_proc.o aic7770_linux.o
# Core Files
AIC7XXX_OBJS += aic7xxx.o aic7xxx_pci.o aic7xxx_93cx6.o aic7770.o

obj-y	+= $(AIC7XXX_OBJS)

MOD_TARGET = aic7xxx.o

include $(TOPDIR)/Rules.make

aic7xxx_generated	:= aic7xxx_seq.h aic7xxx_reg.h

$(AIC7XXX_OBJS): $(aic7xxx_generated)

$(aic7xxx_generated): dummy
	sh ./make_sequencer

clean:
	rm -f $(aic7xxx_generated)
	$(MAKE) -C aicasm clean

