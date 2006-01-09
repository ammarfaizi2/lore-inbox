Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932197AbWAIKy6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932197AbWAIKy6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 05:54:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932181AbWAIKy6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 05:54:58 -0500
Received: from moutng.kundenserver.de ([212.227.126.187]:4091 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S932071AbWAIKy5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 05:54:57 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: spereira@tusc.com.au
Subject: Re: [PATCH] net: 32 bit (socket layer) ioctl emulation for 64 bit kernels
Date: Mon, 9 Jan 2006 10:54:34 +0000
User-Agent: KMail/1.9.1
Cc: linux-kenel <linux-kernel@vger.kernel.org>,
       netdev <netdev@vger.kernel.org>, Andi Kleen <ak@muc.de>,
       SP <pereira.shaun@gmail.com>
References: <1136789216.6653.17.camel@spereira05.tusc.com.au>
In-Reply-To: <1136789216.6653.17.camel@spereira05.tusc.com.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601091054.35010.arnd@arndb.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 09 January 2006 06:46, Shaun Pereira wrote:
> Hi all,
> The attached patch is a follow up to a post made earlier to this site
> with regard to 32 bit (socket layer) ioctl emulation for 64 bit kernels.

Ok, cool. Note that I also posted a longer series of patches that does
this and much more. Unfortunately, I have suspended working on it for
now, so it's probably better to first get your stuff in.

> I needed to implement 32 bit userland ioctl support for modular (x.25)
> socket ioctls in a 64 bit kernel. With the removal of the
> register_ioctl32_conversion() function from the kernel, one of the
> suggestions made by Andi was "to just extend the socket code to add a
> compat_ioctl vector to the socket options"
> 
> With Arnd's help (see previous mails with subject = 32 bit (socket
> layer) ioctl emulation for 64 bit kernels) I have prepared the following
> patchand tested with with x25 over tcp on a x26_64 kernel. 
> 
> Since we are interested in ioctl's from userspace I have not added the 
> .compat_ioctl function pointer to struct net_device. The assumption
> being once the userspace data has reached the kernel via the socket api,
> if the socket layer protocol knows how to handle the data, it will
> prepare it for the device.

I think we need to have it in the long run, but if you don't need it
for x25, then it's not your call to implement net_device->compat_ioctl.
I've been thinking about how to get it right before, but did not
reach a proper conclusion, since dev_ioctl is called in so many places
that would all need to be changed for this.

> Am not too sure whether struct proto requires modification. Since it is 
> allocated dynamically in the protocol layer I have left it alone;no
> compat_ioctl. Also it seems like the socket layer would know how to
> "ioctl" the transport layer, userspace does not need to know about
> this? 

The proto ioctls are all forwarded from sock ioctls, so in theory
it would be needed. 

> But if any of this is incorrect and needs to be changed please advise 
> and I will make the changes accordingly. If this patch is accepted I 
> would be in a position to submit a patch for x25 (32 bit userspace 
> for 64 bit kernel). 

Please post that patch now as well, just make a series out of this
socket compat_ioctl patch and your x25 patch so it becomes clear
that they depend on each other. It should be easier to justify the
infrastructure patch when there is an actual user for it ;-)

> @@ -143,6 +143,10 @@ struct proto_ops {
>                                       struct poll_table_struct *wait);
>         int             (*ioctl)     (struct socket *sock, unsigned int cmd,
>                                       unsigned long arg);
> +#ifdef CONFIG_COMPAT
> +       int             (*compat_ioctl) (struct socket *sock, unsigned int cmd,
> +                                     unsigned long arg);
> +#endif
>         int             (*listen)    (struct socket *sock, int len);
>         int             (*shutdown)  (struct socket *sock, int flags);
>         int             (*setsockopt)(struct socket *sock, int level,
...
> +
> +#define SOCKOPS_COMPAT_WRAP(name, fam)					\
> +SOCKCALL_WRAP(name, release, (struct socket *sock), (sock))	\
> +SOCKCALL_WRAP(name, bind, (struct socket *sock, struct sockaddr *uaddr,
> int addr_len), \
> +	      (sock, uaddr, addr_len))		

I really don't like the way you are extending the SOCKCALL_WRAP
mechanism like this. Ideally, you should convert the x25 layer to
not need SOCKOPS_WRAP at all.
Besides x25, only four other users of this remain, all others have
gotten rid of it. If you have a really good reason to keep it, it's
probably easier to add the compat_ioctl method unconditionally so
you don't need two different version of SOCKOPS_WRAP.
Making it unconditional would also help with those protocols that
have only compatible ioctl handlers and could then also point
.compat_ioctl to their native ioctl method without needing #ifdef
around it.

	Arnd <><
