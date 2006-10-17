Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030190AbWJQAu1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030190AbWJQAu1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 20:50:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030189AbWJQAu1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 20:50:27 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:7871 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1030178AbWJQAu0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 20:50:26 -0400
Date: Tue, 17 Oct 2006 01:50:25 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: [RFC] typechecking for get_unaligned/put_unaligned
Message-ID: <20061017005025.GF29920@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	What kind of typechecking do we want for those?

AFAICS, current constraints are
	* {put,get}_unaligned() should be passed a pointer to object; void *
is not acceptable
	* sizeof(*ptr) should be one of 1, 2, 4, 8
	* assignment of val to *ptr should be valid C.

Questions:
	a) do we want all of the above to be enforced on all targets?
	b) do we really want to allow use of that when sizeof(*ptr) is 1?
It's almost certainly a sloppy code (and I don't see any instances in
the tree), but I might be missing some potentially valid use in macros.
	c) how about gradually switching to linux/unaligned.h?  In this
case we can do it nicely; start with mutual #include in asm/unaligned.h
and linux/unaligned.h (in the beginning of each), then switch users
and once they'd been all gone for a while, have asm/unaligned.h contain
#ifndef __LINUX_UNALGINED_H__
#error include linux/unaligned.h instead
#endif
instead of
#include <linux/unaligned.h>
	d) any objections to having asm/unaligned.h defining
__{get,put}_unaligned{2,4,8} and linux/unaligned.h doing __builtin_choose_expr()
to pick the right one?  AFAICS, that should not have any bad effects on the
generated code and it would allow to put all typechecking in one place.
Helpers in question would take pointers to u{16,32,64} and value of the
same type.  Even the targets doing a simple assignment in all cases would
get the same code generated, AFAICS...
