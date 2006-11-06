Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753096AbWKFNiw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753096AbWKFNiw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 08:38:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753121AbWKFNiw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 08:38:52 -0500
Received: from nat-132.atmel.no ([80.232.32.132]:48604 "EHLO relay.atmel.no")
	by vger.kernel.org with ESMTP id S1753096AbWKFNiv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 08:38:51 -0500
Date: Mon, 6 Nov 2006 14:38:32 +0100
From: Haavard Skinnemoen <hskinnemoen@atmel.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [GIT PULL] avr32 update
Message-ID: <20061106143832.721c9e6b@cad-250-152.norway.atmel.com>
Organization: Atmel Norway
X-Mailer: Sylpheed-Claws 2.5.6 (GTK+ 2.8.20; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, please pull from

	git://www.atmel.no/~hskinnemoen/linux/kernel/avr32.git for-linus

to receive the following updates:

Haavard Skinnemoen (4):
      AVR32: Get rid of board_early_init
      AVR32: Fix thinko in generic_find_next_zero_le_bit()
      AVR32: Wire up sys_epoll_pwait
      AVR32: Add missing return instruction in __raw_writesb

 arch/avr32/boards/atstk1000/setup.c |    9 ---------
 arch/avr32/kernel/head.S            |    3 ---
 arch/avr32/kernel/syscall-stubs.S   |    9 +++++++++
 arch/avr32/kernel/syscall_table.S   |    1 +
 arch/avr32/lib/findbit.S            |    3 ++-
 arch/avr32/lib/io-readsb.S          |    2 ++
 include/asm-avr32/unistd.h          |    3 ++-
 7 files changed, 16 insertions(+), 14 deletions(-)

diff --git a/arch/avr32/boards/atstk1000/setup.c b/arch/avr32/boards/atstk1000/setup.c
index 191ab85..272c011 100644
--- a/arch/avr32/boards/atstk1000/setup.c
+++ b/arch/avr32/boards/atstk1000/setup.c
@@ -21,15 +21,6 @@ struct tag *bootloader_tags __initdata;
 
 struct lcdc_platform_data __initdata atstk1000_fb0_data;
 
-asmlinkage void __init board_early_init(void)
-{
-	extern void sdram_init(void);
-
-#ifdef CONFIG_LOADER_STANDALONE
-	sdram_init();
-#endif
-}
-
 void __init board_setup_fbmem(unsigned long fbmem_start,
 			      unsigned long fbmem_size)
 {
diff --git a/arch/avr32/kernel/head.S b/arch/avr32/kernel/head.S
index 773b7ad..6163bd0 100644
--- a/arch/avr32/kernel/head.S
+++ b/arch/avr32/kernel/head.S
@@ -30,9 +30,6 @@ #ifdef CONFIG_FRAME_POINTER
 	mov	r7, 0
 #endif
 
-	/* Set up the PIO, SDRAM controller, early printk, etc. */
-	rcall	board_early_init
-
 	/* Start the show */
 	lddpc   pc, kernel_start_addr
 
diff --git a/arch/avr32/kernel/syscall-stubs.S b/arch/avr32/kernel/syscall-stubs.S
index 7589a9b..890286a 100644
--- a/arch/avr32/kernel/syscall-stubs.S
+++ b/arch/avr32/kernel/syscall-stubs.S
@@ -100,3 +100,12 @@ __sys_splice:
 	rcall	sys_splice
 	sub	sp, -4
 	popm	pc
+
+	.global	__sys_epoll_pwait
+	.type	__sys_epoll_pwait,@function
+__sys_epoll_pwait:
+	pushm	lr
+	st.w	--sp, ARG6
+	rcall	sys_epoll_pwait
+	sub	sp, -4
+	popm	pc
diff --git a/arch/avr32/kernel/syscall_table.S b/arch/avr32/kernel/syscall_table.S
index 63b2069..db8f8b5 100644
--- a/arch/avr32/kernel/syscall_table.S
+++ b/arch/avr32/kernel/syscall_table.S
@@ -286,4 +286,5 @@ sys_call_table:
 	.long	sys_sync_file_range
 	.long	sys_tee
 	.long	sys_vmsplice
+	.long	__sys_epoll_pwait	/* 265 */
 	.long	sys_ni_syscall		/* r8 is saturated at nr_syscalls */
diff --git a/arch/avr32/lib/findbit.S b/arch/avr32/lib/findbit.S
index 2b4856f..c6b91de 100644
--- a/arch/avr32/lib/findbit.S
+++ b/arch/avr32/lib/findbit.S
@@ -136,6 +136,7 @@ ENTRY(generic_find_next_zero_le_bit)
 	/* offset is not word-aligned. Handle the first (32 - r10) bits */
 	ldswp.w	r8, r12[0]
 	sub	r12, -4
+	com	r8
 	lsr	r8, r8, r10
 	brne	.L_found
 
@@ -146,7 +147,7 @@ ENTRY(generic_find_next_zero_le_bit)
 
 	/* Main loop. offset must be word-aligned */
 1:	ldswp.w	r8, r12[0]
-	cp.w	r8, 0
+	com	r8
 	brne	.L_found
 	sub	r12, -4
 	sub	r9, 32
diff --git a/arch/avr32/lib/io-readsb.S b/arch/avr32/lib/io-readsb.S
index b319d5e..2be5da7 100644
--- a/arch/avr32/lib/io-readsb.S
+++ b/arch/avr32/lib/io-readsb.S
@@ -45,3 +45,5 @@ __raw_readsb:
 	sub	r10, 1
 	st.b	r11++, r8
 	brne	3b
+
+	retal	r12
diff --git a/include/asm-avr32/unistd.h b/include/asm-avr32/unistd.h
index a50e500..56ed1f9 100644
--- a/include/asm-avr32/unistd.h
+++ b/include/asm-avr32/unistd.h
@@ -280,9 +280,10 @@ #define __NR_splice		261
 #define __NR_sync_file_range	262
 #define __NR_tee		263
 #define __NR_vmsplice		264
+#define __NR_epoll_pwait	265
 
 #ifdef __KERNEL__
-#define NR_syscalls		265
+#define NR_syscalls		266
 
 
 #define __ARCH_WANT_IPC_PARSE_VERSION
