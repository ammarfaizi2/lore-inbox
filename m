Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292272AbSBBNLU>; Sat, 2 Feb 2002 08:11:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292273AbSBBNLL>; Sat, 2 Feb 2002 08:11:11 -0500
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:15631 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S292272AbSBBNKw>; Sat, 2 Feb 2002 08:10:52 -0500
Message-Id: <200202021309.g12D9Jt01617@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=US-ASCII
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: "Buddy Lumpkin" <blumpkin@attbi.com>
Subject: Re: should I trust 'free' or 'top'?
Date: Sat, 2 Feb 2002 15:09:21 -0200
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <FJEIKLCALBJLPMEOOMECMECBCFAA.blumpkin@attbi.com>
In-Reply-To: <FJEIKLCALBJLPMEOOMECMECBCFAA.blumpkin@attbi.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2 February 2002 05:18, Buddy Lumpkin wrote:
> >The only kernels you are likely to see that not happen on are
> >
> >-	The 2.4.9 kernel with Rik's patches that Linus didnt take
>
> 	(Red Hat 2.4.9-*)
>
> >-	2.4.17/18pre with the rmap11/rmap12 patches
> >-	2.4.17/18pre with the -aa patched VM
>
> 	(which I believe is also in the SuSE kernel packages)
>
> >-	2.2
> >
> >The base VM in Linus tree has been broken since before 2.4.0 and while
> >somewhat better is still that - broken. The major vendors don't ship it
> > for a reason.
>
> Why is this?
>
> Is linus working toward what he believes will be a better impementation? Is
> he just being stubborn?
> I guess I just can't imagine any reason why he would want
> large enterprise applications running poorly when there are obvious fixes.
>
> Believe it or not, im not trying to start a flame war, just trying to
> understand the logic.

Let's not get into politics. I suggest trying -aa kernels. If that solves
your problems, report to lkml, Linus and Marcelo - this will help
Andrea patches to get in mainline 2.5/2.4 faster.

As a minimum, you may try attached patch.
--
vda

vmscan.patch.2.4.17.d (author: "M.H.VanLeeuwen" <vanl@megsinet.net>)
====================================================================
--- linux.virgin/mm/vmscan.c    Mon Dec 31 12:46:25 2001
+++ linux/mm/vmscan.c   Fri Jan 11 18:03:05 2002
@@ -394,9 +394,9 @@
                if (PageDirty(page) && is_page_cache_freeable(page) && page->mapping) {
                        /*
                         * It is not critical here to write it only if
-                        * the page is unmapped beause any direct writer
+                        * the page is unmapped because any direct writer
                         * like O_DIRECT would set the PG_dirty bitflag
-                        * on the phisical page after having successfully
+                        * on the physical page after having successfully
                         * pinned it and after the I/O to the page is finished,
                         * so the direct writes to the page cannot get lost.
                         */
@@ -480,11 +480,14 @@
 
                        /*
                         * Alert! We've found too many mapped pages on the
-                        * inactive list, so we start swapping out now!
+                        * inactive list.
+                        * Move referenced pages to the active list.
                         */
-                       spin_unlock(&pagemap_lru_lock);
-                       swap_out(priority, gfp_mask, classzone);
-                       return nr_pages;
+                       if (PageReferenced(page) && !PageLocked(page)) {
+                               del_page_from_inactive_list(page);
+                               add_page_to_active_list(page);
+                       }
+                       continue;
                }
 
                /*
@@ -521,6 +524,9 @@
        }
        spin_unlock(&pagemap_lru_lock);
 
+       if (max_mapped <= 0 && (nr_pages > 0 || priority < DEF_PRIORITY))
+               swap_out(priority, gfp_mask, classzone);
+
        return nr_pages;
 }
 
