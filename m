Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932434AbWDMSS4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932434AbWDMSS4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 14:18:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932390AbWDMSS4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 14:18:56 -0400
Received: from saraswathi.solana.com ([198.99.130.12]:34712 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S932434AbWDMSSz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 14:18:55 -0400
Message-Id: <200604131719.k3DHJcZG004674@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Subject: [RFC] PATCH 0/4 - Time virtualization
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 13 Apr 2006 13:19:36 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This set of patches implements 
	time virtualization by creating a time namespace
	an interface to it through unshare
	a ptrace extension to allow UML to take advantage of this
	UML support

The guts of the namespace is just an offset from the system time.  Within
the container, gettimeofday adds this offset to the system time.  settimeofday
changes the offset without touching the system time.  As such, within a 
namespace, settimeofday is unprivileged.

The interface to it is through unshare(CLONE_TIME).  This creates the new
namespace, initialized with a zero offset from the system time.

The advantage of this for UML is that it can create a time namespace for itself
and subsequently let its process' gettimeofday run on the host, without
being intercepted and run inside UML.  As such, it should basically run at
native speed.

In order to allow this, we need selective system call interception.  The
third patch implements PTRACE_SYSCALL_MASK, which specifies, through a 
bitmask, which system calls are intercepted and which aren't.

Finally, the UML support is straightforward.  It calls unshare(CLONE_TIME)
to create the new namespace, sets gettimeofday to run without being 
intercepted, and makes settimeofday call the host's settimeofday instead
of maintaining the time offset itself.

As expected, a gettimeofday loop runs basically at native speed.  The two
quick tests I did had it running inside UML at 98.8 and 99.2 % of native.

BUG - as I was writing this, I realized that refcounting of the time_ns
structures is wrong - they need to be incremented at process creation and
decremented at process exit.

				Jeff

