Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266638AbTAZDhD>; Sat, 25 Jan 2003 22:37:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266640AbTAZDhD>; Sat, 25 Jan 2003 22:37:03 -0500
Received: from packet.digeo.com ([12.110.80.53]:62594 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S266638AbTAZDhC>;
	Sat, 25 Jan 2003 22:37:02 -0500
Date: Sat, 25 Jan 2003 19:46:48 -0800
From: Andrew Morton <akpm@digeo.com>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: green@namesys.com, linux-kernel@vger.kernel.org, hch@lst.de, jack@suse.cz,
       mason@suse.com, shemminger@osdl.org
Subject: Re: ext2 FS corruption with 2.5.59.
Message-Id: <20030125194648.6c417699.akpm@digeo.com>
In-Reply-To: <20030126032815.GA780@holomorphy.com>
References: <20030123153832.A860@namesys.com>
	<20030124023213.63d93156.akpm@digeo.com>
	<20030124153929.A894@namesys.com>
	<20030124225320.5d387993.akpm@digeo.com>
	<20030125153607.A10590@namesys.com>
	<20030125190410.7c91e640.akpm@digeo.com>
	<20030126032815.GA780@holomorphy.com>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 26 Jan 2003 03:46:10.0808 (UTC) FILETIME=[7753F780:01C2C4ED]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III <wli@holomorphy.com> wrote:
>
> On Sat, Jan 25, 2003 at 07:04:10PM -0800, Andrew Morton wrote:
> +static inline unsigned fr_write_begin(frlock_t *rw)
> +{
> +	unsigned ret = rw->pre_sequence++;
> +	wmb();
> +	return ret;
> +}	
> +
> +static inline unsigned fr_write_end(frlock_t *rw) 
> +{
> +	unsgned ret;
> +	wmb();
> +	ret = ++(rw->post_sequence);
> +	wmb();
> +	return ret;
> +}
> 
> Ticket locks need atomic fetch and increment. These don't look right.

Well look at the reader side:

loff_t i_size_read(struct inode *inode)
{
	unsigned seq;
	loff_t ret;

	do {
		seq = fr_write_begin(&inode->i_frlock);
		ret = inode->i_size;
	} while (seq != fr_write_end(&inode->i_frlock);
	return ret;
}

One change which is needed here is to disable preemption in fr_write_begin();
otherwise an frlock could be in the pre!=post state for hundreds of
milliseconds while the writer gets preempted.  Other CPUs would just spin for
the duration.

The same would happen if the writer takes an interrupt while pre!=post, but
that's the same for all spinlocks...


