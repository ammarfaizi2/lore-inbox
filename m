Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265139AbSL3BVU>; Sun, 29 Dec 2002 20:21:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265637AbSL3BVU>; Sun, 29 Dec 2002 20:21:20 -0500
Received: from bitmover.com ([192.132.92.2]:2967 "EHLO mail.bitmover.com")
	by vger.kernel.org with ESMTP id <S265139AbSL3BVT>;
	Sun, 29 Dec 2002 20:21:19 -0500
Date: Sun, 29 Dec 2002 17:29:37 -0800
From: Larry McVoy <lm@bitmover.com>
To: Thomas Ogrisegg <tom@rhadamanthys.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] TCP Zero Copy for mmapped files
Message-ID: <20021230012937.GC5156@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Thomas Ogrisegg <tom@rhadamanthys.org>,
	linux-kernel@vger.kernel.org
References: <20021230010953.GA17731@window.dhis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021230010953.GA17731@window.dhis.org>
User-Agent: Mutt/1.4i
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

How about putting this into a different function?  It's a lot to add
inline for a special case.

>  int tcp_sendmsg(struct sock *sk, struct msghdr *msg, int size)
>  {
>  	struct iovec *iov;
> @@ -1015,6 +1051,7 @@
>  	int mss_now;
>  	int err, copied;
>  	long timeo;
> +	int has_sendpage = sk->socket->file->f_op->sendpage != NULL;
>  
>  	tp = &(sk->tp_pinfo.af_tcp);
>  
> @@ -1049,6 +1086,44 @@
>  
>  		iov++;
>  
> +		if (seglen >= PAGE_SIZE && has_sendpage) {
> +			struct vm_area_struct *vma =
> +				find_vma (current->mm, (long) from);
> +			struct file *filp;
> +
> +			if (vma && (filp = vma->vm_file)) {
> +				read_descriptor_t desc;
> +				struct inode *in, *out;
> +				loff_t pos = (long) from - vma->vm_start;
> +
> +				in  = filp->f_dentry->d_inode;
> +				out = sk->socket->file->f_dentry->d_inode;
> +
> +				if (locks_verify_area (FLOCK_VERIFY_READ, in,
> +					filp, filp->f_pos, seglen))
> +					goto out_no_zero_copy;
> +
> +				if (locks_verify_area (FLOCK_VERIFY_WRITE, out,
> +					sk->socket->file, 0, seglen))
> +					goto out_no_zero_copy;
> +
> +				desc.written = 0;
> +				desc.count   = seglen;
> +				desc.buf     = (char *) sk;
> +				desc.error   = 0;
> +
> +				do_generic_file_read (filp, &pos, &desc,
> +					file_send_actor);
> +
> +				if (!desc.written) {
> +					err = desc.error;
> +					goto do_error;
> +				}
> +				copied += desc.written;
> +				continue;
> +			}
> +		}
> +out_no_zero_copy:
>  		while (seglen > 0) {
>  			int copy;
>  			


-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
