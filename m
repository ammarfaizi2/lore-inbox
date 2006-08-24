Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751672AbWHXTdK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751672AbWHXTdK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 15:33:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751676AbWHXTdJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 15:33:09 -0400
Received: from pat.uio.no ([129.240.10.4]:24481 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S1751672AbWHXTdI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 15:33:08 -0400
Subject: Re: [PATCH] NFS: Check lengths more thoroughly in NFS4 readdir XDR
	decode
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: David Howells <dhowells@redhat.com>
Cc: torvalds@osdl.org, akpm@osdl.org, aviro@redhat.com, steved@redhat.com,
       linux-kernel@vger.kernel.org, nfsv4@linux-nfs.org
In-Reply-To: <7346.1156444521@warthog.cambridge.redhat.com>
References: <1156432859.5629.24.camel@localhost>
	 <32511.1156263593@warthog.cambridge.redhat.com>
	 <7346.1156444521@warthog.cambridge.redhat.com>
Content-Type: text/plain
Date: Thu, 24 Aug 2006 15:32:54 -0400
Message-Id: <1156447974.5629.54.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
X-UiO-Spam-info: not spam, SpamAssassin (score=-1.924, required 12,
	autolearn=disabled, AWL 0.56, RCVD_IN_XBL 2.51,
	UIO_MAIL_IS_INTERNAL -5.00)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-08-24 at 19:35 +0100, David Howells wrote:
> So, what you've done is:
> 
> -+		if (end - p < xlen)
> ++		if (end - p < xlen + 1)
>   			goto short_pkt;
>  +		dprintk("filename = %*s\n", len, (char *)p);
>  +		p += xlen;
>   		len = ntohl(*p++);	/* bitmap length */
>  -		p += len;
>  -		if (p + 1 > end)
> -+		if (end - p < len)
> ++		if (end - p < len + 1)
>   			goto short_pkt;
>  +		p += len;
>   		attrlen = XDR_QUADLEN(ntohl(*p++));
>  -		p += attrlen;		/* attributes */
>  -		if (p + 2 > end)
> -+		if (end - p < attrlen + 1)
> ++		if (end - p < attrlen + 2)
> 
> But is this equivalent:
> 
> -+		if (end - p < xlen)
> ++		if (end - p <= xlen)
>   			goto short_pkt;
>  +		dprintk("filename = %*s\n", len, (char *)p);
>  +		p += xlen;
>   		len = ntohl(*p++);	/* bitmap length */
>  -		p += len;
>  -		if (p + 1 > end)
> -+		if (end - p < len)
> ++		if (end - p <= len)
>   			goto short_pkt;
>  +		p += len;
>   		attrlen = XDR_QUADLEN(ntohl(*p++));
>  -		p += attrlen;		/* attributes */
>  -		if (p + 2 > end)
> -+		if (end - p < attrlen + 1)
> ++		if (end - p <= attrlen + 1)
                              ^^^^^^^^^^^^^^
> 
> Do you think?

No. I find that mixture of < and <= is much less easy to read. Besides,
the compiler should be able to optimise that for me.

Cheers,
  Trond

