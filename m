Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261169AbUEQMxW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261169AbUEQMxW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 May 2004 08:53:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261179AbUEQMxW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 May 2004 08:53:22 -0400
Received: from mailout07.sul.t-online.com ([194.25.134.83]:20384 "EHLO
	mailout07.sul.t-online.com") by vger.kernel.org with ESMTP
	id S261169AbUEQMxU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 May 2004 08:53:20 -0400
From: tglx@linutronix.de (Thomas Gleixner)
Reply-To: tglx@linutronix.de
Organization: linutronix
To: Andries Brouwer <aebr@win.tue.nl>
Subject: Re: [PATCH 2.4.26] drivers/char/vt.c fix compiler warnings
Date: Mon, 17 May 2004 14:47:56 +0200
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org
References: <200405151505.23250.tglx@linutronix.de> <20040517104729.GA8933@wsdw14.win.tue.nl>
In-Reply-To: <20040517104729.GA8933@wsdw14.win.tue.nl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200405171447.56737.tglx@linutronix.de>
X-Seen: false
X-ID: bVk6qOZAQexqQNx66CZkkpgphwCw+gvocVS7J3F5A9Ar7ameIwGF4Y@t-dialin.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 17 May 2004 12:47, Andries Brouwer wrote:
> 4~On Sat, May 15, 2004 at 03:05:23PM +0200, Thomas Gleixner wrote:
> > The patch fixes the following warnings, produced by gcc3.3.3:
> >
> > s is a unsigned char, which can never be >= MAX_NR_KEYMAPS, as
> > MAX_NR_KEYMAPS = 256
> >
> > -	if (i >= NR_KEYS || s >= MAX_NR_KEYMAPS)
> > +	if (i >= NR_KEYS)
> >  		return -EINVAL;
>
> You see that you break thew source in order to avoid a compiler warning.
> Bad.
>
> (MAX_NR_KEYMAPS is a #define, often 256, on tiny systems people tend to
> pick 16. The above test is not superfluous. MAX_NR_KEYMAPS is not an
> absolute constant.)

Ooops, did not think about that. Was just annoyed from the compiler warnings.
What about:

--- linux-2.4.26-preempt/drivers/char/vt.c	2002-11-29 00:53:12.000000000 +0100
+++ linux-2.4.26-rc2-work/drivers/char/vt.c	2004-05-17 14:44:27.000000000 
+0200
@@ -163,7 +163,11 @@
 
 	if (copy_from_user(&tmp, user_kbe, sizeof(struct kbentry)))
 		return -EFAULT;
+#if MAX_NR_KEYMAPS < 256		
 	if (i >= NR_KEYS || s >= MAX_NR_KEYMAPS)
+#else
+	if (i >= NR_KEYS)
+#endif	
 		return -EINVAL;	
 
 	switch (cmd) {

-- 
Thomas
________________________________________________________________________
Steve Ballmer quotes the statistic that IT pros spend 70 percent of their 
time managing existing systems. That couldn’t have anything to do with 
the fact that 99 percent of these systems run Windows, could it?
________________________________________________________________________
linutronix - competence in embedded & realtime linux
http://www.linutronix.de
mail: tglx@linutronix.de

