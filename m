Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261358AbTH3Ch7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Aug 2003 22:37:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261402AbTH3Ch7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Aug 2003 22:37:59 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:54031 "HELO
	127.0.0.1") by vger.kernel.org with SMTP id S261358AbTH3Ch5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Aug 2003 22:37:57 -0400
Content-Type: text/plain; charset=US-ASCII
From: insecure <insecure@mail.od.ua>
Reply-To: insecure@mail.od.ua
To: "J.A. Magallon" <jamagallon@able.es>,
       Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [2.4] gcc3 warns about type-punned pointers ?
Date: Sat, 30 Aug 2003 05:37:49 +0300
X-Mailer: KMail [version 1.4]
References: <20030828223511.GA23528@werewolf.able.es>
In-Reply-To: <20030828223511.GA23528@werewolf.able.es>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200308300537.49700.insecure@mail.od.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> A collateral question: why is the reason for this function ?
> long long assignments are not atomic in gcc ?

Another question: why do we do _double_ store here?

static inline void __set_64bit (unsigned long long * ptr,
                unsigned int low, unsigned int high)
{
        __asm__ __volatile__ (
                "\n1:\t"
                "movl (%0), %%eax\n\t"
                "movl 4(%0), %%edx\n\t"
                "lock cmpxchg8b (%0)\n\t"
                "jnz 1b"
                : /* no outputs */
                :       "D"(ptr),
                        "b"(low),
                        "c"(high)
                :       "ax","dx","memory");
}

This will execute expensive locked load-compare-store operation twice
almost always (unless previous value was already equal
to the value we are about to store)

AFAIK we can safely drop that loop (jnz instruction)
-- 
vda
