Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268157AbUGWW4U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268157AbUGWW4U (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jul 2004 18:56:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268158AbUGWW4U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jul 2004 18:56:20 -0400
Received: from fw.osdl.org ([65.172.181.6]:39333 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268157AbUGWW4S (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jul 2004 18:56:18 -0400
Date: Fri, 23 Jul 2004 15:56:14 -0700
From: Stephen Hemminger <shemminger@osdl.org>
To: Andreas Schwab <schwab@suse.de>
Cc: Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hlist_for_each_safe cleanup
Message-Id: <20040723155614.2a63dc71@dell_ss3.pdx.osdl.net>
In-Reply-To: <jeoem65shc.fsf@sykes.suse.de>
References: <20040723140527.7e3c119a@dell_ss3.pdx.osdl.net>
	<jeoem65shc.fsf@sykes.suse.de>
Organization: Open Source Development Lab
X-Mailer: Sylpheed version 0.9.10claws (GTK+ 1.2.10; i386-redhat-linux-gnu)
X-Face: &@E+xe?c%:&e4D{>f1O<&U>2qwRREG5!}7R4;D<"NO^UI2mJ[eEOA2*3>(`Th.yP,VDPo9$
 /`~cw![cmj~~jWe?AHY7D1S+\}5brN0k*NE?pPh_'_d>6;XGG[\KDRViCfumZT3@[
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Jul 2004 23:22:23 +0200
Andreas Schwab <schwab@suse.de> wrote:

> Stephen Hemminger <shemminger@osdl.org> writes:
> 
> > --- linux-2.6/include/linux/list.h	2004-07-23 09:36:18.000000000 -0700
> > +++ tcp-2.6/include/linux/list.h	2004-07-23 11:43:25.000000000 -0700
> > @@ -620,13 +620,12 @@
> >  
> >  #define hlist_entry(ptr, type, member) container_of(ptr,type,member)
> >  
> > -/* Cannot easily do prefetch unfortunately */
> >  #define hlist_for_each(pos, head) \
> >  	for (pos = (head)->first; pos && ({ prefetch(pos->next); 1; }); \
> >  	     pos = pos->next)
> >  
> >  #define hlist_for_each_safe(pos, n, head) \
> > -	for (pos = (head)->first; n = pos ? pos->next : NULL, pos; \
> > +	for (pos = (head)->first; pos && ({ n = pos->next; 1; }); \
> 
> What's wrong with using the comma operator instead of non-standard
> statement expressions?

It was more a case of consistency and avoiding the n = NULL assignment when pos
is NULL.  

Look at hlist_for_each_entry_safe

#define hlist_for_each_entry_safe(tpos, pos, n, head, member)            \
        for (pos = (head)->first;                                        \
             pos && ({ n = pos->next; 1; }) &&                           \
                ({ tpos = hlist_entry(pos, typeof(*tpos), member); 1;}); \
             pos = n)


What's your problem with the gcc extensions, the kernel uses them all over the place,
planning on starting a conversion?

