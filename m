Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261455AbVCWMiG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261455AbVCWMiG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 07:38:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261565AbVCWMiG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 07:38:06 -0500
Received: from smtp-out.tiscali.no ([213.142.64.144]:11281 "EHLO
	smtp-out.tiscali.no") by vger.kernel.org with ESMTP id S261455AbVCWMhy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 07:37:54 -0500
Subject: Re: forkbombing Linux distributions
From: Natanael Copa <mlists@tanael.org>
To: aq <aquynh@gmail.com>
Cc: "Hikaru1@verizon.net" <Hikaru1@verizon.net>, linux-kernel@vger.kernel.org
In-Reply-To: <9cde8bff050323025663637241@mail.gmail.com>
References: <e0716e9f05032019064c7b1cec@mail.gmail.com>
	 <20050322112628.GA18256@roll>
	 <Pine.LNX.4.61.0503221247450.5858@yvahk01.tjqt.qr>
	 <20050322124812.GB18256@roll> <20050322125025.GA9038@roll>
	 <9cde8bff050323025663637241@mail.gmail.com>
Content-Type: text/plain
Date: Wed, 23 Mar 2005 13:37:38 +0100
Message-Id: <1111581459.27969.36.camel@nc>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-03-23 at 19:56 +0900, aq wrote:
> On Tue, 22 Mar 2005 07:50:25 -0500, Hikaru1@verizon.net
> <Hikaru1@verizon.net> wrote:

> > While I have figured out how it'd be possible in theory to prevent things
> > from grabbing so much memory that your computer enters swap death, I haven't
> > been able to figure out what reasonable defaults would be for myself or
> > others. Soooo, I suggest everyone who is worried about this check the
> > manpage for 'limits' which tells you how to do this. My machine runs various
> > rediculously large and small programs - I'm not sure a forkbomb could be
> > stopped without hindering the usage of some of the games on my desktop
> > machine.

See patch below.

> > /etc/limits does a better job at stopping forkbombs.

but does not limit processes that are started from the boot scripts. So
if a buggy non-root service is exploited, an attacker would be able to
easily shut down the system.

> > This is an example of a program in C my friends gave me that forkbombs.
> > My previous sysctl.conf hack can't stop this, but the /etc/limits solution
> > enables the owner of the computer to do something about it as root.
> > 
> > int main() { while(1) { fork(); } }

I guess that "fork twice and exit" is worse than this?

> I find that this forkbomb doesnt always kill the machine. Trying a
> small forkbomb, I saw that either the forkbomb process, or the parent
> process (of forkbomb) will be killed after a while (by the kernel)
> because of "out of memory" error. The problem is that which process
> would be chosen to kill? (I have no idea on how kernel choose the
> would-be-kill process).

It kills the process that reaches the limit (max proc's / out of mem)?

> If the kernel choose to kill the parent process, or the forkbomb
> itself, damage can be afford. Otherwise, if the more important
> processes are killed (like kernel threads or other daemons), things
> would be much more serious.
> 
> Any idea?

Limit the default maximum of user processes. If someone needs more, let
the sysadmin raise it (with ulimit -u, /etc/limits, sysctl.conf
whatever)

This should do the trick:

--- kernel/fork.c.orig  2005-03-02 08:37:48.000000000 +0100
+++ kernel/fork.c       2005-03-21 15:22:50.000000000 +0100
@@ -119,7 +119,7 @@
         * value: the thread structures can take up at most half
         * of memory.
         */
-       max_threads = mempages / (8 * THREAD_SIZE / PAGE_SIZE);
+       max_threads = mempages / (16 * THREAD_SIZE / PAGE_SIZE);

        /*
         * we need to allow at least 20 threads to boot a system


--
Natanael Copa


