Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267829AbUHWUqy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267829AbUHWUqy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 16:46:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267765AbUHWUpr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 16:45:47 -0400
Received: from zcars04e.nortelnetworks.com ([47.129.242.56]:64462 "EHLO
	zcars04e.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S267792AbUHWUpX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 16:45:23 -0400
Message-ID: <412A5759.7060401@nortelnetworks.com>
Date: Mon, 23 Aug 2004 16:45:13 -0400
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: question on char driver mmap
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I have a need for a device driver to map a page of memory between interrupt 
handlers and userspace.  It's been suggested that I use something like the 
following code (simplified):


unsigned long mypage;

int my_mmap(struct file *filp, struct vm_area_struct *vma)
{
	unsigned long offset = vma->vm_pgoff << PAGE_SHIFT;

	if (offset & ~PAGE_MASK)
		return -ENXIO;

	mypage =  __get_free_page(GFP_KERNEL);
	SetPageReserved(virt_to_page(mypage));
	remap_page_range(vma->vm_start, virt_to_phys((void *) mypage),
	                 PAGE_SIZE, vma->vm_page_prot);
	return 0;
}


This seems to work.  If I do this, however, do I need to hook into the munmap() 
file operations to handle unmapping, clearing the reserved bit, and freeing the 
page, or will the memory subsystem do it for me?

Thanks,

Chris
