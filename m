Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263643AbTEDQEx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 May 2003 12:04:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263645AbTEDQEx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 May 2003 12:04:53 -0400
Received: from camus.xss.co.at ([194.152.162.19]:53262 "EHLO camus.xss.co.at")
	by vger.kernel.org with ESMTP id S263643AbTEDQEv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 May 2003 12:04:51 -0400
Message-ID: <3EB53CFE.8090000@xss.co.at>
Date: Sun, 04 May 2003 18:17:02 +0200
From: Andreas Haumer <andreas@xss.co.at>
Organization: xS+S
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030312
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@redhat.com>
CC: linux-kernel@vger.kernel.org, greg@kroah.com
Subject: Re: Linux 2.4.21rc1-ac4
References: <200305031744.h43Hijh07694@devserv.devel.redhat.com>
In-Reply-To: <200305031744.h43Hijh07694@devserv.devel.redhat.com>
X-Enigmail-Version: 0.74.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Alan Cox wrote:
> Linux 2.4.21rc1-ac4
[...]
> o	Merge some of Greg's ibmphp cleanups		(Greg Kroah-Hartmann)
[...]

There are some problems with this merge...

*) It doesn't compile due to several problems in ibmphp_ebda.c
*) create_file_name() was changed to return -1 on failure
   and 0 success, but it has still some return statements
   inside returning NULL on error condition (having several
   exit points in a single function is bad programming style
   anyway, but here we have the worst case, it seems... )

The following patch makes it at least compile and tries to
fix the return-code mess. But IMHO the whole thing should
be cleaned up, so please re-check...

--- linux-2.4.21-rc1-ac4/drivers/hotplug/ibmphp_ebda.c.orig     Sun May  4 11:30:18 2003
+++ linux-2.4.21-rc1-ac4/drivers/hotplug/ibmphp_ebda.c  Sun May  4 18:05:57 2003
@@ -672,7 +672,7 @@

        if (!slot_cur) {
                err ("Structure passed is empty \n");
-               return NULL;
+               return -1;
        }

        slot_num = slot_cur->number;
@@ -708,7 +708,7 @@
        } else if (rio_table_ptr) {
                if (rio_table_ptr->ver_num == 3) {
                        /* if both NULL and we DO have correct RIO table in BIOS */
-                       return NULL;
+                       return -1;
                }
        }
        if (!flag) {
@@ -754,7 +754,7 @@
        struct ebda_hpc_slot *slot_ptr;
        struct bus_info *bus_info_ptr1, *bus_info_ptr2;
        int rc;
-       struct slot *tmp_slot;
+       struct slot *tmp_slot, *slot_cur;
        struct list_head *list;
        char buf[32];

@@ -992,7 +992,7 @@
                slot_cur = list_entry (list, struct slot, ibm_slot_list);
                if(create_file_name (slot_cur, buf)==0)
                {
-                       snprintf (slot_cur->hotplug_slot->name, 30, "%s", );
+                       snprintf (slot_cur->hotplug_slot->name, 30, "%s", buf);
                        pci_hp_register (slot_cur->hotplug_slot);
                }
        }

Regards,

- andreas

-- 
Andreas Haumer                     | mailto:andreas@xss.co.at
*x Software + Systeme              | http://www.xss.co.at/
Karmarschgasse 51/2/20             | Tel: +43-1-6060114-0
A-1100 Vienna, Austria             | Fax: +43-1-6060114-71

