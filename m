Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310291AbSCLB2x>; Mon, 11 Mar 2002 20:28:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310298AbSCLB2o>; Mon, 11 Mar 2002 20:28:44 -0500
Received: from mhw.ulib.iupui.edu ([134.68.164.123]:43215 "EHLO
	mhw.ULib.IUPUI.Edu") by vger.kernel.org with ESMTP
	id <S310291AbSCLB23>; Mon, 11 Mar 2002 20:28:29 -0500
Date: Mon, 11 Mar 2002 20:28:27 -0500 (EST)
From: "Mark H. Wood" <mwood@IUPUI.Edu>
X-X-Sender: <mwood@mhw.ULib.IUPUI.Edu>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: linux-2.5.4-pre1 - bitkeeper testing
In-Reply-To: <200203111755.KAA11787@tstac.esa.lanl.gov>
Message-ID: <Pine.LNX.4.33.0203111935380.1276-100000@mhw.ULib.IUPUI.Edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: unlisted-recipients:; (no To-header on input)@localhost.localdomain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Okay, I looked this up in the _VMS I/O User's Reference Manual:  Part I_
for VMS v5.0 (latest I have in the programmer series -- they tore out our
single VMS system so that they could install two dozen hefty Windows boxes
to almost replace it).

I can find nothing explicit about creating directories (something that
virtually no one did at the $QIO level) so I'm *assuming* that one just
executes SYS$QIO IO$_CREATE|IO$M_CREATE using a filespec of the form
"somename.DIR;1", passing a file attribute descriptor of ATR$C_UCHAR with
FCH$M_DIRECTORY set, and a record attribute block with FAT$W_VERSIONS set
to the desired version limit default for the directory.  Files entered
into that directory will get their limit set to this default unless they
are created with FIB$W_VERLIMIT nonzero.  It looks as though this
defaulting mechanism is applied to subdirectories when they are created --
the system management essentials volume (I don't have the title handy)
makes special note that putting a version limit on the MFD (think of it as
the directory that the superblock points at) will cause that limit to
trickle down to all inferior directories.

Anyway it looks like this is how it works (and this is the way I remember
it):  setting a version limit default on a directory causes any file to
have that version limit unless the file is created with or modified to
have an explicit version limit of its own.  Subdirectories take on the
default limit of their superiors, so their dependent files will get the
original limit unless the subdirectory's limit default has been modified
or they are created with an explicit limit.  Changing a default in any
directory only affects files subsequently created in that directory and in
any subsequently created subdirectories.

You can specify whether creating a file will supersede a file with equal
version number, or fail due to a file of that name already existing.

So to boil it down still further:  if you usually want four versions
retained, set your home directory to default to four before you create any
files or subdirectories and you're all set.  If you change your mind for
some file or directory, you can alter its limit/default with SET
FILE/VERSION_LIMIT or SET DIRECTORY/VERSION_LIMIT.  The limit is a
per-file attribute with a per-directory default.

Ordinary users, and even ordinary programmers, never see this stuff; they
use a library called RMS which does the tedious directory-tree walking and
other messy $QIOs.  Only a few of us are sick enough to use the ACP-QIO
interface. :-)

The oldest-version deletion magic only chops off the single lowest
version, so if you have four versions of FOO.BAR and you set the top
version's version limit to two, then create a fifth version, only the
first version gets deleted.  To sync. up after lowering the version limit,
you must execute a PURGE command (or your code can contain equivalent
logic).

The version number does not wrap; when you get to version 32767 you cannot
create any more versions.  This was actually used to foil the only malware
I ever heard of on VMS systems, which tried to create a copy of itself
under a name that had special meaning to the DECnet ACP.  Setting that
file's version number to 32767 broke the WANK worm's infection strategy,
and was widely done until the worm-enabling bug was patched.

We probably ought to take this discussion somewhere else if it is to
continue, since I expect that the vast majority of LKML readers are
heartily sick of all this VMS gobbledygook.  None of it has anything to do
with what most people think of as revision control.

-- 
Mark H. Wood, Lead System Programmer   mwood@IUPUI.Edu
Our lives are forever changed.  But *that* is exactly as it always was.

