Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264479AbUFPS3X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264479AbUFPS3X (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jun 2004 14:29:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264396AbUFPS3X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jun 2004 14:29:23 -0400
Received: from mail.fh-wedel.de ([213.39.232.194]:17571 "EHLO mail.fh-wedel.de")
	by vger.kernel.org with ESMTP id S264371AbUFPS3Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jun 2004 14:29:16 -0400
Date: Wed, 16 Jun 2004 20:29:10 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: jolt@tuxbox.org, akpm@osdl.org, B.Zolnierkiewicz@elka.pw.edu.pl,
       linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [STACK] reduce >3k call path in ide
Message-ID: <20040616182910.GC15365@wohnheim.fh-wedel.de>
References: <20040609122921.GG21168@wohnheim.fh-wedel.de> <20040615163445.6b886383.rddunlap@osdl.org> <200406160911.11985.jolt@tuxbox.org> <20040616094737.GA2548@wohnheim.fh-wedel.de> <40D01928.1080309@tuxbox.org> <20040616100008.GB2548@wohnheim.fh-wedel.de> <20040616103741.042f8029.rddunlap@osdl.org> <20040616175730.GA15365@wohnheim.fh-wedel.de> <20040616111621.4d1fdfff.rddunlap@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040616111621.4d1fdfff.rddunlap@osdl.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 June 2004 11:16:21 -0700, Randy.Dunlap wrote:
> On Wed, 16 Jun 2004 19:57:30 +0200 Jörn Engel wrote:
> 
> | On Wed, 16 June 2004 10:37:41 -0700, Randy.Dunlap wrote:
> | > 
> | > Thanks for the helpful comments.  Here's a corrected patch.
> | 
> | Looks, as if it still leaks memory:
> 
> duh.  fudge.  Thanks.  How's this one?

Just four more lines?

>      link->dev = &info->node;
>      printk(KERN_INFO "ide-cs: %s: Vcc = %d.%d, Vpp = %d.%d\n",
> -	   info->node.dev_name, link->conf.Vcc/10, link->conf.Vcc%10,
> -	   link->conf.Vpp1/10, link->conf.Vpp1%10);
> +	   info->node.dev_name, link->conf.Vcc / 10, link->conf.Vcc % 10,
> +	   link->conf.Vpp1 / 10, link->conf.Vpp1 % 10);
>  
>      link->state &= ~DEV_CONFIG_PENDING;
+    kfree(cisparse);
+    kfree(cfginfo);
+    kfree(def_cte);
+    kfree(tbuf);
>      return;
> -    
> +
> +err_mem:
> +    printk(KERN_NOTICE "ide-cs: ide_config failed memory allocation\n");
> +    goto failed;
> +
>  cs_failed:
>      cs_error(link->handle, last_fn, last_ret);
>  failed:
> +    kfree(cisparse);
> +    kfree(cfginfo);
> +    kfree(def_cte);
> +    kfree(tbuf);
> +
>      ide_release(link);
>      link->state &= ~DEV_CONFIG_PENDING;
> -
>  } /* ide_config */
>  
>  /*======================================================================

Jörn

-- 
Fancy algorithms are slow when n is small, and n is usually small.
Fancy algorithms have big constants. Until you know that n is
frequently going to be big, don't get fancy.
-- Rob Pike
