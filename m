Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751660AbWB0IAL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751660AbWB0IAL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 03:00:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751662AbWB0IAL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 03:00:11 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:23505 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751660AbWB0IAJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 03:00:09 -0500
Subject: Re: [PATCH 1/7] isdn4linux: Siemens Gigaset drivers - common module
From: Arjan van de Ven <arjan@infradead.org>
To: Hansjoerg Lipp <hjlipp@web.de>
Cc: Davem@davemloft.net, Karsten Keil <kkeil@suse.de>,
       i4ldeveloper@listserv.isdn4linux.de,
       linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       Greg Kroah-Hartman <gregkh@suse.de>, Tilman Schmidt <tilman@imap.cc>
In-Reply-To: <gigaset307x.2006.02.27.001.1@hjlipp.my-fqdn.de>
References: <gigaset307x.2006.02.27.001.0@hjlipp.my-fqdn.de>
	 <gigaset307x.2006.02.27.001.1@hjlipp.my-fqdn.de>
Content-Type: text/plain
Date: Mon, 27 Feb 2006 09:00:01 +0100
Message-Id: <1141027201.2992.45.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-02-27 at 07:23 +0100, Hansjoerg Lipp wrote:

> +	struct semaphore sem;		/* locks this structure:
> +					 *   connected is not changed,
> +					 *   hardware_up is not changed,
> +					 *   MState is not changed to or from
> +					 *   MS_LOCKED */
> +

please turn this into a mutex



> +/* handling routines for sk_buff */
> +/* ============================= */
> +
> +/* private version of __skb_put()
> + * append 'len' bytes to the content of 'skb', already knowing that the
> + * existing buffer can accomodate them
> + * returns a pointer to the location where the new bytes should be copied to
> + * This function does not take any locks so it must be called with the
> + * appropriate locks held only.
> + */
> +static inline unsigned char *gigaset_skb_put_quick(struct sk_buff *skb,
> +						   unsigned int len)
> +{
> +	unsigned char *tmp = skb->tail;
> +	/*SKB_LINEAR_ASSERT(skb);*/		/* not needed here */
> +	skb->tail += len;
> +	skb->len += len;
> +	return tmp;
> +}


this looks truely scary and wrong

> +/* append received bytes to inbuf */
> +static inline int gigaset_fill_inbuf(struct inbuf_t *inbuf,
> +				     const unsigned char *src,
> +				     unsigned numbytes)
> +{
> +	unsigned n, head, tail, bytesleft;
> +
> +	gig_dbg(DEBUG_INTR, "received %u bytes", numbytes);
> +
> +	if (!numbytes)
[snip 30 lines]

isn't this function rather big to be inlined ?
> +
> +/*======================================================================
> +  Prototypes of internal functions
> + */
> +
> +static struct cardstate *alloc_cs(struct gigaset_driver *drv);
> +static void free_cs(struct cardstate *cs);
> +static void make_valid(struct cardstate *cs, unsigned mask);
> +static void make_invalid(struct cardstate *cs, unsigned mask);

most of the time these can just go away by ordering the functions better

> +
> +void gigaset_dbg_buffer(enum debuglevel level, const unsigned char *msg,
> +			size_t len, const unsigned char *buf, int from_user)


such "from_user" parameter is highly evil, and also breaks sparse and
friends.. (btw please run sparse on the code and fix all warnings)




