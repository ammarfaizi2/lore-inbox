Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261181AbUDIK6e (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Apr 2004 06:58:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261186AbUDIK6e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Apr 2004 06:58:34 -0400
Received: from fw.osdl.org ([65.172.181.6]:17100 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261181AbUDIK6c (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Apr 2004 06:58:32 -0400
Date: Fri, 9 Apr 2004 03:58:12 -0700
From: Andrew Morton <akpm@osdl.org>
To: John M Flinchbaugh <glynis@butterfly.hjsoft.com>
Cc: linux-kernel@vger.kernel.org, tomc@compaqnet.fr
Subject: Re: bsd accounting lockups on smp 2.6.x machines
Message-Id: <20040409035812.70d33081.akpm@osdl.org>
In-Reply-To: <20040225184724.GA2618@butterfly.hjsoft.com>
References: <20040225184724.GA2618@butterfly.hjsoft.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John M Flinchbaugh <glynis@butterfly.hjsoft.com> wrote:
>
> i originally reported kernel oopses and locks here against 2.6.1:
> http://marc.theaimsgroup.com/?l=linux-kernel&m=107488761716255&w=2
> 
> then another person reported it against 2.6.2:
> http://marc.theaimsgroup.com/?l=linux-kernel&m=107697407107875&w=2
> 
> i just saw it happen against 2.6.3, but i couldn't capture an
> oops.  it's still out there.  does anyone have any leads on what
> causes it?  disabling  bsd accounting seems to aleviate the
> crashes.
> 
> running tomcat's stop script (java processes) triggers it at
> times for me.

Guys, are either of you still able to reproduce this oops in BSD accounting?

If so, would you be able to determine whether this fixes it?   Thanks.

diff -puN kernel/acct.c~acct-oops-fix kernel/acct.c
--- 25/kernel/acct.c~acct-oops-fix	2004-04-09 03:52:59.816330248 -0700
+++ 25-akpm/kernel/acct.c	2004-04-09 03:54:08.671862616 -0700
@@ -347,7 +347,10 @@ static void do_acct_process(long exitcod
 	/* we really need to bite the bullet and change layout */
 	ac.ac_uid = current->uid;
 	ac.ac_gid = current->gid;
+
+	read_lock(&tasklist_lock);	/* pin current->tty */
 	ac.ac_tty = current->tty ? old_encode_dev(tty_devnum(current->tty)) : 0;
+	read_unlock(&tasklist_lock);
 
 	ac.ac_flag = 0;
 	if (current->flags & PF_FORKNOEXEC)

_

