Return-Path: <linux-kernel-owner+w=401wt.eu-S937355AbWLKRNT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937355AbWLKRNT (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 12:13:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937365AbWLKRNT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 12:13:19 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:44473 "EHLO omx2.sgi.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S937355AbWLKRNS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 12:13:18 -0500
Date: Mon, 11 Dec 2006 09:13:11 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: Andrew Morton <akpm@osdl.org>
cc: Paul Jackson <pj@sgi.com>, Jay Cliburn <jacliburn@bellsouth.net>,
       linux-kernel@vger.kernel.org
Subject: Re: [BUG] commit 3c517a61, slab: better fallback allocation behavior
In-Reply-To: <20061210141435.afac089d.akpm@osdl.org>
Message-ID: <Pine.LNX.4.64.0612110855380.500@schroedinger.engr.sgi.com>
References: <457C64C5.9030108@bellsouth.net> <20061210124907.60c4a0aa.pj@sgi.com>
 <20061210141435.afac089d.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 10 Dec 2006, Andrew Morton wrote:

> > I fixed the cpuset_zone_allowed() call from fallback_alloc() to avoid
> > sleeping.  Notice the __GFP_HARDWALL added in Linus's version, or the
> > new function cpuset_zone_allowed_hardwall() in Andrew's version, all
> > done in the last week.
> > 
> > But apparently kmem_getpages() can also sleep, as it calls __alloc_pages().

Yes fallback_alloc calls kmem_getpages() and if one does not set the gfp 
flags properly __alloc_pages will sleep. fallback_alloc() uses the passed 
flags so if kmem_cache_alloc is called with the proper flags set then 
__alloc_pages() will not sleep.

In this case kmem_cache_alloc() is called from 
journal_alloc_journal_head() with GFP_NOFS set which is 

#define GFP_NOFS        (__GFP_WAIT | __GFP_IO)

__GFP_WAIT means

#define __GFP_WAIT      ((__force gfp_t)0x10u)  /* Can wait and reschedule? */

Thus the caller allows __alloc_pages to sleep.


/*
 * journal_head splicing and dicing
 */
static struct journal_head *journal_alloc_journal_head(void)
{
        struct journal_head *ret;
        static unsigned long last_warning;

#ifdef CONFIG_JBD_DEBUG
        atomic_inc(&nr_journal_heads);
#endif
        ret = kmem_cache_alloc(journal_head_cache, GFP_NOFS);
        if (ret == 0) {
                jbd_debug(1, "out of memory for journal_head\n");
                if (time_after(jiffies, last_warning + 5*HZ)) {
                        printk(KERN_NOTICE "ENOMEM in %s, retrying.\n",
                               __FUNCTION__);
                        last_warning = jiffies;
                }
                while (ret == 0) {
                        yield();
                        ret = kmem_cache_alloc(journal_head_cache, 
GFP_NOFS);
                }
        }
        return ret;
}

