Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261202AbUL2Aw3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261202AbUL2Aw3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Dec 2004 19:52:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261211AbUL2Aw3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Dec 2004 19:52:29 -0500
Received: from mail.dif.dk ([193.138.115.101]:34751 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S261202AbUL2AwW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Dec 2004 19:52:22 -0500
Date: Wed, 29 Dec 2004 02:03:24 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Jonathan Ho <jonathanho15@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernel lib parser: cleaned up code and fixed redundancies
In-Reply-To: <41D1FD25.3020403@gmail.com>
Message-ID: <Pine.LNX.4.61.0412290156310.3528@dragon.hygekrogen.localhost>
References: <41D1FD25.3020403@gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Dec 2004, Jonathan Ho wrote:

> Just cleaned up code and fixed variable assignment redundancies.
> 
> Signed-off-by: <jonathanho15@gmail.com>
> 
> ----------------------------------
> 
> --- linux-2.6.10/lib/parser.c.orig    Fri Dec 24 13:34:33 2004
> +++ linux-2.6.10/lib/parser.c    Tue Dec 28 12:35:38 2004
> @@ -104,8 +104,7 @@ int match_token(char *s, match_table_t t
> {
>     struct match_token *p;
> 
> -    for (p = table; !match_one(s, p->pattern, args) ; p++)
> -        ;
> +    for (p = table; !match_one(s, p->pattern, args); p++);
> 
Personally I prefer the ";" on a line by itself - make it more 
obvious that the for loop is supposed to be empty and thus more 
readable. If you move the semicolon it it looks more like an error on 
casual inspection.
Personally I'd probably have changed the existing code to something like 
this if at all : 

for (p = table; !match_one(s, p->pattern, args); p++)
	; /* empty body */

Then it's really obvious.


> static int match_number(substring_t *s, int *result, int base)
> {
> -    char *endp;
> -    char *buf;
> -    int ret;
> +    char *endp, *buf;
> +    int ret = 0;
> 
>     buf = kmalloc(s->to - s->from + 1, GFP_KERNEL);
>     if (!buf)
> @@ -132,7 +130,6 @@ static int match_number(substring_t *s,
>     memcpy(buf, s->from, s->to - s->from);
>     buf[s->to - s->from] = '\0';
>     *result = simple_strtol(buf, &endp, base);
> -    ret = 0;
>     if (endp == buf)
>         ret = -EINVAL;
>     kfree(buf);
> 
Why move the assignment of ret? the way it was the assignment would 
only be done when nessesary (we can bail out of the function before the 
poing where ret was set to 0) - with your code we'll always set ret to 0 
even when we bail out early with return -ENOMEM; and ret is not used at 
all.


-- 
Jesper Juhl 


