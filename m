Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751062AbWAPGkT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751062AbWAPGkT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jan 2006 01:40:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751069AbWAPGkS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jan 2006 01:40:18 -0500
Received: from yue.linux-ipv6.org ([203.178.140.15]:13572 "EHLO
	yue.st-paulia.net") by vger.kernel.org with ESMTP id S1751052AbWAPGkQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jan 2006 01:40:16 -0500
Date: Mon, 16 Jan 2006 15:41:06 +0900 (JST)
Message-Id: <20060116.154106.64415709.yoshfuji@linux-ipv6.org>
To: spereira@tusc.com.au
Cc: arnd@arndb.de, acme@ghostprotocols.net, ak@muc.de,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       pereira.shaun@gmail.com, yoshfuji@linux-ipv6.org
Subject: Re: 32 bit (socket layer) ioctl emulation for 64 bit kernels
From: YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
In-Reply-To: <1137391160.5588.32.camel@spereira05.tusc.com.au>
References: <1137122079.5589.34.camel@spereira05.tusc.com.au>
	<200601131146.48128.arnd@arndb.de>
	<1137391160.5588.32.camel@spereira05.tusc.com.au>
Organization: USAGI/WIDE Project
X-URL: http://www.yoshifuji.org/%7Ehideaki/
X-Fingerprint: 9022 65EB 1ECF 3AD1 0BDF  80D8 4807 F894 E062 0EEA
X-PGP-Key-URL: http://www.yoshifuji.org/%7Ehideaki/hideaki@yoshifuji.org.asc
X-Face: "5$Al-.M>NJ%a'@hhZdQm:."qn~PA^gq4o*>iCFToq*bAi#4FRtx}enhuQKz7fNqQz\BYU]
 $~O_5m-9'}MIs`XGwIEscw;e5b>n"B_?j/AkL~i/MEa<!5P`&C$@oP>ZBLP
X-Mailer: Mew version 2.2 on Emacs 20.7 / Mule 4.1 (AOI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <1137391160.5588.32.camel@spereira05.tusc.com.au> (at Mon, 16 Jan 2006 16:59:20 +1100), Shaun Pereira <spereira@tusc.com.au> says:

> If I understand correctly from your comments (thanks for that, they are
> helpful)
> copy_to_user acts like a memcopy for an 'array' of bytes and should not
> be used to copy the timeval struct to userspace. 
> Rather put_user / __put_user macros should be used which allows transfer
> of single element values of the structure. 

> +int compat_sock_get_timestamp(struct sock *sk, struct timeval __user
> *userstamp)
> +{
> +	struct compat_timeval __user *ctv
> +		= (struct compat_timeval __user*) userstamp;
> +	int err = -ENOENT;
> +	if(!sock_flag(sk, SOCK_TIMESTAMP))
> +		sock_enable_timestamp(sk);
> +	if(sk->sk_stamp.tv_sec == -1)
> +		return err;
> +	if(sk->sk_stamp.tv_sec == 0)
> +		do_gettimeofday(&sk->sk_stamp);
> +	err = -EFAULT;
> +	if(access_ok(VERIFTY_WRITE, ctv, sizeof(*ctv))) {
> +		err = __put_user(sk->sk_stamp.tv_sec, &ctv->tv_sec);
> +		err != __put_user(sk->sk_stamp.tv_usec, &ctv->tv_usec);
> +	}
> +	return err;
> +}
> +

Hmm, you will copy 32bit of MSB in big-endian.
You should do something like this:

        strtuct compat_timeval tvtmp;
        :
	tvtmp.tv_sec = sk->sk_stamp.tv_sec;
	tvtmp.tv_usec = sk->sk_stemp.tv_usec;
	return copy_to_user(ctv, &tvtmp, sizeof(tvtmp));

Or, am I miss something?

--yoshfuji
