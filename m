Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262893AbVCQAQq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262893AbVCQAQq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 19:16:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262896AbVCQAO4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 19:14:56 -0500
Received: from fire.osdl.org ([65.172.181.4]:43154 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262892AbVCPX4b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 18:56:31 -0500
Date: Wed, 16 Mar 2005 15:55:26 -0800
From: Chris Wright <chrisw@osdl.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: hugh@veritas.com, roland@redhat.com, torvalds@osdl.org, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, jmforbes@linuxtx.org, zwane@arm.linux.org.uk,
       cliffw@osdl.org, tytso@mit.edu, rddunlap@osdl.org
Subject: [6/9] tasklist left locked
Message-ID: <20050316235526.GE5389@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050316235336.GY5389@shell0.pdx.osdl.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

----

From: Hugh Dickins <hugh@veritas.com>

On 4-way SMP, about one reboot in twenty hangs while killing processes:
exit needs exclusive tasklist_lock, but something still holds read_lock.
do_signal_stop race case misses unlock, and fixing it fixes the symptom.

Signed-off-by: Hugh Dickins <hugh@veritas.com>
Acked-by: Roland McGrath <roland@redhat.com>
Signed-off-by: Chris Wright <chrisw@osdl.org>

--- 2.6.11/kernel/signal.c	2005-03-02 07:38:56.000000000 +0000
+++ linux/kernel/signal.c	2005-03-16 18:10:17.000000000 +0000
@@ -1728,6 +1728,7 @@ do_signal_stop(int signr)
 			 * with another processor delivering a stop signal,
 			 * then the SIGCONT that wakes us up should clear it.
 			 */
+			read_unlock(&tasklist_lock);
 			return 0;
 		}
 
