Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261506AbULTMwe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261506AbULTMwe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Dec 2004 07:52:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261503AbULTMwe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Dec 2004 07:52:34 -0500
Received: from mail-relay-4.tiscali.it ([213.205.33.44]:59077 "EHLO
	mail-relay-4.tiscali.it") by vger.kernel.org with ESMTP
	id S261502AbULTMwY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Dec 2004 07:52:24 -0500
Date: Mon, 20 Dec 2004 13:52:23 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Joseph Seigh <jseigh_02@xemaps.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: What does atomic_read actually do?
Message-ID: <20041220125223.GI4424@dualathlon.random>
References: <opsi7o5nqfs29e3l@grunion> <1103394867.4127.18.camel@laptopd505.fenrus.org> <opsi7xcuizs29e3l@grunion> <1103399680.4127.20.camel@laptopd505.fenrus.org> <opsi707edhs29e3l@grunion> <1103494866.6052.354.camel@localhost> <opsi94i4z0s29e3l@grunion>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <opsi94i4z0s29e3l@grunion>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 19, 2004 at 06:50:54PM -0500, Joseph Seigh wrote:
> What's the assurance that gcc supports this api correctly?   There was
> the  possibility since the C standard leaves it implementation
> dependent what constitutes volatile access, that gcc did something
> special there.  But the gcc  documentation says this for volatile,
> "There is no guarantee that these reads and writes  are atomic,
> especially for objects larger than int."

set_pte_atomic also requires atomicity in
asm-generic/pgtable.h:ptep_establish, but it's not even using volatile
and it's a 64bit pointer that we're writing to.  We're relaying on the
compiler to do the right thing for us. I don't think it's a good idea
for the long run, but Benjamin on ppc64 rejected my suggestion to
rewrite set_pte_atomic in asm, so I doubt you'll be able to rewrite
atomic_read with asm either (because at least atomic_read is an int and
not a long pointer, and at least atomic_read is a volatile unlike
set_pte).

My point is that even before worrying about the theoretical correctness
of atomic_read, I would suggest to worry about set_pte_atomic first,
which is a lot more likely to break if something. The compiler may truly
execute two separate writes if power of 2 bitshifts are involved, as the
optimal compilation of the C source.
