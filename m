Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129092AbQKHXiq>; Wed, 8 Nov 2000 18:38:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129147AbQKHXig>; Wed, 8 Nov 2000 18:38:36 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:52745 "EHLO
	havoc.gtf.org") by vger.kernel.org with ESMTP id <S129092AbQKHXiV>;
	Wed, 8 Nov 2000 18:38:21 -0500
Message-ID: <3A09E3E5.7A8EB9DB@mandrakesoft.com>
Date: Wed, 08 Nov 2000 18:38:13 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test11 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.0test11pre1ac1
In-Reply-To: <E13teE4-0000XI-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

the network driver changes look ok except for:
epic100:
* CARDBUS is never defined.  Should that be CONFIG_CARDBUS?
* just increment the version number.  There's no need to add "a" on the
end...  this version number just differentiates us from the 'canonical'
Donald Becker version of epic100.c.


net/atm/pvc:  return the error value from sock_register, not toss it
away.


ramfs comments:
* Hang on to the ramfs changes for a day or two, there is kmap cleanup
(now returns void*) going to Linus RSN.
* Does ramfs_statfs() need that sb lock in it?  Sure free_pages/inodes
might be getting updated on some other CPU, but its statfs so who
cares...
* the default ramfs maxsize, half of all RAM, seems a little
conservative.
* there is no need to kmalloc a private superblock structure, when room
is already allocated inside the superblock structure for private data. 
(sb->u)
* 


I wonder if we really need removepage added to struct address_space? 
That's one API change we shouldn't throw in without discussion, IMHO...
it screams "ramfs-specific hack in core code!"
 void __remove_inode_page(struct page *page)
 {
+       struct address_space *mapping = page->mapping;
+
+       if (mapping && mapping->a_ops && mapping->a_ops->removepage)
+               mapping->a_ops->removepage(page);
+


And finally, don't you need to EXPORT_SYMBOL pm_devs_lock ?



-- 
Jeff Garzik             |
Building 1024           | Would you like a Twinkie?
MandrakeSoft            |
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
