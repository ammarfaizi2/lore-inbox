Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284087AbRLAMUM>; Sat, 1 Dec 2001 07:20:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284085AbRLAMTv>; Sat, 1 Dec 2001 07:19:51 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:4105 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S284083AbRLAMTl>;
	Sat, 1 Dec 2001 07:19:41 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: =?ISO-8859-1?Q?G=E9rard_Roudier?= <groudier@free.fr>
Cc: linux-kernel@vger.kernel.org
Subject: Clean up drivers/scsi (was: Coding style - a non-issue)
In-Reply-To: Your message of "Sat, 01 Dec 2001 09:54:48 BST."
             <20011201093910.C1139-100000@gerard> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 01 Dec 2001 23:19:28 +1100
Message-ID: <14825.1007209168@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Subject changed and cc trimmed.

On Sat, 1 Dec 2001 09:54:48 +0100 (CET), 
=?ISO-8859-1?Q?G=E9rard_Roudier?= <groudier@free.fr> wrote:
>When I have had to prepare a Makefile for sym-2 as a sub-directory of
>drivers/scsi (sym53c8xx_2), it didn't seem to me that a non-ugly way to do
>so was possible. I mean that using sub-directory for scsi drivers wasn't
>expected by the normal kernel build procedure. Looking into some network
>parts that wanted to do so, I only discovered hacky stuff. This left me in
>the situation I had to do this in an ugly way.

kbuild 2.5 is designed to cope with components that are spread over
several directories, as well as drivers in their own sub directory.
Supporting sym53c8xx_2 was just one line in drivers/scsi/Makefile.in.

select(CONFIG_SCSI_NCR53C7xx            53c7,8xx.o)
link_subdirs(sym53c8xx_2)               # HBA in its own directory
select(CONFIG_SCSI_SYM53C8XX            sym53c8xx.o)

plus drivers/scsi/sym53c8xx_2/Makefile.in.

objlink(sym53c8xx.o sym_fw.o sym_glue.o sym_hipd.o sym_malloc.o sym_misc.o
        sym_nvram.o)
select(CONFIG_SCSI_SYM53C8XX_2 sym53c8xx.o)

>As you cannot ignore the scsi driver directory is a mess since years due
>to too many sources files in an single directory. Will such ugly-ness be
>cleaned up in linux-2.5?

At some time in the 2.5 series I hope to split drivers/scsi into core,
arch independent drivers, arch specific drivers and peripheral drivers
(tape, cdrom etc.), with a top level scsi/Makefile.in that contains:

link_subdirs(core)
link_subdirs(hba)
link_subdirs(acorn)
# link_subdirs(any other arch specific scsi directories here)
link_subdirs(peripheral)

At the moment, adding a new driver means changing the middle of the
Makefile which is nasty.  It also prevents kbuild 2.5 from supporting
add on SCSI drivers in an easy manner.  With a clean split like the
above, testing a new driver outside the kernel source tree only
requires drivers/scsi/hba/Makefile.in.append containing just one line
for the new object.

Whether the drivers are all in one directory or are futher sub divided
is up to the SCSI or individual driver maintainers.  Obviously drivers
built from multiple files should be in their own sub directory.  That
still leaves a large number of drivers built from single source files,
how should they be split, if at all?  One directory per driver is
overkill, grouping by supplier breaks when the supplier is taken over,
grouping by chipset might be useful.

I must emphasise that this is just my wishlist.  It needs broad
agreement from the SCSI maintainers before we start moving the files
around.  Until there is agreement, linux-2.5 will have the same
cluttered scsi makefile, converted to kbuild 2.5 style.

