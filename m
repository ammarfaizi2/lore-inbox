Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282766AbRK0GMi>; Tue, 27 Nov 2001 01:12:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282796AbRK0GM3>; Tue, 27 Nov 2001 01:12:29 -0500
Received: from zok.sgi.com ([204.94.215.101]:7376 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S282766AbRK0GMO>;
	Tue, 27 Nov 2001 01:12:14 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: "David S. Miller" <davem@redhat.com>
Cc: trini@kernel.crashing.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net/802/Makefile 
In-Reply-To: Your message of "Mon, 26 Nov 2001 21:26:58 -0800."
             <20011126.212658.82514202.davem@redhat.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 27 Nov 2001 17:12:04 +1100
Message-ID: <12077.1006841524@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Nov 2001 21:26:58 -0800 (PST), 
"David S. Miller" <davem@redhat.com> wrote:
>   From: Tom Rini <trini@kernel.crashing.org>
>   You haven't tried a BitKeeper tree then.  You have to explicitly get
>   write permission.
>   
>That doesn't make any sense to me.
>
>Firstly, the *.c file should be newer than the template it is
>generated from, so the rule which tries to write the file should
>never run if your file timestamps are setup correctly.  So get the
>timestamps correct in your bitkeeper trees :)

The source repository (whether BK or any other system) is not the
problem.  You can get the timestamps right in the source but the moment
you generate and ship a diff then you lose control of timestamps.  See
the long screed below about the problems with shipping generated files,
from kbuild-2.5.txt.

SHIPPING GENERATED FILES

  In general it is bad practice to include generated files in the kernel
  source tree.  The only exceptions are when the generating code is not in
  the kernel or when the generating code is in the kernel but it requires
  additional tools which not all users have installed.  An example of a
  generated file without the code to regenerate it is firmware for a network
  driver.  An example of a generation process that requires extra tools is
  drivers/char/defkeymap.c which requires the loadkeys program.

  There is no justification for shipping any other generated file as part of
  the kernel.  This is especially true if the user is always expected to
  regenerate the file, even more so if the generated data depends upon the
  user's .config.  Under these circumstances it is dangerous to ship a
  generated file because it can be used when it does not reflect the user's
  kernel.

  When a generated file has no kernel support to regenerate it, the file can
  be shipped as is.  The question of whether including generated files in the
  kernel without the underlying code is a violation of the kernel license is
  outside the scope of this document.

  For generated files where the code is included but not all users can run
  it, you must be careful about when the generated file is rebuilt.  make
  looks at the time stamp of the generating and generated files to decide if
  the output needs to be regenerated.  This works for the person making the
  changes because they control when the files are updated.

  Time stamps do not work when the change is issued to the rest of the world
  as a diff.  After patch has run you cannot guarantee which of the updated
  files has the more recent time.  The patch program does not preserve time
  stamps (it must not) so the time stamps on the changed files depend on the
  order of the entries in the patch set.  There is no defined order for
  entries in a patch set, it depends on the program that generated the
  difference listing.  GNU diff generates patches in alphabetical order but
  only when it is given an entire directory.  When diff is invoked from a
  source repository tool it is typically called once for each file and the
  file order is controlled by the repository tool.  Even if your repository
  generates the patch in the correct order, that order can change when the
  patch is merged into the kernel.

  Since you cannot rely on time stamps to decide if a generated and shipped
  file needs to be regenerated, you must use another mechanism for this case.
  There are two basic possibilities, manual or automatic (otherwise known as
  lazy or correct).

  In the manual case you ignore changes to the generated or generating files
  until the user performs some manual operation, such as selecting
  CONFIG_REGENERATE_foo.  This is easy to implement but it is also the lazy
  approach, making the end user do extra work to save the maintainer doing
  anything.  This goes against the whole idea of *automatically* deciding
  what needs to be rebuilt and relies on human intervention.

  In the automatic case the maintainer has to do more work but the make rules
  can automatically determine if the end user has changed any of the related
  files and regenerate automatically.  This is the correct method.  In the
  absence of reliable time stamps you need another method to check if the
  generating and generated files are in sync or not.  The obvious method is a
  checksum of files.


The 2.5 implementation for correctly handling generated files has been
skipped, read Documentation/kbuild/kbuild-2.5.txt for the gory details.

