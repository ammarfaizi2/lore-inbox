Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136508AbRD3Rmg>; Mon, 30 Apr 2001 13:42:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136505AbRD3RmW>; Mon, 30 Apr 2001 13:42:22 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:31042 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S136508AbRD3RmM>; Mon, 30 Apr 2001 13:42:12 -0400
Date: Mon, 30 Apr 2001 19:40:54 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
        "Magnus Naeslund(f)" <mag@fbab.net>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Alpha compile problem solved by Andrea (pte_alloc)
Message-ID: <20010430194054.D19620@athlon.random>
In-Reply-To: <20010430014653.C923@athlon.random> <E14uGya-0008He-00@the-village.bc.nu> <20010430190747.C19620@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010430190747.C19620@athlon.random>; from andrea@suse.de on Mon, Apr 30, 2001 at 07:07:47PM +0200
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 30, 2001 at 07:07:47PM +0200, Andrea Arcangeli wrote:
> On Mon, Apr 30, 2001 at 05:56:41PM +0100, Alan Cox wrote:
> > > On alpha it's racy if you set CONFIG_ALPHA_LARGE_VMALLOC y (so don't do
> > > that as you don't need it). As long as you use only 1 entry of the pgd
> > > for the whole vmalloc space (CONFIG_ALPHA_LARGE_VMALLOC n) alpha is
> > > safe.
> > 
> > Its racy for all cases on the Alpha because the exception table fixes are
> > not done.
> 
> you're talking about the module races, I was only talking only about

here the fix for your module race (still untested though):

diff -urN 2.4.4/arch/alpha/mm/extable.c alpha-modrace/arch/alpha/mm/extable.c
--- 2.4.4/arch/alpha/mm/extable.c	Thu Nov 16 15:37:26 2000
+++ alpha-modrace/arch/alpha/mm/extable.c	Mon Apr 30 19:28:21 2001
@@ -45,20 +45,25 @@
 	/* There is only the kernel to search.  */
 	ret = search_one_table(__start___ex_table, __stop___ex_table - 1,
 			       addr - gp);
-	if (ret) return ret;
 #else
+	unsigned long flags;
 	/* The kernel is the last "module" -- no need to treat it special. */
 	struct module *mp;
+
+	ret = 0;
+	spin_lock_irqsave(&modlist_lock, flags);
 	for (mp = module_list; mp ; mp = mp->next) {
-		if (!mp->ex_table_start)
+		if (!mp->ex_table_start || !(mp->flags&(MOD_RUNNING|MOD_INITIALIZING)))
 			continue;
 		ret = search_one_table(mp->ex_table_start,
 				       mp->ex_table_end - 1, addr - mp->gp);
-		if (ret) return ret;
+		if (ret)
+			break;
 	}
+	spin_unlock_irqrestore(&modlist_lock, flags);
 #endif
 
-	return 0;
+	return ret;
 }
 
 unsigned

For the large-vmalloc races I'd take a very lazy approch:

--- alpha-modrace/arch/alpha/config.in.~1~	Sat Apr 28 05:24:29 2001
+++ alpha-modrace/arch/alpha/config.in	Mon Apr 30 19:31:24 2001
@@ -211,13 +211,15 @@
 
 # The machine must be able to support more than 8GB physical memory
 # before large vmalloc might even pretend to be an issue.
-if [ "$CONFIG_ALPHA_GENERIC" = "y" -o "$CONFIG_ALPHA_DP264" = "y" \
-	-o "$CONFIG_ALPHA_WILDFIRE" = "y" -o "$CONFIG_ALPHA_TITAN" = "y" ]
-then
-	bool 'Large VMALLOC support' CONFIG_ALPHA_LARGE_VMALLOC
-else
-	define_bool CONFIG_ALPHA_LARGE_VMALLOC n
-fi
+#if [ "$CONFIG_ALPHA_GENERIC" = "y" -o "$CONFIG_ALPHA_DP264" = "y" \
+#	-o "$CONFIG_ALPHA_WILDFIRE" = "y" -o "$CONFIG_ALPHA_TITAN" = "y" ]
+#then
+#	bool 'Large VMALLOC support' CONFIG_ALPHA_LARGE_VMALLOC
+#else
+#	define_bool CONFIG_ALPHA_LARGE_VMALLOC n
+#fi
+# LARGE_VMALLOC is racy, if you *really* need it then fix it first
+define_bool CONFIG_ALPHA_LARGE_VMALLOC n
 
 source drivers/pci/Config.in
 

I mean: I certainly don't need it, not even on the 256G boxes, the non
LARGE_VMALLOC is simpler and _faster_ (it drops a branch from the page
fault handler fast path) and so I'd prefer to spend my time on other
things than fixing LARGE_VMALLOC races, but still the above will avoid
people to get bitten by such race until somebody fixes it.  If anybody
has a rasonable example for which I may need more than 8giga of kernel
vmalloc memory then I can change my mind of course.

Andrea
