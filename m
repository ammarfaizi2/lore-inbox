Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269013AbUJEM5z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269013AbUJEM5z (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 08:57:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269014AbUJEM5y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 08:57:54 -0400
Received: from iPass.cambridge.arm.com ([193.131.176.58]:17646 "EHLO
	cam-admin0.cambridge.arm.com") by vger.kernel.org with ESMTP
	id S269013AbUJEM5t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 08:57:49 -0400
Subject: Re: [RFC] ARM binutils feature churn causing kernel problems
From: Richard Earnshaw <Richard.Earnshaw@arm.com>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: linux-kernel@vger.kernel.org, Catalin Marinas <Catalin.Marinas@arm.com>,
       Rusty Russell <rusty@rustcorp.com.au>, Sam Ravnborg <sam@ravnborg.org>
In-Reply-To: <20041005125324.A6910@flint.arm.linux.org.uk>
References: <20040927210305.A26680@flint.arm.linux.org.uk>
	 <20041001211106.F30122@flint.arm.linux.org.uk> <tnxllemvgi7.fsf@arm.com>
	 <1096931899.32500.37.camel@localhost.localdomain>
	 <loom.20041005T130541-400@post.gmane.org>
	 <20041005125324.A6910@flint.arm.linux.org.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1096981035.14574.20.camel@pc960.cambridge.arm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 05 Oct 2004 13:57:15 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-10-05 at 12:53, Russell King wrote:
> On Tue, Oct 05, 2004 at 11:10:46AM +0000, Richard Earnshaw wrote:
> > Rusty Russell <rusty <at> rustcorp.com.au> writes:
> > > Russell, I thought about not including any symbol which is not of form
> > > "[A-Za-z0-9_]+" in kallsyms, for all archs: you are not the only one
> > > with weird-ass symbols.  Is it that you want these mapping symbols in
> > > /proc/kallsyms but ignored in backtraces, or you don't need them in
> > > kallsyms altogether?
> > > 
> > > Thanks,
> > > Rusty.
> > 
> > 
> > Mapping symbols will always be encoded with STB_LOCAL and STT_NOTYPE.
> > I would have thought it unlikely that the kernel would ever want to
> > report against any symbol with those attributes and they could all
> > be dropped on that basis.
> 
> (Richard - your mailer appears to have dropped people from the CC: list...)
> 

Not by me, I don't subscribe to the list in question and was pointed to
gmane.linux.kernel newsgroup by Phillipe.  I simply followed up to that
message.

> How about this patch?  Is there a better way to parse the 'nm' output
> to achieve the same as your suggestion above?
> 
> diff -up -x BitKeeper -x ChangeSet -x SCCS -x _xlk -x *.orig -x *.rej orig/kernel/module.c linux/kernel/module.c
> --- orig/kernel/module.c	Wed Sep 22 16:07:38 2004
> +++ linux/kernel/module.c	Tue Oct  5 12:46:01 2004
> @@ -1923,6 +1923,10 @@ static const char *get_ksymbol(struct mo
>  		if (mod->symtab[i].st_shndx == SHN_UNDEF)
>  			continue;
>  
> +		if (ELF_ST_BIND(mod->symtab[i].st_info) == STB_LOCAL
> +		    && ELF_ST_TYPE(mod->symtab[i].st_info) == STT_NOTYPE)
> +			continue;
> +
>  		/* We ignore unnamed symbols: they're uninformative
>  		 * and inserted at a whim. */
>  		if (mod->symtab[i].st_value <= addr
> diff -up -x BitKeeper -x ChangeSet -x SCCS -x _xlk -x *.orig -x *.rej orig/scripts/kallsyms.c linux/scripts/kallsyms.c
> --- orig/scripts/kallsyms.c	Sun Jul 11 22:56:39 2004
> +++ linux/scripts/kallsyms.c	Tue Oct  5 12:51:26 2004
> @@ -32,6 +32,17 @@ usage(void)
>  	exit(1);
>  }
>  
> +/*
> + * This ignores the intensely annoying "mapping symbols" found
> + * in ARM ELF files: $a, $t and $d.
> + */
> +static inline int
> +is_arm_mapping_symbol(const char *str)
> +{
> +	return str[0] == '$' && strchr("atd", str[1]) &&
> +	       (str[2] == '\0' || str[2] == '.');
> +}
> +
>  static int
>  read_symbol(FILE *in, struct sym_entry *s)
>  {
> @@ -56,7 +67,8 @@ read_symbol(FILE *in, struct sym_entry *
>  		_sinittext = s->addr;
>  	else if (strcmp(str, "_einittext") == 0)
>  		_einittext = s->addr;
> -	else if (toupper(s->type) == 'A' || toupper(s->type) == 'U')
> +	else if (toupper(s->type) == 'A' || toupper(s->type) == 'U' ||
> +		 is_arm_mapping_symbol(str))
>  		return -1;
>  
>  	s->sym = strdup(str);

Why don't you pass s to is_arm_mapping_symbol and have it do the same
thing as you've done in get_ksymbol?

R.
-- 
Richard Earnshaw             Email: Richard.Earnshaw@arm.com
ARM Ltd                      Phone: +44 1223 400569 (Direct + VoiceMail)
110 Fulbourn Road            Switchboard: +44 1223 400400
Cherry Hinton                Fax: +44 1223 400410
Cambridge CB1 9NJ            Web: http://www.arm.com/
UK
----------------------------------------------------------------
This e-mail message is intended for the addressee(s) only and may
contain information that is the property of, and/or subject to a
confidentiality agreement between the intended recipient(s), their
organisation and/or the ARM Group of Companies. If you are not an
intended recipient of this e-mail message, you should not read, copy,
forward or otherwise distribute or further disclose the information in
it; misuse of the contents of this e-mail message may violate various
laws in your state, country or jurisdiction. If you have received this
e-mail message in error, please contact the originator of this e-mail
message via e-mail and delete all copies of this message from your
computer or network, thank you.
----------------------------------------------------------------

