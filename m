Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264173AbUDGTra (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Apr 2004 15:47:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264185AbUDGTra
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Apr 2004 15:47:30 -0400
Received: from pirx.hexapodia.org ([65.103.12.242]:46149 "EHLO
	pirx.hexapodia.org") by vger.kernel.org with ESMTP id S264173AbUDGTr2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Apr 2004 15:47:28 -0400
Date: Wed, 7 Apr 2004 14:47:27 -0500
From: Andy Isaacson <adi@hexapodia.org>
To: Andrew Morton <akpm@osdl.org>
Cc: bug-coreutils@gnu.org, linux-kernel@vger.kernel.org
Subject: Re: dd PATCH: add conv=direct
Message-ID: <20040407194727.GE2814@hexapodia.org>
References: <20040406220358.GE4828@hexapodia.org> <20040406173326.0fbb9d7a.akpm@osdl.org> <20040407173116.GB2814@hexapodia.org> <20040407111841.78ae0021.akpm@osdl.org> <20040407192432.GD2814@hexapodia.org> <20040407123455.0de9ffa9.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040407123455.0de9ffa9.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
X-PGP-Fingerprint: 48 01 21 E2 D4 E4 68 D1  B8 DF 39 B2 AF A3 16 B9
X-PGP-Key-URL: http://web.hexapodia.org/~adi/pgp.txt
X-Domestic-Surveillance: money launder bomb tax evasion
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 07, 2004 at 12:34:55PM -0700, Andrew Morton wrote:
> Andy Isaacson <adi@hexapodia.org> wrote:
> > Would there be any reason to allow O_DIRECT on the read side?
> 
> Sure.  It saves CPU,

OK, I can see that one.  But it seems like a pretty small benefit to me
-- CPU utilization is already really low.

> avoids blowing pagecache,

Um, that sounds like a bad idea to me.  It seems to me it's the kernel's
responsibility to figure out "hey, looks like a streaming read - let's
not blow out the buffer cache trying to hold 20GB on a 512M system."  If
you're saying that the kernel guys have given up and the established
wisdom is now "you gotta use O_DIRECT if you don't want to throw
everything else out due to streaming data", well... I'm disappointed.

> just as with O_DIRECT writes.

Wouldn't opening both if= and of= with O_DIRECT turn dd into a
synchronous copier?  That would really suck in the
"dd if=/dev/hda1 of=/dev/hdc1" case.  With buffer cache doing
readahead, that command can get, say, 40MB/s read and 40MB/s write;
with synch read and synch write, it would drop to 40MB/s read+write,
assuming that block sizes are big enough to amortize seek overhead.

Having O_DIRECT on just of=, I think you can get back to 40MB/s+40MB/s.

I claim that O_DIRECT on of= is important because you just plain *can
not* do the minimal-sized IDE block scrub without it.  I don't yet see a
similar benefit to O_DIRECT on if= side.

-andy
