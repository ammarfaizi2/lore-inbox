Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964981AbVLQVwh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964981AbVLQVwh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Dec 2005 16:52:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964982AbVLQVwh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Dec 2005 16:52:37 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:27367 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S964981AbVLQVwh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Dec 2005 16:52:37 -0500
To: Christoph Hellwig <hch@infradead.org>
Cc: Roland Dreier <rolandd@cisco.com>, linux-kernel@vger.kernel.org,
       openib-general@openib.org
Subject: Re: [PATCH 01/13]  [RFC] ipath basic headers
References: <200512161548.jRuyTS0HPMLd7V81@cisco.com>
	<200512161548.aLjaDpGm5aqk0k0p@cisco.com>
	<20051217131456.GA13043@infradead.org>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Sat, 17 Dec 2005 14:51:19 -0700
In-Reply-To: <20051217131456.GA13043@infradead.org> (Christoph Hellwig's
 message of "Sat, 17 Dec 2005 13:14:56 +0000")
Message-ID: <m1irtn75pk.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig <hch@infradead.org> writes:

> please always used fixes-size types for user communication.  also please
> avoid ioctls like the rest of the IB codebase.

Could someone please explain to me how the uverbs abuse of write
is better that ioctl?  

Every single command seems to have a __u64 response fields that is a
pointer into user space.  When you write your commands and read your
responses like the netlink layer does I can see the sense of it.  But
making write an ioctl by another name...

One of the scarier comments I have seen lately from ib_user_verbs.h
/*
 * Make sure that all structs defined in this file remain laid out so
 * that they pack the same way on 32-bit and 64-bit architectures (to
 * avoid incompatibility between 32-bit userspace and 64-bit kernels).
 * Specifically:
 *  - Do not use pointer types -- pass pointers in __u64 instead.
 *  - Make sure that any structure larger than 4 bytes is padded to a
 *    multiple of 8 bytes.  Otherwise the structure size will be
 *    different between 32-bit and 64-bit architectures.
 */

The two points that get called out.
- Embedded pointers are a large part of what make ioctl a maintenance
  nightmare.  I admit we are 15-20 years away before big machines
  exhaust the capability of 64bit pointers so we aren't likely
  to run into size issues soon.  But a write that changes your address
  space is ugly, and unexpected.

  What looks like a reimplementation of readv/writev using this
  technique is also scary.

- 64bit compilers will not pad every structure to 8 bytes.  This
  only will happen if you happen to have an 8 byte element in your
  structure that is only aligned to 32bits by a 32bit structure.
  Unfortunately the 32bit gcc only aligns long long to 32bits on
  x86, which triggers the described behavior.



Eric
