Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261163AbVBDLz0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261163AbVBDLz0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 06:55:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261158AbVBDLz0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 06:55:26 -0500
Received: from mx1.redhat.com ([66.187.233.31]:27521 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S263853AbVBDLnR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 06:43:17 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <1107188868.6675.29.camel@gonzales> 
References: <1107188868.6675.29.camel@gonzales> 
To: Xavier Bestel <xavier.bestel@free.fr>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>, akpm@osdl.org
Subject: Re: [Oops] 2.6.10: PREEMPT SMP 
X-Mailer: MH-E 7.82; nmh 1.0.4; GNU Emacs 21.3.50.1
Date: Fri, 04 Feb 2005 11:43:00 +0000
Message-ID: <11365.1107517380@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Xavier Bestel <xavier.bestel@free.fr> wrote:

> I just got this Oops with 2.6.10 (debian/sid stock kernel).
> 
> Kernel is tainted by VMWare, but it wasn't used (machine powered on
> remotely and used just to run gaim though ssh). I can perhaps try to
> reproduce it without it though if you need.

Hmmm... I see it involves the key stuff I wrote.

I don't think it can be a problem with preemption interfering with the key
management code accessing the key tree; every access to the tree outside of
the bootup initialisation is made with the appropriate spinlock held - and
that disables preemption.

It seems unlikely to be a double free... keys aren't freed the moment their
usage count reaches zero; a separate daemon is enlisted to go through the tree
when there's something to dispose of and extract and free all unused keys.

However, it's not impossible that there's a race there that I can't see
(though it doesn't look likely). Are you willing to try patching your kernel
with something? If so, if you can look through security/keys/key.c, and every
time you see a line saying:

	kmem_cache_free(key_jar, key);

insert this line before it:

	memset(key, 0xbb, sizeof(*key);

This will corrupt the memory that held the dead key before freeing it. Then if
something is touching a dead key, the pattern 0xbbbbbbbb or similar will crop
up in a register or on the stack, and the kernel will very likely crash.

David
