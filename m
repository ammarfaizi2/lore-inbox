Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267126AbSKMHdO>; Wed, 13 Nov 2002 02:33:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267127AbSKMHdO>; Wed, 13 Nov 2002 02:33:14 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.105]:56561 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S267126AbSKMHdM>;
	Wed, 13 Nov 2002 02:33:12 -0500
Date: Wed, 13 Nov 2002 13:24:21 +0530
From: "Vamsi Krishna S ." <vamsi@in.ibm.com>
To: Rusty Lynch <rusty@linux.co.intel.com>
Cc: rddunlap@osdl.org, linux-kernel@vger.kernel.org,
       dprobes <dprobes@www-124.southbury.usf.ibm.com>,
       richard <richardj_moore@uk.ibm.com>, tom <hanrahat@us.ibm.com>
Subject: Re: [PATCH]kprobes sample driver
Message-ID: <20021113132421.A3171@in.ibm.com>
Reply-To: vamsi@in.ibm.com
References: <200211130518.gAD5ILf12898@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200211130518.gAD5ILf12898@linux.intel.com>; from rusty@linux.co.intel.com on Tue, Nov 12, 2002 at 09:18:21PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is very nice. In fact, I will probably start using this for
testing kprobes myself. I have a few comments, given below inline.

Thank you,
Vamsi.

PS: I am cc'ing dprobes mailing list for folks who hang out there
to have a chance to take a look at this and may be comment/use. 
Hope you don't mind.
-- 
Vamsi Krishna S.
Linux Technology Center,
IBM Software Lab, Bangalore.
Ph: +91 80 5044959
Internet: vamsi@in.ibm.com

On Tue, Nov 12, 2002 at 09:18:21PM -0800, Rusty Lynch wrote:
> This is a sample kprobes module that implements a simple misc char device
> that can cause arbitrary text to be printk'ed when arbitrary kernel
> addresses are executed.
> 
Nice idea.

> +static struct list_head probe_list;
> +struct nprobe {
> +	struct list_head list;
> +	struct kprobe probe;
> +	char message[MAX_MSG_SIZE + 1];
> +};
> +
Good. This is how I meant struct kprobe to be used: as a part of
a bigger structure that the caller uses to manage probes.

> +static void noisy_pre_handler(struct kprobe *p, struct pt_regs *r)
> +{
> +	struct list_head *tmp;
> +
> +	printk(KERN_CRIT "noisy: noisy_prehandler\n");
> +	list_for_each(tmp, &probe_list) {
> +		struct nprobe *c = list_entry(tmp, struct nprobe, list);
> +		if (&(c->probe) == p) {
> +			printk(KERN_CRIT "%s\n", c->message);
> +		}
> +	}
> +}
Actually, you can do this in a much easier way without having to
loop through all probes. All you need is:

static void noisy_pre_handler(struct kprobe *p, struct pt_regs *r)
{
	struct nprobe *c = container_of(p, struct nprobe, probe);
	printk(KERN_CRIT "%s: %s\n", __FUNCTION__, c->message);
}

> +static ssize_t noisy_read(struct file *file, char *buf,
> +			size_t count, loff_t *ppos)
> +{	
> +	struct list_head *tmp;
> +
> +	printk(KERN_CRIT "noisy: noisy_read\n");	
> +	list_for_each(tmp, &probe_list) {
> +		struct nprobe *p = list_entry(tmp, struct nprobe, list);

You could have used list_for_each_entry as:

	struct nprobe *p;

	list_for_each_entry(p, &probe_list, list) {
		...
	}

> +static ssize_t noisy_write(struct file *file, const char *buf, size_t count, 
> +			   loff_t *ppos)
> +{
> +	struct nprobe *n = 0;
> +	size_t ret = -ENOMEM;
> +	char *tmp = 0;
> +
> +	printk(KERN_CRIT "noisy: noisy_write\n");
> +	if (count > MAX_MSG_SIZE) {
> +		printk(KERN_CRIT 
> +		       "noisy: Input buffer (%i bytes) is too big!\n",
> +		       count);
> +		ret = -EINVAL;
> +		goto out;
> +	}
> +
> +	tmp = (char *)kmalloc(count + 1, GFP_KERNEL);

Don't bother casting the return values from kmalloc. It is not needed.
Same for all other kmalloc calls here.

> +	if (!tmp) {
> +		ret = -ENOMEM;
> +		goto out;
> +	}
> +
> +	n = (struct nprobe *)kmalloc(sizeof(struct nprobe), GFP_KERNEL);
> +	if (!n) {
> +		ret = -ENOMEM;
> +		goto out;
> +	}
> +	memset(n, '\0', sizeof(struct nprobe));
> +	
> +	if (copy_from_user((void *)tmp, (void *)buf, count)) {
> +		ret = -ENOMEM;
> +		goto out;
> +	} 
> +	tmp[count] = '\0';
> +
> +	n = (struct nprobe *)kmalloc(sizeof(struct nprobe), GFP_KERNEL);

This is a duplicate call, kill it. You have already alloc'ed n above.

> +	if (!n) {
> +		ret = -ENOMEM;
> +		goto out;
> +	}
> +
> +	if (2 != sscanf(tmp, "0x%x %s", &(n->probe).addr, n->message)) {
> +		ret = -EINVAL;
> +		goto out;
> +	}
> +	(n->probe).pre_handler = noisy_pre_handler;
> +	(n->probe).post_handler = noisy_post_handler;
> +	(n->probe).fault_handler = noisy_fault_handler;
> +
> +	{
> +		/* 
> +		 * I am attempting to verify that the kernel-mode address
> +		 * passed in is valid, but I suspect this is not the
> +		 * right way of doing this.
> +		 *
> +		 * Although, it appears to work.  I can attempt to setup 
> +		 * a probe for 0xfffffff0, and the write operation fails with 
> +		 * -EINVAL. 
> +		 */
> +		unsigned short eip;
> +		if (__get_user(eip, (unsigned short *)(n->probe).addr)) {
> +			ret = -EINVAL;
> +			goto out;
> +		}
> +	}
This is not quite right. I will reply to your other post on how to
improve this check.
> +
> +	if (register_kprobe(&(n->probe))) {
> +		printk(KERN_CRIT "Unable to register probe at %p\n", 
> +		       (n->probe).addr);
> +		if (n)
> +			kfree(n);

kfree(NULL) is valid. No need for if (n). Same comment for kfree(tmp);
