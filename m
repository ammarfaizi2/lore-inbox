Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265142AbUELSAv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265142AbUELSAv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 May 2004 14:00:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265141AbUELSAv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 May 2004 14:00:51 -0400
Received: from fw.osdl.org ([65.172.181.6]:58563 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265142AbUELSAP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 May 2004 14:00:15 -0400
Date: Wed, 12 May 2004 10:59:24 -0700
From: Stephen Hemminger <shemminger@osdl.org>
To: David Mosberger-Tang <davidm@hpl.hp.com>
Cc: linux-ia64@linuxia64.org, linux-kernel@vger.kernel.org
Subject: GCC nested functions?
Message-Id: <20040512105924.54a8211b@dell_ss3.pdx.osdl.net>
Organization: Open Source Development Lab
X-Mailer: Sylpheed version 0.9.10claws (GTK+ 1.2.10; i386-redhat-linux-gnu)
X-Face: &@E+xe?c%:&e4D{>f1O<&U>2qwRREG5!}7R4;D<"NO^UI2mJ[eEOA2*3>(`Th.yP,VDPo9$
 /`~cw![cmj~~jWe?AHY7D1S+\}5brN0k*NE?pPh_'_d>6;XGG[\KDRViCfumZT3@[
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I used GCC nested functions in the (not released) bridge sysfs interface for 2.6.6.
It seemed like a nice way to express the sysfs related interface without doing
lots of code copying (or worse lots of macros).

The code in question looks like:
static ssize_t store_bridge_parm(struct class_device *cd,
                                 const char *buf, size_t len,
                                 void (*store)(struct net_bridge *, unsigned long))
{
        struct net_bridge *br = to_bridge(cd);
        char *endp;
        unsigned long val;
                                                                                
        if (!capable(CAP_NET_ADMIN))
                return -EPERM;
                                                                                
        val = simple_strtoul(buf, &endp, 0);
        if (endp == buf)
                return -EINVAL;
                                                                                
        spin_lock_bh(&br->lock);
        store(br, val);
        spin_unlock_bh(&br->lock);
        return len;
}
...

static ssize_t store_forward_delay(struct class_device *cd, const char *buf,
                                   size_t len)
{
        void store(struct net_bridge *br, unsigned long val)
        {
                unsigned long delay = clock_t_to_jiffies(val);
                br->forward_delay = delay;
                if (br_is_root_bridge(br))
                        br->bridge_forward_delay = delay;
        }
                                                                                
        return store_bridge_parm(cd, buf, len, store);
}


This works fine for GCC 2.95 and 3.X for i386 and x86_64 architectures, but the ia64
(cross compiler) pukes with:

 In function `store_forward_delay':
: undefined reference to `__ia64_trampoline'

Redoing it as separate functions is easy enough, but the questions are:
	- Are gcc nested functions allowed in the kernel?  If not where should
	  this restriction be put in Documentation? CodingStyles?
	- Or is gcc on ia64 just too stupid? or do some more support routines
	  need to exist in arch/ia64?
	- Do other architectures (sparc, ppc) have similar problems?

Thanks.



