Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262524AbVF2LDG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262524AbVF2LDG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Jun 2005 07:03:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262525AbVF2LDG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Jun 2005 07:03:06 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:54166 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S262524AbVF2LDA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Jun 2005 07:03:00 -0400
From: Denis Vlasenko <vda@ilport.com.ua>
To: linux-kernel@vger.kernel.org
Subject: kmalloc without GFP_xxx?
Date: Wed, 29 Jun 2005 14:02:18 +0300
User-Agent: KMail/1.5.4
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506291402.18064.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

As anybody knows here, one needs to be careful with GFP_xxx
flags. I've no doubts it's important to get it right in fs
and elsewhere in critical places or else nasty things will happen.

However, for driver code it seems like questionaire
"do you remember which network callback is atomic?".

It struck me that kernel actually can figure out whether it's okay
to sleep or not by looking at combination of (flags & __GFP_WAIT)
and ((in_atomic() || irqs_disabled()) as it already does this for
might_sleep() barfing:

kmalloc => __cache_alloc =>

static inline void
cache_alloc_debugcheck_before(kmem_cache_t *cachep, unsigned int __nocast flags)
{
        might_sleep_if(flags & __GFP_WAIT);
#if DEBUG
        kmem_flagcheck(cachep, flags);
#endif
}

	and

void __might_sleep(char *file, int line)
{
#if defined(in_atomic)
        static unsigned long prev_jiffy;        /* ratelimiting */

        if ((in_atomic() || irqs_disabled()) &&
            system_state == SYSTEM_RUNNING && !oops_in_progress) {
                if (time_before(jiffies, prev_jiffy + HZ) && prev_jiffy)
                        return;
                prev_jiffy = jiffies;
                printk(KERN_ERR "Debug: sleeping function called from invalid"
                                " context at %s:%d\n", file, line);
                printk("in_atomic():%d, irqs_disabled():%d\n",
                        in_atomic(), irqs_disabled());
                dump_stack();
        }
#endif
}

So why can't we have kmalloc_auto(size) which does GFP_KERNEL alloc
if called from non-atomic context and GFP_ATOMIC one otherwise?
--
vda

