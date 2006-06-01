Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750901AbWFAEg7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750901AbWFAEg7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jun 2006 00:36:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751753AbWFAEg7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jun 2006 00:36:59 -0400
Received: from smtp.osdl.org ([65.172.181.4]:35560 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750901AbWFAEg6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jun 2006 00:36:58 -0400
Date: Wed, 31 May 2006 21:41:16 -0700
From: Andrew Morton <akpm@osdl.org>
To: Tony Griffiths <tonyg@agile.tv>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Some socket syscalls fail to return an error on bad
 file-descriptor# argument
Message-Id: <20060531214116.ef2d1c3e.akpm@osdl.org>
In-Reply-To: <447E614F.3090905@agile.tv>
References: <447E614F.3090905@agile.tv>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 01 Jun 2006 13:38:55 +1000
Tony Griffiths <tonyg@agile.tv> wrote:

> diff -urpN ./net/socket.c.orig ./net/socket.c
> --- ./net/socket.c.orig	2006-06-01 10:28:30.000000000 +1000
> +++ ./net/socket.c	2006-06-01 10:34:09.000000000 +1000
> @@ -496,6 +496,8 @@ static struct socket *sockfd_lookup_ligh
>  		if (sock)
>  			return sock;
>  		fput_light(file, *fput_needed);
> +	} else {
> +		*err = -EBADF;
>  	}
>  	return NULL;
>  }

Confused.  That patch cannot make any difference to this function:

static struct socket *sockfd_lookup_light(int fd, int *err, int *fput_needed)
{
	struct file *file;
	struct socket *sock;

	*err = -EBADF;
	file = fget_light(fd, fput_needed);
	if (file) {
		sock = sock_from_file(file, err);
		if (sock)
			return sock;
		fput_light(file, *fput_needed);
	}
	return NULL;
}


