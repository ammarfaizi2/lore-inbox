Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261368AbVDWANq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261368AbVDWANq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Apr 2005 20:13:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261405AbVDWANq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Apr 2005 20:13:46 -0400
Received: from mail.fh-wedel.de ([213.39.232.198]:31211 "EHLO
	moskovskaya.fh-wedel.de") by vger.kernel.org with ESMTP
	id S261392AbVDWAMf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Apr 2005 20:12:35 -0400
Date: Sat, 23 Apr 2005 02:12:28 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: Yum Rayan <yum.rayan@gmail.com>, linux-kernel@vger.kernel.org,
       linux-pcmcia@lists.infradead.org, dahinds@users.sourceforge.net,
       rddunlap@osdl.org
Subject: Re: [PATCH linux-2.6.12-rc2-mm3] smc91c92_cs: Reduce stack usage in smc91c92_event()
Message-ID: <20050423001228.GA6418@wohnheim.fh-wedel.de>
References: <df35dfeb05042115021c24638b@mail.gmail.com> <200504221122.51579.vda@port.imtp.ilyichevsk.odessa.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200504221122.51579.vda@port.imtp.ilyichevsk.odessa.ua>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 April 2005 11:22:51 +0300, Denis Vlasenko wrote:
> 
> I do it this way:
> 
> int f()
> {
> -	tuple_t tuple;
> -	cisparse_t parse;
> -	u_char buf[255];
> +	struct {
> +		tuple_t tuple;
> +		cisparse_t parse;
> +		u_char buf[255];
> +	} local;
> +	local = kmalloc(sizeof(*local),...); if(!local)...
> 	...
> -    	tuple.Attributes = tuple.TupleOffset = 0;
> -    	tuple.TupleData = (cisdata_t *)buf;
> -    	tuple.TupleDataMax = sizeof(buf);
> +    	local->tuple.Attributes = local->tuple.TupleOffset = 0;
> +    	local->tuple.TupleData = (cisdata_t *)local->buf;
> +    	local->tuple.TupleDataMax = sizeof(local->buf);
> 
> I see the following advantages:
> 
> 1) struct is unnamed and local to function
> 2) Variables do not change their type, the just sit in local-> now.
>    I can just add 'local->' to each affected variable,
>    without "it was an object, now it is a pointer" changes.
>    No need to replace . with ->, remove &, etc.

I'd have proposed the same, before reading further down in the patch.
Basically, the driver is full of duplication, so the exact same struct
can be used several times.  Therefore, the downsides of your approach
seem to prevail.

> 3) I do not need to do this part of your patch which adds more locals:
> +    tuple_t *tuple;
> +    cisparse_t *parse;
> +    cistpl_cftable_entry_t *cf;
> +    u_char *buf;
> ...
> +    tuple = &cfg_mem->tuple;
> +    parse = &cfg_mem->parse;
> +    buf = cfg_mem->buf;
> 4) in resulting asm one base pointer instead of many will require
>    less registers

Yup.  There are thousands of detail to improve in that driver.  It's
current maintainership (there is none) may explain that state.

Jörn

-- 
Fantasy is more important than knowledge. Knowledge is limited,
while fantasy embraces the whole world.
-- Albert Einstein
