Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266691AbUHSQ4h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266691AbUHSQ4h (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Aug 2004 12:56:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266720AbUHSQ4h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Aug 2004 12:56:37 -0400
Received: from mx1.redhat.com ([66.187.233.31]:27103 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266691AbUHSQzV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Aug 2004 12:55:21 -0400
Date: Thu, 19 Aug 2004 09:52:00 -0700
From: "David S. Miller" <davem@redhat.com>
To: joshk@triplehelix.org (Joshua Kwan)
Cc: sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [2.6] busybox EFAULT on sparc64
Message-Id: <20040819095200.14bb9100.davem@redhat.com>
In-Reply-To: <20040818235528.GA8070@triplehelix.org>
References: <20040818235528.GA8070@triplehelix.org>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Aug 2004 16:55:28 -0700
joshk@triplehelix.org (Joshua Kwan) wrote:

> http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=264482

Joshua, I think I have some more clues.

failing call:
| mount(0x14e060: 'none', 0x150070: '/proc', 0xefffffc5: 'proc', c0ed0000, 0x14e050: '')
successful call:
| mount(0x14e060: 'none', 0x14f068: '/proc', 0x151208: 'proc', c0ed0000, 0x14e050: '')

In the on-stack failing case, we have 0xefffffc5 which is very high up on
the user stack.  The top of stack is at 0xf0000000, that puts this string
pointer less than 64 bytes below that top of stack, this is important.

This confuses copy_mount_options()'s logic.  copy_from_user() for large sizes
tries to copy 64-byte blocks at a time, and this will fail for the first
block access that copy_from_user() tries, so copy_from_user() will say the
whole thing failed.  This causes fs/namespace.c:copy_mount_options() to return
-EFAULT to the mount system call implementation and thus back down to the
implementation.

The is an amazing corner case of this optimistic user space copying scheme that
copy_mount_options() is using.  I've never liked it, but technically it is
copy_from_user() which is buggy... I'll try and fix it.

I do not believe the fork problem is related at all, please try to strace
into the child of klogd using '-f' or similar.
