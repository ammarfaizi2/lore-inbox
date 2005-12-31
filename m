Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965044AbVLaU7A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965044AbVLaU7A (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Dec 2005 15:59:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965046AbVLaU7A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Dec 2005 15:59:00 -0500
Received: from taverner.CS.Berkeley.EDU ([128.32.168.222]:37850 "EHLO
	taverner.CS.Berkeley.EDU") by vger.kernel.org with ESMTP
	id S965044AbVLaU67 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Dec 2005 15:58:59 -0500
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: daw@cs.berkeley.edu (David Wagner)
Newsgroups: isaac.lists.linux-kernel
Subject: Re: Why can setuid programs regain root after dropping it when using
 capabilities?
Date: Sat, 31 Dec 2005 20:58:50 +0000 (UTC)
Organization: University of California, Berkeley
Message-ID: <dp6rea$kdh$1@taverner.CS.Berkeley.EDU>
References: <20051129213545.6154ce37@TANG-FOUR-EIGHTY-ONE.MIT.EDU>
Reply-To: daw-usenet@taverner.CS.Berkeley.EDU (David Wagner)
NNTP-Posting-Host: taverner.cs.berkeley.edu
X-Trace: taverner.CS.Berkeley.EDU 1136062730 20913 128.32.168.222 (31 Dec 2005 20:58:50 GMT)
X-Complaints-To: news@taverner.CS.Berkeley.EDU
NNTP-Posting-Date: Sat, 31 Dec 2005 20:58:50 +0000 (UTC)
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: daw@taverner.cs.berkeley.edu (David Wagner)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Chau  wrote:
>While debugging some code, I found that a setuid program could regain
>root after dropping root if the program used capabilities. (I tested
>this on 2.6.14 and 2.6.9.) Is this the expected behavior? Here's a
>short test case:
>
>/* chown root this program, suid it, and run it as non-root */
>#include <sys/types.h>
>#include <sys/capability.h>
>#include <unistd.h>
>#include <stdio.h>
>int main() {
>   cap_set_proc(cap_from_text("all-eip")); /* drop all caps */
>   setuid(getuid());                       /* drop root. this call succeeds */
>   setuid(0);                              /* this should fail! but doesn't */
>   printf("%d\n", geteuid());              /* we regained root. prints 0 */
>   return 0;
>}
>
>(If we don't use capabilities at all, and take out the cap_set_proc
>line, then the program behaves as expected, and doesn't allow us to
>regain root.)

Yup, that does seem weird, indeed.  The semantics of uid syscalls is
already weird, and when you introduce POSIX capabilities, they get
even weirder.  What is going on here is that setuid(getuid()) will only
modify the saved uid if CAP_SETUID is enabled.  Normally, CAP_SETUID is
enabled if and only if the effective uid is zero.  However, dropping all
capabilities changes this, and consequently your attempt to drop root
still leaves suid==0, which is what enables the subsequent setuid(0)
to succeed.  You can confirm this by reading the source code, which
can be found in kernel/sys.c:sys_setuid().

Nonetheless, even though I can explain what the OS is doing, I can't
explain why it is doing that.  I have no idea why someone decided
that setuid() should leave the saved uid unmodified if CAP_SETUID is
not present.

My recommendation: Use sys_setresuid().  It has by far the most
intuitive semantics, and POSIX capabilities don't trigger any surprising
modifications to its behavior.
