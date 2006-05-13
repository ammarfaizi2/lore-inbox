Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932413AbWEMMb2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932413AbWEMMb2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 May 2006 08:31:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932416AbWEMMb0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 May 2006 08:31:26 -0400
Received: from smtp.osdl.org ([65.172.181.4]:10404 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932413AbWEMMbH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 May 2006 08:31:07 -0400
Date: Sat, 13 May 2006 05:27:57 -0700
From: Andrew Morton <akpm@osdl.org>
To: Chris Wright <chrisw@sous-sol.org>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.osdl.org,
       xen-devel@lists.xensource.com, ian.pratt@xensource.com,
       Christian.Limpach@cl.cam.ac.uk
Subject: Re: [RFC PATCH 29/35] Add the Xen virtual console driver.
Message-Id: <20060513052757.59446e03.akpm@osdl.org>
In-Reply-To: <20060509085159.285105000@sous-sol.org>
References: <20060509084945.373541000@sous-sol.org>
	<20060509085159.285105000@sous-sol.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 09 May 2006 00:00:29 -0700
Chris Wright <chrisw@sous-sol.org> wrote:

> This provides a bootstrap and ongoing emergency console which is
> intended to be available from very early during boot and at all times
> thereafter, in contrast with alternatives such as UDP-based syslogd,
> or logging in via ssh. The protocol is based on a simple shared-memory
> ring buffer.
>
> ...
>
> +/* The kernel and user-land drivers share a common transmit buffer. */
> +static unsigned int wbuf_size = 4096;
> +#define WBUF_MASK(_i) ((_i)&(wbuf_size-1))
> +static char *wbuf;
> +static unsigned int wc, wp; /* write_cons, write_prod */
> +
> +static int __init xencons_bufsz_setup(char *str)
> +{
> +	unsigned int goal;
> +	goal = simple_strtoul(str, NULL, 0);
> +	while (wbuf_size < goal)
> +		wbuf_size <<= 1;

roundup_pow_of_two()

> +/* This lock protects accesses to the common transmit buffer. */
> +static spinlock_t xencons_lock = SPIN_LOCK_UNLOCKED;

DEFINE_SPINLOCK()  (entire patchset)

> +
> +static void kcons_write(
> +	struct console *c, const char *s, unsigned int count)
> +{
> +	int           i = 0;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&xencons_lock, flags);
> +
> +	while (i < count) {
> +		for (; i < count; i++) {
> +			if ((wp - wc) >= (wbuf_size - 1))
> +				break;
> +			if ((wbuf[WBUF_MASK(wp++)] = s[i]) == '\n')
> +				wbuf[WBUF_MASK(wp++)] = '\r';
> +		}
> +
> +		__xencons_tx_flush();
> +	}
> +
> +	spin_unlock_irqrestore(&xencons_lock, flags);
> +}

hm.  You have all that elaborate generate-ringbuffer-code-with-C-macros
stuff in the header file patch, yet this code (blessedly) doesn't use it.

> +static void kcons_write_dom0(
> +	struct console *c, const char *s, unsigned int count)
> +{
> +	int rc;
> +
> +	while ((count > 0) &&
> +	       ((rc = HYPERVISOR_console_io(
> +			CONSOLEIO_write, count, (char *)s)) > 0)) {
> +		count -= rc;
> +		s += rc;
> +	}
> +}

must.. not.. mention.. coding.. style..


