Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932578AbVIISm4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932578AbVIISm4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 14:42:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932577AbVIISm4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 14:42:56 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:11446 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S932576AbVIISmz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 14:42:55 -0400
Date: Fri, 9 Sep 2005 19:42:54 +0100
From: viro@ZenIV.linux.org.uk
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC] killing linux/irq.h
Message-ID: <20050909184254.GT9623@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	We get regular portability bugs when somebody decides to include
linux/irq.h into a driver instead of asm/irq.h.  It's almost always a
wrong thing to do and, in fact, causes immediate breakage on e.g. arm.

	Here's what I'm going to do:
* check current includes of linux/irq.h; e.g. in arch/x86_64 all but two
had been 100% useless, one should've been asm/irq.h and one - asm/irq.h +
asm/hw_irq.h.  The only legitimate user of linux/irq.h on amd64 was
asm/hardirq.h.
Situation elsewhere in arch/* is similar - most of includes are not needed
at all.
* remove bogus includes, arch by arch for architectures that live in main
tree.  Switch ones that should've been asm/irq.h to that form.
* put the current contents of linux/irq.h to asm-generic/hardirq.h (which
is what it really is - declarations for hardirq code, relevant on many but
not all platforms).
* switch remaining users of linux/irq.h to asm-generic/hardirq.h (again, for
architectures that live in main tree)
* replace contents of linux/irq.h with #warning and
#include <asm-generic/hardirq.h>.
* after 2.6.14 kill linux/irq.h completely.

	Objections?  That variant leaves out-of-tree folks with window until
2.6.15 to convert and that's really more than enough...
