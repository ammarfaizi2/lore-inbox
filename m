Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289296AbSA2NhE>; Tue, 29 Jan 2002 08:37:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289313AbSA2Ngo>; Tue, 29 Jan 2002 08:36:44 -0500
Received: from zcamail03.zca.compaq.com ([161.114.32.103]:10513 "EHLO
	zcamail03.zca.compaq.com") by vger.kernel.org with ESMTP
	id <S289308AbSA2Ngf> convert rfc822-to-8bit; Tue, 29 Jan 2002 08:36:35 -0500
content-class: urn:content-classes:message
Subject: pagecoloring: kernel 2.2 mm question: what is happening during fork ?
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Date: Tue, 29 Jan 2002 14:36:24 +0100
X-MimeOLE: Produced By Microsoft Exchange V6.0.5762.3
Message-ID: <11EB52F86530894F98FFB1E21F9972540C239A@aeoexc01.emea.cpqcorp.net>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [OT] Re: Note describing poor dcache utilization under high memory pressure
Thread-Index: AcGovmv+zk3zKRtSQaKNwaUQUyuYTwAAYCRw
From: "Cabaniols, Sebastien" <Sebastien.Cabaniols@Compaq.com>
To: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 29 Jan 2002 13:36:24.0936 (UTC) FILETIME=[F2418E80:01C1A8C9]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello lkml,

I have a few questions about memory management:

When I do a fork, which part of the kernel is allocating the memory for
the childs, where and when the memory copy takes place ? I know that
linux is doing copy on write but I don't know which part of the kernel
is really doing the page allocation when the copy on write understands
that the process really wants to write now. Then the second question is
how is the memory copy done ?


The third and last question is what is the role of the slab allocator ?
When does a process asks for memory from a slab ? Is it used to build
the stack the heap ? 

I have looked many web pages but none of them were clear to me. 

If you have time, my whole problem is described here:

More context:
-------------

I am currently working to add page coloring into the linux kernel
version 2.2.19 (I am using Alpha with big direct mapped L1 so 
page coloring is really necessary to have good stable perfs)

I started from a patch found on the web and it basically just
rewrapps some get_free_page calls to a get_free_page_by_address
routine that checks the virtual address and looks for a page which
is correctly aligned.

To sumup:

All calls to get_free_page in filemap.c have been replaced by
get_free_page_by_address
In memory.c the do_anonymous contains a get_free_page replaced by a
get_free_page_by_address



The patch is really doing nice job on simple cases (fortran monothread
code) but it fails on the following code:

{
	char* a;
	int i,n=0;

	while(1)
	{
	
	  a=malloc(sizeof(char)*1024*8*10); /*reserve ten pages (8k*10)
*/
 
	  for(i=0;i<81920;i++)
		{
		  a[i]=i*n;
		}

	  sleep (1<<n);
	  n++;
	  fork();

	}
}

It simply fails because the page_coloring_code is bypassed when doing
forks... but 
I could not find which part of the linux kernel code is doing the memory
allocations
for the forked processes.


thanks for any help

Sebastien

