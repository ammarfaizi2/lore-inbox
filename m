Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317326AbSHOTAq>; Thu, 15 Aug 2002 15:00:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317329AbSHOTAq>; Thu, 15 Aug 2002 15:00:46 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:27659 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S317326AbSHOTAo>;
	Thu, 15 Aug 2002 15:00:44 -0400
Date: Thu, 15 Aug 2002 20:04:36 +0100
From: Matthew Wilcox <willy@debian.org>
To: James Morris <jmorris@intercode.com.au>
Cc: "David S. Miller" <davem@redhat.com>, kuznet@ms2.inr.ac.ru,
       Andi Kleen <ak@muc.de>, linux-kernel@vger.kernel.org,
       Matthew Wilcox <willy@debian.org>
Subject: Re: [PATCH][RFC] sigurg/sigio cleanup for 2.5.31
Message-ID: <20020815200436.E29958@parcelfarce.linux.theplanet.co.uk>
References: <Mutt.LNX.4.44.0208160302100.28909-100000@blackbird.intercode.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Mutt.LNX.4.44.0208160302100.28909-100000@blackbird.intercode.com.au>; from jmorris@intercode.com.au on Fri, Aug 16, 2002 at 03:16:57AM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 16, 2002 at 03:16:57AM +1000, James Morris wrote:
> This patch is a clean up of the sigurg and sigio related code, for 
> the 2.5.31 kernel.

In general, this is good... I think it could be better:

> +	lock_kernel();
> +	error = f_setown(filp, current->pid);
> +	unlock_kernel();

There are a lot of these, and you even batch it up as sock_setown()
later.  May I suggest renaming f_setown to __setown and sock_setown
to f_setown?

> @@ -306,19 +334,11 @@
>  			break;
>  		case F_SETOWN:
>  			lock_kernel();
> -
> -			err = security_ops->file_set_fowner(filp);
> +			err = f_setown(filp, arg);
>  			if (err) {
>  				unlock_kernel();
>  				break;
>  			}
> -
> -			filp->f_owner.pid = arg;
> -			filp->f_owner.uid = current->uid;
> -			filp->f_owner.euid = current->euid;
> -			err = 0;
> -			if (S_ISSOCK (filp->f_dentry->d_inode->i_mode))
> -				err = sock_fcntl (filp, F_SETOWN, arg);
>  			unlock_kernel();
>  			break;
>  		case F_GETSIG:

this one's particularly silly -- now you've done the good job of wrapping
the security_ops up inside f_setown this can simply be:

			lock_kernel();
			err = f_setown(filp, arg);
			unlock_kernel();
			break;

though if you accept my suggestion above, it's even easier.

> +int sk_send_sigurg(struct sock *sk)
> +{
> +	if (sk->socket && sk->socket->file)
> +		return send_sigurg(&sk->socket->file->f_owner);
> +	return 0;
> +}
> +

I notice that both the callers of this do:

>  	/* Tell the world about our new urgent pointer. */
> +	if (sk_send_sigurg(sk))
>  		sk_wake_async(sk, 3, POLL_PRI);

Might make more sense to refactor as:

void sk_send_sigurg(struct sock *sk)
{
	if (!sk->socket || !sk->socket->file)
		return;
	if (send_sigurg(&sk->socket->file->f_owner))
		sk_wake_async(sk, 3, POLL_PRI);
}

-- 
Revolutions do not require corporate support.
