Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030249AbVKPJEi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030249AbVKPJEi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 04:04:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030250AbVKPJEi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 04:04:38 -0500
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:59302 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1030249AbVKPJEg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 04:04:36 -0500
Message-ID: <437AF619.2000101@jp.fujitsu.com>
Date: Wed, 16 Nov 2005 18:04:25 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: ja, en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.14-mm2
References: <20051110203544.027e992c.akpm@osdl.org>
In-Reply-To: <20051110203544.027e992c.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I saw following errors while compilng with CONFIG_MEMORY_HOTPLUG=y.

==
drivers/base/memory.c:28: error: static declaration of 'memory_sysdev_class' follows non-static declaration
include/linux/memory.h:88: error: previous declaration of 'memory_sysdev_class' was here
drivers/base/memory.c:47: warning: initialization from incompatible pointer type
drivers/base/memory.c:54: error: static declaration of 'register_memory_notifier' follows non-static declaration
include/linux/memory.h:85: error: previous declaration of 'register_memory_notifier' was here
drivers/base/memory.c:59: error: static declaration of 'unregister_memory_notifier' follows non-static declaration
include/linux/memory.h:86: error: previous declaration of 'unregister_memory_notifier' was here
drivers/base/memory.c:69: error: static declaration of 'register_memory' follows non-static declaration
include/linux/memory.h:73: error: previous declaration of 'register_memory' was here
==

patch is attached.

-- Kame

Compile fix for /driver/base/memory.c

Signed-Off-by KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>


Index: linux-2.6.14-mm2/drivers/base/memory.c
===================================================================
--- linux-2.6.14-mm2.orig/drivers/base/memory.c
+++ linux-2.6.14-mm2/drivers/base/memory.c
@@ -25,12 +25,12 @@

  #define MEMORY_CLASS_NAME	"memory"

-static struct sysdev_class memory_sysdev_class = {
+struct sysdev_class memory_sysdev_class = {
  	set_kset_name(MEMORY_CLASS_NAME),
  };
  EXPORT_SYMBOL(memory_sysdev_class);

-static char *memory_hotplug_name(struct kset *kset, struct kobject *kobj)
+static const char *memory_hotplug_name(struct kset *kset, struct kobject *kobj)
  {
  	return MEMORY_CLASS_NAME;
  }
@@ -50,12 +50,12 @@ static struct kset_hotplug_ops memory_ho

  static struct notifier_block *memory_chain;

-static int register_memory_notifier(struct notifier_block *nb)
+int register_memory_notifier(struct notifier_block *nb)
  {
          return notifier_chain_register(&memory_chain, nb);
  }

-static void unregister_memory_notifier(struct notifier_block *nb)
+void unregister_memory_notifier(struct notifier_block *nb)
  {
          notifier_chain_unregister(&memory_chain, nb);
  }
@@ -63,7 +63,7 @@ static void unregister_memory_notifier(s
  /*
   * register_memory - Setup a sysfs device for a memory block
   */
-static int
+int
  register_memory(struct memory_block *memory, struct mem_section *section,
  		struct node *root)
  {

