Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261793AbVCVJjK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261793AbVCVJjK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 04:39:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262595AbVCVJjK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 04:39:10 -0500
Received: from post.tau.ac.il ([132.66.16.11]:15283 "EHLO post.tau.ac.il")
	by vger.kernel.org with ESMTP id S261793AbVCVJiw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 04:38:52 -0500
Date: Tue, 22 Mar 2005 11:38:50 +0200 (IST)
From: Hayim Shaul <hayim@post.tau.ac.il>
X-X-Sender: hayim@nova.cs.tau.ac.il
To: yingchao zhou <zhou_ict@yahoo.com.cn>
Cc: linux-kernel@vger.kernel.org
Subject: Re: mmap/munmap bug
In-Reply-To: <20050322084545.88435.qmail@web15304.mail.bjs.yahoo.com>
Message-ID: <Pine.LNX.4.61.0503221121340.15767@nova.cs.tau.ac.il>
References: <20050322084545.88435.qmail@web15304.mail.bjs.yahoo.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1132758464-1739646488-1111484330=:15767"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1132758464-1739646488-1111484330=:15767
Content-Type: TEXT/PLAIN; charset=gb2312; format=flowed
Content-Transfer-Encoding: quoted-printable


The page contains the data part of the skbuff, so I guess it is used by=20
a slab.

Isn't this the idea of mapcount? to keep count of number of mapping to a=20
page, and free the page only when this ref-count reaches zero??


I don't mind the slab being freed and the page not. My application won't=20
access that page until the net-driver allocates a buffer on this page and=
=20
I receive its pointer.
Will this page be used again, if I keep a mapping to it?
I don't see any reasons not to.

On Tue, 22 Mar 2005, yingchao zhou wrote:

> Suppose the page used by slab, and when it was cut
> down, the page probably be freed twice.
> --- Hayim Shaul <hayim@post.tau.ac.il> =B5=C4=D5=FD=CE=C4=A3=BA
>>
>> It certainly is.
>>
>> But doesn't the get_page() supposed to increment the
>> map_count??
>>
>> If so, then the kernel should have crashed every
>> time I mapped/unmapped.
>>
>>
>>
>> On Tue, 22 Mar 2005, yingchao zhou wrote:
>>
>>> The returned page from proc_file_nopage probably
>> used
>>> by other part of kernel or application.
>>> --- Hayim Shaul <hayim@post.tau.ac.il> =B5=C4=D5=FD=CE=C4=A3=BA
>>>>
>>>> Hi all,
>>>>
>>>> I have an unexplained bug with mmap/munmap on
>> 2.6.X.
>>>>
>>>> I'm writing a kernel module that gives super-fast
>>>> access to the network.
>>>> It does so by doing mmap thus avoiding the memcpy
>>>> to/from user.
>>>>
>>>> It works well for some time but then the kernel
>>>> panics with a bad_page
>>>> message (full stack is given below)
>>>>
>>>> What I understand from this message is that an
>>>> unmapped page is being
>>>> unmapped again. The bug usually appears when I
>> unmap
>>>> the area from user
>>>> space.
>>>>
>>>> I don't understand what I am doing wrong. I
>> follow
>>>> the example from
>>>> Linux-device-driver (2nd ed.) and codes I found
>>>> under drivers/.
>>>>
>>>> I also saw that there's a mapping bug in the 2.6
>>>> kernels. I'm not
>>>> convinced yet that this is the case, but if so,
>> is
>>>> there a work around?
>>>>
>>>> relevant parts of the code are given below.
>>>>
>>>> I'd appreciate any input,
>>>>    Hayim.
>>>>
>>>> ************************************88
>>>> The full panic message:
>>>>
>>>> Mar 21 08:48:15 localhost kernel: Bad page state
>> at
>>>> free_hot_cold_page
>>>> (in process 'noa', page c1000100)
>>>> Mar 21 08:48:15 localhost kernel:
>> flags:0x00001014
>>>> mapping:00000000
>>>> mapcount:0 count:0
>>>> Mar 21 08:48:15 localhost kernel: Backtrace:
>>>> Mar 21 08:48:15 localhost kernel:  [<c01329a5>]
>>>> bad_page+0x75/0xb0
>>>> Mar 21 08:48:15 localhost kernel:  [<c013308c>]
>>>> free_hot_cold_page+0x5c/0xd0
>>>> Mar 21 08:48:15 localhost kernel:  [<c013c6fb>]
>>>> zap_pte_range+0x14b/0x270
>>>> Mar 21 08:48:15 localhost kernel:  [<c013c873>]
>>>> zap_pmd_range+0x53/0x70
>>>> Mar 21 08:48:15 localhost kernel:  [<c013c8d3>]
>>>> zap_pud_range+0x43/0x60
>>>> Mar 21 08:48:15 localhost kernel:  [<c013c96e>]
>>>> unmap_page_range+0x7e/0xa0
>>>> Mar 21 08:48:15 localhost kernel:  [<c013ca81>]
>>>> unmap_vmas+0xf1/0x200
>>>> Mar 21 08:48:15 localhost kernel:  [<c0141005>]
>>>> unmap_region+0x75/0xe0
>>>> Mar 21 08:48:15 localhost kernel:  [<c0141303>]
>>>> do_munmap+0x113/0x150
>>>> Mar 21 08:48:15 localhost kernel:  [<c0141384>]
>>>> sys_munmap+0x44/0x70
>>>> Mar 21 08:48:15 localhost kernel:  [<c0102563>]
>>>> syscall_call+0x7/0xb
>>>> Mar 21 08:48:15 localhost kernel: Trying to fix
>> it
>>>> up, but a reboot is
>>>> needed
>>>>
>>>>
>>>
>>
> **********************************************************8
>>>>
>>>>
>>>> static void sniffer_vma_open(struct
>> vm_area_struct
>>>> *vma) {
>>>>      printk("vma_open\n");
>>>> }
>>>>
>>>> static void sniffer_vma_close(struct
>> vm_area_struct
>>>> *vma) {
>>>>      printk("vma_close\n");
>>>> }
>>>>
>>>> static int proc_file_mmap(struct file *filp,
>> struct
>>>> vm_area_struct *vma)
>>>> {
>>>>      /* don.t do anything here: "nopage" will
>> fill
>>>> the holes */
>>>>      vma->vm_ops =3D &sniffer_vm_ops;
>>>>      vma->vm_flags |=3D VM_RESERVED;
>>>>      sniffer_vma_open(vma);
>>>>      return 0;
>>>> }
>>>>
>>>> static struct page *proc_file_nopage(struct
>>>> vm_area_struct *vma,
>>>>                  unsigned long address, int
>> *type)
>>>> {
>>>>      struct page *page =3D NOPAGE_SIGBUS;
>>>>
>>>>      unsigned long physaddr =3D ((address -
>>>> vma->vm_start) >> PAGE_SHIFT) +
>>>> vma->vm_pgoff;
>>>>
>>>>      if (! page_should_be_mapped(my_page_bitmap,
>>>> physaddr))
>>>>          return NOPAGE_SIGBUS;
>>>>
>>>>      page =3D virt_to_page((physaddr <<
>> PAGE_SHIFT));
>>>> //  page =3D virt_to_page(__va(physaddr <<
>>>> PAGE_SHIFT));    // bug in LDD?
>>>>      get_page(page);
>>>>      return page;
>>>>
>>>>                            }
>>>>
>>>> struct vm_operations_struct sniffer_vm_ops =3D {
>>>>      .open   =3D sniffer_vma_open,
>>>>      .close  =3D sniffer_vma_close,
>>>>      .nopage =3D proc_file_nopage,
>>>> };
>>>>
>>>>                             static
>>>> struct file_operations File_Ops_4_Our_Proc_File =3D
>> {
>>>>      .read =3D proc_file_read,
>>>>      .write =3D proc_file_write,
>>>>      .open =3D proc_file_open,
>>>>      .release =3D proc_file_close,
>>>>      .mmap =3D proc_file_mmap,
>>>> };
>>>>
>>>> --
>>>> Kernelnewbies: Help each other learn about the
>> Linux
>>>> kernel.
>>>> Archive:
>>>> http://mail.nl.linux.org/kernelnewbies/
>>>> FAQ:           http://kernelnewbies.org/faq/
>>>>
>>>>
>>>> +++++++++++++++++++++++++++++++++++++++++++
>>>> This Mail Was Scanned By Mail-seCure System
>>>> at the Tel-Aviv University CC.
>>>> -
>>>> To unsubscribe from this list: send the line
>>>> "unsubscribe linux-kernel" in
>>>> the body of a message to
>> majordomo@vger.kernel.org
>>>> More majordomo info at
>>>> http://vger.kernel.org/majordomo-info.html
>>>> Please read the FAQ at  http://www.tux.org/lkml/
>>>>
>>>
>>>
>>
> _________________________________________________________
>>> Do You Yahoo!?
>>> =D7=A2=B2=E1=CA=C0=BD=E7=D2=BB=C1=F7=C6=B7=D6=CA=B5=C4=D1=C5=BB=A2=C3=
=E2=B7=D1=B5=E7=D3=CA
>>>
>>
> http://cn.rd.yahoo.com/mail_cn/tag/1g/*http://cn.mail.yahoo.com/
>>>
>>> +++++++++++++++++++++++++++++++++++++++++++
>>> This Mail Was Scanned By Mail-seCure System
>>> at the Tel-Aviv University CC.
>>>
>
> _________________________________________________________
> Do You Yahoo!?
> =D7=A2=B2=E1=CA=C0=BD=E7=D2=BB=C1=F7=C6=B7=D6=CA=B5=C4=D1=C5=BB=A2=C3=E2=
=B7=D1=B5=E7=D3=CA
> http://cn.rd.yahoo.com/mail_cn/tag/1g/*http://cn.mail.yahoo.com/
>
> +++++++++++++++++++++++++++++++++++++++++++
> This Mail Was Scanned By Mail-seCure System
> at the Tel-Aviv University CC.
>
--1132758464-1739646488-1111484330=:15767--
