Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263741AbUCYXsh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Mar 2004 18:48:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263789AbUCYXsh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Mar 2004 18:48:37 -0500
Received: from server2.netdiscount.de ([217.13.198.2]:8329 "EHLO
	server2.netdiscount.de") by vger.kernel.org with ESMTP
	id S263741AbUCYXsR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Mar 2004 18:48:17 -0500
Date: Fri, 26 Mar 2004 00:48:04 +0100
From: Christian Leber <christian@leber.de>
To: linux-kernel@vger.kernel.org
Subject: Problem with remap_page_range/mmap
Message-ID: <20040325234804.GA29507@core.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Accept-Language: de en
X-Location: Europe, Germany, Mannheim
X-Operating-System: Debian GNU/Linux (sid)
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I have a problem with mmaping memory to userspace.

It´s very simple:

addr = __get_free_pages(GFP_KERNEL,0);
int atoll_fops_mmap(struct file *filp, struct vm_area_struct *vma)
{
        vma->vm_flags |= VM_SHM | VM_LOCKED | VM_IO;
	
	if(remap_page_range_A(vma,
		vma->vm_start, addr, 4096,
		vma->vm_page_prot)) {
			printk("remapping send space failed\n");
			return -ENXIO;
	}
        *(unsigned long *)addr = 0x23;
        printk("mmap finished, first bytes: %lx\n",*(unsigned long *)addr);
	return 0;
}
int atoll_fops_release(struct inode *inode,struct file *filp)
{
	printk("release, first bytes: %lx\n",*(unsigned long *)addr);
	return 0;
}

complete code is here:
http://debian.christian-leber.de/mmap_problem/atollinit.txt
or as tar
http://debian.christian-leber.de/mmap_problem.tar.bz2

The stupid little testprogramm:
 ptr=mmap(NULL,4096,PROT_READ|PROT_WRITE,MAP_SHARED,fdopen,0);
 if(ptr==-1) printf("ERROR\n");
 *(ptr) = 0x42;
 printf("%lx\n",*(ptr));


This works as expected with 2.6.3 on IA64
Testprogramm gives out "42"
and in the kernel log:
mmap finished, first bytes: 23
release, first bytes: 42


Now it gets odd:
On a Dual PIII; another one; dual xeon; another one; and a P3 laptop

The testprogramm gives out "ffffffff"
In the kernel log:
mmap finished, first bytes: 23
release, first bytes: 23

So never anything is written to memory.
(it also doesn´t depend on the kernel, i tried several
versions/configurations)


On a Duron (also tried with exact the same kernel from one of the
systems above), the Testprogramm gives correct output, but the kernel
log says:
mmap finished, first bytes: 23
release, first bytes: 23

So also nothing is actually written to the memory.


Is that a bug (can´t imagine) or do I do a really stupid error?



Christian Leber

-- 
  "Omnis enim res, quae dando non deficit, dum habetur et non datur,
   nondum habetur, quomodo habenda est."       (Aurelius Augustinus)
  Translation: <http://gnuhh.org/work/fsf-europe/augustinus.html>
