Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261771AbUBVWWp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Feb 2004 17:22:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261770AbUBVWWp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Feb 2004 17:22:45 -0500
Received: from pfepb.post.tele.dk ([195.41.46.236]:40574 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S261767AbUBVWWk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Feb 2004 17:22:40 -0500
Date: Mon, 23 Feb 2004 00:23:17 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Rusty Russell <rusty@au1.ibm.com>
Cc: Brian King <brking@us.ibm.com>, sam@ravnborg.org, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: Question on MODULE_VERSION macro
Message-ID: <20040222232317.GA20083@mars.ravnborg.org>
Mail-Followup-To: Rusty Russell <rusty@au1.ibm.com>,
	Brian King <brking@us.ibm.com>, sam@ravnborg.org, akpm@osdl.org,
	linux-kernel@vger.kernel.org
References: <40367FC8.2020802@us.ibm.com> <20040222044826.A94DA17DE9@ozlabs.au.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040222044826.A94DA17DE9@ozlabs.au.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Any update on the MODULE_VERSION macro getting into mainline?
> 
> Sam need to ack the build system changes.

I have taken a look at it now.

As you mention yourself this assume all input files for a module
is .c files. Which is almost always the case.
But I do not like the fact that we warn in cases where .s files is
actually used.

Current implementation will also fail when using O= syntax.

The more correct approach is to list the .o files in the
.mod file. Then in sumversion find the corresponding .file.o.cmd, and parse
up the name of the corresponding source file (listed as the first filename
in the deps_ assignment, and pass this filename to grab_file.

Example .file.o.cmd file:
sam@mars:~/bk/v2.6> head -10 ~/b/drivers/scsi/aic7xxx/.aic7xxx_osm.o.cmd
cmd_drivers/scsi/aic7xxx/aic7xxx_osm.o := gcc -Wp,-MD,drivers/scsi/aic7xxx/.aic7xxx_osm.o.d -nostdinc -iwithprefix include -D__KERNEL__ -Iinclude -Iinclude2 -I/home/sam/bk/v2.6/include -I/home/sam/bk/v2.6/drivers/scsi/aic7xxx -Idrivers/scsi/aic7xxx -D__KERNEL__ -I/home/sam/bk/v2.6/include -Iinclude -I/home/sam/bk/v2.6/include2 -Iinclude2  -I/home/sam/bk/v2.6/include -Wall -Wstrict-prototypes -Wno-trigraphs -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=i686 -I/home/sam/bk/v2.6/include/asm-i386/mach-default -Iinclude/asm-i386/mach-default -O2 -fomit-frame-pointer -I/home/sam/bk/v2.6/drivers/scsi -Idrivers/scsi -DMODULE -DKBUILD_BASENAME=aic7xxx_osm -DKBUILD_MODNAME=aic7xxx -c -o drivers/scsi/aic7xxx/aic7xxx_osm.o /home/sam/bk/v2.6/drivers/scsi/aic7xxx/aic7xxx_osm.c

deps_drivers/scsi/aic7xxx/aic7xxx_osm.o := \
  /home/sam/bk/v2.6/drivers/scsi/aic7xxx/aic7xxx_osm.c \
    $(wildcard include/config/aic7xxx/reset/delay/ms.h) \
    $(wildcard include/config/aic7xxx/proc/stats.h) \


Here the source file is listed with absolute path.
It must be as simple as searching through the file for a line starting with deps_,
and then read the following line.

The .mod file will specify the path to the .file.o.cmd file, since this
is an output file, there is no need to use $(srctree).

I hope I made the approach clear enough?

	Sam

