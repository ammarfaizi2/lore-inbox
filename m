Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262085AbVBUUUq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262085AbVBUUUq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Feb 2005 15:20:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262086AbVBUUUp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Feb 2005 15:20:45 -0500
Received: from fire.osdl.org ([65.172.181.4]:25574 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262085AbVBUUUe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Feb 2005 15:20:34 -0500
Date: Mon, 21 Feb 2005 12:20:47 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Russell King <rmk+lkml@arm.linux.org.uk>, Andrew Morton <akpm@osdl.org>
cc: Martin Drohmann <m_droh01@uni-muenster.de>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Why does printk helps PCMCIA card to initialise?
In-Reply-To: <20050221091754.A28213@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.58.0502211211050.2378@ppc970.osdl.org>
References: <42187819.5050808@uni-muenster.de> <20050220123817.A12696@flint.arm.linux.org.uk>
 <20050221091754.A28213@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 21 Feb 2005, Russell King wrote:
> 
> In cs.c, alloc_io_space(), find the line:
> 
>     if (*base & ~(align-1)) {
> 
> delete the ~ and rebuild.  This may resolve your problem.

Unlikely. The code is too broken for words.

First off, setting align to zero makes no sense. An alignment cannot be
zero, although some other parts of the system seem to consider a zero
alignment to be the same as a maximum one (ie nonstatic_find_io_region()).

Something like the appended has at least a snowballs chance in hell of 
being correct, although considering the amount of confusion in that single 
function, I'm not very optimistic.

In particular, the initialization of "align" still has a case where it 
sets alignment to 0:

	align = (*base) ? (lines ? 1<<lines : 0) : 1;

(ie *base != 0 and lines == 0), and that one is _guaranteed_ to cause a 
warning just a line later when we do a (corrected)

	if (*base & (align-1))

and then set align to 1 again.

IOW, the whole function just does not make any sense. It didn't make sense 
before, it doesn't make sense after it's partly fixed. Somebody who 
understands what it is actually supposed to _do_, please explain it..

		Linus

--
--- 1.124/drivers/pcmcia/cs.c	2005-01-25 13:50:25 -08:00
+++ edited/drivers/pcmcia/cs.c	2005-02-21 12:13:52 -08:00
@@ -748,14 +748,14 @@
 	if (*base) {
 	    cs_dbg(s, 0, "odd IO request: num %#x align %#lx\n",
 		   num, align);
-	    align = 0;
+	    align = 1;
 	} else
 	    while (align && (align < num)) align <<= 1;
     }
-    if (*base & ~(align-1)) {
+    if (*base & (align-1)) {
 	cs_dbg(s, 0, "odd IO request: base %#x align %#lx\n",
 	       *base, align);
-	align = 0;
+	align = 1;
     }
     if ((s->features & SS_CAP_STATIC_MAP) && s->io_offset) {
 	*base = s->io_offset | (*base & 0x0fff);
@@ -766,7 +766,7 @@
        potential conflicts, just the most obvious ones. */
     for (i = 0; i < MAX_IO_WIN; i++)
 	if ((s->io[i].NumPorts != 0) &&
-	    ((s->io[i].BasePort & (align-1)) == *base))
+	    ((s->io[i].BasePort & ~(align-1)) == *base))
 	    return 1;
     for (i = 0; i < MAX_IO_WIN; i++) {
 	if (s->io[i].NumPorts == 0) {
