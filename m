Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269561AbUHZU24@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269561AbUHZU24 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 16:28:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269518AbUHZUMN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 16:12:13 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:43748 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S269520AbUHZTzF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 15:55:05 -0400
Date: Thu, 26 Aug 2004 21:54:55 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-kernel@vger.kernel.org, gregkh@us.ibm.com
Subject: Re: [2.4 patch][1/6] ibmphp_res.c: fix gcc 3.4 compilation
Message-ID: <20040826195455.GC12772@fs.tum.de>
References: <20040826195133.GB12772@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040826195133.GB12772@fs.tum.de>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I got the following compile error when trying to build 2.4.28-pre2 using 
gcc 3.4:

<--  snip  -->

...
gcc-3.4 -D__KERNEL__ 
-I/home/bunk/linux/kernel-2.4/linux-2.4.28-pre2-full/include -Wall 
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common 
-fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=athlon 
-fno-unit-at-a-time  -D_LINUX 
-I/home/bunk/linux/kernel-2.4/linux-2.4.28-pre2-full/drivers/acpi  
-nostdinc -iwithprefix include -DKBUILD_BASENAME=ibmphp_res  -c -o 
ibmphp_res.o ibmphp_res.c
ibmphp_res.c: In function `ibmphp_rsrc_init':
ibmphp_res.c:45: sorry, unimplemented: inlining failed in call to 
'find_bus_wprev': function body not available
ibmphp_res.c:237: sorry, unimplemented: called from here
ibmphp_res.c:45: sorry, unimplemented: inlining failed in call to 
'find_bus_wprev': function body not available
ibmphp_res.c:261: sorry, unimplemented: called from here
ibmphp_res.c:45: sorry, unimplemented: inlining failed in call to 
'find_bus_wprev': function body not available
ibmphp_res.c:284: sorry, unimplemented: called from here
make[3]: *** [ibmphp_res.o] Error 1
make[3]: Leaving directory `/home/bunk/linux/kernel-2.4/linux-2.4.28-pre2-full/drivers/hotplug'

<--  snip  -->


The patch below fixes this issue by uninlining find_bus_wprev (as done 
in 2.6).


Signed-off-by: Adrian Bunk <bunk@fs.tum.de>

--- linux-2.4.28-pre2-full/drivers/hotplug/ibmphp_res.c.old	2004-08-26 17:09:38.000000000 +0200
+++ linux-2.4.28-pre2-full/drivers/hotplug/ibmphp_res.c	2004-08-26 17:10:16.000000000 +0200
@@ -42,7 +42,7 @@
 static int update_bridge_ranges (struct bus_node **);
 static int add_range (int type, struct range_node *, struct bus_node *);
 static void fix_resources (struct bus_node *);
-static inline struct bus_node *find_bus_wprev (u8, struct bus_node **, u8);
+static struct bus_node *find_bus_wprev (u8, struct bus_node **, u8);
 
 static LIST_HEAD(gbuses);
 LIST_HEAD(ibmphp_res_head);
@@ -1757,7 +1757,7 @@
 	return find_bus_wprev (bus_number, NULL, 0);
 }
 
-static inline struct bus_node *find_bus_wprev (u8 bus_number, struct bus_node **prev, u8 flag)
+static struct bus_node *find_bus_wprev (u8 bus_number, struct bus_node **prev, u8 flag)
 {
 	struct bus_node *bus_cur;
 	struct list_head *tmp;
