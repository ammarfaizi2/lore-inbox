Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266454AbUHFD4P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266454AbUHFD4P (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 23:56:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266493AbUHFD4P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 23:56:15 -0400
Received: from fw.osdl.org ([65.172.181.6]:27084 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266454AbUHFD4M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 23:56:12 -0400
Date: Thu, 5 Aug 2004 20:47:16 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: lkml <linux-kernel@vger.kernel.org>
Cc: WHarms@bfs.de
Subject: Re: patch: linux-2.6.4/lib/int_sqrt.c long aware
Message-Id: <20040805204716.38caeb88.rddunlap@osdl.org>
In-Reply-To: <20040805173023.175a77f8.rddunlap@osdl.org>
References: <20040805173023.175a77f8.rddunlap@osdl.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.8a (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

| From: <> (Walter Harms)
| 
| hi list,
| this patch make int_sqrt() handle long properly. i tested it
| on my alpha and i386. also some comparision again an alternativ int_sqrt() code.
| The placement (and using) of 'tmp' is a bit odd but faster (on alpha, no matter on i386).
| 
| happy hacking,
| walter
| 
| ps: i must use c&p so be aware of possible tab->space translations
| 
| 
| --- linux-2.6.4/lib/int_sqrt.c.org	2004-03-21 12:58:55.783035928 +0100
| +++ linux-2.6.4/lib/int_sqrt.c	2004-03-21 13:16:20.999138928 +0100
| @@ -10,22 +10,23 @@
|   */
|  unsigned long int_sqrt(unsigned long x)
|  {
| -	unsigned long op, res, one;
| +	unsigned long op, res, one,tmp;
|  
|  	op = x;
|  	res = 0;
|  
| -	one = 1 << 30;
| +	one = 1UL << (BITS_PER_LONG-2);
|  	while (one > op)
|  		one >>= 2;
|  
|  	while (one != 0) {
| +		tmp=res + one;
|  		if (op >= res + one) {
| -			op = op - (res + one);
| -			res = res +  2 * one;
| +			op = op - tmp;
| +			res = tmp + one;
|  		}
| -		res /= 2;
| -		one /= 4;
| +		res >>= 1;
| +		one >>= 2;
|  	}
|  	return res;
|  }

Hi Walter,

I found a little time to play with this.  I only tested it on
a P4 UP machine (via userspace app).
It does indeed speed up integer sqrt typically by around 3% for me.

--
~Randy
