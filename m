Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265224AbVBDWzj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265224AbVBDWzj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 17:55:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266114AbVBDWwu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 17:52:50 -0500
Received: from colin2.muc.de ([193.149.48.15]:3593 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S264177AbVBDWMg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 17:12:36 -0500
Date: 4 Feb 2005 23:12:30 +0100
Date: Fri, 4 Feb 2005 23:12:30 +0100
From: Andi Kleen <ak@muc.de>
To: Tom Zanussi <zanussi@us.ibm.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Greg KH <greg@kroah.com>,
       Andrew Morton <akpm@osdl.org>, Roman Zippel <zippel@linux-m68k.org>,
       Robert Wisniewski <bob@watson.ibm.com>, Tim Bird <tim.bird@AM.SONY.COM>,
       karim@opersys.com
Subject: Re: [PATCH] relayfs redux, part 3
Message-ID: <20050204221230.GA97506@muc.de>
References: <16899.55393.651042.627079@tut.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16899.55393.651042.627079@tut.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just a minor comment, not reading it all. 

On Fri, Feb 04, 2005 at 02:17:37PM -0600, Tom Zanussi wrote:
_write - write data into the channel
> + *	@chan: relay channel
> + *	@data: data to be written
> + *	@length: number of bytes to write
> + *
> + *	Returns the number of bytes written, 0 if full.
> + *
> + *	Writes data into the current cpu's channel buffer.  irq safe.

This needs a better comment on the allowed contexts. 

> + */
> +static inline unsigned relay_write(struct rchan *chan,
> +				   const void *data,
> +				   unsigned length)
> +{
> +	unsigned long flags;
> +	struct rchan_buf *buf = relay_get_buf(chan, smp_processor_id());

Needs to be inside the local_irq_save of course.

> +
> +	local_irq_save(flags);
> +	if (unlikely(buf->offset + length > chan->subbuf_size))
> +		length = relay_switch_subbuf(buf, length);
> +	memcpy(buf->data + buf->offset, data, length);
> +	buf->offset += length;
> +	local_irq_restore(flags);
> + 
> +	return length;

Is there any useful user case for returning length here? 
(e.g. are users likely to handle errors? I doubt it somehow) 

If not I would eliminate it.

> +}
> +
> +/**
> + *	__relay_write - write data into the channel
> + *	@chan: relay channel
> + *	@data: data to be written
> + *	@length: number of bytes to write
> + *
> + *	Returns the number of bytes written, 0 if full.
> + *
> + *	Writes data into the current cpu's channel buffer.  Preempt safe.

And this needs more comments on the context too.

-Andi
