Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261894AbVCANIM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261894AbVCANIM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Mar 2005 08:08:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261895AbVCANIM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Mar 2005 08:08:12 -0500
Received: from web54610.mail.yahoo.com ([68.142.225.194]:3426 "HELO
	web54610.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261894AbVCANID (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Mar 2005 08:08:03 -0500
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  b=lhFfrKB3mx1DS6zTeFBT5zVW1JSLlek36JqW+c9vSRt/F17UCFnxmVkdgQYdlathNvVVaIJc/2dYAkUluHLcJvSu6UBAaPP0Rwb8btbRgKRS/VMQmCK6RSMV8MRnx0eL3rOc2eVTufcyVL6Dmk2aBMCTAhaf3GQZA/iK7+mXGpo=  ;
Message-ID: <20050301130803.34688.qmail@web54610.mail.yahoo.com>
Date: Tue, 1 Mar 2005 05:08:03 -0800 (PST)
From: Prakash Bhurke <prakash_bhurke@yahoo.com>
Subject: memory mapping of vmalloc
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi ,

  I am facing a problem -- memory mapping of proc
entry into user space using mmap syscall.
  I have written a module which creates a proc entry &
provides read, write, mmap, etc.
  Normal read, write etc file operation works, but
mmap is not working.
  I am trying to map a vmalloc kernel buffer to user
space using remap_page_range(). In my module, this
function returns success if we call mmap() from user
space, but i can not access content of vmalloc buffer
from user space. Pointer returned by mmap() syscall
seems pointing to other memory page which contains
zeros. I am using linux 2.6.10 kernel on Pentium 4
system.

here is code of module_mmap();
static inline unsigned long kvirt_to_pa(unsigned long
adr)
{
	unsigned long kva, ret;

	kva = (unsigned long)
page_address(vmalloc_to_page((void *)adr));
	kva |= adr & (PAGE_SIZE-1); /* restore the offset */
	ret = __pa(kva);
	return ret;
}

static int module_mmap(struct file *file, struct
vm_area_struct *vma)
{
	unsigned long offset = vma->vm_pgoff << PAGE_SHIFT;
	unsigned long len = vma->vm_end - vma->vm_start;
	unsigned long pos = (unsigned long) test_tsc +
offset;

	printk(KERN_INFO "PROCINFO : in mmap started, length
= %ld\n", len);

	if (!tscinfo)
		return -ENODEV;

	if ((offset + len) > PAGE_ALIGN(sizeof(sizeof(struct
test_tsc_info)))))
		return -ENXIO;

	if ((vma->vm_flags & (VM_SHARED|VM_WRITE)) ==
(VM_SHARED|VM_WRITE)) {
		printk("PROCINFO : in mmap attempt to write to
mapping\n");
		return -EPERM;
	}

	vma->vm_flags |= VM_SHM | VM_LOCKED ;

	if (remap_pfn_range(vma, vma->vm_start,
kvirt_to_pa(pos) >> PAGE_SHIFT, \
			     len, vma->vm_page_prot)) {
		printk(KERN_INFO "PROCINFO : in mmap remap_pfn_range
returns error\n");
		return -EAGAIN;
	}

	printk(KERN_INFO "PROCINFO : in mmap ret 0 end\n");

	return 0;
}

>From user space program i mapping kernel memory like
this
proc_fd = open("/proc/"PROC_ENTRY_FILENAME, O_RDONLY);
mem_base = mmap(NULL, sizeof(struct test_tsc_info),
PROT_READ, MAP_SHARED, proc_fd, 0);

Please let me know what wrong thing i m doing.

Regards,
Prakash.



		
__________________________________ 
Do you Yahoo!? 
Yahoo! Sports - Sign up for Fantasy Baseball. 
http://baseball.fantasysports.yahoo.com/
