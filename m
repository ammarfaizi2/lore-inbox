Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262913AbUC2NVT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Mar 2004 08:21:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262977AbUC2NSw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Mar 2004 08:18:52 -0500
Received: from mail.shareable.org ([81.29.64.88]:28307 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S262913AbUC2NSV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Mar 2004 08:18:21 -0500
Date: Mon, 29 Mar 2004 14:18:19 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Ulrich Drepper <drepper@redhat.com>
Cc: "linux-kern >> Linux Kernel" <linux-kernel@vger.kernel.org>
Subject: Re: For the almost 4-year anniversary: O_CLOEXEC again
Message-ID: <20040329131819.GF4984@mail.shareable.org>
References: <40677D1B.9060801@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40677D1B.9060801@redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ulrich Drepper wrote:
> It cannot be done through a per-thread switch which decides whether
> newly allocated descriptors are CLOEXEC until further notice since
> open() is a signal-safe interface.  The signal handler code might
> not be aware of this mode and create descriptors which are not
> inherited.

Since O_CLOEXEC is non-portable, why not implement the per-thread
switch?

Signal handlers that call open() will have to be aware of it, but
that's ok: an application will only set the switch if it knows what
that implies.

For POSIX compatibility the switch should be off initially, and only
turned on at the application's request.

Portable code which assumes POSIX interfaces has to have another way
to work around the close-on-exec problem anyway.

Overall I like the O_CLOEXEC flag.  It really should have always been
an O_* flag, and F_SETFL should be able to change it.

The only problem is there are so many other ways to get file
descriptors which it doesn't help with.  Most especially sockets,
which are heavily used in the kinds of programs which use threads and
and forking.

Btw, is open() the only signal-safe interface where this matters?
Perhaps a per-thread flag could be used for all the _other_ file
descriptor generating interfaces, but not for open() where only
O_CLOEXEC would work?

-- Jamie
