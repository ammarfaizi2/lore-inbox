Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264487AbTGGV1K (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jul 2003 17:27:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264493AbTGGV1K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jul 2003 17:27:10 -0400
Received: from fencepost.gnu.org ([199.232.76.164]:19631 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S264487AbTGGV1H
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jul 2003 17:27:07 -0400
Date: Mon, 7 Jul 2003 17:41:40 -0400 (EDT)
From: Pavel Roskin <proski@gnu.org>
X-X-Sender: proski@marabou.research.att.com
To: Andrey Borzenkov <arvidjaar@mail.ru>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       devfs@oss.sgi.com
Subject: Re: [PATCH][2.5.74] devfs lookup deadlock/stack corruption combined
 patch
In-Reply-To: <200307072306.15995.arvidjaar@mail.ru>
Message-ID: <Pine.LNX.4.56.0307071725400.11643@marabou.research.att.com>
References: <E198K0q-000Am8-00.arvidjaar-mail-ru@f23.mail.ru>
 <20030706120315.261732bb.akpm@osdl.org> <20030706175405.518f680d.akpm@osdl.org>
 <200307072306.15995.arvidjaar@mail.ru>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Jul 2003, Andrey Borzenkov wrote:

> To reproduce (2.5.74 UP or SMP - does not matter, single CPU system)
>
> ls /dev/foo & rm -f /dev/foo &
>
> or possibly in a loop but then it easily fills up process table. In my case it
> hangs 100% reliably - on 2.5 OR 2.4.

I've done some testing too.  I was using this script:

while :; do ls /dev/foo & rm -f /dev/foo & done

On Linux 2.5.74-bk5 without patches, running this script on a local
virtual console makes the system very slow.  I could not even login on
another virtual console.  However, I could interrupt the script by Ctrl-C.
After that I had a large number of processes in the D state.  Here's an
excerpt from the output of "ps ax":

31011 vc/1     D      0:00 ls /dev/foo
31012 vc/1     D      0:00 rm -f /dev/foo
31013 vc/1     D      0:00 ls /dev/foo
31014 vc/1     D      0:00 rm -f /dev/foo

I couldn't reboot the system cleanly.  My guess is that no new processes
could be run.

Linux 2.5.74-bk5 with the "combined" patch is OK.  Running the test
script doesn't prevent new logins.  There are no hanging processes after
interrupting the script.

> I have already sent the patch for 2.4 two times - please, could somebody
> finally either apply it or explain what is wrong with it. Richard is out of
> reach apparently and the bug is real and seen by many people.

I confirm seeing the bug on two systems with recent 2.4.x kernels with
probability over 50%.  Upgrading both systems to 2.5.x cured the problem
(of course, it's just a race condition that stopped happening).

Yes, it's an important problem to fix, and maybe we could remove the
"experimental" mark from CONFIG_DEVFS once it's done.  Maybe it's better
to have the patch accepted in the 2.5 series first just for "methodical"
reasons, but in practical terms, it's 2.4 kernels that need the deadlock
fix very badly.

-- 
Regards,
Pavel Roskin
