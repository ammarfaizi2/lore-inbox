Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261667AbVBEJya@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261667AbVBEJya (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Feb 2005 04:54:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265561AbVBEJy3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Feb 2005 04:54:29 -0500
Received: from colin2.muc.de ([193.149.48.15]:42250 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S265546AbVBEJyR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Feb 2005 04:54:17 -0500
Date: 5 Feb 2005 10:54:16 +0100
Date: Sat, 5 Feb 2005 10:54:16 +0100
From: Andi Kleen <ak@muc.de>
To: Tom Zanussi <zanussi@us.ibm.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Greg KH <greg@kroah.com>,
       Andrew Morton <akpm@osdl.org>, Roman Zippel <zippel@linux-m68k.org>,
       Robert Wisniewski <bob@watson.ibm.com>, Tim Bird <tim.bird@AM.SONY.COM>,
       karim@opersys.com
Subject: Re: [PATCH] relayfs redux, part 3 II - another comment
Message-ID: <20050205095416.GA2187@muc.de>
References: <16899.55393.651042.627079@tut.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16899.55393.651042.627079@tut.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Another comment on relay_write fast pathing

> +static inline unsigned relay_write(struct rchan *chan,
> +				   const void *data,
> +				   unsigned length)
> +{
> +	unsigned long flags;
> +	struct rchan_buf *buf = relay_get_buf(chan, smp_processor_id());
> +
> +	local_irq_save(flags);
> +	if (unlikely(buf->offset + length > chan->subbuf_size))
> +		length = relay_switch_subbuf(buf, length);
> +	memcpy(buf->data + buf->offset, data, length);

I said earlier gcc would optimize the memcpy, but thinking about
this again I'm not so sure anymore. The problem is that with variable 
buf->offset gcc cannot prove the alignment of the destination, and with 
unknown alignment it tends to generate a out of line call to memcpy, which
is quite typically slow. 

You can take a look at the generated assembly if that's true
or not, but I suspect it is.

To avoid this it may be needed to play 

if (__builtin_constant_p(length)) 
	switch (length) { 
	case 1: /* optimized version for 1 byte */ break;
	case 2: ...
	case 4: ...
	case 8:  ...
	}
else
	memcpy(...); 

games like e.g. uaccess.h does. Problem is that sometimes gcc seems
to break __builtin_constant_p inside inlines, so it may be needed
to move it into a macro (i would double check if that is really needed
though for this case, the code is much nicer with a inline) 

-Andi			
