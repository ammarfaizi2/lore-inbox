Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268468AbUHYExS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268468AbUHYExS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 00:53:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268411AbUHYExS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 00:53:18 -0400
Received: from fw.osdl.org ([65.172.181.6]:55177 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268436AbUHYEvg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 00:51:36 -0400
Date: Tue, 24 Aug 2004 21:49:50 -0700
From: Andrew Morton <akpm@osdl.org>
To: Ryan Arnold <rsa@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, linuxppc64-dev@lists.linuxppc.org,
       paulus@samba.org, benh@kernel.crashing.org
Subject: Re: [PATCH] interrupt driven hvc_console as vio device
Message-Id: <20040824214950.5d9043a3.akpm@osdl.org>
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
>  static int hvc_write_room(struct tty_struct *tty)
>   {
>   	struct hvc_struct *hp = tty->driver_data;
>  +	unsigned long flags;
>  +	int retval;
>   
>  -	return N_OUTBUF - hp->n_outbuf;
>  +	spin_lock_irqsave(&hp->lock, flags);
>  +	retval = N_OUTBUF - hp->n_outbuf;
>  +	spin_unlock_irqrestore(&hp->lock, flags);
>  +	return retval;
>   }
>   
>   static int hvc_chars_in_buffer(struct tty_struct *tty)
>   {
>   	struct hvc_struct *hp = tty->driver_data;
>  +	unsigned long flags;
>  +	int retval;
>   
>  -	return hp->n_outbuf;
>  +	spin_lock_irqsave(&hp->lock, flags);
>  +	retval = hp->n_outbuf;
>  +	spin_unlock_irqrestore(&hp->lock, flags);
>  +	return retval;
>   }

The new locking in these functions doesn't really do anything, apart from
adding memory barriers.  If that's what you really want, I suggest you
simply add (commented) memory barriers.

