Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318941AbSIIWu7>; Mon, 9 Sep 2002 18:50:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318946AbSIIWu7>; Mon, 9 Sep 2002 18:50:59 -0400
Received: from antigonus.hosting.pacbell.net ([216.100.98.13]:33265 "EHLO
	antigonus.hosting.pacbell.net") by vger.kernel.org with ESMTP
	id <S318941AbSIIWu6>; Mon, 9 Sep 2002 18:50:58 -0400
Reply-To: <imran.badr@cavium.com>
From: "Imran Badr" <imran.badr@cavium.com>
To: "'Alan Cox'" <alan@lxorguk.ukuu.org.uk>
Cc: <root@chaos.analogic.com>, "'David S. Miller'" <davem@redhat.com>,
       <phillips@arcor.de>, <linux-kernel@vger.kernel.org>
Subject: RE: Calculating kernel logical address ..
Date: Mon, 9 Sep 2002 15:52:12 -0700
Message-ID: <01b901c25853$8a0f65f0$9e10a8c0@IMRANPC>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook CWS, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <1031608526.29792.77.camel@irongate.swansea.linux.org.uk>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


But the buffer which I am concerned about was allocated my kmalloc() and
mapped to the process space in mmap(). AFAIK, kmalloc'ed buffers are
guaranteed to be mapped.

Here is how I am doing it:

1) Implement mmap method in driver.
2) allocate memory by kmalloc()
3) set reserved bit for all allocated pages.
4) set VM_LOCKED flag on the memory aread. ( vma->flags |= VM_LOCKED; )
5) call remap_page_range() to map physical address of the buffer to the user
space address.

I have posted the complete code in a previous post under the same subject.
Now in ioctl() method, the user gives me the memory address. I know that it
was mmaped by looking at the ioctl code. Now I have to calculate physical
address of the user memory address. I know that it was allocated my kmalloc
so it should be mapped. I am currently accessing the process page tables to
find the kernel logical address so that I could use virt_to_bus() to get bus
address.

adr = user_address;
pgd_offset(current->mm, adr);
if (!pgd_none(*pgd)) {
	pmd = pmd_offset(pgd, adr);
	if (!pmd_none(*pmd)) {
		ptep = pte_offset(pmd, adr);
		pte = *ptep;
		if(pte_present(pte)) {
			kaddr  = (unsigned long) page_address(pte_page(pte));
			kaddr |= (adr & (PAGE_SIZE - 1));
		}
	}
}

One suggestion was to use get_user_pages() after getting appropriate
semaphore but I have learned that this API is fundamentally broken for
architectures with noncoherent caches. Does any body has any solution?

Thanks,
Imran.









-----Original Message-----
From: Alan Cox [mailto:alan@lxorguk.ukuu.org.uk]
Sent: Monday, September 09, 2002 2:55 PM
To: imran.badr@cavium.com
Cc: root@chaos.analogic.com; 'David S. Miller'; phillips@arcor.de;
linux-kernel@vger.kernel.org
Subject: RE: Calculating kernel logical address ..


On Mon, 2002-09-09 at 19:12, Imran Badr wrote:
> But my question here still begging an answer: What would be the portable
way
> to calculate kernel logical address of that user buffer?

Who says it even has one ? Not all user allocated pages are even mapped
into the kernel by default. The kiobuf stuff used in 2.4 will do the job
for 2.4. For 2.5 the API will probably look a little different and be a
fair bit faster


