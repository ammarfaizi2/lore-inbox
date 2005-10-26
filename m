Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932598AbVJZIuw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932598AbVJZIuw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Oct 2005 04:50:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932600AbVJZIuv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Oct 2005 04:50:51 -0400
Received: from smtp.osdl.org ([65.172.181.4]:62675 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932598AbVJZIuv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Oct 2005 04:50:51 -0400
Date: Wed, 26 Oct 2005 01:50:00 -0700
From: Andrew Morton <akpm@osdl.org>
To: Steve Dickson <SteveD@redhat.com>
Cc: nfs@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       Patrick McHardy <kaber@trash.net>
Subject: Re: Bad  nsec conversion  in svc_udp_recvfrom()
Message-Id: <20051026015000.609cd153.akpm@osdl.org>
In-Reply-To: <435F3FFC.6020303@RedHat.com>
References: <435F3FFC.6020303@RedHat.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steve Dickson <SteveD@redhat.com> wrote:
>
> In patch-2.6.14-rc5 there is the following:
> @@ -584,13 +583,16 @@ svc_udp_recvfrom(struct svc_rqst *rqstp)
>          /* possibly an icmp error */
>          dprintk("svc: recvfrom returned error %d\n", -err);
>      }
> -   if (skb->stamp.tv_sec == 0) {
> -       skb->stamp.tv_sec = xtime.tv_sec;
> -       skb->stamp.tv_usec = xtime.tv_nsec / NSEC_PER_USEC;
> +   if (skb->tstamp.off_sec == 0) {
> +       struct timeval tv;
> +
> +       tv.tv_sec = xtime.tv_sec;
> +       tv.tv_usec = xtime.tv_nsec * 1000;
> +       skb_set_timestamp(skb, &tv);
>          /* Don't enable netstamp, sunrpc doesn't
>             need that much accuracy */
>      }
> -   svsk->sk_sk->sk_stamp = skb->stamp;
> +   skb_get_timestamp(skb, &svsk->sk_sk->sk_stamp);
>      set_bit(SK_DATA, &svsk->sk_flags); /* there may be more data... */
> 
>      /*
> Shouldn't tv.tv_usec = xtime.tv_nsec * 1000
> be tv.tv_usec = xtime.tv_nsec / 1000 or possible
> tv.tv_usec = xtime.tv_nsec / NSEC_PER_USEC ?
> 
> The was fixed by a previous patch
> (see http://lkml.org/lkml/2005/8/1/251)
> but now it seems to be broken again...
> 

Yes, that's screwed up - well spotted.

Patrick, please be more careful about these things.

I'll fix it up.
