Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262145AbVHCHHA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262145AbVHCHHA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Aug 2005 03:07:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262143AbVHCHGm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Aug 2005 03:06:42 -0400
Received: from smtp.osdl.org ([65.172.181.4]:13279 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262119AbVHCHEs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Aug 2005 03:04:48 -0400
Date: Wed, 3 Aug 2005 00:04:12 -0700
From: Chris Wright <chrisw@osdl.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Chuck Wolber <chuckw@quantumlinux.com>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk, blaisorblade@yahoo.it
Subject: [11/13] sys_get_thread_area does not clear the returned argument
Message-ID: <20050803070412.GZ7762@shell0.pdx.osdl.net>
References: <20050803064439.GO7762@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050803064439.GO7762@shell0.pdx.osdl.net>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------

sys_get_thread_area does not memset to 0 its struct user_desc info before
copying it to user space...  since sizeof(struct user_desc) is 16 while the
actual datas which are filled are only 12 bytes + 9 bits (across the
bitfields), there is a (small) information leak.

This was already committed to Linus' repository.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
Signed-off-by: Chris Wright <chrisw@osdl.org>
---

 vanilla-linux-2.6.12-paolo/arch/i386/kernel/process.c |    2 ++
 1 files changed, 2 insertions(+)

diff -puN arch/i386/kernel/process.c~sec-micro-info-leak arch/i386/kernel/process.c
--- vanilla-linux-2.6.12/arch/i386/kernel/process.c~sec-micro-info-leak	2005-07-28 21:19:26.000000000 +0200
+++ vanilla-linux-2.6.12-paolo/arch/i386/kernel/process.c	2005-07-28 21:19:26.000000000 +0200
@@ -827,6 +827,8 @@ asmlinkage int sys_get_thread_area(struc
 	if (idx < GDT_ENTRY_TLS_MIN || idx > GDT_ENTRY_TLS_MAX)
 		return -EINVAL;
 
+	memset(&info, 0, sizeof(info));
+
 	desc = current->thread.tls_array + idx - GDT_ENTRY_TLS_MIN;
 
 	info.entry_number = idx;
