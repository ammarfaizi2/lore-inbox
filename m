Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276249AbRJUP2R>; Sun, 21 Oct 2001 11:28:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276255AbRJUP15>; Sun, 21 Oct 2001 11:27:57 -0400
Received: from vasquez.zip.com.au ([203.12.97.41]:37647 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S276249AbRJUP1w>; Sun, 21 Oct 2001 11:27:52 -0400
Message-ID: <3BD2E89C.78D757A2@zip.com.au>
Date: Sun, 21 Oct 2001 08:24:12 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.12-ac3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Colin Phipps <cph@cph.demon.co.uk>
CC: Robert Love <rml@tech9.net>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] updated preempt-kernel
In-Reply-To: <1003562833.862.65.camel@phantasy>,
		<1003562833.862.65.camel@phantasy> <20011021120539.A1197@cph.demon.co.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Colin Phipps wrote:
> 
> [1.] NULL pointer deference in con_flush_chars with preempt patch
> [2.]
> Ok, running with preempt-kernel-rml-2.4.12-ac3-2.patch I had a crash
> yesterday.  It occured when the machine was under
> light load, I had just exited X, and I was logging off a console - I may
> have hit ctrl-d twice.  I did a little investigating myself, and the
> closest I could find in the archives was the problem mentioned in
> http://www.geocrawler.com/archives/3/35/1998/11/0/217652/ , except my
> crash is occuring at console close instead of open. It may not be
> preempt related, just preempt induced :-)
> 

This one has been reported before.

n_tty_receive_buf() puts a character into the tty queue and
then calls con_flush_chars(), which touches tty->driver_data.

Problem is, there's a window between these two operations where the
device can be closed (especially if the char is "^D"!), and con_close()
will zero out tty->driver_data.  Hence null pointer deref.

I don't really believe this explanation, because the timing's
wrong - the reader isn't woken until after the flush is called.
Hence it'll be very difficult to actually trigger this race.
It's probably something else.  But a bit more sticking plaster
should make it appear to be fixed:



--- linux-2.4.12-ac3/drivers/char/console.c	Mon Oct 15 16:04:23 2001
+++ ac/drivers/char/console.c	Sun Oct 21 08:19:42 2001
@@ -2387,9 +2387,15 @@ static void con_flush_chars(struct tty_s
 		return;
 
 	pm_access(pm_con);
-	acquire_console_sem();
-	set_cursor(vt->vc_num);
-	release_console_sem();
+	if (vt) {
+		/*
+		 * If we raced with con_close(), `vt' may be null.
+		 * Hence this bandaid.   - akpm
+		 */
+		acquire_console_sem();
+		set_cursor(vt->vc_num);
+		release_console_sem();
+	}
 }
 
 /*
