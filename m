Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129903AbRB0XFf>; Tue, 27 Feb 2001 18:05:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129901AbRB0XF0>; Tue, 27 Feb 2001 18:05:26 -0500
Received: from mail.valinux.com ([198.186.202.175]:32787 "EHLO
	mail.valinux.com") by vger.kernel.org with ESMTP id <S129890AbRB0XFL>;
	Tue, 27 Feb 2001 18:05:11 -0500
Date: Tue, 27 Feb 2001 15:04:32 -0800
From: "H . J . Lu" <hjl@valinux.com>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: NFS maillist <nfs@lists.sourceforge.net>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [NFS] Updated patch for the [2.4.x] NFS 'missing directory entry a.k.a. IRIX server' problem...
Message-ID: <20010227150432.A18066@valinux.com>
In-Reply-To: <14997.9938.106305.635202@charged.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <14997.9938.106305.635202@charged.uio.no>; from trond.myklebust@fys.uio.no on Thu, Feb 22, 2001 at 03:48:50PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 22, 2001 at 03:48:50PM +0100, Trond Myklebust wrote:
> 
> The above fixes should ensure that all cookies taking values between 0
> and (2^32-1) on the NFS server are preserved through the 32-bit VFS
> interface, and are accepted by glibc as valid entries. It should also
> work fine with existing 64-bit architectures.
> 
> Please could people give this a try, and report if it fixes the
> problems.

Have you tried it against a Linux NFS V3 server? When I log in
with my home directory mounted from a Linux NFS V3 server, I
got kernel oops when I do

# cat /proc/mounts

I think the problem may be cookie transform thing.

> --- linux-2.4.2-fh_align/fs/nfs/nfs3xdr.c	Fri Feb  9 20:29:44 2001
> +++ linux-2.4.2-dir/fs/nfs/nfs3xdr.c	Thu Feb 22 10:47:49 2001
> @@ -523,6 +523,13 @@
>  	return 0;
>  }
>  
> +/* Hack to sign-extending 32-bit cookies */
> +static inline
> +u64 nfs_transform_cookie64(u64 cookie)
> +{
> +	return (cookie & 0x80000000) ? (cookie ^ 0xFFFFFFFF00000000) : cookie;
> +}
> +
>  /*
>   * Encode arguments to readdir call
>   */
> @@ -533,7 +540,7 @@
>  	int		buflen, replen;
>  
>  	p = xdr_encode_fhandle(p, args->fh);
> -	p = xdr_encode_hyper(p, args->cookie);
> +	p = xdr_encode_hyper(p, nfs_transform_cookie64(args->cookie));
>  	*p++ = args->verf[0];
>  	*p++ = args->verf[1];
>  	if (args->plus) {
> @@ -635,6 +642,7 @@
>  nfs3_decode_dirent(u32 *p, struct nfs_entry *entry, int plus)
>  {
>  	struct nfs_entry old = *entry;
> +	u64 cookie;
>  
>  	if (!*p++) {
>  		if (!*p)
> @@ -648,7 +656,8 @@
>  	entry->name = (const char *) p;
>  	p += XDR_QUADLEN(entry->len);
>  	entry->prev_cookie = entry->cookie;
> -	p = xdr_decode_hyper(p, &entry->cookie);
> +	p = xdr_decode_hyper(p, cookie);
> +	entry->cookie = nfs_transform_cookie64(cookie);

I don't understand this. As far as I can tell, "cookie" is not
initialized at all. Even if it is initialized, what does

	p = xdr_decode_hyper(p, cookie);

do?


H.J.
