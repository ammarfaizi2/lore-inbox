Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266250AbSKLHGB>; Tue, 12 Nov 2002 02:06:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266251AbSKLHGB>; Tue, 12 Nov 2002 02:06:01 -0500
Received: from [61.171.250.108] ([61.171.250.108]:41412 "HELO
	tsunami.cn.solution-soft.com") by vger.kernel.org with SMTP
	id <S266250AbSKLHGA> convert rfc822-to-8bit; Tue, 12 Nov 2002 02:06:00 -0500
Content-Type: text/plain; charset=US-ASCII
From: Zhonghua Dai <zdai@solution-soft.com>
Reply-To: zdai@solution-soft.com
Organization: Solution-soft
To: Der Herr Hofrat <der.herr@mail.hofr.at>, linux-kernel@vger.kernel.org
Subject: Re: mmap question
Date: Tue, 24 Sep 2002 17:37:53 +0800
User-Agent: KMail/1.4.1
References: <200209240726.g8O7QNA06595@hofr.at>
In-Reply-To: <200209240726.g8O7QNA06595@hofr.at>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200209241737.53490.zdai@solution-soft.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 24 September 2002 15:26, Der Herr Hofrat wrote:
> Hi !
>
>  trying to write up a simple mmap for a pseudo device that accesses a
>  kmalloc'ed area.
>
>  The driver is a character driver that only has mmap implemented - the
> kmalloc is done in init module and the pointer to the buffer is in global
> context. I expected to be able to write to the mmap'ed area from user-space
> but it never shows up in kernel space (the printk in driver_mmap always
> shows the init_msg passed in init_module).
>
>  the basic framework I'm using is below - can anybody point me to an
> obvious error or to some docs that would explain how to share an kmalloc'ed
> area with user-space via mmap ?
>
> thx !
> hofrat
>
> ---driver---
> char *kmalloc_area;
> ...
> static int
> driver_mmap(struct file *file,
> 	struct vm_area_struct *vma)
> {
> 	vma->vm_flags |= VM_LOCKED|VM_SHARED;
>
> 	printk("message buffer: %s\",kmalloc_area);
> 	remap_page_range(vma->vm_start,
> 		virt_to_phys(kmalloc_area),
> 		LEN,
> 		PAGE_SHARED);

Before memory can be exported into userspace, the reserved bit must be set. 
Call mem_map_reserve()  prior to remap_page_range().

good luck.


> 	return 0;
> }
>
> static struct file_operations simple_fops={
>     mmap:	driver_mmap,
> };
>
> int
> init_module(void){
> 	...
> 	kmalloc_area=kmalloc(LEN,GFP_USER);
> 	strncpy(kmalloc_area,init_msg,sizeof(init_msg));
> 	...
> }
>
> ---user-app---
>
> int main(void)
> {
> 	int fd;
> 	char msg[]="some message - should appear in kernel space";
> 	unsigned int *addr;
>
> 	if((fd=open("/dev/simple-device", O_RDWR))<0)
> 	addr = mmap(0, LEN, PROT_READ|PROT_WRITE, MAP_SHARED, fd, 0);
> 	memset(addr,0,LEN);
> 	strncpy(addr,msg,sizeof(msg));
> 	return 0;
> }
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

