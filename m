Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268525AbTANDss>; Mon, 13 Jan 2003 22:48:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268537AbTANDss>; Mon, 13 Jan 2003 22:48:48 -0500
Received: from dp.samba.org ([66.70.73.150]:23471 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S268525AbTANDso>;
	Mon, 13 Jan 2003 22:48:44 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: Richard Henderson <rth@twiddle.net>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [MODULES] fix weak symbol handling 
In-reply-to: Your message of "Mon, 13 Jan 2003 11:00:36 -0800."
             <20030113110036.A873@twiddle.net> 
Date: Tue, 14 Jan 2003 14:57:11 +1100
Message-Id: <20030114035737.07C672C2BD@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20030113110036.A873@twiddle.net> you write:
>  		case SHN_UNDEF:
> +			sym[i].st_value
> +			  = resolve_symbol(sechdrs, symindex, strtab,
> +					   strtab + sym[i].st_name, mod);
> +
> +			/* Ok if resolved.  */
> +			if (sym[i].st_value != 0)
> +				break;
> +			/* Ok if weak.  */
> +			if (ELF_ST_BIND(sym[i].st_info) == STB_WEAK)
> +				break;
> +
> +			printk(KERN_WARNING "%s: Unknown symbol %s\n",
> +			       mod->name, strtab + sym[i].st_name);
> +			ret = -ENOENT;
>  			break;

I don't understand this.  For a weak symbol, st_shndx won't be
SHN_UNDEF.  And you don't want to set its value to 0, anyway.  I think
you want:

	default:
		if (ELF_ST_BIND(sym[i].st_info) == STB_WEAK) {
			unsigned long val = resolve_symbol(...);
			if (val)
				sym[i].st_value = val;
		} else
			...

Or am I missing something?
Rusty.
PS.  "s/Fix weak symbol handling/Implement weak symbol handling/" 8)
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
