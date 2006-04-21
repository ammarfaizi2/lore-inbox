Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932457AbWDUVCn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932457AbWDUVCn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 17:02:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932469AbWDUVCn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 17:02:43 -0400
Received: from pproxy.gmail.com ([64.233.166.176]:55172 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932457AbWDUVCm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 17:02:42 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:content-type:content-transfer-encoding;
        b=uZl37BoKcSoBRIGf0G6z9He/Cae9ZXWk2YhkYfrsUVXWwuesk2Jx6Wq8yQyuSmDg4X7UpWvLfstrpIx7W5gRHZpM8BTiGpl8UoEtr+Mz55DX8I6VP/lRJgrGWqaGruFZF0axuOKcpTIrr9EkwEj+5FIJK6lzpzkaF5SXUm9vTcI=
Message-ID: <4449486F.8020108@gmail.com>
Date: Fri, 21 Apr 2006 14:02:39 -0700
From: Hua Zhong <hzhong@gmail.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: akpm@osdl.org, jmorris@namei.org, dwalker@mvista.com
CC: linux-kernel@vger.kernel.org
Subject: Re: kfree(NULL)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Maybe something like this might be a useful debug option to detect unwise likely()/unlikely() usage?

This is a quick hack (not submitted for inclusion), but it works on my box and detected certain points after boot. Anyone likes this idea?

The reason I had to add printk_debug_likely() is that using printk directly gives compile error. It seems not to like asmlinkage for some reason..I guess likely/unlikely are too fundamental macros and the dependency gets too messy. Or maybe it could be fixed in a way I've not found.

It increases kernel size by about 10%, but hey, it's a debugg option. :-)

Sample print:

possible (un)likely misuse at include/asm/mmu_context.h:32/switch_mm()
 <c011b644> printk_debug_likely+0x25/0x31   <c02b3092> schedule+0xb04/0xefa
 <c02b457b> __mutex_lock_slowpath+0x35a/0x89e   <c016c0fd> real_lookup+0x1f/0xb3
 <c016c0fd> real_lookup+0x1f/0xb3   <c016c512> do_lookup+0x50/0xe8
 <c016d14b> __link_path_walk+0xba1/0x125f   <c016d8a6> link_path_walk+0x9d/0x166
 <c014b911> __handle_mm_fault+0x2fd/0x35b   <c01ca29e> _atomic_dec_and_lock+0x22/0x2c
 <c016d5c2> __link_path_walk+0x1018/0x125f   <c016d8a6> link_path_walk+0x9d/0x166
 <c014b911> __handle_mm_fault+0x2fd/0x35b   <c01ce9fe> strncpy_from_user+0x94/0xb3
 <c016dee7> do_path_lookup+0x35c/0x4d2   <c016e385> __user_walk_fd+0x84/0x9b
 <c0167ae1> vfs_stat_fd+0x15/0x3c   <c014b911> __handle_mm_fault+0x2fd/0x35b
 <c0168091> sys_stat64+0xf/0x23   <c0113fea> do_page_fault+0x30d/0x753
 <c01ceefd> copy_to_user+0x113/0x11c   <c0126ee6> sys_rt_sigprocmask+0xae/0xc1
 <c01035cb> sysenter_past_esp+0x54/0x75  
possible (un)likely misuse at kernel/sched.c:1638/context_switch()
 <c011b644> printk_debug_likely+0x25/0x31   <c02b3025> schedule+0xa97/0xefa
 <c011ddcd> do_exit+0x75b/0x765   <c011dec4> sys_exit_group+0x0/0xd
 <c01035cb> sysenter_past_esp+0x54/0x75  
possible (un)likely misuse at kernel/softlockup.c:59/softlockup_tick()
 <c011b644> printk_debug_likely+0x25/0x31   <c0138f78> softlockup_tick+0x88/0xf5
 <c0123dcd> update_process_times+0x35/0x57   <c0106133> timer_interrupt+0x3d/0x60
 <c013919c> handle_IRQ_event+0x21/0x4a   <c01392f7> __do_IRQ+0x132/0x1e7
 <c0104d86> do_IRQ+0x9c/0xab   <c01037fe> common_interrupt+0x1a/0x20
possible (un)likely misuse at kernel/sched.c:1645/context_switch()
 <c011b644> printk_debug_likely+0x25/0x31   <c02b3236> schedule+0xca8/0xefa
 <c0130d33> enqueue_hrtimer+0x5b/0x80   <c02b57f5> do_nanosleep+0x3b/0xc0
 <c0131092> hrtimer_nanosleep+0x45/0xe6   <c01680b4> sys_lstat64+0xf/0x23
 <c013102a> hrtimer_wakeup+0x0/0x18   <c01cf021> copy_from_user+0x11b/0x142
 <c0131179> sys_nanosleep+0x46/0x4e   <c01035cb> sysenter_past_esp+0x54/0x75

diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index f23d3c6..a6df5f7 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -58,9 +58,32 @@ #endif
  * build go below this comment. Actual compiler/compiler version
  * specific implementations come from the above header files
  */
+#define CONFIG_DEBUG_LIKELY
+#ifdef CONFIG_DEBUG_LIKELY
+extern int printk_debug_likely(const char *fmt, ...);
+extern int debug_likely_count_min_thresh;
+extern int debug_likely_print_max_thresh;
+#define __check_likely(x, v, uv)                                \
+  ({ static int _ckl_print_nr = 0;                              \
+     static unsigned int _ckl_s[2];                             \
+     int _ckl_r = !!(x);                                        \
+     _ckl_s[_ckl_r]++;                                          \
+     if ((_ckl_s[v] == _ckl_s[uv]) && (_ckl_s[v] > debug_likely_count_min_thresh) \
+          && (_ckl_print_nr < debug_likely_print_max_thresh)) { \
+         _ckl_print_nr++;                                       \
+         printk_debug_likely("possible (un)likely misuse at %s:%d/%s()\n",        \
+                             __FILE__, __LINE__, __FUNCTION__); \
+     }                                                          \
+     _ckl_r; })
+#else
+#define __check_likely(x, v, uv)       __builtin_expect(!!(x), v)
+#endif
+
+#define likely(x)      __check_likely(x, 1, 0)
+#define unlikely(x)    __check_likely(x, 0, 1)
 
-#define likely(x)      __builtin_expect(!!(x), 1)
-#define unlikely(x)    __builtin_expect(!!(x), 0)
+//#define likely(x)    __builtin_expect(!!(x), 1)
+//#define unlikely(x)  __builtin_expect(!!(x), 0)
 
 /* Optimization barrier */
 #ifndef barrier
diff --git a/kernel/printk.c b/kernel/printk.c
index c056f33..cc09dca 100644
--- a/kernel/printk.c
+++ b/kernel/printk.c
@@ -602,6 +602,30 @@ out:
 EXPORT_SYMBOL(printk);
 EXPORT_SYMBOL(vprintk);
 
+#ifdef CONFIG_DEBUG_LIKELY
+int debug_likely_count_min_thresh = 100;
+int debug_likely_print_max_thresh = 1;
+int printk_debug_likely(const char *fmt, ...)
+{
+       int r = 0;
+       static atomic_t recurse = ATOMIC_INIT(1); /* as a mutex */
+       if (atomic_dec_and_test(&recurse)) {
+               va_list args;
+
+               va_start(args, fmt);
+               r = vprintk(fmt, args);
+               va_end(args);
+               dump_stack();
+       }
+       atomic_inc(&recurse);
+
+       return r;
+}
+EXPORT_SYMBOL(debug_likely_count_min_thresh);
+EXPORT_SYMBOL(debug_likely_print_max_thresh);
+EXPORT_SYMBOL(printk_debug_likely);
+#endif
+
 #else
 
 asmlinkage long sys_syslog(int type, char __user *buf, int len)


