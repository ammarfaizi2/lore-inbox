Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264258AbTLYBXh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Dec 2003 20:23:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264259AbTLYBXg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Dec 2003 20:23:36 -0500
Received: from dbl.q-ag.de ([80.146.160.66]:38016 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S264258AbTLYBXe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Dec 2003 20:23:34 -0500
Date: Thu, 25 Dec 2003 02:21:04 +0100 (CET)
From: Manfred Spraul <manfred@colorfullife.com>
X-X-Sender: manfred@dbl.q-ag.de
To: Linus Torvalds <torvalds@osdl.org>
cc: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
       <lse-tech@lists.sourceforge.net>, <linux-kernel@vger.kernel.org>
Subject: Re: [RFC,PATCH] use rcu for fasync_lock
In-Reply-To: <Pine.LNX.4.58.0312211357200.1621@home.osdl.org>
Message-ID: <Pine.LNX.4.44.0312250213120.13730-100000@dbl.q-ag.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 21 Dec 2003, Linus Torvalds wrote:

>
> > kill_fasync is far more common (every pipe_read and _write), I want to
> > remove the unconditional read_lock(&global_lock).
>
> Note that my personal preference would be to kill off "kill_fasync()"
> entirely.
>
We've discussed that earlier in the thread, and came to the same
conclusion. Unfortunately it touches several drivers, and is not a simple
patch. Viro's summary of fasync in Documentation/filesystem/Locking is
"fasync is a mess" - converting kill_fasync to wake_up_band() is 2.7
stuff.

What about this minimal approach:

<<<<
--- 2.6/fs/fcntl.c	2003-12-04 19:44:38.000000000 +0100
+++ build-2.6/fs/fcntl.c	2003-12-24 00:15:16.000000000 +0100
@@ -609,9 +609,15 @@

 void kill_fasync(struct fasync_struct **fp, int sig, int band)
 {
-	read_lock(&fasync_lock);
-	__kill_fasync(*fp, sig, band);
-	read_unlock(&fasync_lock);
+	/* First a quick test without locking: usually
+	 * the list is empty.
+	 */
+	if (*fp) {
+		read_lock(&fasync_lock);
+		/* reread *fp after obtaining the lock */
+		__kill_fasync(*fp, sig, band);
+		read_unlock(&fasync_lock);
+	}
 }

 EXPORT_SYMBOL(kill_fasync);
<<<<


--
	Manfred

