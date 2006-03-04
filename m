Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751832AbWCDK0L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751832AbWCDK0L (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Mar 2006 05:26:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751836AbWCDK0K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Mar 2006 05:26:10 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:46022
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1751832AbWCDK0J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Mar 2006 05:26:09 -0500
Date: Sat, 04 Mar 2006 02:25:46 -0800 (PST)
Message-Id: <20060304.022546.85833873.davem@davemloft.net>
To: linux-kernel@vger.kernel.org
CC: dipankar@in.ibm.com, torvalds@osdl.org, fabbione@ubuntu.com
Subject: VFS nr_files accounting
From: "David S. Miller" <davem@davemloft.net>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I just wanted to report that I am hitting the "VFS: file-max limit xxx
reached" problem quite easily on my 32-cpu Niagara machine with 16GB
of ram with current 2.6.x GIT.

It seems far too easy to get a box into this state due to SLAB
fragmentation and RCU.  And once you get a machine into this state it
is totally unusable.

Our test case is usually a "make -j8192" kernel build along with a
parallel bootstrap of gcc.  That puts about 256 processes on each
cpu's runqueue, I doubt ksoftirqd can run much at all.

I think part of what helps trigger it might be ccache, which we are
using on this machine.  ccache seems to open up a ton of files each
build invocation.

Usually within an hour of that load you'll hit the nr_files limit and
you can't run anything and have to power-cycle.

I think we need to think seriously about this problem.
