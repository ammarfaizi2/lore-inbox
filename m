Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261284AbVBRBiY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261284AbVBRBiY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Feb 2005 20:38:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261282AbVBRBiY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Feb 2005 20:38:24 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.145]:5338 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261254AbVBRBiT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Feb 2005 20:38:19 -0500
Subject: Re: -rc3 leaking NOT BIO [Was: Memory leak in 2.6.11-rc1?]
From: Badari Pulavarty <pbadari@us.ibm.com>
To: Parag Warudkar <kernel-stuff@comcast.net>
Cc: Andrew Morton <akpm@osdl.org>, noel@zhtwn.com, torvalds@osdl.org,
       kas@fi.muni.cz, axboe@suse.de,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200502170800.28012.kernel-stuff@comcast.net>
References: <20050121161959.GO3922@fi.muni.cz>
	 <200502160107.08039.kernel-stuff@comcast.net>
	 <20050216155255.0ffab555.akpm@osdl.org>
	 <200502170800.28012.kernel-stuff@comcast.net>
Content-Type: multipart/mixed; boundary="=-lTidyjOgfzFrZQbr/Jn0"
Organization: 
Message-Id: <1108690714.20053.1692.camel@dyn318077bld.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 17 Feb 2005 17:38:35 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-lTidyjOgfzFrZQbr/Jn0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, 2005-02-17 at 05:00, Parag Warudkar wrote:
> On Wednesday 16 February 2005 06:52 pm, Andrew Morton wrote:
> > So it's probably an ndiswrapper bug?
> Andrew, 
> It looks like it is a kernel bug triggered by NdisWrapper. Without 
> NdisWrapper, and with just 8139too plus some light network activity the 
> size-64 grew from ~ 1100 to 4500 overnight. Is this normal? I will keep it 
> running to see where it goes.
> 
> A question - is it safe to assume it is  a kmalloc based leak? (I am thinking 
> of tracking it down by using kprobes to insert a probe into __kmalloc and 
> record the stack to see what is causing so many allocations.)
> 

Last time I debugged something like this, I ended up adding dump_stack()
in kmem_cache_alloc() for the specific slab.

If you are really interested, you can try to get following jprobe
module working. (need to teach about kmem_cache_t structure to
get it to compile and export kallsyms_lookup_name() symbol etc).

Thanks,
Badari




--=-lTidyjOgfzFrZQbr/Jn0
Content-Disposition: attachment; filename=kmod.c
Content-Type: text/x-c; name=kmod.c; charset=UTF-8
Content-Transfer-Encoding: 7bit

#include <linux/module.h>
#include <linux/kprobes.h>
#include <linux/kallsyms.h>
#include <linux/kdev_t.h>

MODULE_PARM_DESC(kmod, "\n");

int count = 0;
void fastcall inst_kmem_cache_alloc(kmem_cache_t *cachep, int flags)
{
	if (cachep->objsize == 64) {
		if (count++ == 100) {
			dump_stack();
			count = 0;
		}
	}
	jprobe_return();
}
static char *fn_names[] = {
	"kmem_cache_alloc",
};

static struct jprobe kmem_probes[] = {
  {
    .entry = (kprobe_opcode_t *) inst_kmem_cache_alloc,
    .kp.addr=(kprobe_opcode_t *) 0,
  }
};

#define MAX_KMEM_ROUTINE (sizeof(kmem_probes)/sizeof(struct kprobe))

/* installs the probes in the appropriate places */
static int init_kmods(void)
{
	int i;

	for (i = 0; i < MAX_KMEM_ROUTINE; i++) {
		kmem_probes[i].kp.addr = kallsyms_lookup_name(fn_names[i]);
		if (kmem_probes[i].kp.addr) { 
			printk("plant jprobe at name %s %p, handler addr %p\n",
		          fn_names[i], kmem_probes[i].kp.addr, kmem_probes[i].entry);
			register_jprobe(&kmem_probes[i]);
		}
	}
	return 0;
}

static void cleanup_kmods(void)
{
	int i;
	for (i = 0; i < MAX_KMEM_ROUTINE; i++) {
		unregister_jprobe(&kmem_probes[i]);
	}
}

module_init(init_kmods);
module_exit(cleanup_kmods);
MODULE_LICENSE("GPL");

--=-lTidyjOgfzFrZQbr/Jn0--

