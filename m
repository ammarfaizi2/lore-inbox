Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261431AbVDDWQs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261431AbVDDWQs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Apr 2005 18:16:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261446AbVDDWPG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Apr 2005 18:15:06 -0400
Received: from fire.osdl.org ([65.172.181.4]:36754 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261434AbVDDWMj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Apr 2005 18:12:39 -0400
Message-ID: <4251BBC5.8000802@osdl.org>
Date: Mon, 04 Apr 2005 15:12:21 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
Organization: OSDL
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: maximilian attems <janitor@sternwelten.at>
CC: lkml <linux-kernel@vger.kernel.org>, akpm <akpm@osdl.org>,
       B.Zolnierkiewicz@elka.pw.edu.pl, rusty@rustcorp.com.au
Subject: Re: [patch 2/3] hd eliminate bad section references
References: <20050404181102.GB12394@sputnik.stro.at>
In-Reply-To: <20050404181102.GB12394@sputnik.stro.at>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

maximilian attems wrote:
> Fix hd section references:
> make parse_hd_setup() __init
> 
> Error: ./drivers/ide/legacy/hd.o .text refers to 00000943 R_386_PC32
> .init.text
> 
> Signed-off-by: maximilian attems <janitor@sternwelten.at>
> 
> 
> --- linux-2.6.12-rc1-bk5/drivers/ide/legacy/hd.c.orig	2005-04-04 18:39:04.000000000 +0200
> +++ linux-2.6.12-rc1-bk5/drivers/ide/legacy/hd.c	2005-04-04 19:02:57.908576221 +0200
> @@ -851,7 +851,7 @@
>  	goto out;
>  }
>  
> -static int parse_hd_setup (char *line) {
> +static int __init parse_hd_setup (char *line) {
>  	int ints[6];
>  
>  	(void) get_options(line, ARRAY_SIZE(ints), ints);

This one is fairly interesting and needs some resolution by someone
who knows....

On the surface, the patch is correct.

Rusty, can you explain when __setup functions are called relative
to in-kernel init functions?  or put another way, can a __setup
function safely call in __init function?

Here's the function in question:

static int parse_hd_setup (char *line) {
	int ints[6];

	(void) get_options(line, ARRAY_SIZE(ints), ints);
	hd_setup(NULL, ints);

	return 1;
}
__setup("hd=", parse_hd_setup);



Should we make parse_hd_setup() __init,
or make hd_setup() non-__init, or something else?

{time passes, he looks]

OK, I looked at include/linux/init.h.  From what I can see
there, __setup() causes an .init.setup section to be emitted,
so marking __setup() function as __init would make sense.
I think that this patch is good.

Thanks.
-- 
~Randy
