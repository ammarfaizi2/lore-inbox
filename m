Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132037AbRCVPBK>; Thu, 22 Mar 2001 10:01:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132047AbRCVPBC>; Thu, 22 Mar 2001 10:01:02 -0500
Received: from zeus.kernel.org ([209.10.41.242]:59093 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S132037AbRCVPAk>;
	Thu, 22 Mar 2001 10:00:40 -0500
Date: Thu, 22 Mar 2001 14:58:10 +0000
From: "Stephen C. Tweedie" <sct@redhat.com>
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Stephen Tweedie <sct@redhat.com>,
        arjanv@redhat.com, Linus Torvalds <torvalds@transmeta.com>
Subject: Thinko in kswapd?
Message-ID: <20010322145810.A7296@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Kj7319i9nmIyA2yE"
Content-Disposition: inline
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Kj7319i9nmIyA2yE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

There is what appears to be a simple thinko in kswapd.  We really
ought to keep kswapd running as long as there is either a free space
or an inactive page shortfall; but right now we only keep going if
_both_ are short.

Diff below.  With this change, I've got a 64MB box running Applix and
Star Office with multiple open documents plus a few other big apps
running, and switching desktops or going between documents is once
more nice and snappy.  Running a normal heavily populated desktop in
256MB used to be painful, with much apparently unnecessary swapping,
if we had background page-cache intensive operations (eg find|wc)
going on: the patched kernel feels much better interactively,
presumably because kswapd is now doing the work it is supposed to do,
instead of forcing normal apps to go into page stealing mode
themselves.

--Stephen


--Kj7319i9nmIyA2yE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="2.4.2-ac20.kswap.diff"

--- mm/vmscan.c.~1~	Fri Mar 16 15:39:24 2001
+++ mm/vmscan.c	Thu Mar 22 13:05:37 2001
@@ -1010,7 +1010,7 @@
 		 * We go to sleep for one second, but if it's needed
 		 * we'll be woken up earlier...
 		 */
-		if (!free_shortage() || !inactive_shortage()) {
+		if (!free_shortage() && !inactive_shortage()) {
 			interruptible_sleep_on_timeout(&kswapd_wait, HZ);
 		/*
 		 * If we couldn't free enough memory, we see if it was

--Kj7319i9nmIyA2yE--
