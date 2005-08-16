Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965119AbVHPFtz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965119AbVHPFtz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Aug 2005 01:49:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965120AbVHPFtz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Aug 2005 01:49:55 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:48068 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S965119AbVHPFtz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Aug 2005 01:49:55 -0400
Subject: Re: [RFC] [PATCH] cache pollution aware __copy_from_user_ll()
From: Arjan van de Ven <arjan@infradead.org>
To: Hiro Yoshioka <hyoshiok@miraclelinux.com>
Cc: lkml.hyoshiok@gmail.com, linux-kernel@vger.kernel.org
In-Reply-To: <20050816.123042.424254477.hyoshiok@miraclelinux.com>
References: <98df96d305081501441bc9b121@mail.gmail.com>
	 <1124096021.3228.20.camel@laptopd505.fenrus.org>
	 <98df96d3050815163331d6cce1@mail.gmail.com>
	 <20050816.123042.424254477.hyoshiok@miraclelinux.com>
Content-Type: text/plain
Date: Tue, 16 Aug 2005 07:49:49 +0200
Message-Id: <1124171390.3215.8.camel@laptopd505.fenrus.org>
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

On Tue, 2005-08-16 at 12:30 +0900, Hiro Yoshioka wrote:

> The following example shows the L3 cache miss is reduced from 37410 to 107.

most impressive; it seems the approach to do this selectively is paying
off very well! 

The only comment/question I have is about the use of prefetchnta; that
might have cache-evicting properties as well (eg evict the cache of the
original of the copy, eg the userspace memory). Is that really the right
approach? 
In addition, my measurements show that removing the prefetch from the
main copy loop is a gain because the modern cpus have an autoprefetcher
already in the hardware.

       "1: prefetchnta (%0)\n"         /* This set is 28 bytes */
+               "   prefetchnta 64(%0)\n"
+               "   prefetchnta 128(%0)\n"
+               "   prefetchnta 192(%0)\n"
+               "   prefetchnta 256(%0)\n"
+               "2:  \n"
+               ".section .fixup, \"ax\"\n"
+               "3: movw $0x1AEB, 1b\n" /* jmp on 26 bytes */
+               "   jmp 2b\n"
+               ".previous\n"

oh and prefetch(nta) is a non-faulting instruction so no need for the
fixup handling...


But overall this is starting to look really interesting!

Greetings,
   Arjan van de Ven

