Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318234AbSHPHFn>; Fri, 16 Aug 2002 03:05:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318236AbSHPHFn>; Fri, 16 Aug 2002 03:05:43 -0400
Received: from cerebus.wirex.com ([65.102.14.138]:28403 "EHLO
	figure1.int.wirex.com") by vger.kernel.org with ESMTP
	id <S318234AbSHPHFm>; Fri, 16 Aug 2002 03:05:42 -0400
Date: Fri, 16 Aug 2002 00:06:29 -0700
From: Chris Wright <chris@wirex.com>
To: James Morris <jmorris@intercode.com.au>
Cc: "David S. Miller" <davem@redhat.com>, kuznet@ms2.inr.ac.ru,
       Andi Kleen <ak@muc.de>, linux-kernel@vger.kernel.org,
       Matthew Wilcox <willy@debian.org>
Subject: Re: [PATCH][RFC] sigurg/sigio cleanup for 2.5.31
Message-ID: <20020816000629.A15216@figure1.int.wirex.com>
Mail-Followup-To: James Morris <jmorris@intercode.com.au>,
	"David S. Miller" <davem@redhat.com>, kuznet@ms2.inr.ac.ru,
	Andi Kleen <ak@muc.de>, linux-kernel@vger.kernel.org,
	Matthew Wilcox <willy@debian.org>
References: <Mutt.LNX.4.44.0208160302100.28909-100000@blackbird.intercode.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Mutt.LNX.4.44.0208160302100.28909-100000@blackbird.intercode.com.au>; from jmorris@intercode.com.au on Fri, Aug 16, 2002 at 03:16:57AM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* James Morris (jmorris@intercode.com.au) wrote:
> @@ -95,15 +96,14 @@
>  		prev = &odn->dn_next;
>  	}
>  
> -	error = security_ops->file_set_fowner(filp);
> +	lock_kernel();
> +	error = f_setown(filp, current->pid);
> +	unlock_kernel();
>  	if (error) {
>  		write_unlock(&dn_lock);
>  		return error;
>  	}

This propagates a leak which John Levon found in current mainline.  Needs a
kmem_cache_free(dn_cache, dn) before returning.  You may consider goto
for common unlock/return path.  Is BKL best way to protect f_owner?

cheers,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
