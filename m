Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261179AbUEJSEj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261179AbUEJSEj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 May 2004 14:04:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261159AbUEJSEj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 May 2004 14:04:39 -0400
Received: from fw.osdl.org ([65.172.181.6]:60032 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261179AbUEJSE1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 May 2004 14:04:27 -0400
Date: Mon, 10 May 2004 10:56:06 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: linux-kernel@vger.kernel.org, zwane@linuxpower.ca
Subject: Re: [PATCH*] show last kernel-image symbol in /proc/kallsyms
Message-Id: <20040510105606.27554ad0.rddunlap@osdl.org>
In-Reply-To: <1084162450.8121.6.camel@bach>
References: <20040509171452.09ee1ca0.rddunlap@osdl.org>
	<1084162450.8121.6.camel@bach>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 May 2004 14:14:10 +1000 Rusty Russell wrote:

| On Mon, 2004-05-10 at 10:14, Randy.Dunlap wrote:
| > 'cat' or 'tail' of /proc/kallsyms (2.6.6-rc2 or -rc3, & probably much
| > earlier) does not include the last kernel-image symbol (_einittext).
| > 
| > _einittext is the last symbol generated in .tmp_kallsyms2.S
| > and the symbol count in that file also appears to be correct,
| > but the iterator code for /proc/kallsyms comes up 1 short somehow.
| > 
| > Here are 2 patches.  Either one of them "fixes" the problem.
| > Neither of them is the correct fix AFAIK.
| 
| Ah, I see you are a student of the Morton school of patch extraction. 
| Well, it worked.

Well.... yes.

And thanks for taking time to fix it.
It now works as expected.  :)

'patch' complains about a malformed input file (the @@ line counts
don't match the patch content).
Correction is below.  Or were more patch lines needed (& missing)?


| Name: Show Last Symbol in /proc/kallsyms
| Status: Tested on 2.6.6-rc3.bk11
| 
| The current code doesn't show the last symbol (usually _einittext) in
| /proc/kallsyms.  The reason for this is subtle: s_start() returns an
| empty string for position 0 (ignored by s_show()), and s_next()
| returns the first symbol for position 1.
| 
| What should happen is that update_iter() for position 0 should fill in
| the first symbol.  Unfortunately, the get_ksymbol_core() fills in the
| symbol information, *and* updates the iterator: we have to split these
| functions, which we do by making it return the length of the name
| offset.
| 
| Then we can call get_ksymbol_core() without moving the iterator,
| meaning that we can call it at position 0 (ie. s_start()).
| 
| diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal linux-2.6.6-rc3-bk11/kernel/kallsyms.c working-2.6.6-rc3-bk11/kernel/kallsyms.c
| --- linux-2.6.6-rc3-bk11/kernel/kallsyms.c	2004-03-12 07:57:28.000000000 +1100
| +++ working-2.6.6-rc3-bk11/kernel/kallsyms.c	2004-05-10 13:11:06.000000000 +1000
| @@ -210,16 +212,16 @@ static int update_iter(struct kallsym_it
***** should be:  @@ -210,9 +212,10 @@

|  
|  	/* We need to iterate through the previous symbols: can be slow */
|  	for (; iter->pos != pos; iter->pos++) {
| -		get_ksymbol_core(iter);
| +		iter->nameoff += get_ksymbol_core(iter);
|  		cond_resched();
|  	}
| +	get_ksymbol_core(iter);
|  	return 1;
|  }
|  

--
~Randy
(Again.  Sometimes I think ln -s /usr/src/linux/.config .signature) -- akpm
