Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269018AbUJENPD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269018AbUJENPD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 09:15:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269019AbUJENPD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 09:15:03 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:24328 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S269018AbUJENO5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 09:14:57 -0400
Date: Tue, 5 Oct 2004 14:14:52 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Richard Earnshaw <Richard.Earnshaw@arm.com>
Cc: linux-kernel@vger.kernel.org, Catalin Marinas <Catalin.Marinas@arm.com>,
       Rusty Russell <rusty@rustcorp.com.au>, Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [RFC] ARM binutils feature churn causing kernel problems
Message-ID: <20041005141452.B6910@flint.arm.linux.org.uk>
Mail-Followup-To: Richard Earnshaw <Richard.Earnshaw@arm.com>,
	linux-kernel@vger.kernel.org,
	Catalin Marinas <Catalin.Marinas@arm.com>,
	Rusty Russell <rusty@rustcorp.com.au>,
	Sam Ravnborg <sam@ravnborg.org>
References: <20040927210305.A26680@flint.arm.linux.org.uk> <20041001211106.F30122@flint.arm.linux.org.uk> <tnxllemvgi7.fsf@arm.com> <1096931899.32500.37.camel@localhost.localdomain> <loom.20041005T130541-400@post.gmane.org> <20041005125324.A6910@flint.arm.linux.org.uk> <1096981035.14574.20.camel@pc960.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1096981035.14574.20.camel@pc960.cambridge.arm.com>; from Richard.Earnshaw@arm.com on Tue, Oct 05, 2004 at 01:57:15PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 05, 2004 at 01:57:15PM +0100, Richard Earnshaw wrote:
> On Tue, 2004-10-05 at 12:53, Russell King wrote:
> > diff -up -x BitKeeper -x ChangeSet -x SCCS -x _xlk -x *.orig -x *.rej orig/scripts/kallsyms.c linux/scripts/kallsyms.c
> > --- orig/scripts/kallsyms.c	Sun Jul 11 22:56:39 2004
> > +++ linux/scripts/kallsyms.c	Tue Oct  5 12:51:26 2004
> > @@ -32,6 +32,17 @@ usage(void)
> >  	exit(1);
> >  }
> >  
> > +/*
> > + * This ignores the intensely annoying "mapping symbols" found
> > + * in ARM ELF files: $a, $t and $d.
> > + */
> > +static inline int
> > +is_arm_mapping_symbol(const char *str)
> > +{
> > +	return str[0] == '$' && strchr("atd", str[1]) &&
> > +	       (str[2] == '\0' || str[2] == '.');
> > +}
> > +
> >  static int
> >  read_symbol(FILE *in, struct sym_entry *s)
> >  {
> > @@ -56,7 +67,8 @@ read_symbol(FILE *in, struct sym_entry *
> >  		_sinittext = s->addr;
> >  	else if (strcmp(str, "_einittext") == 0)
> >  		_einittext = s->addr;
> > -	else if (toupper(s->type) == 'A' || toupper(s->type) == 'U')
> > +	else if (toupper(s->type) == 'A' || toupper(s->type) == 'U' ||
> > +		 is_arm_mapping_symbol(str))
> >  		return -1;
> >  
> >  	s->sym = strdup(str);
> 
> Why don't you pass s to is_arm_mapping_symbol and have it do the same
> thing as you've done in get_ksymbol?

"sym_entry" is not an ELF symtab structure - it's a parsed version
of the `nm' output, and as such does not contain the symbol type nor
binding information.

> ----------------------------------------------------------------
> This e-mail message is intended for the addressee(s) only and may
> contain information that is the property of, and/or subject to a
> confidentiality agreement between the intended recipient(s), their
> organisation and/or the ARM Group of Companies. If you are not an
> intended recipient of this e-mail message, you should not read, copy,
> forward or otherwise distribute or further disclose the information in
> it; misuse of the contents of this e-mail message may violate various
> laws in your state, country or jurisdiction. If you have received this
> e-mail message in error, please contact the originator of this e-mail
> message via e-mail and delete all copies of this message from your
> computer or network, thank you.
> ----------------------------------------------------------------

Does this apply to your message?  It would appear that third parties
subscribed to linux-kernel are not allowed to read your messages
because they're not an "intended recipient" !

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
