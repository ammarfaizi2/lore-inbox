Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932649AbWB1V0v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932649AbWB1V0v (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 16:26:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932650AbWB1V0v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 16:26:51 -0500
Received: from adsl-70-250-156-241.dsl.austtx.swbell.net ([70.250.156.241]:60069
	"EHLO gw.microgate.com") by vger.kernel.org with ESMTP
	id S932649AbWB1V0u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 16:26:50 -0500
Subject: Re: [PATCH -rt] buggy UART fix
From: Paul Fulghum <paulkf@microgate.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Steven Rostedt <rostedt@goodmis.org>, Thomas Gleixner <tglx@linutronix.de>,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20060228204059.GA1825@elte.hu>
References: <Pine.LNX.4.58.0602270954520.26564@gandalf.stny.rr.com>
	 <20060228194503.GB23453@elte.hu>  <20060228204059.GA1825@elte.hu>
Content-Type: text/plain
Date: Tue, 28 Feb 2006 15:26:26 -0600
Message-Id: <1141161986.2914.2.camel@amdx2.microgate.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-02-28 at 21:40 +0100, Ingo Molnar wrote:
> hm, i just got the deadlock below, most likely due to your serial fix.  
> (never got this before) It's not 100% reproducible - booted the kernel a 
> dozen times (with your patch applied, working on other stuff) before i 
> got this deadlock.

The original patch grabs the port.lock and then
calls serial8250_handle_port() which grabs the lock
again. Just remove the spin_lock/spin_unlock below.

+ /*
+ * If we have a buggy TX line, that doesn't
+ * notify us via iir that we need to transmit
+ * then force the call.
+ */
+ if (!handled && (up->bugs & UART_BUG_TXEN)) {
+ spin_lock(&up->port.lock);
+ serial8250_handle_port(up, regs);
+ spin_unlock(&up->port.lock);
+ }

-- 
Paul Fulghum
Microgate Systems, Ltd

