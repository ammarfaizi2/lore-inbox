Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750756AbVIRKGd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750756AbVIRKGd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Sep 2005 06:06:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750829AbVIRKGd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Sep 2005 06:06:33 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:57103 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1750756AbVIRKGd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Sep 2005 06:06:33 -0400
Date: Sun, 18 Sep 2005 11:06:27 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Al Viro <viro@ftp.linux.org.uk>
Subject: p = kmalloc(sizeof(*p), )
Message-ID: <20050918100627.GA16007@flint.arm.linux.org.uk>
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@osdl.org>, Al Viro <viro@ftp.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

In todays git update, the following text has been added to the coding
style document:

+The preferred form for passing a size of a struct is the following:
+
+       p = kmalloc(sizeof(*p), ...);
+
+The alternative form where struct name is spelled out hurts readability and
+introduces an opportunity for a bug when the pointer variable type is changed
+but the corresponding sizeof that is passed to a memory allocator is not.

I completely disagree with the above assertion for the following
reasons:

1. The above implies that the common case is that we are changing the
   names of structures more frequently than we change the contents of
   structures.  Reality is that we change the contents of structures
   more often than the names of those structures.

   Why is this relevant?  If you change the contents of structures,
   they need checking for initialisation.  How do you find all the
   locations that need initialisation checked?  Via grep.  The problem
   is that:

	p = kmalloc(sizeof(*p), ...)

   is not grep-friendly, and can not be used to identify potential
   initialisation sites.  However:

	p = kmalloc(sizeof(struct foo), ...)

   is grep-friendly, and will lead you to inspect each place where
   such a structure is allocated for correct initialisation.

2. in the rare case that you're changing the name of a structure, you're
   grepping the source for all instances for struct old_name, or doing
   a search and replace for struct old_name.  You will find all instances
   of struct old_name by this method and the bug alluded to will not
   happen.

3. if you are changing the name of a structure, in order to ensure that
   everyone gets fixed up correctly, you do not want to keep an old
   declaration of the structure around, unless you have a very very good
   reason to do so.  This will ensure that any missed old structure
   names (eg, because of merging of independent concurrent threads of
   development) get caught.  As a result, any sizeof(struct) also gets
   caught.

So the assertion above that kmalloc(sizeof(*p) is somehow superiour is
rather flawed, and as such should not be in the Coding Style document.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
