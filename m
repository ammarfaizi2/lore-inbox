Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262691AbTJTQBR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Oct 2003 12:01:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262694AbTJTQBR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Oct 2003 12:01:17 -0400
Received: from zok.SGI.COM ([204.94.215.101]:1199 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id S262691AbTJTQBL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Oct 2003 12:01:11 -0400
Message-ID: <3F940643.DFC17539@engr.sgi.com>
Date: Mon, 20 Oct 2003 08:58:59 -0700
From: Rich Altmaier <richa@engr.sgi.com>
Organization: SGI
X-Mailer: Mozilla 4.78 [en]C-CCK-MCD SGI  (Windows NT 5.0; U)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: fielding PCI bus timeouts - was: prevent "dd if=/dev/mem" crash
References: <200310171610.36569.bjorn.helgaas@hp.com>
		<20031017155028.2e98b307.akpm@osdl.org>
		<200310171725.10883.bjorn.helgaas@hp.com>
		<20031017165543.2f7e9d49.akpm@osdl.org> <16272.34681.443232.246020@napali.hpl.hp.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just a note to mention experience with handling hardware failures.

For the case of user mappings to IO buses there are important
classes of aps, usually realtime or data acquisition, that
benefit from nice error handling of bus timeouts at user level.

These aps tend to be using old or prototype hardware, which can
fail (cause a bus timeout) during "normal" operation.
Or at least the user view is that the machine should not crash
due to "one flaky board".   Hence there is merit in being
able to translate a PIO-read bus timeout to say a SIGBUS.

More interesting is the case of PIO-write failure, as the writes
can be asynchronous.  Meaning by the time the hardware recognizes
a failure, the CPU's store instruction has graduated and the
CPU has moved on.  Perhaps gone through a context switch or
even exitted the user process.  In this case something more
than a SIGBUS is needed (IRIX has several options to deal with
this).  

On the thread about dd if=/dev/mem, I don't know of any legitmate
reason that user code needs to successfully recover from reading
non-existant phys memory.  I would suggest the princple that
bad user code should not cause a crash, and bad user code that
does a lot of reads would be thought harmless by many dangerous
users.  So some kind of error to the user process is probably
reasonable, perhaps SIGBUS.
Silently returning 0 doesn't sound right, as if there were any 
legitimate reason for this code in the first place, it probably
relates to some search of the physical address space.  Perhaps
a diagnostic.

FYI, Rich
