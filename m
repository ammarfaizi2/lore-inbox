Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262282AbUCGRqM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Mar 2004 12:46:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262287AbUCGRqM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Mar 2004 12:46:12 -0500
Received: from [139.30.44.16] ([139.30.44.16]:62388 "EHLO
	gockel.physik3.uni-rostock.de") by vger.kernel.org with ESMTP
	id S262282AbUCGRqF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Mar 2004 12:46:05 -0500
Date: Sun, 7 Mar 2004 18:45:51 +0100 (CET)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: Arthur Corliss <corliss@digitalmages.com>
cc: Rik van Riel <riel@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH] Re: 2.6.x BSD Process Accounting w/High UID
In-Reply-To: <Pine.LNX.4.58.0403041324330.20616@bifrost.nevaeh-linux.org>
Message-ID: <Pine.LNX.4.53.0403071820190.32060@gockel.physik3.uni-rostock.de>
References: <Pine.LNX.4.44.0403041451360.20043-100000@chimarrao.boston.redhat.com>
 <Pine.LNX.4.58.0403041103500.24930@bifrost.nevaeh-linux.org>
 <Pine.LNX.4.53.0403042242190.29818@gockel.physik3.uni-rostock.de>
 <Pine.LNX.4.58.0403041324330.20616@bifrost.nevaeh-linux.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Mar 2004, Arthur Corliss wrote:

> Second:  I don't want new userspace tools, either, but I do want the ones
> I've got to work, which is what they don't do when it reports the lower bits
> of the uid field on high uids.  In other words, the tools are *already*
> broken.  I realise that I'm probably a corner case in that most admins will
> never assign high uids, but that really doesn't make me feel better about
> broken tools.  ;-)

But the current tools are only broken for the few people using high UIDs
(and generally on 64 bit archs, but that's a different story).

We shouldn't require people to recompile their userspace tools in the 
middle of a stable kernel series. (OK, 2.6 has just started, but we don't 
want to offend people upgrading from 2.4, either.)

How about the patch below? It requires a change to userspace tools if you
want to use high uids, but it dosn't break binary compatibility. It even
allows userspace to check whether high UIDs are supported, and allows
future incompatible format changes to be detected.


> > btw: if you actually push an incompatible change, could we do something
> > about large times as well?
> 
> If the numbers we're logging are meaningless, then hell, yes, let's fix them
> all!

Well, they are not totally meaningless since we clip at the maximum 
representable value instead of wrapping around.

Still, I'd prefer to do something about this as well. Will send out a
patch to deal with both things in a few minutes. (Note to Andrew/Linus:  
please don't apply the patch below before considering the other patch :-)


Tim


diff -urpP --exclude-from dontdiff linux-2.6.4-rc1/include/linux/acct.h linux-2.6.4-rc1-acct/include/linux/acct.h
--- linux-2.6.4-rc1/include/linux/acct.h	2004-02-04 04:43:17.000000000 +0100
+++ linux-2.6.4-rc1-acct/include/linux/acct.h	2004-03-07 18:03:48.000000000 +0100
@@ -33,6 +33,7 @@ typedef __u16	comp_t;
  */
 
 #define ACCT_COMM	16
+#define ACCT_VERSION    1
 
 struct acct
 {
@@ -56,7 +57,10 @@ struct acct
 	comp_t		ac_swaps;		/* Accounting Number of Swaps */
 	__u32		ac_exitcode;		/* Accounting Exitcode */
 	char		ac_comm[ACCT_COMM + 1];	/* Accounting Command Name */
-	char		ac_pad[10];		/* Accounting Padding Bytes */
+	__u16		ac_uid_hi;		/* Accounting Real User ID */
+	__u16		ac_gid_hi;		/* Accounting Real Group ID */
+	char		ac_pad[5];		/* Accounting Padding Bytes */
+	char		ac_version;		/* Always set to ACCT_VERSION */
 };
 
 /*

--- linux-2.6.4-rc1/kernel/acct.c	2004-02-04 04:43:56.000000000 +0100
+++ linux-2.6.4-rc1-acct/kernel/acct.c	2004-03-07 18:03:39.000000000 +0100
@@ -270,11 +270,19 @@ void acct_auto_close(struct super_block 
 #define	MANTSIZE	13			/* 13 bit mantissa. */
 #define	EXPSIZE		3			/* Base 8 (3 bit) exponent. */
 #define	MAXFRACT	((1 << MANTSIZE) - 1)	/* Maximum fractional value. */
+#define MAXVAL	((unsigned long long) MAXFRACT << (EXPSIZE*((1<<EXPSIZE)-1)))
+						/* Maximum encodable value. */
 
 static comp_t encode_comp_t(unsigned long value)
 {
 	int exp, rnd;
 
+	/*
+	 * On 64 bit platforms, value may be too large to fit into a comp_t.
+	 */
+	if (value > MAXVAL)
+		return (comp_t) -1;
+
 	exp = rnd = 0;
 	while (value > MAXFRACT) {
 		rnd = value & (1 << (EXPSIZE - 1));	/* Round up? */
@@ -342,7 +350,9 @@ static void do_acct_process(long exitcod
 	ac.ac_stime = encode_comp_t(current->stime);
 	/* we really need to bite the bullet and change layout */
 	ac.ac_uid = current->uid;
+	ac.ac_uid_hi = current->uid >> 16;
 	ac.ac_gid = current->gid;
+	ac.ac_gid_hi = current->gid >> 16;
 	ac.ac_tty = current->tty ? old_encode_dev(tty_devnum(current->tty)) : 0;
 
 	ac.ac_flag = 0;
@@ -374,6 +384,7 @@ static void do_acct_process(long exitcod
 	ac.ac_majflt = encode_comp_t(current->maj_flt);
 	ac.ac_swaps = encode_comp_t(current->nswap);
 	ac.ac_exitcode = exitcode;
+	ac.ac_version = ACCT_VERSION;
 
 	/*
          * Kernel segment override to datasegment and write it
