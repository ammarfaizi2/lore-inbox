Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262878AbVA2IKq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262878AbVA2IKq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jan 2005 03:10:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262879AbVA2IKq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jan 2005 03:10:46 -0500
Received: from canuck.infradead.org ([205.233.218.70]:2063 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S262878AbVA2IKb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jan 2005 03:10:31 -0500
Subject: Re: Patch 4/6  randomize the stack pointer
From: Arjan van de Ven <arjan@infradead.org>
To: John Richard Moser <nigelenki@comcast.net>
Cc: Rik van Riel <riel@redhat.com>, linux-kernel@vger.kernel.org,
       akpm@osdl.org
In-Reply-To: <41FB2DD2.1070405@comcast.net>
References: <20050127101117.GA9760@infradead.org>
	 <20050127101322.GE9760@infradead.org>  <41F92721.1030903@comcast.net>
	 <1106848051.5624.110.camel@laptopd505.fenrus.org>
	 <41F92D2B.4090302@comcast.net>
	 <Pine.LNX.4.58.0501271010130.2362@ppc970.osdl.org>
	 <41F95F79.6080904@comcast.net>
	 <1106862801.5624.145.camel@laptopd505.fenrus.org>
	 <41F96C7D.9000506@comcast.net>
	 <Pine.LNX.4.61.0501282147090.19494@chimarrao.boston.redhat.com>
	 <41FB2DD2.1070405@comcast.net>
Content-Type: text/plain
Date: Sat, 29 Jan 2005 09:10:23 +0100
Message-Id: <1106986224.4174.65.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 4.1 (++++)
X-Spam-Report: SpamAssassin version 2.63 on canuck.infradead.org summary:
	Content analysis details:   (4.1 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.3 RCVD_NUMERIC_HELO      Received: contains a numeric HELO
	1.1 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?80.57.133.107>]
	2.5 RCVD_IN_DYNABLOCK      RBL: Sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	0.1 RCVD_IN_SORBS          RBL: SORBS: sender is listed in SORBS
	[80.57.133.107 listed in dnsbl.sorbs.net]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I actually just tried to paxtest a fresh Fedora Core 3, unadultered,
> that I installed, and it FAILED every test.  After a while, spender
> reminded me about PT_GNU_STACK.  It failed everything but the Executable
> Stack test after execstack -c *.  The randomization tests gave
> 13(heap-etexec), 16(heap-etdyn), 17(stack), and none for main exec
> (etexec,et_dyn) or shared library randomization.

because you ran prelink.
and you did not compile paxtest with -fPIE -pie to make it a PIE
executable.

> 
> Also, before you say it, I read, comprehended, and anylized the source.
>  This was PaXtest 0.9.6, and I did specific traces (after changing
> body.c to prevent it from forking) to look for mprotect() and mmap()
> calls and find out what they do (I saw probably glibc getting mmap()ed
> in, there wasn't anything in the source doing the mmap() calls I saw).
> There were no dirty tricks to mprotect() a high area of memory, which is
> something Ingo called foul on in 0.9.5.

there is one actually if you look careful enough.


> 
> if (strlen(a) > 4)
>   a[5] = '\0';
> foo(a);
> 
> void foo(char *a) {
>    char b[5];
>    strcpy(b,a);
> }
> 
> This code is safe, but you can't tell from looking at foo().  You don't
> get a look at every other object being compiled against this one that
> may call foo() either.  So compile time buffer overflow detection is a
> best-effort at best.

actually this one gets caught, since this will be turned into a checking
strcpy which aborts after the 5th character.


