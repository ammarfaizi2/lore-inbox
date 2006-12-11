Return-Path: <linux-kernel-owner+w=401wt.eu-S937178AbWLKQg2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937178AbWLKQg2 (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 11:36:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937168AbWLKQg2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 11:36:28 -0500
Received: from nf-out-0910.google.com ([64.233.182.190]:31721 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S937178AbWLKQg1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 11:36:27 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:reply-to:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding:from;
        b=W1PxJkoWPnfBZWs3KQx33JL3KM35b8TBrsW7jjObfTLt7LuEJZQZSr62ykquZGkBT2psqATvC8EXm+5YGLY8wYyHyBOL8S9Knhj/9g/nYdiP4eSazDlGPEfBkV4V89sexZ1UJrTsVTj5MCct83VHIWOENkijW2WVYzZCpFQc46w=
Message-ID: <457D895D.4010500@innova-card.com>
Date: Mon, 11 Dec 2006 17:37:49 +0100
Reply-To: Franck <vagabon.xyz@gmail.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: jayakumar.lkml@gmail.com
CC: linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: [RFC 2.6.19 1/1] fbdev,mm: hecuba/E-Ink fbdev driver v2
References: <200612111046.kBBAkV8Y029087@localhost.localdomain>
In-Reply-To: <200612111046.kBBAkV8Y029087@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
From: Franck Bui-Huu <vagabon.xyz@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

jayakumar.lkml@gmail.com wrote:
> Hi Geert, James, FBdev, MM folk, 
> 
> Appended is my attempt to support the Hecuba/E-Ink display. I've added
> some code to do deferred IO. This is there in order to hide the latency
> associated with updating the display (500ms to 800ms). The method used
> is to fake a framebuffer in memory. Then use pagefaults followed by delayed
> unmaping and only then do the actual framebuffer update. To explain this 
> better, the usage scenario is like this:
> 
> - userspace app like Xfbdev mmaps framebuffer
> - driver handles and sets up nopage and page_mkwrite handlers
> - app tries to write to mmaped vaddress
> - get pagefault and reaches driver's nopage handler
> - driver's nopage handler finds and returns physical page ( no
>   actual framebuffer )
> - write so get page_mkwrite where we add this page to a list
> - also schedules a workqueue task to be run after a delay
> - app continues writing to that page with no additional cost
> - the workqueue task comes in and unmaps the pages on the list, then 
>   completes the work associated with updating the framebuffer
> - app tries to write to the address (that has now been unmapped)
> - get pagefault and the above sequence occurs again
> 
> The desire is roughly to allow bursty framebuffer writes to occur. 
> Then after some time when hopefully things have gone quiet, we go and 
> really update the framebuffer. For this type of nonvolatile high latency 
> display, the desired image is the final image rather than intermediate 
> stages which is why it's okay to not update for each write that is 
> occuring.
> 
> Please let me know if this looks okay so far and if you have any feedback
> or suggestions. Thanks to peterz for the page_mkwrite/clean suggestions
> that made this possible.
> 

[snip]

> +struct hecubafb_par {
> +	unsigned long dio_addr;
> +	unsigned long cio_addr;
> +	unsigned long c2io_addr;
> +	unsigned char ctl;
> +	atomic_t ref_count;
> +	atomic_t vma_count;

what purpose do these counters deserve ?

> +	struct fb_info *info;
> +	unsigned int irq;
> +	spinlock_t lock;
> +	struct workqueue_struct *wq;
> +	struct work_struct work;
> +	struct list_head pagelist;
> +};
> +

[snip]

> +
> +void hcb_wait_for_ack(struct hecubafb_par *par)
> +{
> +
> +	int timeout;
> +	unsigned char ctl;
> +
> +	timeout=500;
> +	do {
> +		ctl = hcb_get_ctl(par);
> +		if ((ctl & HCB_ACK_BIT)) 
> +			return;
> +		udelay(1);
> +	} while (timeout--);
> +	printk(KERN_ERR "timed out waiting for ack\n");
> +}

When timeout occur this function does not return any error values.
the callers needn't to be warn in this case ?

> +
> +void hcb_wait_for_ack_clear(struct hecubafb_par *par)

[snip]

> +}
> +
> +/* this is to find and return the vmalloc-ed fb pages */
> +static struct page* hecubafb_vm_nopage(struct vm_area_struct *vma, 
> +					unsigned long vaddr, int *type)
> +{
> +	unsigned long offset;
> +	struct page *page;
> +	struct fb_info *info = vma->vm_private_data;
> +
> +	offset = (vaddr - vma->vm_start) + (vma->vm_pgoff << PAGE_SHIFT);
> +	if (offset >= (DPY_W*DPY_H)/8)
> +		return NOPAGE_SIGBUS;
> +
> +	page = vmalloc_to_page(info->screen_base + offset);
> +	if (!page)
> +		return NOPAGE_OOM;
> +
> +	get_page(page);
> +	if (type)
> +		*type = VM_FAULT_MINOR;
> +	return page;
> +}
> +

so page can be accessed by using vma->start virtual address....

> +static int hecubafb_page_mkwrite(struct vm_area_struct *vma, 

[snip]

> +
> +	if (!(videomemory = vmalloc(videomemorysize)))
> +		return retval;

and here the kernel access to the same page by using address returned
by vmalloc which are different from the previous one. So 2 different
addresses map the same physical page. In this case are there any cache
aliasing issues specially for x86 arch ?

thanks

		Franck

