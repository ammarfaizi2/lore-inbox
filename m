Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261387AbUBTTop (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 14:44:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261383AbUBTTlT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 14:41:19 -0500
Received: from tantale.fifi.org ([216.27.190.146]:3975 "EHLO tantale.fifi.org")
	by vger.kernel.org with ESMTP id S261390AbUBTTUk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 14:20:40 -0500
To: Kiko Piris <kernel@pirispons.net>
Cc: Cristiano De Michele <demichel@na.infn.it>, linux-kernel@vger.kernel.org
Subject: Re: laptop mode in 2.4.24
References: <1077276719.6533.16.camel@piro>
	<20040220134218.GA15112@fpirisp.portsdebalears.com>
Mail-Copies-To: nobody
From: Philippe Troin <phil@fifi.org>
Date: 20 Feb 2004 11:15:25 -0800
In-Reply-To: <20040220134218.GA15112@fpirisp.portsdebalears.com>
Message-ID: <87vfm136lu.fsf@ceramic.fifi.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=

Kiko Piris <kernel@pirispons.net> writes:

> On 20/02/2004 at 12:32, Cristiano De Michele wrote:
> 
> > that is only journaling is writing to my HD
> > and anyway every minute more or less something
> > gets written to HD preventing it from being spinned down
> 
> IIRC, laptop-mode included in mainline 2.4 does not reset commit
> interval of ext3 filesystems (as surely did the patch you applied to
> older kernels).
> 
> You need to remount your filesystems with appropate commit option. You
> can see the updated control script that's in 2.6.*-mm* trees.

Or use this patch...


--=-=-=
Content-Type: text/x-patch
Content-Disposition: attachment;
  filename=linux-2.4.24-09-laptop-mode.patch.bz2

diff -ruN linux-2.4.24.orig/fs/jbd/transaction.c linux-2.4.24/fs/jbd/transaction.c
--- linux-2.4.24.orig/fs/jbd/transaction.c	Fri Nov 28 10:26:21 2003
+++ linux-2.4.24/fs/jbd/transaction.c	Mon Jan 12 12:01:54 2004
@@ -56,7 +56,11 @@
 	transaction->t_journal = journal;
 	transaction->t_state = T_RUNNING;
 	transaction->t_tid = journal->j_transaction_sequence++;
-	transaction->t_expires = jiffies + journal->j_commit_interval;
+	/*
+	 * have to do it here, otherwise changed age_buffers since boot
+	 * wont have any effect
+	 */
+	transaction->t_expires = jiffies + get_buffer_flushtime();
 	INIT_LIST_HEAD(&transaction->t_jcb);
 
 	/* Set up the commit timer for the new transaction. */

--=-=-=


Phil.

--=-=-=--
