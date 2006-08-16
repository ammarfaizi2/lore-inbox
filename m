Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750829AbWHPK0L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750829AbWHPK0L (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 06:26:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750837AbWHPK0L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 06:26:11 -0400
Received: from mtagate5.de.ibm.com ([195.212.29.154]:35983 "EHLO
	mtagate5.de.ibm.com") by vger.kernel.org with ESMTP
	id S1750829AbWHPK0J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 06:26:09 -0400
Date: Wed, 16 Aug 2006 12:26:03 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Roland McGrath <roland@redhat.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kexec warning fix
Message-ID: <20060816102603.GB6900@osiris.boeblingen.de.ibm.com>
References: <20060816090105.9A4E9180063@magilla.sf.frob.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060816090105.9A4E9180063@magilla.sf.frob.com>
User-Agent: mutt-ng/devel-r804 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 16, 2006 at 02:01:05AM -0700, Roland McGrath wrote:
> 
> This fixes a couple of compiler warnings, and adds paranoia checks to boot.
> 
> Signed-off-by: Roland McGrath <roland@redhat.com>
> ---
>  kernel/kexec.c |    6 ++++--
>  1 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/kexec.c b/kernel/kexec.c
> index 50087ec..989c7cd 100644  
> --- a/kernel/kexec.c
> +++ b/kernel/kexec.c
> @@ -995,7 +995,8 @@ asmlinkage long sys_kexec_load(unsigned 
>  	image = xchg(dest_image, image);
>  
>  out:
> -	xchg(&kexec_lock, 0); /* Release the mutex */
> +	locked = xchg(&kexec_lock, 0); /* Release the mutex */
> +	BUG_ON(!locked);
>  	kimage_free(image);
>  
>  	return result;
> @@ -1061,7 +1062,8 @@ void crash_kexec(struct pt_regs *regs)
>  			machine_crash_shutdown(&fixed_regs);
>  			machine_kexec(kexec_crash_image);
>  		}
> -		xchg(&kexec_lock, 0);
> +		locked = xchg(&kexec_lock, 0);
> +		BUG_ON(!locked);
>  	}
>  }

On s390 I changed the xchg macro, so gcc 4.x doesn't warn anymore about unused
return values. Maybe something similar would be needed on other architectures
as well?
See commit 5a651c93d3a823af63b1b15bb94fdc951670fb2f .
