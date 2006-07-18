Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932166AbWGRKZi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932166AbWGRKZi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jul 2006 06:25:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932167AbWGRKZi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jul 2006 06:25:38 -0400
Received: from [216.208.38.107] ([216.208.38.107]:56704 "EHLO
	OTTLS.pngxnet.com") by vger.kernel.org with ESMTP id S932166AbWGRKZh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jul 2006 06:25:37 -0400
Subject: Re: [RFC PATCH 27/33] Add the Xen virtual console driver.
From: Arjan van de Ven <arjan@infradead.org>
To: Chris Wright <chrisw@sous-sol.org>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.osdl.org,
       xen-devel@lists.xensource.com, Jeremy Fitzhardinge <jeremy@goop.org>,
       Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>,
       Rusty Russell <rusty@rustcorp.com.au>, Zachary Amsden <zach@vmware.com>,
       Ian Pratt <ian.pratt@xensource.com>,
       Christian Limpach <Christian.Limpach@cl.cam.ac.uk>
In-Reply-To: <20060718091956.653901000@sous-sol.org>
References: <20060718091807.467468000@sous-sol.org>
	 <20060718091956.653901000@sous-sol.org>
Content-Type: text/plain
Organization: Intel International BV
Date: Tue, 18 Jul 2006 12:24:38 +0200
Message-Id: <1153218278.3038.43.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-07-18 at 00:00 -0700, Chris Wright wrote:
> +			} else if (sysrq_requested) {
> +				unsigned long sysrq_timeout =
> +					sysrq_requested + HZ*2;
> +				sysrq_requested = 0;
> +				if (time_before(jiffies, sysrq_timeout)) {
> +					spin_unlock_irqrestore(
> +						&xencons_lock, flags);
> +					handle_sysrq(
> +						buf[i], regs, xencons_tty);
> +					spin_lock_irqsave(
> +						&xencons_lock, flags);
> +					continue;
> +				}

Lindent can be harmful...

> +static void xencons_wait_until_sent(struct tty_struct *tty, int timeout)
> +{
> +	unsigned long orig_jiffies = jiffies;
> +
> +	if (TTY_INDEX(tty) != 0)
> +		return;
> +
> +	while (DRV(tty->driver)->chars_in_buffer(tty)) {
> +		set_current_state(TASK_INTERRUPTIBLE);
> +		schedule_timeout(1);
> +		if (signal_pending(current))
> +			break;
> +		if (timeout && time_after(jiffies, orig_jiffies + timeout))
> +			break;
> +	}
> +
> +	set_current_state(TASK_RUNNING);
> +}

hmm somehow I find this code scary; we had similar code recently
elsewhere where this turned out to be a real issue; you now sleep for
"1" time, so you sleep for a fixed time if you aren't getting wakeups,
but if you are getting wakeups your code is upside down, I would expect
it to look like

+	set_current_state(TASK_INTERRUPTIBLE);
+	while (DRV(tty->driver)->chars_in_buffer(tty))
+		schedule_timeout(1);
+		if (signal_pending(current))
+			break;
+		if (timeout && time_after(jiffies, orig_jiffies + timeout))
+			break;
+		set_current_state(TASK_INTERRUPTIBLE);
+	}

instead, so that you don't have the wakeup race..




