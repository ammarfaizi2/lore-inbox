Return-Path: <linux-kernel-owner+willy=40w.ods.org-S935312AbWKZKM6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935312AbWKZKM6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Nov 2006 05:12:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935314AbWKZKM6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Nov 2006 05:12:58 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:4577 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S935312AbWKZKM5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Nov 2006 05:12:57 -0500
Date: Sun, 26 Nov 2006 10:12:54 +0000
From: Al Viro <viro@ftp.linux.org.uk>
To: Eugene Teo <eteo@redhat.com>
Cc: lksctp-developers@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] net/sctp/socket.c: add missing sctp_spin_unlock_irqrestore
Message-ID: <20061126101254.GW3078@ftp.linux.org.uk>
References: <456965D5.1000302@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <456965D5.1000302@redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 26, 2006 at 06:00:53PM +0800, Eugene Teo wrote:
> This patch adds a missing sctp_spin_unlock_irqrestore when returning
> from "if(space_left<addrlen)" condition.
>                 if (copy_to_user(*to, &temp, addrlen)) {
> -                       sctp_spin_unlock_irqrestore(&sctp_local_addr_lock,
> -                                                   flags);
> -                       return -EFAULT;
> +                       err = -EFAULT;
> +                       goto unlock;

> +       sctp_spin_unlock_irqrestore(&sctp_local_addr_lock, flags);
> +       return err;
>  }

You do realize that it's obviously still badly broken, don't you?
copy_to_user() under a spinlock is a recipe for deadlock, especially
if you've got interrupts disabled...

I have a beginning of locking fixes in that shitpile, but it's incomplete
and bloody painful ;-/
