Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262176AbUE1Dzt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262176AbUE1Dzt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 May 2004 23:55:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262730AbUE1Dzt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 May 2004 23:55:49 -0400
Received: from moraine.clusterfs.com ([66.246.132.190]:60134 "EHLO
	moraine.clusterfs.com") by vger.kernel.org with ESMTP
	id S262176AbUE1Dzp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 May 2004 23:55:45 -0400
Date: Thu, 27 May 2004 21:55:37 -0600
From: Andreas Dilger <adilger@clusterfs.com>
To: David Gibson <david@gibson.dropbear.id.au>, Andrew Morton <akpm@osdl.org>,
       Anton Blanchard <anton@samba.org>, Paul Mackerras <paulus@samba.org>,
       linux-kernel@vger.kernel.org, linuxppc64-dev@lists.linuxppc.org
Subject: Re: [PPC64] Remove silly debug path from get_vsid()
Message-ID: <20040528035537.GT2603@schnapps.adilger.int>
Mail-Followup-To: David Gibson <david@gibson.dropbear.id.au>,
	Andrew Morton <akpm@osdl.org>, Anton Blanchard <anton@samba.org>,
	Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org,
	linuxppc64-dev@lists.linuxppc.org
References: <20040528031659.GC15922@zax>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040528031659.GC15922@zax>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On May 28, 2004  13:16 +1000, David Gibson wrote:
> This patch removes the test, replacing it with a compile time switch.
> It seems to make a measurable, although small speedup to the SLB miss
> path (maybe 0.5%).

Looking at include/asm-ppc64/ppcdebug.h the ifppcdebug() macro is defined:

#ifdef CONFIG_PPCDBG
#define ifppcdebug(FLAGS) if (udbg_ifdebug(FLAGS))
#else
#define ifppcdebug(...) if (0)
#endif

so presumably if you don't select CONFIG_PPCDBG it is also a no-op unless
the compiler is broken and doesn't optimize away "if (0)" stanzas.  The
original construct gives you the option to enable this particular debugging
at runtime (without necessarily enabling all debugging at one time) if wanted.

> Index: working-2.6/include/asm-ppc64/mmu_context.h
> ===================================================================
> --- working-2.6.orig/include/asm-ppc64/mmu_context.h	2004-05-20 12:58:51.000000000 +1000
> +++ working-2.6/include/asm-ppc64/mmu_context.h	2004-05-27 14:22:01.088506616 +1000
> @@ -189,15 +189,15 @@
>  	ordinal = (((ea >> 28) & 0x1fff) * LAST_USER_CONTEXT) | (ea >> 60);
>  	vsid = (ordinal * VSID_RANDOMIZER) & VSID_MASK;
>  
> -	ifppcdebug(PPCDBG_HTABSTRESS) {
> -		/* For debug, this path creates a very poor vsid distribuition.
> -		 * A user program can access virtual addresses in the form
> -		 * 0x0yyyyxxxx000 where yyyy = xxxx to cause multiple mappings
> -		 * to hash to the same page table group.
> -		 */ 
> -		ordinal = ((ea >> 28) & 0x1fff) | (ea >> 44);
> -		vsid = ordinal & VSID_MASK;
> -	}
> +#ifdef HTABSTRESS
> +	/* For debug, this path creates a very poor vsid distribuition.
> +	 * A user program can access virtual addresses in the form
> +	 * 0x0yyyyxxxx000 where yyyy = xxxx to cause multiple mappings
> +	 * to hash to the same page table group.
> +	 */ 
> +	ordinal = ((ea >> 28) & 0x1fff) | (ea >> 44);
> +	vsid = ordinal & VSID_MASK;
> +#endif /* HTABSTRESS */
>  
>  	return vsid;
>  } 
> @@ -212,11 +212,11 @@
>  	ordinal = (((ea >> 28) & 0x1fff) * LAST_USER_CONTEXT) | context;
>  	vsid = (ordinal * VSID_RANDOMIZER) & VSID_MASK;
>  
> -	ifppcdebug(PPCDBG_HTABSTRESS) {
> -		/* See comment above. */
> -		ordinal = ((ea >> 28) & 0x1fff) | (context << 16);
> -		vsid = ordinal & VSID_MASK;
> -	}
> +#ifdef HTABSTRESS
> +	/* See comment above. */
> +	ordinal = ((ea >> 28) & 0x1fff) | (context << 16);
> +	vsid = ordinal & VSID_MASK;
> +#endif /* HTABSTRESS */
>  
>  	return vsid;
>  }
> 
> -- 
> David Gibson			| For every complex problem there is a
> david AT gibson.dropbear.id.au	| solution which is simple, neat and
> 				| wrong.
> http://www.ozlabs.org/people/dgibson
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

