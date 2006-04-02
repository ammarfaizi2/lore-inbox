Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932300AbWDBJOb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932300AbWDBJOb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Apr 2006 05:14:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932302AbWDBJOb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Apr 2006 05:14:31 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:64128
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S932300AbWDBJOa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Apr 2006 05:14:30 -0400
Date: Sun, 02 Apr 2006 01:14:30 -0800 (PST)
Message-Id: <20060402.011430.02794933.davem@davemloft.net>
To: linux-kernel@vger.kernel.org
Subject: /proc/${pid}/auxv
From: "David S. Miller" <davem@davemloft.net>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I think this needs to be handled by the binfmt of the current thread
because the size of the auxv words themselves is binfmt dependent.

For core file output, the binfmt handler does the auxv writing and
it interpretes the type of the entry words correctly.

So what happens now is that, for a 32-bit ELF binary executing on
64-bit kernel, /proc/${pid}/auxv will report an extra AT_NULL entry or
garbage at the end (because it's interpreting 32-bit words as 64-bit
words when trying to find the AT_NULL that ends the auxv vector).
Whereas core file generation will find the end accurately and place
only the exact number of AUXV entries into the core file.

There is actually a gdb testsuite case that checks that the auxv
provided by /proc/${pid}/auxv matches what ends up on the core file,
which is the only reason that I noticed this :-)
