Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288338AbSA2PaZ>; Tue, 29 Jan 2002 10:30:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289698AbSA2PaH>; Tue, 29 Jan 2002 10:30:07 -0500
Received: from zcamail03.zca.compaq.com ([161.114.32.103]:38148 "EHLO
	zcamail03.zca.compaq.com") by vger.kernel.org with ESMTP
	id <S288338AbSA2P3x> convert rfc822-to-8bit; Tue, 29 Jan 2002 10:29:53 -0500
content-class: urn:content-classes:message
Subject: RE: pagecoloring: kernel 2.2 mm question: what is happening during fork ?
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Date: Tue, 29 Jan 2002 16:27:48 +0100
X-MimeOLE: Produced By Microsoft Exchange V6.0.5762.3
Message-ID: <11EB52F86530894F98FFB1E21F9972540C239D@aeoexc01.emea.cpqcorp.net>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: pagecoloring: kernel 2.2 mm question: what is happening during fork ?
Thread-Index: AcGo0LLn5ZOIkAnDSLmaWVhQaenA/AAA35cg
From: "Cabaniols, Sebastien" <Sebastien.Cabaniols@Compaq.com>
To: "Alan Cox" <alan@lxorguk.ukuu.org.uk>, "Momchil Velikov" <velco@fadata.bg>,
        "Helge Hafting" <helgehaf@aitel.hist.no>
Cc: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 29 Jan 2002 15:27:50.0114 (UTC) FILETIME=[82EEC420:01C1A8D9]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>The page fault handler. When you write to a copy on write page its
actually
>>marked read-only in the hardware. The kernel copies the page marks
both
>>copies writable and fixes up the fault so that user space doesn't see
anything
>>happen.

Thank you very much for this clarification. 

As said in my previous email, I am interested in adding a page coloring 
fonctionnality into the linux kernel.

To do that I just have a get_free_page_by_address routine that is able
to do the same job as get_free_page (except that it takes care about the
physical adress of the page returned)

then I changed:

All calls to get_free_page in mm/filemap.c have been replaced by
get_free_page_by_address

In mm/memory.c:

the do_anonymous_page contains a get_free_page replaced by a
get_free_page_by_address
the do_wp_page contains a get_free_page replaced by a
get_free_page_by_address

This patch is giving very good results on simple fortran processes but
it 
still looks like my patch is bypassed when doing forks. 

I have done a grep get_free_page() into the whole linux kernel code and
I have many 
get_free_page unmodified in the drivers section and in the fs directory
but I think
my user space pure computationnal application do not need that to be
coloured.


When I am using the following code:
===================================

char *a;
int i,n=0;

while(1)

{
	a=malloc(sizeof(char)*8192) /* allocate 10 8k pages (on the
alpha one page = 8k) */
	
	for (i=0;i<81920;i++) a[i]=i*n; /* write to the array to force
it really to allocate*/

	sleep(1<<n); /* sleep to make the process eating very few CPU
and avoid bombing the system with the fork */
	
	fork(); 
	
      n++; /* 
}

and after having insmoded the page coloring module with verbosity at
maximum,I can see only 8 pages 
allocated and coloured by the system and then nothing. The processes are
forked
and eat the memory (doing their job as they should) bypassing my patch
(as if it was not present), 
that's why I suspect another mecanism is used. Am I wrong ?


thanks again for your help.


Sebastien 














