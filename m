Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265515AbUGCAjv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265515AbUGCAjv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jul 2004 20:39:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265520AbUGCAju
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jul 2004 20:39:50 -0400
Received: from hiauly1.hia.nrc.ca ([132.246.100.193]:26892 "EHLO
	hiauly1.hia.nrc.ca") by vger.kernel.org with ESMTP id S265515AbUGCAjs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jul 2004 20:39:48 -0400
Message-Id: <200407030039.i630dddX016102@hiauly1.hia.nrc.ca>
Subject: Re: [parisc-linux] Comparing PROT_EXEC-only pages on different CPUs
To: jamie@shareable.org (Jamie Lokier)
Date: Fri, 2 Jul 2004 20:39:39 -0400 (EDT)
From: "John David Anglin" <dave@hiauly1.hia.nrc.ca>
Cc: linux-kernel@vger.kernel.org, parisc-linux@parisc-linux.org,
       matthew@wil.cx, grundler@parisc-linux.org
In-Reply-To: <20040702040752.GB10366@mail.shareable.org> from "Jamie Lokier" at Jul 2, 2004 05:07:52 am
X-Mailer: ELM [version 2.4 PL25]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> As Richard Henderson points out, the toolchain should be requesting
> PROT_READ|PROT_EXEC if it generates code which needs data read access.
> ELF is particularly good for tracking generating those flags, so do
> HPPA code segments have the read flag set at the moment?  I.e. if it
> does, then it would be fine to change the kernel to honour
> PROT_EXEC-only.

The default flags for .text and other code sections are "AX" for both
hppa64-hpux and hppa-linux.  Thus, unless someone explicitly removes
PROT_READ, there isn't a problem reading the offsets in the jump tables.

Having jump tables containing data in the code sections is relatively
new on HPPA.  There were problems with the previous implementation in
which the jump tables contained code.

It would be possible to put the jump tables in .rodata.  The reasons
why the jump tables ended up in the code sections are:

1) The instruction sequence to load the start of the table is about
   three instructions shorter.

2) The tables contain absolute offsets.  In order to put the tables
   in .rodata, we needed support for 32 and 64-bit pc-relative
   relocations in binutils.  I added this support to binutils a few
   months ago.  However, I decided that I didn't want to require
   an update to a non-released version of binutils in order to build
   and use GCC.

3) There weren't any problems putting the tables in the code sections
   under hpux.

> (There's also the question of whether that code needs data read
> access: do jump table instructions do data reads or do they count as
> code reads?  I don't know HPPA well enough to know).

The jump table instructions use the standard HPPA load instructions
(i.e., there is no difference in a read to .text or .data aside from
the protection flags that have been set for the page).

The tool chain only controls the setting of SHF_ALLOC, SHF_EXECINSTR,
SHF_WRITE, ...  There isn't any control over whether a section can be
read or not as far as I can tell.

Dave
-- 
J. David Anglin                                  dave.anglin@nrc-cnrc.gc.ca
National Research Council of Canada              (613) 990-0752 (FAX: 952-6602)
