Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267705AbTGVBR3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jul 2003 21:17:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269242AbTGVBR3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jul 2003 21:17:29 -0400
Received: from thunk.org ([140.239.227.29]:34500 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S267341AbTGVBR1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jul 2003 21:17:27 -0400
Date: Mon, 21 Jul 2003 21:04:01 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Olaf Dietsche <olaf+list.linux-kernel@olafdietsche.de>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH][RFC] speeding up fsck -A
Message-ID: <20030722010401.GA9641@think>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Olaf Dietsche <olaf+list.linux-kernel@olafdietsche.de>,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <87adb8dcpz.fsf@goat.bogus.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87adb8dcpz.fsf@goat.bogus.local>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 21, 2003 at 01:01:44AM +0200, Olaf Dietsche wrote:
> With this patch, I get a speedup of about 60%. During boot time it is
> even more. Can someone please tell me, why and when this WNOHANG was
> introduced. fsck seems to work fine without it.

This isn't a kernel problem; you should have just sent it to me
directly as an e2fsprogs maintainer, as documented in the README file
in the e2fsprogs source tree, or in /usr/shared/doc/e2fsprogs/README
on a Debian system, instead of bothering folks on the kernel list.

In any case, thanks for reporting this bug; I've fixed it
appropriately in the latest e2fsprogs sources.  The WNOHANG was
introduced when I added support for the FSCK_MAX_INST environment
variable, which allows to user to constrain the maximum number of
child fsck's running at the same time, and FSCK_FORCE_ALL_PARALLEL.
What I needed to do was to call wait_one in blocking mode the first
time, and then call it in WNOHANG mode until all exited children have
been reaped.  This is necessary so that fsck will start keep the
necesary number of children in parallel at the same time.  What I did
instead was to always call it with WNOHANG always, which caused a
CPU-burning loop.  Oops.

Anyway, this will be fixed in the next release, which will be soon at
this point....

						- Ted
