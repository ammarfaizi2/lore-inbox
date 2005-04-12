Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262359AbVDLLrs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262359AbVDLLrs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 07:47:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262361AbVDLLro
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 07:47:44 -0400
Received: from [195.23.16.24] ([195.23.16.24]:27876 "EHLO
	bipbip.comserver-pie.com") by vger.kernel.org with ESMTP
	id S262359AbVDLLnj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 07:43:39 -0400
Message-ID: <425BB466.4030209@grupopie.com>
Date: Tue, 12 Apr 2005 12:43:34 +0100
From: Paulo Marques <pmarques@grupopie.com>
Organization: Grupo PIE
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] kallsyms C_SYMBOL_PREFIX support
References: <m24qecmq3p.wl%ysato@users.sourceforge.jp>
In-Reply-To: <m24qecmq3p.wl%ysato@users.sourceforge.jp>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yoshinori Sato wrote:
> kallsyms does not consider SYMBOL_PREFIX of C.
> Consequently do not work in architecture using prefix character (h8300, v850) really.
> 
> Because I can want to use this, I made a patch.
> Please comment.
> 
> [...]

> @@ -177,6 +184,11 @@
>  		"_SDA2_BASE_",		/* ppc */
>  		NULL };
>  	int i;
> +	int offset = 1;
> +
> +	/* skip prefix char */
> +	if (symbol_prefix_char && *(s->sym + 1) == symbol_prefix_char)
> +		offset++;

maybe something like:

char *sname;
sname = s->sym + 1;
if (symbol_prefix_char && *(s->sym + 1) == symbol_prefix_char)
	sname++;

would avoid all the "(s->sym + offset)" below, turning them to just "sname".

I know that it was "(s->sym + 1)" before, so its really not your fault, 
but you could take this opportunity to clean that up, too.

>  
>  	/* if --all-symbols is not specified, then symbols outside the text
>  	 * and inittext sections are discarded */
> @@ -190,17 +202,17 @@
>  		 * they may get dropped in pass 2, which breaks the kallsyms
>  		 * rules.
>  		 */
> -		if ((s->addr == _etext && strcmp(s->sym + 1, "_etext")) ||
> -		    (s->addr == _einittext && strcmp(s->sym + 1, "_einittext")))
> +		if ((s->addr == _etext && strcmp(s->sym + offset, "_etext")) ||
> +		    (s->addr == _einittext && strcmp(s->sym + offset, "_einittext")))
>  			return 0;
>  	}
>  
>  	/* Exclude symbols which vary between passes. */
> -	if (strstr(s->sym + 1, "_compiled."))
> +	if (strstr(s->sym + offset, "_compiled."))
>  		return 0;
>  
>  	for (i = 0; special_symbols[i]; i++)
> -		if( strcmp(s->sym + 1, special_symbols[i]) == 0 )
> +		if( strcmp(s->sym + offset, special_symbols[i]) == 0 )
>  			return 0;
>  
>  	return 1;
> @@ -225,9 +237,15 @@

>  [...]
>  
>  /* uncompress a compressed symbol. When this function is called, the best table
> @@ -665,6 +683,13 @@
>  
>  	insert_real_symbols_in_table();
>  
> +	/* When valid symbol is not registered, exit to error */
> +	if (good_head.left == good_head.right &&
> +	    bad_head.left == bad_head.right) {
> +		fprintf(stderr, "No valid symbol.\n");
> +		exit(1);
> +	}
> +
>  	optimize_result();
>  }

This should only trigger if there are no symbols at all, or if there are 
some symbols that are considered invalid, and do not go into the final 
result.

Maybe we should just do a return here instead of exit, so that even if 
this happens, kallsyms will still produce an empty result, that will at 
least allow the kernel to compile.

It should give the error output to warn the user that there is something 
fishy, nevertheless. Maybe even a bigger message, since this should not 
happen at all, and if this triggers it means that something is seriously 
wrong.

> @@ -672,9 +697,21 @@
>  int
>  main(int argc, char **argv)
>  {
> -	if (argc == 2 && strcmp(argv[1], "--all-symbols") == 0)
> -		all_symbols = 1;
> -	else if (argc != 1)
> +	if (argc >= 2) {

This test is unnecessary.

> +		int i;
> +		for (i = 1; i < argc; i++) { 
> +			if(strcmp(argv[i], "--all-symbols") == 0)
> +				all_symbols = 1;
> +			else if (strncmp(argv[i], "--symbol-prefix=", 16) == 0) {
> +				char *p = &argv[i][16];
> +				/* skip quote */
> +				if ((*p == '"' && *(p+2) == '"') || (*p == '\'' && *(p+2) == '\''))
> +					p++;
> +				symbol_prefix_char = *p;
> +			} else
> +				usage();
> +		}
> +	} else if (argc != 1)
>  		usage();

and so is this.

>  
>  	read_map(stdin);
> @@ -683,4 +720,3 @@
>  
>  	return 0;
>  }

At least the patch seems to not affect architectures that don't use the 
"--symbol-prefix" option, so it should be harmless for most.

Anyway, appart from the few comments, it has my acknowledge.

-- 
Paulo Marques - www.grupopie.com

All that is necessary for the triumph of evil is that good men do nothing.
Edmund Burke (1729 - 1797)
