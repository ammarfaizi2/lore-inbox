Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262178AbUCERdU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Mar 2004 12:33:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262662AbUCERdT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Mar 2004 12:33:19 -0500
Received: from hermes.dur.ac.uk ([129.234.4.9]:39161 "EHLO hermes.dur.ac.uk")
	by vger.kernel.org with ESMTP id S262178AbUCERdS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Mar 2004 12:33:18 -0500
Subject: Potential bug in fs/binfmt_elf.c?
From: Mike Hearn <mike@navi.cx>
Reply-To: mike@navi.cx
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1078508281.3065.33.camel@linux.littlegreen>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Fri, 05 Mar 2004 17:38:01 +0000
Content-Transfer-Encoding: 7bit
X-DurhamAcUk-MailScanner: Found to be clean, Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I believe there is a problem in fs/binfmt_elf.c, around line 700 (kernel
2.6.1)

When mapping a nobits PT_LOAD segment with a memsize > filesize, the
kernel calls set_brk (which in turns calls do_brk) to map and clear the
area, but this discards access permissons on the mapping leading to rwx
protection. This causes a load failure on systems where the VM cannot
reserve swap space for the segment, unless overcommit is active (on many
systems it's not on by default).

I don't know this code well, but it seems that this discarding of access
permissions on the unlikely codepath is incorrect. I filed bug #2255 [1]
on it.

Could somebody who understands the ELF loading code please check to see
if this is a bug, and if so produce a patch? 

The ability to define a new (large) ELF section which isn't backed by
swap space nor disk space and that will be mapped to a specific VMA
range is needed by Wine to reserve the PE load area. 

Currently the fact that the section is always mapped rwx despite being
marked read-only in the binary prevents us from using this as a solution
to the problems caused by exec-shield/prelink, meaning the only solution
is to bootstrap the ELF interpreter ourselves from a statically linked
binary. Clearly we'd rather not do that.

Thanks to pageexec@freemail.hu for bringing the matter to my attention.

Your assistance is appreciated,
thanks -mike

[1] http://bugzilla.kernel.org/show_bug.cgi?id=2255

