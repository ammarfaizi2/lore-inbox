Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262824AbREaRpu>; Thu, 31 May 2001 13:45:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263123AbREaRpj>; Thu, 31 May 2001 13:45:39 -0400
Received: from quasar.osc.edu ([192.148.249.15]:18826 "EHLO quasar.osc.edu")
	by vger.kernel.org with ESMTP id <S262824AbREaRpc>;
	Thu, 31 May 2001 13:45:32 -0400
Date: Thu, 31 May 2001 13:45:30 -0400
From: Pete Wyckoff <pw@osc.edu>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Makefile patch for cscope and saner Ctags
Message-ID: <20010531134530.A15302@osc.edu>
In-Reply-To: <20010530180232.A4546@somanetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010530180232.A4546@somanetworks.com>; from mark@somanetworks.com on Wed, May 30, 2001 at 06:02:32PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mark@somanetworks.com said:
> The following patch generates saner Ctags and will build cscope
> output.  It's against 2.4.5
> 
> --- Makefile.old	Mon May 28 22:44:01 2001
> +++ Makefile	Wed May 30 17:50:01 2001
> @@ -334,11 +334,32 @@
>  
>  # Exuberant ctags works better with -I
>  tags: dummy
> -	CTAGSF=`ctags --version | grep -i exuberant >/dev/null && echo "-I __initdata,__exitdata,EXPORT_SYMBOL,EXPORT_SYMBOL_NOVERS"`; \
> +	CTAGSF=`ctags --version | grep -i exuberant >/dev/null && echo "--sort=no -I __initdata,__exitdata,EXPORT_SYMBOL,EXPORT_SYMBOL_NOVERS"`; \
>  	ctags $$CTAGSF `find include/asm-$(ARCH) -name '*.h'` && \
> -	find include -type d \( -name "asm-*" -o -name config \) -prune -o -name '*.h' -print | xargs ctags $$CTAGSF -a && \
> +	find include -type f -name '*.h' -mindepth 2 -maxdepth 2 \
> +	    | grep -v include/asm- | grep -v include/config \
> +	    | xargs -r ctags $$CTAGSF -a && \
> +	find include -type f -name '*.h' -mindepth 3 -maxdepth 3 \
> +	    | grep -v include/asm- | grep -v include/config \
> +	    | xargs -r ctags $$CTAGSF -a && \
> +	find include -type f -name '*.h' -mindepth 4 -maxdepth 4 \
> +	    | grep -v include/asm- | grep -v include/config \
> +	    | xargs -r ctags $$CTAGSF -a && \
> +	find include -type f -name '*.h' -mindepth 5 -maxdepth 5 \
> +	    | grep -v include/asm- | grep -v include/config \
> +	    | xargs -r ctags $$CTAGSF -a && \
>  	find $(SUBDIRS) init -name '*.c' | xargs ctags $$CTAGSF -a
> +	mv tags tags.unsorted
> +	LC_ALL=C sort -k 1,1 -s tags.unsorted > tags
> +	rm tags.unsorted
>  
> +cscope: dummy
> +	find include/asm-$(ARCH) -name '*.h' >cscope.files
> +	find include $(SUBDIRS) init -type f -name '*.[ch]' \
> +	    | grep -v include/asm- | grep -v include/config >> cscope.files
> +	cscope -b -I include
> +
> +	
>  ifdef CONFIG_MODULES
>  ifdef CONFIG_MODVERSIONS
>  MODFLAGS += -DMODVERSIONS -include $(HPATH)/linux/modversions.h

You seem not to have read my response to your earlier mail proprosing
such a thing (for tags only, not cscope):

    http://boudicca.tux.org/hypermail/linux-kernel/2001week21/1869.html

How does the patch above fix anything?  You're sorting so that
include/linux/*.h comes before include/linux/{mtd,lockd,raid,...}/*.h,
but I don't see how that can be an improvement, or how it addresses
your original complaint "ctags doesn't honour any CPP #if'ing".

		-- Pete
