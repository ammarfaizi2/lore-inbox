Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129425AbQKIKJk>; Thu, 9 Nov 2000 05:09:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129486AbQKIKJa>; Thu, 9 Nov 2000 05:09:30 -0500
Received: from jalon.able.es ([212.97.163.2]:60113 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S129425AbQKIKJ1>;
	Thu, 9 Nov 2000 05:09:27 -0500
Date: Thu, 9 Nov 2000 11:09:20 +0100
From: "J . A . Magallon" <jamagallon@able.es>
To: Athanasius <Athanasius@miggy.org>
Cc: "J . A . Magallon" <jamagallon@able.es>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: Nvidia GeForce2 kernel driver - kernel 2.4.0 test-10
Message-ID: <20001109110920.A1423@werewolf.able.es>
Reply-To: jamagallon@able.es
In-Reply-To: <3A08F5E9.61F424A0@ihug.co.nz> <3A092269.9020501@edge.net> <20001109010848.A709@werewolf.able.es> <20001109075436.U17457@miggy.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="AWniW0JNca5xppdA"
Content-Transfer-Encoding: 8bit
In-Reply-To: <20001109075436.U17457@miggy.org>; from Athanasius@miggy.org on Thu, Nov 09, 2000 at 08:54:36 +0100
X-Mailer: Balsa 1.0.pre2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--AWniW0JNca5xppdA
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit


On Thu, 09 Nov 2000 08:54:36 Athanasius wrote:
> 
>    Oh no it wasn't, doh *;-).

One other try...

-- 
Juan Antonio Magallon Lacarta                                 #> cd /pub
mailto:jamagallon@able.es                                     #> more beer
--AWniW0JNca5xppdA
Content-Type: application/octet-stream; charset=us-ascii
Content-Disposition: attachment; filename="patch-nvdriver-2.4.0-test11"

diff -ru NVIDIA_kernel-0.9-5/nv.c nvdriver_/nv.c
--- NVIDIA_kernel-0.9-5/nv.c	Sat Aug 26 02:48:38 2000
+++ nvdriver_/nv.c	Thu Nov  9 00:23:42 2000
@@ -49,6 +49,13 @@
 #include <linux/modversions.h>
 #endif
 
+#ifndef mem_map_dec_count
+  #define mem_map_dec_count(p) atomic_inc(&((p)->count));
+#endif
+#ifndef mem_map_inc_count
+  #define mem_map_inc_count(p) atomic_dec(&((p)->count));
+#endif
+
 #include <nv.h>			        // needs to precede other headers (SMP)
 
 #include <linux/stddef.h>
diff -ru NVIDIA_kernel-0.9-5/os-interface.c nvdriver_/os-interface.c
--- NVIDIA_kernel-0.9-5/os-interface.c	Fri Sep  1 04:19:17 2000
+++ nvdriver_/os-interface.c	Thu Nov  9 00:22:45 2000
@@ -1331,6 +1331,11 @@
     char *parmp;
     char ch;
 
+    spinlock_t unload_lock = SPIN_LOCK_UNLOCKED;
+    struct module *mp = THIS_MODULE;
+    struct module_symbol *sym;
+    int i;
+
     if ((strlen(regParmStr) + NV_SYM_PREFIX_LENGTH) > NV_MAX_SYM_NAME)
         goto done;
 
@@ -1351,11 +1356,17 @@
 
     *symp = '\0';
 
-    symbol_value = get_module_symbol(NV_MODULE_NAME, symbol_name);
-    
-#if LINUX_VERSION_CODE >= KERNEL_VERSION(2, 4, 0)
-    put_module_symbol(symbol_value);
-#endif
+    spin_lock(&unload_lock);
+    if (MOD_CAN_QUERY(mp) && (mp->nsyms > 0)) {
+        for (i = mp->nsyms, sym = mp->syms;
+             i > 0; --i, ++sym) {
+
+            if (strcmp(sym->name, symbol_name) == 0) {
+                symbol_value = sym->value;
+                break;
+            }
+        }
+    }
+    spin_unlock(&unload_lock);
 
  done:
     return (void *) symbol_value;

--AWniW0JNca5xppdA--


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
