Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129249AbRBZXaP>; Mon, 26 Feb 2001 18:30:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129268AbRBZXaE>; Mon, 26 Feb 2001 18:30:04 -0500
Received: from mail.valinux.com ([198.186.202.175]:29452 "EHLO
	mail.valinux.com") by vger.kernel.org with ESMTP id <S129242AbRBZX3n>;
	Mon, 26 Feb 2001 18:29:43 -0500
Date: Mon, 26 Feb 2001 15:28:26 -0800
From: "H . J . Lu" <hjl@valinux.com>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: NFS maillist <nfs@lists.sourceforge.net>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [NFS] Updated patch for the [2.4.x] NFS 'missing directory entry a.k.a. IRIX server' problem...
Message-ID: <20010226152826.A20653@valinux.com>
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
> Hi,
> 
>   After having tried to thrash out what exactly is the kernel
> interface for telldir/seekdir w.r.t. the existence of negative offsets
> with the glibc people, I've finally found a way to work within the
> current scheme.
> 
>   The problem at hand is that we currently would like to support the
> existence of directory cookies that take unsigned 32-bit values in
> NFSv2, unsigned 64-bit values in NFSv3.
> 
>   Given that most NFSv3 servers can/do use 32-bit cookies for
> compatibility with 32-bit systems, we would like to be able to pass
> this type of cookie back up to userland for use by the 32-bit
> interface.
>   However the interface chosen both in glibc and partly in the kernel
> itself assumes all cookies are 32-bit signed values. Thus you have to
> find a way to cope with the kernel and glibc sign extending (almost)
> all cookies which have bit 31 set.
> 
>   The following patch therefore does 3 things:
> 
>    - Patch linux/fs/readdir.c so that file->f_pos is copied into the
>      dirent64 structure with sign extension. This is for consistency
>      with the behaviour of filldir64.
> 
>    - Patch NFSv2 xdr routines so that 32-bit cookies get extended to
>      take 64-bit signed values (as opposed to unsigned values) for
>      consistency with the fact that (l|)off_t are both signed.
> 
>    - Patch NFSv3 xdr routines with a hack that mimics sign extension
>      on those cookies which are truly 32-bit unsigned.
>      To do this we use the transformation
> 
>         (cookie & 0x80000000) ? cookie ^ 0xFFFFFFFF00000000 : cookie;
> 
>      Note that this a transformation has no effect on true 64-bit
>      cookies because it is reversible.
> 
>    - Make a special version of 'lseek()' for NFS directories that
>      returns 0 if the offset used was negative (rather than returning
>      the offset itself). This avoids userland misinterpreting the
>      return value as an error.
> 
> The above fixes should ensure that all cookies taking values between 0
> and (2^32-1) on the NFS server are preserved through the 32-bit VFS
> interface, and are accepted by glibc as valid entries. It should also
> work fine with existing 64-bit architectures.
> 
> Please could people give this a try, and report if it fixes the
> problems.
> 

I don't know how it will work with real 64bit cookies on a 32bit
host for NFS V3 since you truncate it into 32bit during sign
extension.


H.J.
