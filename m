Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262205AbUD2A2C@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262205AbUD2A2C (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 20:28:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262213AbUD2A2C
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 20:28:02 -0400
Received: from brmea-mail-3.Sun.COM ([192.18.98.34]:1199 "EHLO
	brmea-mail-3.sun.com") by vger.kernel.org with ESMTP
	id S262205AbUD2A17 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 20:27:59 -0400
Date: Wed, 28 Apr 2004 16:24:58 -0700
From: Tim Hockin <thockin@sun.com>
To: Linux Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: BUG: might_sleep in /proc/swaps code
Message-ID: <20040428232457.GB1483@sun.com>
Reply-To: thockin@sun.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Testing some othe rwork, totally unrelated, we added a might_sleep() to
mntput().  It turned up this:

Debug: sleeping function called from invalid context at
include/linux/mount.h:82
in_atomic():1, irqs_disabled():0
Call Trace:
 [<c012378f>] __might_sleep+0xab/0xcb
 [<c018787c>] d_path+0x171/0x272
 [<c018ff50>] seq_path+0x4b/0xf4
 [<c0165b12>] swap_show+0x3d/0x110
 [<c018f87d>] seq_read+0xa8/0x31b
 [<c015aa83>] do_brk+0x14f/0x21c
 [<c0168fae>] vfs_read+0xaf/0x119
 [<c0169224>] sys_read+0x3f/0x5d
 [<c010b4e1>] sysenter_past_esp+0x52/0x71


* /proc/swaps uses seq_file code, calling seq_path() with swaplock held
* seq_path() calls d_path()
* d_path() calls mntput() which might_sleep()

Is this worth trying to solve?  

-- 
Tim Hockin
Sun Microsystems, Linux Software Engineering
thockin@sun.com
All opinions are my own, not Sun's
