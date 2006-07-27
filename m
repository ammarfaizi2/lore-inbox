Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161017AbWG0Dfb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161017AbWG0Dfb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jul 2006 23:35:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161020AbWG0Dfb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jul 2006 23:35:31 -0400
Received: from mailgw.cvut.cz ([147.32.3.235]:57805 "EHLO mailgw.cvut.cz")
	by vger.kernel.org with ESMTP id S1161017AbWG0Dfa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jul 2006 23:35:30 -0400
Message-ID: <44C83480.6000102@vandrovec.name>
Date: Thu, 27 Jul 2006 05:35:28 +0200
From: Petr Vandrovec <petr@vandrovec.name>
User-Agent: Mozilla/5.0 (X11; U; Linux i686 (x86_64); en-US; rv:1.7.13) Gecko/20060620 Debian/1.7.13-0.2
X-Accept-Language: cs, en
MIME-Version: 1.0
To: Arnd Bergmann <arnd.bergmann@de.ibm.com>
CC: Heiko Carstens <heiko.carstens@de.ibm.com>, linux-kernel@vger.kernel.org,
       Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [PATCH] ncpfs: move ioctl32 code to fs/ncpfs/ioctl.c
References: <20060710085142.GB9440@osiris.boeblingen.de.ibm.com> <200607270303.42959.arnd.bergmann@de.ibm.com> <200607270309.58867.arnd.bergmann@de.ibm.com> <200607270456.48014.arnd.bergmann@de.ibm.com>
In-Reply-To: <200607270456.48014.arnd.bergmann@de.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[removed linware@sh.cvut.cz - I believe it is dead...]

Arnd Bergmann wrote:
> The ncp specific compat ioctls are clearly local to one
> file system, so the code can better live there.
> 
> This version of the patch moves everything into the
> generic ioctl handler and uses it for both 32 and 64
> bit calls.
> 
> Petr, can you test this patch on a 64 bit system?

Yes, tomorrow (on amd64).

> @@ -544,6 +691,9 @@
>  			kfree(oldname);
>  			return 0;
>  		}
> +#ifdef CONFIG_COMPAT
> +	case NCP_IOC_GETPRIVATEDATA_32:
> +#endif
>  	case NCP_IOC_GETPRIVATEDATA:
>  		if (current->uid != server->m.mounted_uid) {
>  			return -EACCES;
...
> @@ -562,10 +722,23 @@
>  						 server->priv.data,
>  						 outl)) return -EFAULT;
>  			}
> -			if (copy_to_user(argp, &user, sizeof(user)))
> -				return -EFAULT;
> +			if (cmd == NCP_IOC_GETPRIVATEDATA) {
> +				if (copy_to_user(argp, &user, sizeof(user)))
> +					return -EFAULT;
> +			} else {
> +#ifdef CONFIG_COMPAT
> +				struct compat_ncp_privatedata_ioctl user32;
> +				user32.len = user.len;
> +				user32.data = (unsigned long) user.data;
> +				if (copy_to_user(&user32, argp, sizeof(user32)))
> +					return -EFAULT;
> +#endif
> +			}
>  			return 0;
>  		}

Although I understand that this code is correct, what about removing this second 
  #ifdef ?  gcc should realize it anyway that without CONFIG_COMPAT defined cmd 
must be equal to NCP_IOC_GETPRIVATEDATA, and having empty "else" variant is IMHO 
just asking for troubles.  Or what about

#ifdef CONFIG_COMPAT
     if (cmd == NCP_IOC_GETPRIVATEDATA_32) {
        struct ...
     } else
#endif
     if (copy_to_user(argp, &user, sizeof(user)))
        return -EFAULT;

							Thanks,
								Petr

