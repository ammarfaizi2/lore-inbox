Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273920AbRIXOC1>; Mon, 24 Sep 2001 10:02:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273918AbRIXOCR>; Mon, 24 Sep 2001 10:02:17 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:61708 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S273920AbRIXOCC> convert rfc822-to-8bit; Mon, 24 Sep 2001 10:02:02 -0400
Date: Mon, 24 Sep 2001 09:38:24 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Paul Larson <plars@austin.ibm.com>,
        Linus Torvalds <torvalds@transmeta.com>
Cc: =?ISO-8859-1?Q?Christian_Borntr=E4ger?= 
	<linux-kernel@borntraeger.net>,
        =?ISO-8859-1?Q?Jacek_=5Biso-8859-2=5D_Pop=B3awski?= 
	<jpopl@interia.pl>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: __alloc_pages: 0-order allocation failed
In-Reply-To: <1001319223.4613.34.camel@plars.austin.ibm.com>
Message-ID: <Pine.LNX.4.21.0109240933390.1593-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 24 Sep 2001, Paul Larson wrote:

> On 24 Sep 2001 08:12:20 -0300, Marcelo Tosatti wrote:
> > 
> > 
> > On Mon, 24 Sep 2001, Jacek [iso-8859-2] Pop³awski wrote:
> > 
> > > I just installed 2.4.10, and...
> > > 
> > > __alloc_pages: 0-order allocation failed (gfp=0x1d2/0) from c0126c2e
> > > __alloc_pages: 0-order allocation failed (gfp=0x1d2/0) from c0126c2e
> > > __alloc_pages: 0-order allocation failed (gfp=0x1d2/0) from c0126c2e
> > > VM: killing process donkey_s
> ...
> 
> I'm getting a lot of this with 2.4.10 also.  At the time, I had KDM
> running, but I was coming into the box over telnet and running the
> latest released version of LTP.  The test it appeared to be on at the
> time was a filesystem test called growfiles.  Nothing else was running
> other than these things and standard system services.  The machine has
> 256 MB of ram, and 512 MB swap.  The order that things got killed in
> were sadc, sar, kdm, X, in.telnetd, xinetd (ouch).
> 
> 
> __alloc_pages: 0-order allocation failed (gfp=0xf0/0) from c012b9b2
> __alloc_pages: 0-order allocation failed (gfp=0x1d2/0) from c012b9b2
> VM: killing process xinetd
> __alloc_pages: 0-order allocation failed (gfp=0x1d2/0) from c012b9b2
> __alloc_pages: 0-order allocation failed (gfp=0x1d2/0) from c012b9b2
> __alloc_pages: 0-order allocation failed (gfp=0x1d2/0) from c012b9b2

For the people having the allocation failure problems, please try the
following patch. 

Currently the page freeing success accounting is completly broken (it does
not report a task has made progress while it did), and the page allocation
code uses that information to know if it should or not try to keep calling
the freeing code.

Please test this. 

--- linux.orig/mm/vmscan.c	Mon Sep 24 10:36:40 2001
+++ linux/mm/vmscan.c	Mon Sep 24 10:54:01 2001
@@ -567,6 +567,9 @@
 		if (nr_pages <= 0)
 			return 1;
 
+		if (nr_pages < SWAP_CLUSTER_MAX)
+			ret |= 1;
+
 		ret |= swap_out(priority, classzone, gfp_mask, SWAP_CLUSTER_MAX << 2);
 	} while (--priority);
 
--- linux.orig/mm/page_alloc.c	Mon Sep 24 10:36:40 2001
+++ linux/mm/page_alloc.c	Mon Sep 24 10:44:12 2001
@@ -400,7 +400,7 @@
 			if (!z)
 				break;
 
-			if (zone_free_pages(z, order) > z->pages_high) {
+			if (zone_free_pages(z, order) > z->pages_min) {
 				page = rmqueue(z, order);
 				if (page)
 					return page;

