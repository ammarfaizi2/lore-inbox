Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263096AbTEBSll (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 May 2003 14:41:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263091AbTEBSll
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 May 2003 14:41:41 -0400
Received: from zero.aec.at ([193.170.194.10]:51986 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S263096AbTEBSlj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 May 2003 14:41:39 -0400
Date: Fri, 2 May 2003 20:52:29 +0200
From: Andi Kleen <ak@muc.de>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: Andi Kleen <ak@muc.de>, linux-kernel@vger.kernel.org
Subject: Re: 2.5.68-bk11: .text.exit errors in .altinstructions
Message-ID: <20030502185229.GA27169@averell>
References: <20030502171355.GU21168@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030502171355.GU21168@fs.tum.de>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 02, 2003 at 07:13:56PM +0200, Adrian Bunk wrote:
> Hi Andi,
> 
> I'm getting the following .text.exit errors in 2.5.68-bk11 (kernel 
> compiled with gcc 2.95 for a K6):

That's what I feared. You have a prefetch or mb() in an __exit
function. Basically it's an binutils design bug, but hard to fix
according to the binutils hackers.

The only fix I know currently is to remove the .exit.text
discard from arch/i386/vmlinux.lds.S. It'll increase the kernel
text size slightly because functions that would only be needed
for module unload in some drivers will be compiled in too. 
But it's probably not too bad, at worst a few KB.

-Andi

Index: linux/arch/i386/vmlinux.lds.S
===================================================================
RCS file: /home/cvs/linux-2.5/arch/i386/vmlinux.lds.S,v
retrieving revision 1.18
diff -u -u -r1.18 vmlinux.lds.S
--- linux/arch/i386/vmlinux.lds.S	30 Apr 2003 14:32:05 -0000	1.18
+++ linux/arch/i386/vmlinux.lds.S	2 May 2003 17:52:38 -0000
@@ -106,7 +106,6 @@
 
   /* Sections to be discarded */
   /DISCARD/ : {
-	*(.exit.text)
 	*(.exit.data)
 	*(.exitcall.exit)
 	}






