Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261569AbVC2Wbx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261569AbVC2Wbx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 17:31:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261588AbVC2Wbx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 17:31:53 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:62855 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S261569AbVC2W3i
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 17:29:38 -0500
Message-ID: <4249D6D0.9080300@us.ibm.com>
Date: Tue, 29 Mar 2005 14:29:36 -0800
From: Hien Nguyen <hien@us.ibm.com>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041127)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH 2.6.12-rc1-mm3] [2/2] kprobes += function-return probes -
 example: probing arbitrary functions
Content-Type: multipart/mixed;
 boundary="------------000501040909010706000604"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000501040909010706000604
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Also include here is a test module

The testrprobe.ko is a generic test module. One could use this module to 
insert an exit probe to any function in the kernel.
For example :
insmod test_rprobe.ko <entryaddr=address for func entry>
or use the included loadtestrprobe.sh script
./loadtestrprobe.sh <function name>

One good example is to see what kind of page fault is encountered
./loadtestrprobe.sh handle_mm_fault

Signed-off-by: hien Nguyen <hien@us.ibm.com>

--------------000501040909010706000604
Content-Type: text/x-csrc;
 name="testrprobe.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="testrprobe.c"

#include <linux/module.h>
#include <linux/kprobes.h>

static unsigned long entryaddr;
module_param(entryaddr, ulong, 0);
MODULE_PARM_DESC(addr,
		 "\nfunction entry address.\n");

int inst_test_erprobe (void)
{
	jprobe_return();
	return 0;
}


int rp_handler(struct retprobe_instance *ri, struct pt_regs *regs)
{
	printk("rprobe handler: p->addr=0x%p, ret=0x%lx\n", ri->rp->kprobe->addr, regs->eax);
	return 0;
}
	
static struct jprobe jp = {
	.entry = (kprobe_opcode_t *) inst_test_erprobe,
};


static struct retprobe rp = {
	.handler = rp_handler,
	.maxactive = 1,
	.nmissed = 0
};


static int init_testrp(void)
{
  if (entryaddr == 0 ) {
    printk("Need to input an function entry address as parameter.\n");
    return -EINVAL;
  }
  jp.kp.addr = (kprobe_opcode_t *) entryaddr;

  register_jretprobe(&jp, &rp);
  printk("exit probe init: instrumentation is enabled...\n");
  return 0;
}

static void cleanup_testrp(void)
{
  unregister_jprobe(&jp);
  printk("exit probe cleanup.\n");
}

module_init(init_testrp);
module_exit(cleanup_testrp);
MODULE_LICENSE("GPL");


--------------000501040909010706000604
Content-Type: application/x-shellscript;
 name="loadtestrprobe.sh"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="loadtestrprobe.sh"

IyEvYmluL3NoCnBhZGRyPWBjYXQgL3Byb2Mva2FsbHN5bXMgfCBncmVwICIgJHsxfSQiIHwg
YXdrICd7cHJpbnQgJDF9J2AKaWYgWyAiJHtwYWRkcn1YIiA9ICJYIiBdOyB0aGVuCgllY2hv
ICJDYW50IHJlc29sdmUgYWRkcmVzcyBmb3IgJHsxfSIKCWV4aXQgMQpmaQppbnNtb2QgdGVz
dHJwcm9iZS5rbyBlbnRyeWFkZHI9MHgke3BhZGRyfQo=
--------------000501040909010706000604--
