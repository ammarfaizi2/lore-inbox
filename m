Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030393AbWHUMKh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030393AbWHUMKh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Aug 2006 08:10:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030405AbWHUMKh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Aug 2006 08:10:37 -0400
Received: from mx1.redhat.com ([66.187.233.31]:35786 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S964980AbWHUMKf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Aug 2006 08:10:35 -0400
Message-ID: <44E9A272.3020202@redhat.com>
Date: Mon, 21 Aug 2006 22:09:22 +1000
From: Eugene Teo <eteo@redhat.com>
Organization: Red Hat Asia-Pacific
User-Agent: Thunderbird 1.5.0.5 (X11/20060808)
MIME-Version: 1.0
To: Willy Tarreau <w@1wt.eu>
CC: Michael Buesch <mb@bu3sch.de>, Solar Designer <solar@openwall.com>,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH] getsockopt() early argument sanity checking
References: <20060819230532.GA16442@openwall.com> <20060819234806.GB27115@1wt.eu> <200608200205.20876.mb@bu3sch.de> <20060820004307.GD27115@1wt.eu>
In-Reply-To: <20060820004307.GD27115@1wt.eu>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Willy Tarreau wrote:
> On Sun, Aug 20, 2006 at 02:05:20AM +0200, Michael Buesch wrote:
>> On Sunday 20 August 2006 01:48, Willy Tarreau wrote:
>>> On Sun, Aug 20, 2006 at 03:05:32AM +0400, Solar Designer wrote:
[snipped]
> diff --git a/net/socket.c b/net/socket.c
> index ac45b13..910ef88 100644
> --- a/net/socket.c
> +++ b/net/socket.c
> @@ -1307,11 +1307,17 @@ asmlinkage long sys_setsockopt(int fd, i
>  asmlinkage long sys_getsockopt(int fd, int level, int optname, char *optval, int *optlen)
>  {
>  	int err;
> +	int len;
        ^^^^^^^^

>  	struct socket *sock;
>  
>  	if ((sock = sockfd_lookup(fd, &err))!=NULL)
>  	{
> -		if (level == SOL_SOCKET)
> +		/* XXX: insufficient for SMP, but should be redundant anyway */
> +		if (get_user(len, optlen))
> +			err = -EFAULT;
> +		else if (len < 0)
                ^^^^^^^^^^^^^^^^^

s/else//

> +			err = -EINVAL;
> +		else if (level == SOL_SOCKET)

s/else//

>  			err=sock_getsockopt(sock,level,optname,optval,optlen);
>  		else
>  			err=sock->ops->getsockopt(sock, level, optname, optval, optlen);

These checks are already in getsockopt(). Duplicated code?

Eugene
-- 
eteo redhat.com  ph: +65 6490 4142  http://www.kernel.org/~eugeneteo
gpg fingerprint:  47B9 90F6 AE4A 9C51 37E0  D6E1 EA84 C6A2 58DF 8823
