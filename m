Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262122AbREPXFm>; Wed, 16 May 2001 19:05:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262123AbREPXFc>; Wed, 16 May 2001 19:05:32 -0400
Received: from mout1.freenet.de ([194.97.50.132]:36298 "EHLO mout1.freenet.de")
	by vger.kernel.org with ESMTP id <S262122AbREPXFV>;
	Wed, 16 May 2001 19:05:21 -0400
Date: Thu, 17 May 2001 01:05:26 +0200 (CEST)
From: Andreas Franck <afranck@gmx.de>
To: <linux-kernel@vger.kernel.org>
Subject: oops in 2.4.4-ac9 (mm/slab.c)
Message-ID: <Pine.LNX.4.31.0105170103380.2918-100000@dg1kfa.ampr.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello people,

I triggered an "invalid operand" oops in linux-2.4.4-ac9 today, and could
trace it back to the line mm/slab.c:1244. I did nothing really special
when this happened, and I was not able to log in onto any console or
terminal afterwards (probably because tty_open failed very miserably
on the way?)

The final BUG() is found inside:

static inline void * kmem_cache_alloc_one_tail (kmem_cache_t *cachep,
                                                         slab_t *slabp)
{
   [...]

#if DEBUG
        if (cachep->flags & SLAB_POISON)
                if (kmem_check_poison_obj(cachep, objp))
                        BUG();
			^^^^^^ This one is triggered
        if (cachep->flags & SLAB_RED_ZONE) {
                /* Set alloc red-zone, and check old one. */
    [...]
#endif
    [...]
}

So CONFIG_DEBUG_SLAB (which I have enabled, out of curiosity and to help you all)
might have found a bug here.

ksymoops output is found below.

Greetings and happy hacking,
Andreas

---snip---

ksymoops 2.4.0 on i686 2.4.4-ac9.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.4-ac9/ (default)
     -m /boot/System.map-2.4.4-ac9 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Warning (compare_maps): ksyms_base symbol __VERSIONED_SYMBOL(bm_cast_buffer) not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol __VERSIONED_SYMBOL(bm_copy_to_buffer) not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol __VERSIONED_SYMBOL(bm_evaluate_object) not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol __VERSIONED_SYMBOL(bm_evaluate_reference_list) not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol __VERSIONED_SYMBOL(bm_evaluate_simple_integer) not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol __VERSIONED_SYMBOL(bm_extract_package_data) not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol __VERSIONED_SYMBOL(bm_get_device_context) not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol __VERSIONED_SYMBOL(bm_get_device_info) not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol __VERSIONED_SYMBOL(bm_get_device_power_state) not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol __VERSIONED_SYMBOL(bm_get_device_status) not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol __VERSIONED_SYMBOL(bm_get_node) not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol __VERSIONED_SYMBOL(bm_osl_generate_event) not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol __VERSIONED_SYMBOL(bm_proc_root) not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol __VERSIONED_SYMBOL(bm_register_driver) not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol __VERSIONED_SYMBOL(bm_request) not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol __VERSIONED_SYMBOL(bm_search) not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol __VERSIONED_SYMBOL(bm_set_device_power_state) not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol __VERSIONED_SYMBOL(bm_unregister_driver) not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol acpi_fadt_R__ver_acpi_fadt not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): mismatch on symbol partition_name  , ksyms_base says c01f2b40, System.map says c01485d0.  Ignoring ksyms_base entry
invalid operand: 0000
CPU:    0
EIP:    0010:[<c012621e>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010012
eax: dea55fff   ebx: c40fc768     ecx: 00000001       edx: 00000001
esi: dea55000   edi: dea559aa     ebp: 00012800       esp: cc0d1e68
ds: 0018   es: 0018   ss: 0018
Process blogd (pid: 4143, stackpage=cc0d1000)
Stack: 00000000 00008000 c03219c0 c03219c0 00001000 dea559aa 00000246 c017ad0d
       00000c3c 00000007 c03219c0 c017b92c 00000000 c03219c0 c03219c0 00000000
       cc0d0000 00000000 00000000 00000000 df8ee658 00000000 cc0d0000 00000000
Call Trace: [<c017ad0d>] [<c017b92c>] [<c017c34b>] [<c012e70f>] [<c0137717>]
   [<c012e892>] [<c012da95>] [<c012d9ce>] [<c012dcb6>] [<c0106b5f>]
Code: 0f 0b f7 c5 00 04 00 00 74 2a b8 a5 c2 0f 17 87 06 3d 71 f0

>>EIP; c012621e <kmalloc+10a/184>   <=====
Trace; c017ad0d <alloc_tty_struct+d/28>
Trace; c017b92c <init_dev+8c/420>
Trace; c017c34b <tty_open+f7/360>
Trace; c012e70f <get_chrfops+67/c8>
Trace; c0137717 <permission+2b/30>
Trace; c012e892 <chrdev_open+3e/4c>
Trace; c012da95 <dentry_open+bd/140>
Trace; c012d9ce <filp_open+52/5c>
Trace; c012dcb6 <sys_open+36/98>
Trace; c0106b5f <system_call+33/38>
Code;  c012621e <kmalloc+10a/184>
00000000 <_EIP>:
Code;  c012621e <kmalloc+10a/184>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c0126220 <kmalloc+10c/184>
   2:   f7 c5 00 04 00 00         test   $0x400,%ebp
Code;  c0126226 <kmalloc+112/184>
   8:   74 2a                     je     34 <_EIP+0x34> c0126252 <kmalloc+13e/184>
Code;  c0126228 <kmalloc+114/184>
   a:   b8 a5 c2 0f 17            mov    $0x170fc2a5,%eax
Code;  c012622d <kmalloc+119/184>
   f:   87 06                     xchg   %eax,(%esi)
Code;  c012622f <kmalloc+11b/184>
  11:   3d 71 f0 00 00            cmp    $0xf071,%eax


21 warnings issued.  Results may not be reliable.

---snip---


