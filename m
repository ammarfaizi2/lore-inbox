Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263259AbTKJXlg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Nov 2003 18:41:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263273AbTKJXlg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Nov 2003 18:41:36 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:16779
	"EHLO x30.random") by vger.kernel.org with ESMTP id S263259AbTKJXle
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Nov 2003 18:41:34 -0500
Date: Tue, 11 Nov 2003 00:41:08 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Davide Libenzi <davidel@xmailserver.org>, Larry McVoy <lm@bitmover.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: kernel.bkbits.net off the air
Message-ID: <20031110234108.GG6834@x30.random>
References: <3FAFD1E5.5070309@zytor.com> <Pine.LNX.4.44.0311101004150.2097-100000@bigblue.dev.mdolabs.com> <20031110183722.GE6834@x30.random> <3FAFE22B.3030108@zytor.com> <20031110193101.GF6834@x30.random> <3FAFEA34.7090005@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FAFEA34.7090005@zytor.com>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 10, 2003 at 11:42:44AM -0800, H. Peter Anvin wrote:
> Good grief.  This is messy as hell, and really interferes rather badly
> with the whole kernel.org mirror setup.

allowing coherent checkouts from the mirrors too is an interesting
matter, I believe I've a solution for it, but it obviously requires a
special script to spread the mirror of /pub/scm. However pserver is also
not being mirrored right now, and rsync is still more efficient (and it
carries all the info, not just a certain local copy), so even w/o
mirror-coherency it would be better.

> I guess the "best" solution is to use LVM atomic snapshots, and only
> allow rsync off the atomic snapshot.  That way any particular rsync
> session would always be consistent.  That's a *HUGE* amount of work,
> though, and still doesn't solve the mirrors issue -- I don't control
> what the mirrors run.  On the other hand, I don't know how many mirror
> sites actually mirror /pub/scm since it's not a requirement.

I'm unsure how you can leave an rsync running on the old snapshot and
the new forked off ones running in the new snapshot. as for the mirror
issues it should be possible to make it work like this:

1) increase file1 on the mirror
2) read file2 on the master and store it on the userspace stack
3) copy the tree from master to mirror
4) read file1 on the master and compare it with file2 on the stack
5) if they're different goto 2 after a delay
6) increase file2 on the mirror

basically those sequence numbers should not be copied, they should be
completely separated, each server exporting the tree will have its own
sequence numbers. ideally the master could be at sequence number 1000
and the mirror could be at sequence number 100, depends on the frequency
of the mirror sync and the age of the mirror. the mirror could fetch
multiple updats at once and its sequence number would advance slower, or
it could sync more frequently than there are updates on the server and
its sequence number would advance more quickly than the master.

(for simplicity I'm using the two sequence number model, but clearly the
above can be easily converted to the single sequence number model, and
infact that's preferable since having a single sequence number is
cleaner from a filesystem maintainance point of view, both models are
functionally equivalent)
