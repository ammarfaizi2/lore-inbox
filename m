Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286530AbRLUJOl>; Fri, 21 Dec 2001 04:14:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286581AbRLUJOb>; Fri, 21 Dec 2001 04:14:31 -0500
Received: from ns0.dhm-systems.de ([195.126.154.163]:35855 "EHLO
	ns0.dhm-systems.de") by vger.kernel.org with ESMTP
	id <S286569AbRLUJOS>; Fri, 21 Dec 2001 04:14:18 -0500
Message-ID: <3C22FD46.11CC921A@web-systems.net>
Date: Fri, 21 Dec 2001 10:13:42 +0100
From: Heinz-Ado Arnolds <Ado.Arnolds@dhm-systems.de>
Reply-To: Ado.Arnolds@dhm-systems.de
Organization: DHM GmbH & Co. KG
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.16 i686)
X-Accept-Language: de, en, fr, ru
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo@conectiva.com.br>,
        Linus Torvalds <torvalds@transmeta.com>, alan@lxorguk.ukuu.org.uk
CC: linux-kernel@vger.kernel.org, Rogier Wolff <R.E.Wolff@BitWizard.nl>,
        hylafax-users@hylafax.org, hylafax-devel@hylafax.org
Subject: Re: sx driver, DCD-HylaFAX problem solved
In-Reply-To: <200112210008.BAA20609@cave.bitwizard.nl>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rogier Wolff wrote:
> 
...
> Please Email Marcello, Linus and linux-kernel with this patch, and
> state that you are submitting this patch on my request for inclusion
> in the standard kernel.
> 
>                         Roger.

Hi Marcelo, hi Linus, hi Alan,

I'm sending you this patch to the specialix sx driver on the request
of Roger E. Wolf. It fixes a long outstanding problem with hangup when
a DCD change is detected by the driver. The CLOCAL in c_cflag was
ignored. The problem shows up in connection with HylaFAX and gettys.

Please insert this patch into the next available kernel releases.
The patch is to linux-2.4.16, but this section of the sx driver
didn't change at least since 2.2.19.

Thanks a lot for your attention.

Ado

-------------------------------------------------------------------------

--- linux/drivers/char/sx.c.~1~	Fri Nov  9 23:01:21 2001
+++ linux/drivers/char/sx.c	Thu Dec 20 17:22:53 2001
@@ -1160,7 +1160,8 @@
 				/* DCD went UP */
 				if( (~(port->gs.flags & ASYNC_NORMAL_ACTIVE) || 
 						 ~(port->gs.flags & ASYNC_CALLOUT_ACTIVE)) &&
-						(sx_read_channel_byte(port, hi_hstat) != HS_IDLE_CLOSED)) {
+						(sx_read_channel_byte(port, hi_hstat) != HS_IDLE_CLOSED) &&
+						!(port->gs.tty->termios->c_cflag & CLOCAL) ) {
 					/* Are we blocking in open?*/
 					sx_dprintk (SX_DEBUG_MODEMSIGNALS, "DCD active, unblocking
open\n");
 					wake_up_interruptible(&port->gs.open_wait);
@@ -1170,7 +1171,8 @@
 			} else {
 				/* DCD went down! */
 				if (!((port->gs.flags & ASYNC_CALLOUT_ACTIVE) &&
-				      (port->gs.flags & ASYNC_CALLOUT_NOHUP))) {
+				      (port->gs.flags & ASYNC_CALLOUT_NOHUP)) &&
+				    !(port->gs.tty->termios->c_cflag & CLOCAL) ) {
 					sx_dprintk (SX_DEBUG_MODEMSIGNALS, "DCD dropped. hanging
up....\n");
 					tty_hangup (port->gs.tty);
 				} else {

-- 
------------------------------------------------------------------------
  Heinz-Ado Arnolds                        Ado.Arnolds@web-systems.net
  Websystems GmbH                              +49 2234 1840-0 (voice)
  Max-Planck-Strasse 2, 50858 Koeln, Germany   +49 2234 1840-40  (fax)
