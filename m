Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751360AbWDYDxa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751360AbWDYDxa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 23:53:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751363AbWDYDxa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 23:53:30 -0400
Received: from ns2.suse.de ([195.135.220.15]:52876 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751360AbWDYDx3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 23:53:29 -0400
Date: Mon, 24 Apr 2006 20:52:16 -0700
From: Greg KH <greg@kroah.com>
To: Akinobu Mita <mita@miraclelinux.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [patch 2/4] kref debugging config option
Message-ID: <20060425035216.GC18085@kroah.com>
References: <20060424083333.217677000@localhost.localdomain> <20060424083342.069630000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060424083342.069630000@localhost.localdomain>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 24, 2006 at 04:33:35PM +0800, Akinobu Mita wrote:
> This patch converts all WARN_ON() in kref code to BUG_ON().
> And split them into new DEBUG_KREF config option.
> 
> Signed-off-by: Akinobu Mita <mita@miraclelinux.com>
> 
>  lib/Kconfig.debug |    7 +++++++
>  lib/kref.c        |   30 +++++++++++++++++++++++++-----
>  2 files changed, 32 insertions(+), 5 deletions(-)
> 
> Index: 2.6-git/lib/Kconfig.debug
> ===================================================================
> --- 2.6-git.orig/lib/Kconfig.debug
> +++ 2.6-git/lib/Kconfig.debug
> @@ -130,6 +130,13 @@ config DEBUG_KOBJECT
>  	  If you say Y here, some extra kobject debugging messages will be sent
>  	  to the syslog. 
>  
> +config DEBUG_KREF
> +	bool "kref debugging"
> +	depends on DEBUG_KERNEL
> +	help
> +	  This option enables addition error checking for kref,
> +	  library routines for handling generic reference counted objects.
> +
>  config DEBUG_HIGHMEM
>  	bool "Highmem debugging"
>  	depends on DEBUG_KERNEL && HIGHMEM
> Index: 2.6-git/lib/kref.c
> ===================================================================
> --- 2.6-git.orig/lib/kref.c
> +++ 2.6-git/lib/kref.c
> @@ -20,16 +20,38 @@
>   */
>  void kref_init(struct kref *kref)
>  {
> -	atomic_set(&kref->refcount,1);
> +	atomic_set(&kref->refcount, 1);
>  }
>  
> +#ifdef CONFIG_DEBUG_KREF
> +static void kref_get_debug_check(struct kref *kref)
> +{
> +	BUG_ON(!atomic_read(&kref->refcount));
> +}

Eeek, no, you do not want to do this.  Unless you never want to get a
bug report with this enabled :)

thanks,

greg k-h
