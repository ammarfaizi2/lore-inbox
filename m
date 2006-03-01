Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932132AbWCATsP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932132AbWCATsP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 14:48:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932192AbWCATsP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 14:48:15 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:36785 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S932132AbWCATsO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 14:48:14 -0500
Date: Wed, 1 Mar 2006 20:47:59 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@osdl.org>, Martin Michlmayr <tbm@cyrius.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Convert serial_core oopses to BUG_ON
Message-ID: <20060301194759.GA1879@elf.ucw.cz>
References: <20060226100518.GA31256@flint.arm.linux.org.uk> <20060226021414.6a3db942.akpm@osdl.org> <20060227141315.GD2429@ucw.cz> <20060228101713.6fd44027.akpm@osdl.org> <20060228220128.GA4254@unjust.cyrius.com> <20060228153256.64f4781d.akpm@osdl.org> <20060301171046.GA4024@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060301171046.GA4024@flint.arm.linux.org.uk>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On St 01-03-06 17:10:46, Russell King wrote:
> On Tue, Feb 28, 2006 at 03:32:56PM -0800, Andrew Morton wrote:
> > Martin Michlmayr <tbm@cyrius.com> wrote:
> > >
> > > * Andrew Morton <akpm@osdl.org> [2006-02-28 10:17]:
> > > > > It will oops in hard-to-guess, place, anyway.
> > > > Will it?   Where?  Unfixably?
> > > 
> > > http://www.linux-mips.org/archives/linux-mips/2006-02/msg00241.html is
> > > one example we just had on MIPS.  On SGI IP22, using the serial
> > > console, you'd get the following on shutdown:
> > > 
> > > The system is going down for reboot NOW!
> > > INIT: Sending processes the TERM signal
> > > INIT: Sending proces
> > > 
> > > and then nothing at all.  I'd never have suspected the serial driver,
> > > had not users reported that the machine shutdowns properly when using
> > > the framebuffer.
> > > 
> > > For the record, I don't mind whether it's BUG_ON or WARN_ON, but I
> > > just wanted to give this as an example of an "oops in hard-to-guess,
> > > place".
> > 
> > >From my reading of the above thread, putting the proposed workaround into
> > serial core will indeed allow people's machines to keep running while
> > reminding us about the driver bugs.
> 
> I would much rather the buggy drivers were actually fixed - is there a
> reason why the drivers can't actually be fixed (other than lazyness)?
> 
> Once they're fixed, adding a BUG_ON then becomes practical IMHO - it'll
> stop new driver writers being confused.

Okay, but lets add BUG_ONs that actually work. BUG_ON in second hunk
could never trigger, and last hunk did not help in specific case of
bluetooth problem. This should be better: it warns at right places,
but allows system to survive. I'll now try to fix bluetooth problem.

Signed-off-by: Pavel Machek <pavel@suse.cz>

diff --git a/drivers/serial/serial_core.c b/drivers/serial/serial_core.c
index 95fb493..cc1faa3 100644
--- a/drivers/serial/serial_core.c
+++ b/drivers/serial/serial_core.c
@@ -71,6 +71,11 @@ static void uart_change_pm(struct uart_s
 void uart_write_wakeup(struct uart_port *port)
 {
 	struct uart_info *info = port->info;
+	/*
+	 * This means you called this function _after_ the port was
+	 * closed.  No cookie for you.
+	 */
+	BUG_ON(!info);
 	tasklet_schedule(&info->tlet);
 }
 
@@ -471,14 +476,26 @@ static void uart_flush_chars(struct tty_
 }
 
 static int
-uart_write(struct tty_struct *tty, const unsigned char * buf, int count)
+uart_write(struct tty_struct *tty, const unsigned char *buf, int count)
 {
 	struct uart_state *state = tty->driver_data;
-	struct uart_port *port = state->port;
-	struct circ_buf *circ = &state->info->xmit;
+	struct uart_port *port;
+	struct circ_buf *circ;
 	unsigned long flags;
 	int c, ret = 0;
 
+	/*
+	 * This means you called this function _after_ the port was
+	 * closed.  No cookie for you.
+	 */
+	if (!state || !state->info) {
+		WARN_ON(1);
+		return -EL3HLT;
+	}
+
+	port = state->port;
+	circ = &state->info->xmit;
+
 	if (!circ->buf)
 		return 0;
 
@@ -521,6 +538,15 @@ static void uart_flush_buffer(struct tty
 	struct uart_port *port = state->port;
 	unsigned long flags;
 
+	/*
+	 * This means you called this function _after_ the port was
+	 * closed.  No cookie for you.
+	 */
+	if (!state || !state->info) {
+		WARN_ON(1);
+		return;
+	}
+
 	DPRINTK("uart_flush_buffer(%d) called\n", tty->index);
 
 	spin_lock_irqsave(&port->lock, flags);


-- 
Web maintainer for suspend.sf.net (www.sf.net/projects/suspend) wanted...
