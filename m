Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267484AbUHXLSH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267484AbUHXLSH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 07:18:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267482AbUHXLSH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 07:18:07 -0400
Received: from cantor.suse.de ([195.135.220.2]:5071 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S267484AbUHXLRj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 07:17:39 -0400
Date: Tue, 24 Aug 2004 13:17:35 +0200
From: Andi Kleen <ak@suse.de>
To: Dave Jones <davej@redhat.com>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: Fix MTRR strings definition.
Message-Id: <20040824131735.3980c21a.ak@suse.de>
In-Reply-To: <20040824110001.GD28237@redhat.com>
References: <20040823232320.GA1875@redhat.com>
	<20040824081729.311ee677.ak@suse.de>
	<20040824110001.GD28237@redhat.com>
X-Mailer: Sylpheed version 0.9.11 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Aug 2004 12:00:01 +0100
Dave Jones <davej@redhat.com> wrote:

> On Tue, Aug 24, 2004 at 08:17:29AM +0200, Andi Kleen wrote:
>  > On Tue, 24 Aug 2004 00:23:20 +0100
>  > Dave Jones <davej@redhat.com> wrote:
>  > 
>  > > Instead of deleting the extern from include/asm/mtrr.h, I believe
>  > > the correct fix would be to move the strings back to the include file
>  > > where they belong.
>  > > The reason behind this, is that there are userspace apps (admittedly
>  > > few, but we even ship two in Documentation/mtrr.txt) that rely upon
>  > > these definitions being in that header.  This has been broken for
>  > > all 2.6 releases so far. Patch below fixes things back the way it
>  > > was in 2.4
>  > 
>  > That's rather ugly. It would be cleaner to just have a 
>  > macro that expands to the strings, and everybody who wants to use
>  > it declares an own array using that macro.
> 
> feel free to go rewrite the userspace that uses this.

Umm - since when do we care about user space gratuously including kernel 
headers?  I normally avoid breaking user space by this without need, but depending
on a static variable declaration in a header is really far too ugly
to be kept alive.


>  > > Andi, I don't have gcc 3.5 to hand, I trust this fixes whatever
>  > > problem you saw there too ?
>  > 
>  > 3.5 doesn't like it when something is declared both extern and static.
>  > Your new patch has this problem again.
> 
> The extern definitions no longer exist.

Your patch was: 

--- latest-FC2/include/asm-x86_64/mtrr.h~	2004-08-24 00:20:17.377436336 +0100
+++ latest-FC2/include/asm-x86_64/mtrr.h	2004-08-24 00:21:04.137327752 +0100
@@ -69,6 +69,19 @@
 #define MTRR_TYPE_WRBACK     6
 #define MTRR_NUM_TYPES       7
 
+#ifdef MTRR_NEED_STRINGS
+static char *mtrr_strings[MTRR_NUM_TYPES] =
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+{
+	"uncachable",		/* 0 */
+	"write-combining",	/* 1 */
+	"?",			/* 2 */
+	"?",			/* 3 */
+	"write-through",	/* 4 */
+	"write-protect",	/* 5 */
+	"write-back",		/* 6 */
+};
+#endif
+
 #ifdef __KERNEL__
 
 extern char *mtrr_strings[MTRR_NUM_TYPES];
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

-Andi
