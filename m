Return-Path: <linux-kernel-owner+w=401wt.eu-S932374AbXAPHYw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932374AbXAPHYw (ORCPT <rfc822;w@1wt.eu>);
	Tue, 16 Jan 2007 02:24:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932333AbXAPHYw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Jan 2007 02:24:52 -0500
Received: from smtp113.sbc.mail.mud.yahoo.com ([68.142.198.212]:42529 "HELO
	smtp113.sbc.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S932374AbXAPHYv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Jan 2007 02:24:51 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=pacbell.net;
  h=Received:X-YMail-OSG:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Disposition:Message-Id:Content-Type:Content-Transfer-Encoding;
  b=Cllq+YNFkR1o5K8c3WfWO7RBKoOmW7z2Yn2FrK84tfDX0X/eve86UDIzt9LzaoELBMjWMsheWHoEuS+Tggeve9FP2TTh2A5lvyhNt6mrzbXAoWGrRXoJidPPyOtmz1OZP2tQJ8tmupUZo5wsbujPp+hZwi+A1V/uwkG9ZAwXS/U=  ;
X-YMail-OSG: DDnFRJcVM1k0EJJu22i.MY9aAcfgqF8kDYvWpPVCTGa79tFmDPUtVLnZXJQT2ykPEkkWamZv2bYxX1XyZAGRd3W2ONnmCVI36Ex25A120ikFjpQFw6ORMpy8NjDltWn_cc0PbGDj8O5aUIk-
From: David Brownell <david-b@pacbell.net>
To: Nate Diller <nate@agami.com>
Subject: Re: [PATCH -mm 4/10][RFC] aio: convert aio_complete to file_endio_t
Date: Mon, 15 Jan 2007 21:53:46 -0800
User-Agent: KMail/1.7.1
Cc: Nate Diller <nate.diller@gmail.com>, Andrew Morton <akpm@osdl.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       Benjamin LaHaise <bcrl@kvack.org>,
       Alexander Viro <viro@zeniv.linux.org.uk>,
       Suparna Bhattacharya <suparna@in.ibm.com>,
       Kenneth W Chen <kenneth.w.chen@intel.com>,
       David Brownell <dbrownell@users.sourceforge.net>,
       Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, netdev@vger.kernel.org,
       ocfs2-devel@oss.oracle.com, linux-aio@kvack.org,
       xfs-masters@oss.sgi.com
References: <20070116015450.9764.38389.patchbomb.py@nate-64.agami.com>
In-Reply-To: <20070116015450.9764.38389.patchbomb.py@nate-64.agami.com>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200701152153.49260.david-b@pacbell.net>
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 15 January 2007 5:54 pm, Nate Diller wrote:
> --- a/drivers/usb/gadget/inode.c	2007-01-12 14:42:29.000000000 -0800
> +++ b/drivers/usb/gadget/inode.c	2007-01-12 14:25:34.000000000 -0800
> @@ -559,35 +559,32 @@ static int ep_aio_cancel(struct kiocb *i
>  	return value;
>  }
>  
> -static ssize_t ep_aio_read_retry(struct kiocb *iocb)
> +static int ep_aio_read_retry(struct kiocb *iocb)
>  {
>  	struct kiocb_priv	*priv = iocb->private;
> -	ssize_t			len, total;
> -	int			i;
> +	ssize_t			total;
> +	int			i, err = 0;
>  
>    	/* we "retry" to get the right mm context for this: */
>  
>   	/* copy stuff into user buffers */
>   	total = priv->actual;
> - 	len = 0;
>   	for (i=0; i < priv->nr_segs; i++) {
>   		ssize_t this = min((ssize_t)(priv->iv[i].iov_len), total);
>  
>   		if (copy_to_user(priv->iv[i].iov_base, priv->buf, this)) {
> - 			if (len == 0)
> - 				len = -EFAULT;
> + 			err = -EFAULT;

Discarding the capability to report partial success, e.g. that the first N
bytes were properly transferred?  I don't see any virtue in that change.
Quite the opposite in fact.

I think you're also expecting that if N bytes were requested, that's always
how many will be received.  That's not true for packetized I/O such as USB
isochronous transfers ... where it's quite legit (and in some cases routine)
for the other end to send packets that are shorter than the maximum allowed.
Sending a zero length packet is not the same as sending no packet at all,
for another example.
