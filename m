Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268322AbUHLD42@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268322AbUHLD42 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 23:56:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268380AbUHLD42
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 23:56:28 -0400
Received: from mx1.redhat.com ([66.187.233.31]:61632 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S268322AbUHLD4S (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 23:56:18 -0400
Date: Wed, 11 Aug 2004 20:55:29 -0700
From: "David S. Miller" <davem@redhat.com>
To: torvalds@osdl.org
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH]: __crc_* symbols in System.map
Message-Id: <20040811205529.1ff86e9d.davem@redhat.com>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Shouldn't we be grepping these things out of the System.map file?

For one thing, these can confuse readprofile.  It's algorithm is
to start at _stext, then stop when it sees a line in the System.map
which is not text (mode is one of 'T' 't' 'W' or 'w')

It will exit early if there are some intermixed __crc_* things in
there (since they are are mode 'A').

For example, in my current sparc64 kernel I have this:

00000000004cef80 t do_split
00000000004cf2a0 t add_dirent_to_buf
00000000004cf5a7 A __crc_init_special_inode
00000000004cf640 t make_indexed_dir
00000000004cf900 t ext3_add_entry

So no symbols after add_dirent_to_buf will be shown in the profiling
output of readprofile.

So we should grep them out, right?  If so, here is a patch which
implements that.

===== Makefile 1.511 vs edited =====
--- 1.511/Makefile	2004-08-09 19:12:34 -07:00
+++ edited/Makefile	2004-08-11 20:21:36 -07:00
@@ -538,7 +538,7 @@
 	echo 'cmd_$@ := $(cmd_vmlinux__)' > $(@D)/.$(@F).cmd
 endef
 
-do_system_map = $(NM) $(1) | grep -v '\(compiled\)\|\(\.o$$\)\|\( [aUw] \)\|\(\.\.ng$$\)\|\(LASH[RL]DI\)' | sort > $(2)
+do_system_map = $(NM) $(1) | grep -v '\(compiled\)\|\(\.o$$\)\|\( [aUw] \)\|\(\.\.ng$$\)\|\(LASH[RL]DI\)\|\(__crc_\)' | sort > $(2)
 
 LDFLAGS_vmlinux += -T arch/$(ARCH)/kernel/vmlinux.lds.s
 
