Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268166AbTBWJzC>; Sun, 23 Feb 2003 04:55:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268156AbTBWJxy>; Sun, 23 Feb 2003 04:53:54 -0500
Received: from carisma.slowglass.com ([195.224.96.167]:13572 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S268118AbTBWJw1>; Sun, 23 Feb 2003 04:52:27 -0500
Date: Sun, 23 Feb 2003 10:02:34 +0000
From: Christoph Hellwig <hch@infradead.org>
To: "David S. Miller" <davem@redhat.com>
Cc: ak@suse.de, sim@netnation.com, linux-kernel@vger.kernel.org,
       linux-net@vger.kernel.org
Subject: Re: Longstanding networking / SMP issue? (duplextest)
Message-ID: <20030223100234.B15347@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	"David S. Miller" <davem@redhat.com>, ak@suse.de, sim@netnation.com,
	linux-kernel@vger.kernel.org, linux-net@vger.kernel.org
References: <20030221102257.GA10108@wotan.suse.de> <20030221.021125.66547838.davem@redhat.com> <20030221104541.GA18417@wotan.suse.de> <20030223.011217.04700323.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030223.011217.04700323.davem@redhat.com>; from davem@redhat.com on Sun, Feb 23, 2003 at 01:12:17AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 23, 2003 at 01:12:17AM -0800, David S. Miller wrote:
> +static struct socket *__icmp_socket[NR_CPUS];
> +#define icmp_socket	__icmp_socket[smp_processor_id()]

This should be per-cpu data

> -static __inline__ int icmp_xmit_lock(void)
> +static __inline__ void icmp_xmit_lock(void)
>  {
> -	int ret;
>  	local_bh_disable();
> -	ret = icmp_xmit_lock_bh();
> -	if (ret)
> -		local_bh_enable();
> -	return ret;
> -}
>  
> -static void icmp_xmit_unlock_bh(void)
> -{
> -	icmp_xmit_holder = -1;
> -	spin_unlock(&icmp_socket->sk->lock.slock);
> +	if (!spin_trylock(&icmp_socket->sk->lock.slock))
> +		BUG();

unlikely()?

> -static __inline__ void icmp_xmit_unlock(void)
> +static void icmp_xmit_unlock(void)
>  {
> -	icmp_xmit_unlock_bh();
> +	spin_unlock(&icmp_socket->sk->lock.slock);
>  	local_bh_enable();

spin_unlock_bh

> +	icmp_xmit_lock();

Hmm, and I guess the code would be much more readable if you used
the spin_lock call directly.  The impliclit icmp_socket doesn't
really help readability either.

