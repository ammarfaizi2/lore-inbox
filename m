Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266163AbUG1DOw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266163AbUG1DOw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jul 2004 23:14:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266177AbUG1DOw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jul 2004 23:14:52 -0400
Received: from mx1.redhat.com ([66.187.233.31]:14316 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266163AbUG1DOu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jul 2004 23:14:50 -0400
Date: Tue, 27 Jul 2004 20:13:01 -0700
From: "David S. Miller" <davem@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: viro@parcelfarce.linux.theplanet.co.uk
Subject: stat very inefficient
Message-Id: <20040727201301.2723f5ad.davem@redhat.com>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


All of the *stat*() syscall routines copy the inode attributes
around a whopping _3_ times before they get to userspace.

1) From inode to "struct kstat"
2) From "struct kstat" to "struct stat{,64}" on local kernel stack
3) From local kernel stack to userspace

That's rediculious.  And also the stores into the various
structures are not done in ascending order and thus all of
the store buffers on various cpus never get a reasonable
store stream for maximal store buffer compression.

The reason things happen this way is that each implementation
of the various stat structures have padding in different places
and/or have other layout issues.  The simplest thing to do
is memset() the thing, fill in the non-pad parts, and copy
it into user space.

We should be able to do this with just 2 copies as I recognize
the reason why the struct kstat abstraction exists.

I was about to make sparc64 specific copies of all the stat
system calls in order to optimize this properly.  But that
makes little sense, instead I think fs/stat.c should call
upon arch-specific stat{,64} structure fillin routines that
can do the magic, given a kstat struct.

Comments?
