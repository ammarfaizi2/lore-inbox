Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261610AbSIXISz>; Tue, 24 Sep 2002 04:18:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261611AbSIXISz>; Tue, 24 Sep 2002 04:18:55 -0400
Received: from [80.120.128.82] ([80.120.128.82]:33811 "EHLO hofr.at")
	by vger.kernel.org with ESMTP id <S261610AbSIXISy>;
	Tue, 24 Sep 2002 04:18:54 -0400
From: Der Herr Hofrat <der.herr@mail.hofr.at>
Message-Id: <200209240726.g8O7QNA06595@hofr.at>
Subject: mmap question
To: linux-kernel@vger.kernel.org
Date: Tue, 24 Sep 2002 09:26:23 +0200 (CEST)
X-Mailer: ELM [version 2.4ME+ PL60 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi !

 trying to write up a simple mmap for a pseudo device that accesses a 
 kmalloc'ed area.

 The driver is a character driver that only has mmap implemented - the kmalloc
 is done in init module and the pointer to the buffer is in global context.
 I expected to be able to write to the mmap'ed area from user-space but it
 never shows up in kernel space (the printk in driver_mmap always shows the
 init_msg passed in init_module). 

 the basic framework I'm using is below - can anybody point me to an obvious
 error or to some docs that would explain how to share an kmalloc'ed area
 with user-space via mmap ? 

thx !
hofrat
 
---driver---
char *kmalloc_area;
...
static int
driver_mmap(struct file *file,
	struct vm_area_struct *vma)
{
	vma->vm_flags |= VM_LOCKED|VM_SHARED;

	printk("message buffer: %s\",kmalloc_area); 
	remap_page_range(vma->vm_start,
		virt_to_phys(kmalloc_area),
		LEN,
		PAGE_SHARED);
	return 0;
}
	
static struct file_operations simple_fops={
    mmap:	driver_mmap,
};

int
init_module(void){
	...
	kmalloc_area=kmalloc(LEN,GFP_USER);
	strncpy(kmalloc_area,init_msg,sizeof(init_msg));
	...
}

---user-app---

int main(void)
{
	int fd;
	char msg[]="some message - should appear in kernel space";
	unsigned int *addr;

	if((fd=open("/dev/simple-device", O_RDWR))<0)
	addr = mmap(0, LEN, PROT_READ|PROT_WRITE, MAP_SHARED, fd, 0);
	memset(addr,0,LEN); 
	strncpy(addr,msg,sizeof(msg));
	return 0;
}
