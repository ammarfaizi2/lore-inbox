Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261424AbVAaXNU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261424AbVAaXNU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 18:13:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261425AbVAaXNU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 18:13:20 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:47547 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S261424AbVAaXNG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 18:13:06 -0500
Date: Tue, 1 Feb 2005 00:12:56 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Tom Zanussi <zanussi@us.ibm.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>, Greg KH <greg@kroah.com>,
       Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@muc.de>,
       Robert Wisniewski <bob@watson.ibm.com>, Tim Bird <tim.bird@AM.SONY.COM>,
       karim@opersys.com
Subject: Re: [PATCH] relayfs redux, part 2
In-Reply-To: <16890.38062.477373.644205@tut.ibm.com>
Message-ID: <Pine.LNX.4.61.0501312247150.30794@scrub.home>
References: <16890.38062.477373.644205@tut.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 28 Jan 2005, Tom Zanussi wrote:

> +static inline int rchan_create_file(const char *chanpath,
> +				    struct dentry **dentry,
> +				    struct rchan_buf *data)
> +{
> +	int err;
> +	const char * fname;
> +	struct dentry *topdir;
> +
> +	err = rchan_create_dir(chanpath, &fname, &topdir);
> +	if (err && (err != -EEXIST))
> +		return err;
> +
> +	err = relayfs_create_file(fname, topdir, dentry, data, S_IRUSR);
> +
> +	return err;
> +}

What protects topdir from being removed inbetween?
Why is necessary to let the user create/remove files/dirs at all?

> +void *relay_reserve(struct rchan *chan,
> +                   unsigned length,
> +                   int cpu)
> +{
> +       unsigned offset;
> +       struct rchan_buf *buffer;
> +
> +       buffer = relay_get_buffer(chan, cpu);
> +
> +       while(1) {
> +               offset = local_add_return(&buffer->offset, length);
> +               if (likely(offset + length <= buffer->bufsize))
> +                       break;
> +               buffer = relay_switch_buffer(buffer, offset, length);
> +               if (buffer == NULL)
> +                       return NULL;
> +       }
> +
> +       return buffer->data + offset;
> +}
> +
> [..]
> +
> +unsigned relay_write(struct rchan *chan,
> +		     const void *data,
> +		     unsigned length)
> +{
> +	int cpu;
> +	char *reserved;
> +	unsigned count = 0;
> +
> +	cpu = get_cpu();
> +
> +	reserved = relay_reserve(chan, length, cpu);
> +	if(reserved) {
> +		memcpy(reserved, data, length);
> +		count = length;
> +	}
> +
> +	put_cpu();
> + 
> +	return count;
> +}

For the first version I would suggest to use just local_irq_save/_restore.
Getting it right with local_add_return is not trivial and I'm pretty sure 
your relay_switch_buffer() gets it wrong, e.g. the caller for whom (offset 
< bufsize) must close the subbuffer. Also buffer->data in relay_reserve 
may have become invalid (e.g. by an interrupt just before it).

You can also move all the rchan_buf members which are not written to in 
the event path and which are common to all channels back to rchan.
relay_write should so look more like this:

unsigned int relay_write(struct rchan *chan, const void *data, 
			 unsigned int length)
{
	struct rchan_buf *buffer;
	unsigned long flags;

	local_irq_save(flags);
	buffer = chan->buff[smp_processor_id()];
	if (unlikely(buffer->offset + length > chan->size)) {
		if (relay_switch_buffer(chan, buffer)) {
			length = 0;
			goto out;
		}
	}
	memcpy(buffer->data + offset, data, length);
	buffer->offset += length;
out:
	local_irq_restore(flags);
	return length;
}

relay_reserve() should be more or less obvious from this.

bye, Roman
