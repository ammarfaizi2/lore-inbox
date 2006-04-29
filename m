Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030245AbWD2Aq1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030245AbWD2Aq1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Apr 2006 20:46:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030266AbWD2Aq0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Apr 2006 20:46:26 -0400
Received: from moutng.kundenserver.de ([212.227.126.171]:55232 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1030245AbWD2AqM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Apr 2006 20:46:12 -0400
Message-Id: <200604290245.57507.arnd@arndb.de>
References: <20060429004019.126937000@localhost.localdomain>
Date: Sat, 29 Apr 2006 02:45:56 +0200
From: Arnd Bergmann <arnd@arndb.de>
To: Paul Mackerras <paulus@samba.org>
Cc: cbe-oss-dev@ozlabs.org, linuxppc-dev@ozlabs.org,
       linux-kernel@vger.kernel.org, Ryan Arnold <rsa@us.ibm.com>,
       Michael Ellerman <michael@ellerman.id.au>,
       Arnd Bergmann <arnd.bergmann@de.ibm.com>
Subject: [PATCH 1/3] powerpc: Make rtas console _much_ faster
Content-Disposition: inline
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:bf0b512fe2ff06b96d9695102898be39
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the hvc_rtas driver is painfully slow to use. Our "benchmark" is
ls -R /etc, which spits out about 27866 characters. The theoretical maximum
speed would be about 2.2 seconds, the current code takes ~50 seconds.

The core of the problem is that sometimes when the tty layer asks us to push
characters the firmware isn't able to handle some or all of them, and so
returns an error. The current code sees this and just returns to the tty code
with the buffer half sent.

There's the khvcd thread which will eventually wake up and try to push more
characters, that will usually work because the firmware's had time to push
the characters out. But the thread only wakes up every 10 milliseconds, which
isn't fast enough.

There's already code in the hvc_console driver to make the khvcd thread do
a "quick" loop, where it just calls yield() instead of sleeping. The only code
that triggered that behaviour was recently removed though, which I don't
quite understand.

Still, if we set HVC_POLL_QUICK whenever the push hvc_push() doesn't push all
characters (ie. RTAS blocks), we can get good performance out of the hvc_rtas
backend. With this patch the "benchmark" takes ~2.8 seconds.

Cc: Ryan Arnold <rsa@us.ibm.com>
Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>

---

 drivers/char/hvc_console.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linus-2.6/drivers/char/hvc_console.c
===================================================================
--- linus-2.6.orig/drivers/char/hvc_console.c
+++ linus-2.6/drivers/char/hvc_console.c
@@ -570,7 +570,7 @@ static int hvc_poll(struct hvc_struct *h
 		hvc_push(hp);
 	/* Reschedule us if still some write pending */
 	if (hp->n_outbuf > 0)
-		poll_mask |= HVC_POLL_WRITE;
+		poll_mask |= HVC_POLL_WRITE | HVC_POLL_QUICK;
 
 	/* No tty attached, just skip */
 	tty = hp->tty;

--

