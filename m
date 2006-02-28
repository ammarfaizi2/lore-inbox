Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751910AbWB1HaL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751910AbWB1HaL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 02:30:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751911AbWB1HaL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 02:30:11 -0500
Received: from fmr21.intel.com ([143.183.121.13]:13192 "EHLO
	scsfmr001.sc.intel.com") by vger.kernel.org with ESMTP
	id S1751910AbWB1HaK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 02:30:10 -0500
Message-ID: <4403FA60.6060701@intel.com>
Date: Tue, 28 Feb 2006 15:23:12 +0800
From: "bibo,mao" <bibo.mao@intel.com>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org,
       Ananth N Mavinakayanahalli <ananth@in.ibm.com>,
       "Keshavamurthy, Anil S" <anil.s.keshavamurthy@intel.com>,
       Prasanna S Panchamukhi <prasanna@in.ibm.com>,
       hiramatu@sdl.hitachi.co.jp
Subject: [PATCH]kprobe handler discard user space trap
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Currently kprobe handler traps only happen in kernel space, so function
kprobe_exceptions_notify should skip traps which happen in user space.
This patch modifies this, and it is based on 2.6.16-rc4.

Signed-off-by: bibo mao <bibo.mao@intel.com>

diff -Nruap a/arch/i386/kernel/kprobes.c b/arch/i386/kernel/kprobes.c
--- a/arch/i386/kernel/kprobes.c    2006-02-25 17:08:52.000000000 +0800
+++ b/arch/i386/kernel/kprobes.c    2006-03-01 10:37:50.000000000 +0800
@@ -463,6 +463,9 @@ int __kprobes kprobe_exceptions_notify(s
      struct die_args *args = (struct die_args *)data;
      int ret = NOTIFY_DONE;

+    if (user_mode(args->regs))
+        return ret;
+
      switch (val) {
      case DIE_INT3:
          if (kprobe_handler(args->regs))
diff -Nruap a/arch/ia64/kernel/kprobes.c b/arch/ia64/kernel/kprobes.c
--- a/arch/ia64/kernel/kprobes.c    2006-02-25 17:08:53.000000000 +0800
+++ b/arch/ia64/kernel/kprobes.c    2006-03-01 10:39:15.000000000 +0800
@@ -740,6 +740,9 @@ int __kprobes kprobe_exceptions_notify(s
      struct die_args *args = (struct die_args *)data;
      int ret = NOTIFY_DONE;

+    if (user_mode(args->regs))
+        return ret;
+
      switch(val) {
      case DIE_BREAK:
          /* err is break number from ia64_bad_break() */
diff -Nruap a/arch/powerpc/kernel/kprobes.c b/arch/powerpc/kernel/kprobes.c
--- a/arch/powerpc/kernel/kprobes.c    2006-02-25 17:08:52.000000000 +0800
+++ b/arch/powerpc/kernel/kprobes.c    2006-03-01 10:39:53.000000000 +0800
@@ -397,6 +397,9 @@ int __kprobes kprobe_exceptions_notify(s
      struct die_args *args = (struct die_args *)data;
      int ret = NOTIFY_DONE;

+    if (user_mode(args->regs))
+        return ret;
+
      switch (val) {
      case DIE_BPT:
          if (kprobe_handler(args->regs))
diff -Nruap a/arch/sparc64/kernel/kprobes.c b/arch/sparc64/kernel/kprobes.c
--- a/arch/sparc64/kernel/kprobes.c    2006-02-25 17:08:52.000000000 +0800
+++ b/arch/sparc64/kernel/kprobes.c    2006-03-01 10:40:16.000000000 +0800
@@ -324,6 +324,9 @@ int __kprobes kprobe_exceptions_notify(s
      struct die_args *args = (struct die_args *)data;
      int ret = NOTIFY_DONE;

+    if (user_mode(args->regs))
+        return ret;
+
      switch (val) {
      case DIE_DEBUG:
          if (kprobe_handler(args->regs))
diff -Nruap a/arch/x86_64/kernel/kprobes.c b/arch/x86_64/kernel/kprobes.c
--- a/arch/x86_64/kernel/kprobes.c    2006-02-25 17:08:52.000000000 +0800
+++ b/arch/x86_64/kernel/kprobes.c    2006-03-01 10:38:48.000000000 +0800
@@ -601,6 +601,9 @@ int __kprobes kprobe_exceptions_notify(s
      struct die_args *args = (struct die_args *)data;
      int ret = NOTIFY_DONE;

+    if (user_mode(args->regs))
+        return ret;
+
      switch (val) {
      case DIE_INT3:
          if (kprobe_handler(args->regs))

