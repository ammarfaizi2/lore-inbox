Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262697AbTH1ADw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Aug 2003 20:03:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262723AbTH1ADw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Aug 2003 20:03:52 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:21638 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S262697AbTH1ADu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Aug 2003 20:03:50 -0400
Date: Thu, 28 Aug 2003 01:03:21 +0100
From: Jamie Lokier <jamie@shareable.org>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: Timo Sirainen <tss@iki.fi>, Martin Konold <martin.konold@erfrakon.de>,
       linux-kernel@vger.kernel.org
Subject: Re: Lockless file reading
Message-ID: <20030828000321.GC3759@mail.jlokier.co.uk>
References: <1061987837.1455.107.camel@hurina> <200308271442.48672.martin.konold@erfrakon.de> <1061988729.1457.115.camel@hurina> <Pine.LNX.4.53.0308270925550.278@chaos>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.53.0308270925550.278@chaos>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard B. Johnson wrote:
> Let's see if it is possible for the middle byte of
> a 3-byte sequence to not be written when both
> other bytes are written:

> Even in machines that do load/store operations where individual
> components of those stores happen in groups, access to/from
> a buffer of such data is controlled (by hardware) so a write
> will complete before a read occurs.

I don't understand what you mean by this.

Do you mean that the writes are forced to appear on a different CPU in
the same order that they were written?  That isn't true on x86, for
two reasons: 1. writes aren't always in processor order (see
CONFIG_X86_OOSTORE and CONFIG_X86_PPRO_FENCE); 2. reads on the other
processor are out of order anyway.

> With hardware that can perform byte-access (ix86), the only
> byte-access that is going to happen is at the end(s) of buffers.

Not true.  Take a look at __copy_user() in arch/i386/lib/usercopy.c.
The first few bytes are copied using "rep;movsb", which is not
guaranteed to use a word write for the aligned pair, nor is it
guaranteed a particular timing (there could be an interrupt between
each byte).

Other architectures are similar.

-- Jamie
