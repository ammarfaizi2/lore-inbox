Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030424AbWGZGxU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030424AbWGZGxU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jul 2006 02:53:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030425AbWGZGxU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jul 2006 02:53:20 -0400
Received: from smtp.osdl.org ([65.172.181.4]:56533 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030424AbWGZGxT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jul 2006 02:53:19 -0400
Date: Tue, 25 Jul 2006 23:53:09 -0700
From: Andrew Morton <akpm@osdl.org>
To: NeilBrown <neilb@suse.de>
Cc: nfs@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 009 of 9] knfsd: Allow sockets to be passed to nfsd via
 'portlist'
Message-Id: <20060725235309.8f30b28f.akpm@osdl.org>
In-Reply-To: <1060725015508.22007@suse.de>
References: <20060725114207.21779.patches@notabene>
	<1060725015508.22007@suse.de>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Jul 2006 11:55:08 +1000
NeilBrown <neilb@suse.de> wrote:

> 
> Userspace should create and bind a socket (but not connectted)
> and write the 'fd' to portlist.  This will cause the nfs server
> to listen on that socket.
> 
> To close a socket, the name of the socket - as read from 'portlist'
> can be written to 'portlist' with a preceding '-'.
> 

ick.  Is that the best API we can come up with?

It's a privileged operation, but heck.  Do we perform validation on the fd
to make sure that it's refers to a socket and not to /dev/fb0?

>  static ssize_t write_ports(struct file *file, char *buf, size_t size)
>  {
> -	/* for now, ignore what was written and just
> -	 * return known ports
> -	 * AF proto address port
> +	if (size == 0) {
> +		int len = 0;
> +		lock_kernel();
> +		if (nfsd_serv)
> +			len = svc_sock_names(buf, nfsd_serv, NULL);
> +		unlock_kernel();
> +		return len;
> +	}
> +	/* Either a single 'fd' number is written, in which
> +	 * case it must be for a socket of a supported family/protocol,
> +	 * and we use it as an nfsd socket, or
> +	 * A '-' followed by the 'name' of a socket in which case
> +	 * we close the socket.
>  	 */
> -	int len = 0;
> -	lock_kernel();
> -	if (nfsd_serv)
> -		len = svc_sock_names(buf, nfsd_serv);
> -	unlock_kernel();
> -	return len;
> +	if (isdigit(buf[0])) {
> +		char *mesg = buf;
> +		int fd;
> +		int err;
> +		err = get_int(&mesg, &fd);
> +		if (err)
> +			return -EINVAL;
> +		if (fd < 0)
> +			return -EINVAL;
> +		err = nfsd_create_serv();
> +		if (!err) {
> +			int proto = 0;
> +			err = svc_addsock(nfsd_serv, fd, buf, &proto);
> +			/* Decrease the count, but don't shutdown the
> +			 * the service
> +			 */
> +			if (err >= 0)
> +				lockd_up(proto);
> +			nfsd_serv->sv_nrthreads--;
> +		}
> +		return err;
> +	}
> +	if (buf[0] == '-') {
> +		char *toclose = kstrdup(buf+1, GFP_KERNEL);
> +		int len = 0;
> +		if (!toclose)
> +			return -ENOMEM;
> +		lock_kernel();
> +		if (nfsd_serv)
> +			len = svc_sock_names(buf, nfsd_serv, toclose);
> +		unlock_kernel();
> +		kfree(toclose);
> +		return len;
> +	}
> +	return -EINVAL;
>  }

<checks>

OK, simple_transaction_get() guarantees that *buf is null-terminated.  It
might be worth a comment to stop code-reviewers from freaking out ;)

