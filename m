Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318706AbSHQTb6>; Sat, 17 Aug 2002 15:31:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318708AbSHQTb6>; Sat, 17 Aug 2002 15:31:58 -0400
Received: from to-velocet.redhat.com ([216.138.202.10]:8185 "EHLO
	touchme.toronto.redhat.com") by vger.kernel.org with ESMTP
	id <S318706AbSHQTb5>; Sat, 17 Aug 2002 15:31:57 -0400
Date: Sat, 17 Aug 2002 15:35:56 -0400
From: Benjamin LaHaise <bcrl@redhat.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>,
       Linus Torvalds <torvalds@transmeta.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] reduce stack usage of sanitize_e820_map
Message-ID: <20020817153556.A4540@redhat.com>
References: <20020815174825.F29874@redhat.com> <m11y8xqu98.fsf@frodo.biederman.org> <20020817151704.A3894@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020817151704.A3894@redhat.com>; from bcrl@redhat.com on Sat, Aug 17, 2002 at 03:17:04PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 17, 2002 at 03:17:04PM -0400, Benjamin LaHaise wrote:
> Nope.  static conflicts with __initdata.  If namespace pollution is a 
> concern, just prefix them with e820_.

Erm, foot-in-mouth.  I'd tried adding __initdata within the function, 
which conflicts with the auto attribute.  Making it static within the 
function and adding __initdata works here and has the same effect on 
stack usage.  Linus, could you apply this?  Thanks.

		-ben

--- foo-v2.5.31/arch/i386/kernel/setup.c	Sat Aug 17 15:31:33 2002
+++ test-v2.5.31/arch/i386/kernel/setup.c	Sat Aug 17 15:28:33 2002
@@ -275,17 +275,16 @@
  * replaces the original e820 map with a new one, removing overlaps.
  *
  */
-struct change_member {
-	struct e820entry *pbios; /* pointer to original bios entry */
-	unsigned long long addr; /* address for this change point */
-};
-struct change_member change_point_list[2*E820MAX] __initdata;
-struct change_member *change_point[2*E820MAX] __initdata;
-struct e820entry *overlap_list[E820MAX] __initdata;
-struct e820entry new_bios[E820MAX] __initdata;
-
 static int __init sanitize_e820_map(struct e820entry * biosmap, char * pnr_map)
 {
+	struct change_member {
+		struct e820entry *pbios; /* pointer to original bios entry */
+		unsigned long long addr; /* address for this change point */
+	};
+	static struct change_member change_point_list[2*E820MAX] __initdata;
+	static struct change_member *change_point[2*E820MAX] __initdata;
+	static struct e820entry *overlap_list[E820MAX] __initdata;
+	static struct e820entry new_bios[E820MAX] __initdata;
 	struct change_member *change_tmp;
 	unsigned long current_type, last_type;
 	unsigned long long last_addr;
