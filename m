Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318040AbSHHWdH>; Thu, 8 Aug 2002 18:33:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318043AbSHHWdH>; Thu, 8 Aug 2002 18:33:07 -0400
Received: from smtp1.san.rr.com ([24.25.195.37]:60034 "EHLO smtp1.san.rr.com")
	by vger.kernel.org with ESMTP id <S318040AbSHHWdG>;
	Thu, 8 Aug 2002 18:33:06 -0400
Message-Id: <3.0.5.32.20020808153603.01476050@pop-server.san.rr.com>
X-Mailer: QUALCOMM Windows Eudora Light Version 3.0.5 (32)
Date: Thu, 08 Aug 2002 15:36:03 -0700
To: Andries.Brouwer@cwi.nl, alan@lxorguk.ukuu.org.uk, martin@dalecki.de
From: John Coffman <johninsd@san.rr.com>
Subject: Re: [bug, 2.5.29, IDE] partition table corruption?
Cc: Andries.Brouwer@cwi.nl, adam@yggdrasil.com, linux-kernel@vger.kernel.org,
       mingo@elte.hu
In-Reply-To: <UTC200208081822.g78IM2r23833.aeb@smtp.cwi.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As the LILO maintainer, I thank you for copying me on this topic.  So here
are a few comments of my own:

CHS == (Cylinder:Head:Sector)


Neither the LILO boot installer (/sbin/lilo) nor the Linux protected mode
kernel, hence disk drivers, has access to the machine BIOS.  The BIOS
return values for int 13h, fn 8 (Get drive parameters), which returns the
disk CHS geometry subject to the 1024 cylinder limit, is only available in
Real Mode.

A comment appeared in this thread referring to DOS, and partitioning with
it.  DOS uses the BIOS for its disk I/O, hence, the CHS geometry which it
sees is that reported by the BIOS.  There are many disks out there that
were originally partitioned under DOS.

The lilo boot loader must use the BIOS as its disk driver to access the
disk at boot time.  It may be directed to use one of three addressing modes:

  geometric - use int 13h, fn 2 (CHS read)
  linear - convert 24-bit disk address to CHS, use int 13h, fn 2 as above.
  lba32 - 32-bit disk addresses; IF AVAILABLE, use int 13h, fn 42h (EDD
packet call) to read disk; else convert disk address to CHS, use int 13h,
fn 2 as above.

All CHS addressing is subject to the 1024 cylinder limit.  If a 'linear' or
'lba32' address is converted to CHS, the head/sector information need for
the conversion is obtained with int 13h, fn 8 (Get drive parameters).

The LILO boot installer really wants a look at the BIOS CHS geometric
information, especially if 'geometric' addressing is to be used.  A real
mode V86 interface was tried on an experimental basis with late version
21.X.X boot installers.  Unfortunately, it was found to have the
characteristic of hanging on too many systems.  The approach was abandoned.

The present LILO distribution takes a peek at BIOS parameters using a Real
Mode kludge:  just before starting a loaded kernel, the responses to a
bunch of BIOS calls is recorded in the first page of memory (<4k) where a
subsequent invocation of the boot installer (/sbin/lilo) can find the LILO
signature and checksum.  This is a strange way to allow a protected mode
program access to the BIOS.  This accounts for the "BIOS data check"
message of the present LILO distribution.  There are two methods of
bypassing this code, in case of a buggy BIOS which hangs up, and two such
systems have been encountered.

This kludgy code does, however, work on most systems.  The BIOS calls used
are only those specified by Microsoft as being among the ones which Windows
requires to function correctly.  And care is exercised to detect any
returned error code, and to record this fact for the protected mode code
which uses the return values.

Ugly -- I would heartily agree.  BUT IT WORKS.  /sbin/lilo now has access
to the BIOS return values if the system was booted by a compatible version
of LILO.  Sort of a chicken-and-egg problem.

This code is also included in one of the LILO diagnostic disks which may be
created from the source distribution.  Occasionally, I have to refer
correspondents who are having particularly bad LILO problems to these
diagnostic disks.  They are also a mechanism for me to learn about BIOS
problems on a much wider variety of systems than I have physical access to.

One thought I have is that it would be nice if this BIOS data check
(collection) code were part of the real mode kernel (setup.S).  However, as
we are all painfully aware, there are many BIOS incompatibilities which
exist in the real world, so there must be a mechanism to bypass this code,
which I still consider dangerous.  As I stated, LILO has two such bypass
mechanisms, one of which is automatic bypass after a failed boot, and one
of which is an obscure, but documented, 'lilo.conf' flag.

On todays' IDE disks, as on all SCSI disks, the topic of CHS geometry is
really irrelevant.  However, it is a legacy of the evolution of the IBM PC
which we must live with.

--John Coffman






	PGP encrypted e-mail preferred (www.pgpi.com)
	My KeyID: E97AE783  (good until 31-Dec-2002)
	Keyserver at http://web.mit.edu/network/pgp.html
	LILO links at http://freshmeat.net

