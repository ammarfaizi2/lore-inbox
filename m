Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261884AbULUXyJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261884AbULUXyJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Dec 2004 18:54:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261899AbULUXyJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Dec 2004 18:54:09 -0500
Received: from coderock.org ([193.77.147.115]:5833 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S261884AbULUXyA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Dec 2004 18:54:00 -0500
Date: Wed, 22 Dec 2004 00:54:24 +0100
From: Domen Puncer <domen@coderock.org>
To: Jesper Juhl <juhl-lkml@dif.dk>
Cc: Steve French <sfrench@samba.org>, Steve French <sfrench@us.ibm.com>,
       samba-technical@lists.samba.org, linux-kernel@vger.kernel.org
Subject: Re: in cifssmb.c add copy_from_user return value check and do minor formatting/whitespace cleanups.
Message-ID: <20041221235424.GA19274@nd47.coderock.org>
References: <Pine.LNX.4.61.0412220021580.3518@dragon.hygekrogen.localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0412220021580.3518@dragon.hygekrogen.localhost>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/12/04 00:33 +0100, Jesper Juhl wrote:
> 
> Hi, 
> 
> Seeing this warning :
> 
> fs/cifs/cifssmb.c:902: warning: ignoring return value of `copy_from_user', declared with attribute warn_unused_result
> 
> lead to the following patch.
> 
> The patch adds a check of the copy_from_user return value and returns 
> -EFAULT if the call fails. In addition to that I did some 
> formatting/whitespace changes - the code uses primarily tabs for 
> indentation, but this little bit used spaces, so I changed that to tabs; I 
> also added a few curly braces {} for a few if statements, in the same 
> area, that seemed to be becomming quite hard to read without.
> 
> Patch has been compile tested, but I have no real way to test it properly 
> beyond that. 
> I hope the patch is acceptable and mergable :)
> 
> Btw, I'm only subscribed to LKML, so please keep me on CC.
> 
> 
> Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>
> 
> diff -up linux-2.6.10-rc3-bk13-orig/fs/cifs/cifssmb.c linux-2.6.10-rc3-bk13/fs/cifs/cifssmb.c
> --- linux-2.6.10-rc3-bk13-orig/fs/cifs/cifssmb.c	2004-12-20 22:19:42.000000000 +0100
> +++ linux-2.6.10-rc3-bk13/fs/cifs/cifssmb.c	2004-12-22 00:21:38.000000000 +0100
> @@ -895,14 +895,19 @@ CIFSSMBWrite(const int xid, struct cifsT
>  		bytes_sent = count;
>  	pSMB->DataLengthHigh = 0;
>  	pSMB->DataOffset =
> -	    cpu_to_le16(offsetof(struct smb_com_write_req,Data) - 4);
> -    if(buf)
> -	    memcpy(pSMB->Data,buf,bytes_sent);
> -	else if(ubuf)
> -		copy_from_user(pSMB->Data,ubuf,bytes_sent);
> -    else {
> +		cpu_to_le16(offsetof(struct smb_com_write_req,Data) - 4);
> +
> +	if (buf) {
> +		memcpy(pSMB->Data,buf,bytes_sent);
> +	} else if (ubuf) {
> +		if (copy_from_user(pSMB->Data,ubuf,bytes_sent)) {
> +			if (pSMB)

How can this be NULL, and code not Oopsing?

> +				cifs_buf_release(pSMB);
> +			return -EFAULT;
> +		}
> +	} else {
>  		/* No buffer */
> -		if(pSMB)
> +		if (pSMB)

Same here.

>  			cifs_buf_release(pSMB);
>  		return -EINVAL;
>  	}
> 
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
