Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262028AbVBJGau@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262028AbVBJGau (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Feb 2005 01:30:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262029AbVBJGau
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Feb 2005 01:30:50 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:7299 "EHLO e34.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S262028AbVBJGak (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Feb 2005 01:30:40 -0500
Date: Thu, 10 Feb 2005 12:00:54 +0530
From: Maneesh Soni <maneesh@in.ibm.com>
To: Tom Zanussi <zanussi@us.ibm.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Greg KH <greg@kroah.com>,
       Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@muc.de>,
       Roman Zippel <zippel@linux-m68k.org>,
       Robert Wisniewski <bob@watson.ibm.com>, Tim Bird <tim.bird@AM.SONY.COM>,
       Christoph Hellwig <hch@infradead.org>, karim@opersys.com
Subject: Re: [PATCH] relayfs redux, part 4
Message-ID: <20050210063054.GA4216@in.ibm.com>
Reply-To: maneesh@in.ibm.com
References: <16906.52160.870346.806462@tut.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16906.52160.870346.806462@tut.ibm.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 09, 2005 at 08:49:36PM -0600, Tom Zanussi wrote:
[..]
> + */
> +struct dentry *relayfs_create_file(const char *name, struct dentry *parent,
> +				   int mode, struct rchan *chan)
> +{
> +	struct dentry *dentry;
> +	int error;
> +	
> +	if (!mode)
> +		mode = S_IRUSR;
> +	mode = (mode & S_IALLUGO) | S_IFREG;
> +
> +	error = relayfs_create_entry(name, parent, mode, chan, &dentry);

^^^^
I think you missed GregKH's suggesstion to have relayfs_create_entry()
return pointer to struct dentry, and reduce one parameter.

> +unsigned relay_switch_subbuf(struct rchan_buf *buf, unsigned length)
> +{
> +	int cur_subbuf, prev_subbuf, subbufs_produced;
> +	unsigned start = 0, padding = buf->chan->subbuf_size - buf->offset;
> +	
> +	if (unlikely(relay_buf_full(buf)))
> +		return 0;
> +
> +	subbufs_produced = atomic_read(&buf->subbufs_produced);
> +	cur_subbuf = prev_subbuf = subbufs_produced % buf->chan->n_subbufs;
> +	buf->padding[cur_subbuf] = padding;
> +
> +	atomic_inc(&buf->subbufs_produced);
> +
> +	if (waitqueue_active(&buf->read_wait)) {
> +		PREPARE_WORK(&buf->wake_readers, wakeup_readers, buf);
> +		schedule_delayed_work(&buf->wake_readers, 1);
> +	}
> +
> +	if (unlikely(relay_buf_full(buf))) {
> +		return 0;
> +		buf->chan->cb->buf_full(buf);

		^^^^^^^^
		Typo? statement after return !


Thanks
Maneesh

-- 
Maneesh Soni
Linux Technology Center, 
IBM India Software Labs,
Bangalore, India
email: maneesh@in.ibm.com
Phone: 91-80-25044990
