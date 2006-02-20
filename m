Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030231AbWBTNzU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030231AbWBTNzU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 08:55:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030232AbWBTNzU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 08:55:20 -0500
Received: from mail13.bluewin.ch ([195.186.18.62]:4736 "EHLO mail13.bluewin.ch")
	by vger.kernel.org with ESMTP id S1030231AbWBTNzS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 08:55:18 -0500
Date: Mon, 20 Feb 2006 08:53:15 -0500
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Linus <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       apgo@patchbomb.org, linuxppc64-dev@ozlabs.org,
       Paul Mackerras <paulus@samba.org>,
       "David S. Miller" <davem@davemloft.net>,
       LKML <linux-kernel@vger.kernel.org>, trond.myklebust@fys.uio.no
Subject: Re: [PATCH] Fix compile for CONFIG_SYSVIPC=n or CONFIG_SYSCTL=n
Message-ID: <20060220135315.GA24943@krypton>
References: <20060218100849.GA1869@krypton> <17400.23551.904754.47979@cargo.ozlabs.ibm.com> <20060220153226.30ee4b13.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060220153226.30ee4b13.sfr@canb.auug.org.au>
User-Agent: Mutt/1.5.11+cvs20060126
From: apgo@patchbomb.org (Arthur Othieno)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 20, 2006 at 03:32:26PM +1100, Stephen Rothwell wrote:
> The compat syscalls are added to sys_ni.c since they are not defined
> if the above CONFIG options are off. Also, nfs would not build with
> CONFIG_SYSCTL off.
> 
> Noticed by Arthur Othieno.
> 
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>

Looks good, thanks ;-)

Acked-by: Arthur Othieno <apgo@patchbomb.org>

> ---
> 
>  include/linux/nfs_fs.h |    2 +-
>  kernel/sys_ni.c        |    2 ++
>  2 files changed, 3 insertions(+), 1 deletions(-)
> 
> On Sun, 19 Feb 2006 22:52:31 +1100 Paul Mackerras <paulus@samba.org> wrote:
> >
> > Arthur Othieno writes:
> > 
> > > --- a/arch/powerpc/kernel/sys_ppc32.c
> > > +++ b/arch/powerpc/kernel/sys_ppc32.c
> > > @@ -440,7 +440,13 @@ long compat_sys_ipc(u32 call, u32 first,
> > >  
> > >  	return -ENOSYS;
> > >  }
> > > -#endif
> > > +#else
> > > +long compat_sys_ipc(u32 call, u32 first, u32 second, u32 third, compat_uptr_t ptr,
> > > +	       u32 fifth)
> > > +{
> > > +	return -ENOSYS;
> > > +}
> > > +#endif /* CONFIG_SYSVIPC */
> > 
> > Can't we just add a couple of cond_syscall lines to kernel/sys_ni.c
> > instead?
> 
> Linus, can we have this applied for 2.6.16.  It presumably affects sparc64
> (at least for CONFIG_SYSVIPC) as well as powerpc.  The NFS fix would
> affect all architectures, I think?
> 
> This has been compile tested with the CONFIG options on and off for powerpc.
> 
> -- 
> Cheers,
> Stephen Rothwell                    sfr@canb.auug.org.au
> http://www.canb.auug.org.au/~sfr/
> 
> c1a27bc400a1412c7c758775bb695e8b98d1c0c3
> diff --git a/include/linux/nfs_fs.h b/include/linux/nfs_fs.h
> index 547d649..b4dc6e2 100644
> --- a/include/linux/nfs_fs.h
> +++ b/include/linux/nfs_fs.h
> @@ -398,7 +398,7 @@ extern struct inode_operations nfs_symli
>  extern int nfs_register_sysctl(void);
>  extern void nfs_unregister_sysctl(void);
>  #else
> -#define nfs_register_sysctl() do { } while(0)
> +#define nfs_register_sysctl() 0
>  #define nfs_unregister_sysctl() do { } while(0)
>  #endif
>  
> diff --git a/kernel/sys_ni.c b/kernel/sys_ni.c
> index 17313b9..1067090 100644
> --- a/kernel/sys_ni.c
> +++ b/kernel/sys_ni.c
> @@ -104,6 +104,8 @@ cond_syscall(sys_setreuid16);
>  cond_syscall(sys_setuid16);
>  cond_syscall(sys_vm86old);
>  cond_syscall(sys_vm86);
> +cond_syscall(compat_sys_ipc);
> +cond_syscall(compat_sys_sysctl);
>  
>  /* arch-specific weak syscall entries */
>  cond_syscall(sys_pciconfig_read);
> -- 
> 1.2.1
