Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752255AbWKVLb5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752255AbWKVLb5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Nov 2006 06:31:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752153AbWKVLb5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Nov 2006 06:31:57 -0500
Received: from relay.2ka.mipt.ru ([194.85.82.65]:31400 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S1752041AbWKVLb4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Nov 2006 06:31:56 -0500
Date: Wed, 22 Nov 2006 14:30:59 +0300
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Eric Dumazet <dada1@cosmosbay.com>
Cc: David Miller <davem@davemloft.net>, Ulrich Drepper <drepper@redhat.com>,
       Andrew Morton <akpm@osdl.org>, netdev <netdev@vger.kernel.org>,
       Zach Brown <zach.brown@oracle.com>,
       Christoph Hellwig <hch@infradead.org>,
       Chase Venters <chase.venters@clientec.com>,
       Johann Borck <johann.borck@densedata.com>, linux-kernel@vger.kernel.org,
       Jeff Garzik <jeff@garzik.org>
Subject: Re: [take25 6/6] kevent: Pipe notifications.
Message-ID: <20061122113057.GA28808@2ka.mipt.ru>
References: <11641265981515@2ka.mipt.ru> <200611221220.50245.dada1@cosmosbay.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <200611221220.50245.dada1@cosmosbay.com>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Wed, 22 Nov 2006 14:31:00 +0300 (MSK)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 22, 2006 at 12:20:50PM +0100, Eric Dumazet (dada1@cosmosbay.com) wrote:
> On Tuesday 21 November 2006 17:29, Evgeniy Polyakov wrote:
> > Pipe notifications.
> 
> > +int kevent_pipe_enqueue(struct kevent *k)
> > +{
> > +	struct file *pipe;
> > +	int err = -EBADF;
> > +	struct inode *inode;
> > +
> > +	pipe = fget(k->event.id.raw[0]);
> > +	if (!pipe)
> > +		goto err_out_exit;
> > +
> > +	inode = igrab(pipe->f_dentry->d_inode);
> > +	if (!inode)
> > +		goto err_out_fput;
> > +
> 
> Well...
> 
> How can you be sure 'pipe/inode' really refers to a pipe/fifo here ?
> 
> Hint : i_pipe <> NULL is not sufficient because i_pipe, i_bdev, i_cdev share 
> the same location. (check pipe_info() in fs/splice.c)
> 
> So I guess you need :
> 
> err = -EINVAL;
> if  (!S_ISFIFO(inode->i_mode))
> 	goto err_out_iput;
 
You are correct, I did not perform that check, since all pipe open
functions do rely on the i_pipe, which can not be block device at that
point, but with kevent file descriptor can be anything, so that check
must be performed.

I will put it into the tree, thanks Eric.
 
> Eric

-- 
	Evgeniy Polyakov
