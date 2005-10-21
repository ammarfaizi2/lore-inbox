Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964986AbVJUPXU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964986AbVJUPXU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Oct 2005 11:23:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964982AbVJUPXO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Oct 2005 11:23:14 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:64740 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S964981AbVJUPXL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Oct 2005 11:23:11 -0400
Subject: Re: Understanding Linux addr space, malloc, and heap
From: Arjan van de Ven <arjan@infradead.org>
To: "Vincent W. Freeh" <vin@csc.ncsu.edu>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <4359051C.2070401@csc.ncsu.edu>
References: <4358F0E3.6050405@csc.ncsu.edu>
	 <1129903396.2786.19.camel@laptopd505.fenrus.org>
	 <4359051C.2070401@csc.ncsu.edu>
Content-Type: text/plain
Date: Fri, 21 Oct 2005 17:22:59 +0200
Message-Id: <1129908179.2786.23.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 2.9 (++)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (2.9 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	2.8 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?80.57.133.107>]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-10-21 at 11:11 -0400, Vincent W. Freeh wrote:
> Arjan van de Ven wrote:
> > On Fri, 2005-10-21 at 09:45 -0400, Vincent W. Freeh wrote:
> > 
> >>Thanks for your quick response.  It basically confirmed that I observed 
> >>what I thought I did.  However, I am no closer to solving my problem.  I 
> >>cannot mprotect data that I malloc beyond the first 65 pages.
> > 
> > 
> > you can't mprotect malloc() memory period ..
> 
> Actually, I can and do.  Simple program at end.

Ok I meant in the "while adhering to the standard" :)


> I call mprotect and it return 0--meaning it succeeded.  But the 
> permissions on the page remain rw.  So it fails to change the 
> permissions, but doesn't give any indication of this.
> 
> Thanks,
> vince.
> 
> ------------------
> #include <stdio.h>
> #include <stdlib.h>
> #include <sys/mman.h>
> #include <unistd.h>
> 
> int main(int argc, char *argv[])
> {
>    void *p;
>    int pgsize = getpagesize();
> 
>    p = malloc(1024);
>    mprotect((void*)((unsigned)p & ~(pgsize-1)), 1024, PROT_NONE);
>    printf("\t*p = %d\n", *(int *)p);
>    return 0;
>}

this has a bug, the 1024 is wrong... what if your "p" point actually
spans 2 pages? 

but to have "some effect" even for malloc-falling-back-to-mmap..
just there's a bunch of collateral damage since you mprotect more than
just the memory you got from malloc. mprotect works on page size.. so if
p spans 2 pages (why wouldn't it ;) you mprotect either the wrong memory
(as in your example) or too much (eg both pages)...


