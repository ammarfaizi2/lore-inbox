Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292456AbSBUPZX>; Thu, 21 Feb 2002 10:25:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292458AbSBUPZO>; Thu, 21 Feb 2002 10:25:14 -0500
Received: from d12lmsgate.de.ibm.com ([195.212.91.199]:19933 "EHLO
	d12lmsgate.de.ibm.com") by vger.kernel.org with ESMTP
	id <S292456AbSBUPZI>; Thu, 21 Feb 2002 10:25:08 -0500
Subject: Patch: netfilter ipv6
To: linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.4a  July 24, 2000
Message-ID: <OF56179CF1.BE50D71D-ONC1256B67.004B342F@de.ibm.com>
From: "Andreas Herrmann" <AHERRMAN@de.ibm.com>
Date: Thu, 21 Feb 2002 16:26:41 +0100
X-MIMETrack: Serialize by Router on D12ML033/12/M/IBM(Release 5.0.8 |June 18, 2001) at
 21/02/2002 16:26:43
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

enclosed is a patch (against version 2.4.17
of the kernel) for netfilter module ip6_tables.

On an SMP machine (s390 LPAR 4cpus) a page
fault occured when executing "ip6tables -L".

The exception occured in kernel module
ip6_tables (in function get_counters() in
IP6T_ENTRY_ITERATE()).

I found out that the exception goes
back to the memcpy() call in function
translate_table() of ip6_tables.c,
where for each additional cpu a copy
of the entries is generated.

But the entries were copied to the
wrong place. (due to the SMP_ALIGN macro)
(Bad luck :)

Applying the patch, the page
fault didn't occure anymore.


Regards,

Andreas


--- net/ipv6/netfilter/ip6_tables.c~     Wed Oct 31 00:08:12 2001
+++ net/ipv6/netfilter/ip6_tables.c      Wed Feb 20 17:38:18 2002
@@ -906,7 +906,7 @@

     /* And one copy for every other CPU */
     for (i = 1; i < smp_num_cpus; i++) {
-         memcpy(newinfo->entries + SMP_ALIGN(newinfo->size*i),
+         memcpy(newinfo->entries + SMP_ALIGN(newinfo->size)*i,
                 newinfo->entries,
                 SMP_ALIGN(newinfo->size));
     }


--
Linux for eServer Development
Tel :  +49-7031-16-4640
Notes mail :  Andreas Herrmann/GERMANY/IBM@IBMDE
email :  aherrman@de.ibm.com


