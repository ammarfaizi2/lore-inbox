Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261776AbVC0PNH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261776AbVC0PNH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Mar 2005 10:13:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261785AbVC0PNH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Mar 2005 10:13:07 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:41961 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S261776AbVC0PNA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Mar 2005 10:13:00 -0500
Date: Sun, 27 Mar 2005 17:12:58 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] no need to check for NULL before calling kfree() -fs/ext2/
In-Reply-To: <20050327065655.6474d5d6.pj@engr.sgi.com>
Message-ID: <Pine.LNX.4.61.0503271708350.20909@yvahk01.tjqt.qr>
References: <Pine.LNX.4.62.0503252307010.2498@dragon.hyggekrogen.localhost>
 <Pine.LNX.4.61.0503251726010.6354@chaos.analogic.com>
 <1111825958.6293.28.camel@laptopd505.fenrus.org>
 <Pine.LNX.4.61.0503261811001.9945@chaos.analogic.com>
 <Pine.LNX.4.62.0503270044350.3719@dragon.hyggekrogen.localhost>
 <1111881955.957.11.camel@mindpipe> <Pine.LNX.4.62.0503271246420.2443@dragon.hyggekrogen.localhost>
 <20050327065655.6474d5d6.pj@engr.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Just looking at the third run, it seems to me that "if (likely(p))
>kfree(p);" beats a naked "kfree(p);" everytime, whether p is half
>NULL's, or very few NULL's, or almost all NULL's.

Well, kfree inlined was already mentioned but forgotten again.
What if this was used:

inline static void kfree_WRAP(void *addr) {
    if(likely(addr != NULL)) {
        kfree_real(addr);
    }
    return;
}

And remove the NULL-test in kfree_real()? Then we would have:

  test eax, eax
  jz afterwards;
  <some more stuff for call>
  call kfree_real;
.afterwards:
  <continue execution>

The two cases then:
ptr==NULL: test-jmp
ptr!=NULL: test-call(freeit-return)

Looks like the least expensive way to me.


Jan Engelhardt
-- 
No TOFU for me, please.
