Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932104AbWJEPbr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932104AbWJEPbr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 11:31:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932123AbWJEPbr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 11:31:47 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:52149 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S932104AbWJEPbq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 11:31:46 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Andrew Morton <akpm@osdl.org>
Cc: vgoyal@in.ibm.com,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Reloc Kernel List <fastboot@lists.osdl.org>, ak@suse.de,
       horms@verge.net.au, lace@jankratochvil.net, hpa@zytor.com,
       magnus.damm@gmail.com, lwang@redhat.com, dzickus@redhat.com,
       maneesh@in.ibm.com
Subject: Re: [PATCH 12/12] i386 boot: Add an ELF header to bzImage
References: <20061003170032.GA30036@in.ibm.com>
	<20061003172511.GL3164@in.ibm.com>
	<20061003201340.afa7bfce.akpm@osdl.org>
	<m1vemzbe4c.fsf@ebiederm.dsl.xmission.com>
	<20061004214403.e7d9f23b.akpm@osdl.org>
	<m1ejtnb893.fsf@ebiederm.dsl.xmission.com>
	<20061004233137.97451b73.akpm@osdl.org>
Date: Thu, 05 Oct 2006 09:29:42 -0600
In-Reply-To: <20061004233137.97451b73.akpm@osdl.org> (Andrew Morton's message
	of "Wed, 4 Oct 2006 23:31:37 -0700")
Message-ID: <m14pui4w7t.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


In the lazy programmer school of fixes.

I haven't really tested this in any configuration.
But reading video.S it does use variable in the bootsector.
It does seem to initialize the variables before use.
But obviously something is missed.

By zeroing the uninteresting parts of the bootsector just after we
have determined we are loaded ok.  We should ensure we are
always in a known state the entire time. 

Andrew if I am right about the cause of your video not working
when you set an enhanced video mode this should fix your boot
problem.

Singed-off-by: Eric Biederman <ebiederm@xmission.com>

diff --git a/arch/i386/boot/setup.S b/arch/i386/boot/setup.S
index 53903a4..246ac88 100644
--- a/arch/i386/boot/setup.S
+++ b/arch/i386/boot/setup.S
@@ -287,6 +287,13 @@ # Check if an old loader tries to load a
 loader_panic_mess: .string "Wrong loader, giving up..."
 
 loader_ok:
+# Zero initialize the variables we keep in the bootsector
+	xorw	%di, %di
+	xorb	%al, %al
+	movw	$497, %cx
+	rep
+	stosb
+
 # Get memory size (extended mem, kB)
 
 	xorl	%eax, %eax

