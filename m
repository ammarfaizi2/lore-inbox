Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932200AbWJOXjd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932200AbWJOXjd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Oct 2006 19:39:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932210AbWJOXjd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Oct 2006 19:39:33 -0400
Received: from coyote.holtmann.net ([217.160.111.169]:30365 "EHLO
	mail.holtmann.net") by vger.kernel.org with ESMTP id S932200AbWJOXjc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Oct 2006 19:39:32 -0400
Subject: Re: [PATCH 1/4] l2cap endianness annotations
From: Marcel Holtmann <marcel@holtmann.org>
To: Al Viro <viro@ftp.linux.org.uk>
Cc: Linus Torvalds <torvalds@osdl.org>, davem@davemloft.net,
       linux-kernel@vger.kernel.org
In-Reply-To: <20061015212905.GR29920@ftp.linux.org.uk>
References: <20061015212905.GR29920@ftp.linux.org.uk>
Content-Type: text/plain
Date: Mon, 16 Oct 2006 01:39:03 +0200
Message-Id: <1160955543.14340.21.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Al,

> @@ -34,7 +34,7 @@ #define L2CAP_CONN_TIMEOUT	(HZ * 40)
>  /* L2CAP socket address */
>  struct sockaddr_l2 {
>  	sa_family_t	l2_family;
> -	unsigned short	l2_psm;
> +	__le16		l2_psm;
>  	bdaddr_t	l2_bdaddr;
>  };

this data structure is visible to the userspace (via the Bluetooth
library headers). Do we annotate them, too?

> @@ -205,7 +205,7 @@ #define l2cap_pi(sk) ((struct l2cap_pinf
>  
>  struct l2cap_pinfo {
>  	struct bt_sock	bt;
> -	__u16		psm;
> +	__le16		psm;
>  	__u16		dcid;
>  	__u16		scid;
>  
> @@ -221,7 +221,7 @@ struct l2cap_pinfo {
>  
>  	__u8		ident;
>  
> -	__u16		sport;
> +	__le16		sport;
>  
>  	struct l2cap_conn	*conn;
>  	struct sock		*next_c;

These are internal. We should have to annotate them. They should store
it in host order. If not, than that is the problem.

> @@ -1533,7 +1533,7 @@ static inline int l2cap_config_req(struc
>  	if (!(sk = l2cap_get_chan_by_scid(&conn->chan_list, dcid)))
>  		return -ENOENT;
>  
> -	l2cap_parse_conf_req(sk, req->data, cmd->len - sizeof(*req));
> +	l2cap_parse_conf_req(sk, req->data, __le16_to_cpu(cmd->len) - sizeof(*req));

I have to look into this change. It basically means that this code never
worked on big endian systems, but it actually does.

Regards

Marcel


