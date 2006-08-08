Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964901AbWHHO7V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964901AbWHHO7V (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 10:59:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964937AbWHHO7U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 10:59:20 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:6326 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S964898AbWHHO7S
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 10:59:18 -0400
Subject: How to lock current->signal->tty
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: linux-kernel@vger.kernel.org, davem@redhat.com, sds@tycho.nsa.gov,
       jack@suse.cz, dwmw2@infradead.org, tony.luck@intel.com,
       jdike@karaya.com, James.Bottomley@HansenPartnership.com
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 08 Aug 2006 16:17:22 +0100
Message-Id: <1155050242.5729.88.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The biggest crawly horror I've found so far in auditing the tty locking
is current->signal->tty. The tty layer currently and explicitly protects
this using tty_mutex. The core kernel likewise knows about this.

Unfortunately:
	SELinux doesn't do any locking at all
	Dquot passes the tty to tty_write_message without locking
	audit_log_exit doesn't do any locking at all
	acct.c thinks tasklist_lock protects it (wrong)
	drivers/char/sx misuses it unlocked in debug info
	fs/proc/array thinks tasklist_lock will save it (also wrong)
	fs3270 does fascinating things with it which don't look safe
	ebtables remote debugging (#if 0 thankfully) does no locking
		and just for fun calls the tty driver directly with no
		driver locking either.
	voyager_thread sets up a thread and then touches ->tty unlocked
		(and it seems daemonize already fixed it)
	Sparc solaris_procids sets it to NULL without locking
	arch/ia64/kernel/unanligned seems to write to it without locking
	arch/um/kernel/exec.c appears to believe task_lock is used

The semantics are actually as follows

signal->tty must not be changed without holding tty_mutex
signal->tty must not be used unless tty_mutex is held from before
reading it to completing using it
Simple if(signal->tty == NULL) type checks are ok

I'm looking longer term at tty ref counting and the like but for now and
current distributions it might be an idea to fix the existing problems.

Alan

