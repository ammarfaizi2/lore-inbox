Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268214AbUHYEuH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268214AbUHYEuH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 00:50:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268341AbUHYEtg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 00:49:36 -0400
Received: from fw.osdl.org ([65.172.181.6]:23174 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268214AbUHYEsG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 00:48:06 -0400
Date: Tue, 24 Aug 2004 21:46:20 -0700
From: Andrew Morton <akpm@osdl.org>
To: Ryan Arnold <rsa@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, linuxppc64-dev@lists.linuxppc.org,
       paulus@samba.org, benh@kernel.crashing.org
Subject: Re: [PATCH] interrupt driven hvc_console as vio device
Message-Id: <20040824214620.769e03de.akpm@osdl.org>
In-Reply-To: <1093394937.3402.83.camel@localhost>
References: <1093394937.3402.83.camel@localhost>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ryan Arnold <rsa@us.ibm.com> wrote:
>
>  static void hvc_close(struct tty_struct *tty, struct file * filp)
>   {
> ...
>  +		while (hp->n_outbuf) {
>  +			spin_unlock_irqrestore(&hp->lock, flags);
>  +			yield();
>  +			spin_lock_irqsave(&hp->lock, flags);
>  +		}

ick.

I suspect that if the caller of hvc_close() has realtime scheduling policy,
this locks up.  Unless it's waiting for interrupt activity.

Really, a real sleep/wakeup would be tons better.

