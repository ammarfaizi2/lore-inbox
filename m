Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932124AbVHOHQm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932124AbVHOHQm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Aug 2005 03:16:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932136AbVHOHQl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Aug 2005 03:16:41 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:38887 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932124AbVHOHQl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Aug 2005 03:16:41 -0400
Subject: Re: [RFC] [PATCH] cache pollution aware __copy_from_user_ll()
From: Arjan van de Ven <arjan@infradead.org>
To: hyoshiok@miraclelinux.com
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <98df96d30508142343407b4d61@mail.gmail.com>
References: <98df96d305081402164ce52f8@mail.gmail.com>
	 <1124012489.3222.13.camel@laptopd505.fenrus.org>
	 <98df96d305081403222e75b232@mail.gmail.com>
	 <1124015743.3222.17.camel@laptopd505.fenrus.org>
	 <98df96d30508142343407b4d61@mail.gmail.com>
Content-Type: text/plain
Date: Mon, 15 Aug 2005 09:16:30 +0200
Message-Id: <1124090190.3228.3.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
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


> Anyway we could not find the cache aware version of __copy_from_user_ll
> has a big regression yet.


that is because you spread the cache misses out from one place to all
over the place, so that no one single point sticks out anymore.

Do you agree that your copy is less optimal for the case where the
kernel will (almost) immediately use the data? 

I agree that your copy is really nice for places where the kernel will
NOT use the data in the cpu, say for big write() system calls.

My suggestion is to realize there are basically 2 different use cases,
and that in the code the first one is very common, while in your
profiles the second one is very common. Based on that I suggest to make
a special copy_from_user_nocache() API for the cases where the kernel
will not use the data (and ignore software raid5 here) and use your
excellent version for that API, while leaving the code for the cases
where the kernel WILL use the data alone. Code wise the "will use" case
is the vast majority, so only changing the few places that know they
don't use the data will be very efficient, and will give immediate big
improvement in your profile data, since those few places tend to get
used a lot in the cases you benchmark.


