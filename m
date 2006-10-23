Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964943AbWJWPiy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964943AbWJWPiy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Oct 2006 11:38:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964961AbWJWPiy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Oct 2006 11:38:54 -0400
Received: from mis011-1.exch011.intermedia.net ([64.78.21.128]:27831 "EHLO
	mis011-1.exch011.intermedia.net") by vger.kernel.org with ESMTP
	id S964943AbWJWPiw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Oct 2006 11:38:52 -0400
Message-ID: <453CE203.5080908@qumranet.com>
Date: Mon, 23 Oct 2006 17:38:43 +0200
From: Avi Kivity <avi@qumranet.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Avi Kivity <avi@qumranet.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/13] KVM: qemu patch
References: <453CC390.9080508@qumranet.com>
In-Reply-To: <453CC390.9080508@qumranet.com>
Content-Type: multipart/mixed;
 boundary="------------090001060309040800090801"
X-OriginalArrivalTime: 23 Oct 2006 15:38:50.0410 (UTC) FILETIME=[564FF0A0:01C6F6B9]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090001060309040800090801
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Attached is a not-very-pretty patch to qemu-0.8.2 that allows it to use kvm.

You will need:
 - libkvm.a from the userspace posted previously
 - qemu 0.8.2 plus this patch
 - some twiddling with the configure_kvm() function in ./configure to 
set paths
 - run ./configure with --enable-kvm
 - a machine with VT, enabled in the BIOS if possible, running a kernel 
with the kvm patches applied and configured
 - modprobe kvm
 - access to /dev/kvm

Runtime is exactly the same as qemu.  You will need the same BIOS 
shipped with qemu.

Some notes:
 - the display is optimized by tracking which framebuffer pages have 
been dirtied since the last refresh and updating only the affected scanlines
 - the display bits are derived from a similar Xen patch
 - I've only tested this with SDL, not VNC
 - keep your original qemu binary since this one can't run without kvm


-- 
error compiling committee.c: too many arguments to function


--------------090001060309040800090801
Content-Type: text/x-patch;
 name="qemu-kvm.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="qemu-kvm.patch"

Index: cpu-exec.c
===================================================================
--- cpu-exec.c	(.../qemu-vendor-drops)	(revision 3256)
+++ cpu-exec.c	(.../release/qemu)	(revision 3256)
@@ -35,6 +35,10 @@
 #include <sys/ucontext.h>
 #endif
 
+#ifdef USE_KVM
+#include "qemu-kvm.h"
+#endif
+
 int tb_invalidated_flag;
 
 //#define DEBUG_EXEC
@@ -449,6 +453,10 @@
             }
 #endif
 
+#ifdef USE_KVM
+            kvm_cpu_exec(env);
+            longjmp(env->jmp_env, 1);
+#endif
             T0 = 0; /* force lookup of first TB */
             for(;;) {
 #if defined(__sparc__) && !defined(HOST_SOLARIS)
Index: Makefile.target
===================================================================
--- Makefile.target	(.../qemu-vendor-drops)	(revision 3256)
+++ Makefile.target	(.../release/qemu)	(revision 3256)
@@ -201,8 +201,8 @@
 OBJS+= libqemu.a
 
 # cpu emulator library
-LIBOBJS=exec.o kqemu.o translate-op.o translate-all.o cpu-exec.o\
-        translate.o op.o 
+LIBOBJS=exec.o kqemu.o qemu-kvm.o translate-op.o translate-all.o cpu-exec.o\
+        translate.o op.o
 ifdef CONFIG_SOFTFLOAT
 LIBOBJS+=fpu/softfloat.o
 else
@@ -323,6 +323,10 @@
 SOUND_HW += fmopl.o adlib.o
 endif
 AUDIODRV+= wavcapture.o
+ifdef CONFIG_KVM_INC
+DEFINES += -I $(CONFIG_KVM_INC) -I $(CONFIG_KVM_KERNEL_INC)
+LIBS += -L $(CONFIG_KVM_LIB) -lkvm
+endif
 
 # SCSI layer
 VL_OBJS+= scsi-disk.o cdrom.o lsi53c895a.o
Index: exec.c
===================================================================
--- exec.c	(.../qemu-vendor-drops)	(revision 3256)
+++ exec.c	(.../release/qemu)	(revision 3256)
@@ -81,6 +81,7 @@
 int phys_ram_fd;
 uint8_t *phys_ram_base;
 uint8_t *phys_ram_dirty;
+uint8_t *bios_mem;
 
 CPUState *first_cpu;
 /* current CPU in the current thread. It is only valid inside
@@ -1042,6 +1043,10 @@
     if (env->nb_breakpoints >= MAX_BREAKPOINTS)
         return -1;
     env->breakpoints[env->nb_breakpoints++] = pc;
+
+#ifdef USE_KVM
+    kvm_update_debugger(env);
+#endif
     
     breakpoint_invalidate(env, pc);
     return 0;
@@ -1065,6 +1070,10 @@
     if (i < env->nb_breakpoints)
       env->breakpoints[i] = env->breakpoints[env->nb_breakpoints];
 
+#ifdef USE_KVM
+    kvm_update_debugger(env);
+#endif
+    
     breakpoint_invalidate(env, pc);
     return 0;
 #else
@@ -1083,7 +1092,10 @@
         /* XXX: only flush what is necessary */
         tb_flush(env);
     }
+#ifdef USE_KVM
+    kvm_update_debugger(env);
 #endif
+#endif
 }
 
 /* enable or disable low levels log */
Index: configure
===================================================================
--- configure	(.../qemu-vendor-drops)	(revision 3256)
+++ configure	(.../release/qemu)	(revision 3256)
@@ -87,6 +87,7 @@
 bsd="no"
 linux="no"
 kqemu="no"
+kvm="no"
 profiler="no"
 kernel_path=""
 cocoa="no"
@@ -221,6 +222,8 @@
   ;;
   --disable-kqemu) kqemu="no"
   ;;
+  --enable-kvm) kvm="yes"
+  ;;
   --enable-profiler) profiler="yes"
   ;;
   --kernel-path=*) kernel_path="$optarg"
@@ -268,6 +271,7 @@
 echo "kqemu kernel acceleration support:"
 echo "  --disable-kqemu          disable kqemu support"
 echo "  --kernel-path=PATH       set the kernel path (configure probes it)"
+echo "  --enable-kvm             enable kernel virtual machine support"
 echo ""
 echo "Advanced options (experts only):"
 echo "  --source-path=PATH       path of source code [$source_path]"
@@ -559,6 +563,7 @@
 fi
 echo "FMOD support      $fmod $fmod_support"
 echo "kqemu support     $kqemu"
+echo "kvm support       $kvm"
 echo "Documentation     $build_docs"
 [ ! -z "$uname_release" ] && \
 echo "uname -r          $uname_release"
@@ -784,6 +789,15 @@
 interp_prefix1=`echo "$interp_prefix" | sed "s/%M/$target_cpu/g"`
 echo "#define CONFIG_QEMU_PREFIX \"$interp_prefix1\"" >> $config_h
 
+configure_kvm() {
+  if test $kvm = "yes" -a "$target_softmmu" = "yes" -a $cpu = "$target_cpu" ; then
+    echo "#define USE_KVM 1" >> $config_h
+    echo "CONFIG_KVM_INC=$PWD/../user" >> $config_mak
+    echo "CONFIG_KVM_LIB=$PWD/../user" >> $config_mak
+    echo "CONFIG_KVM_KERNEL_INC=$PWD/../kernel/include" >> $config_mak
+  fi
+}
+
 if test "$target_cpu" = "i386" ; then
   echo "TARGET_ARCH=i386" >> $config_mak
   echo "#define TARGET_ARCH \"i386\"" >> $config_h
@@ -791,6 +805,7 @@
   if test $kqemu = "yes" -a "$target_softmmu" = "yes" -a $cpu = "i386" ; then
     echo "#define USE_KQEMU 1" >> $config_h
   fi
+  configure_kvm
 elif test "$target_cpu" = "arm" -o "$target_cpu" = "armeb" ; then
   echo "TARGET_ARCH=arm" >> $config_mak
   echo "#define TARGET_ARCH \"arm\"" >> $config_h
@@ -822,6 +837,7 @@
   if test $kqemu = "yes" -a "$target_softmmu" = "yes" -a $cpu = "x86_64"  ; then
     echo "#define USE_KQEMU 1" >> $config_h
   fi
+  configure_kvm
 elif test "$target_cpu" = "mips" -o "$target_cpu" = "mipsel" ; then
   echo "TARGET_ARCH=mips" >> $config_mak
   echo "#define TARGET_ARCH \"mips\"" >> $config_h
Index: target-i386/helper.c
===================================================================
--- target-i386/helper.c	(.../qemu-vendor-drops)	(revision 3256)
+++ target-i386/helper.c	(.../release/qemu)	(revision 3256)
@@ -184,7 +184,15 @@
     if (!(env->tr.flags & DESC_P_MASK))
         cpu_abort(env, "invalid tss");
     type = (env->tr.flags >> DESC_TYPE_SHIFT) & 0xf;
+#ifdef USE_KVM
+    /*
+     * Bit 1 is the Busy bit.  We believe it is legal to interrupt into a busy
+     * segment
+     */
+    if ((type & 5) != 1)
+#else
     if ((type & 7) != 1)
+#endif
         cpu_abort(env, "invalid tss type");
     shift = type >> 3;
     index = (dpl * 4 + 2) << shift;
@@ -497,7 +505,12 @@
     
     /* TSS must be a valid 32 bit one */
     if (!(env->tr.flags & DESC_P_MASK) ||
+#ifdef USE_KVM
+	/* Probable qemu bug: 11 is a valid segment type */
+        ((env->tr.flags >> DESC_TYPE_SHIFT) & 0xd) != 9 ||
+#else
         ((env->tr.flags >> DESC_TYPE_SHIFT) & 0xf) != 9 ||
+#endif
         env->tr.limit < 103)
         goto fail;
     io_offset = lduw_kernel(env->tr.base + 0x66);
@@ -824,6 +837,11 @@
     uint32_t e1, e2, e3, ss;
     target_ulong old_eip, esp, offset;
 
+#ifdef USE_KVM
+    printf("%s: unexpect\n", __FUNCTION__);
+    exit(-1);
+#endif
+
     has_error_code = 0;
     if (!is_int && !is_hw) {
         switch(intno) {
@@ -1107,6 +1125,10 @@
     int dpl, cpl;
     uint32_t e2;
 
+#ifdef USE_KVM
+    printf("%s: unexpect\n", __FUNCTION__);
+    exit(-1);
+#endif
     dt = &env->idt;
     ptr = dt->base + (intno * 8);
     e2 = ldl_kernel(ptr + 4);
@@ -1132,6 +1154,10 @@
 void do_interrupt(int intno, int is_int, int error_code, 
                   target_ulong next_eip, int is_hw)
 {
+#ifdef USE_KVM
+    printf("%s: unexpect\n", __FUNCTION__);
+    exit(-1);
+#endif
     if (loglevel & CPU_LOG_INT) {
         if ((env->cr[0] & CR0_PE_MASK)) {
             static int count;
@@ -1660,6 +1686,12 @@
         cpu_x86_load_seg_cache(env, R_CS, (new_cs & 0xfffc) | cpl,
                        get_seg_base(e1, e2), limit, e2);
         EIP = new_eip;
+#ifdef USE_KVM
+        if (e2 & DESC_L_MASK) {
+            env->exception_index = -1;
+            cpu_loop_exit();   
+        }       
+#endif
     } else {
         /* jump to call or task gate */
         dpl = (e2 >> DESC_DPL_SHIFT) & 3;
Index: target-i386/cpu.h
===================================================================
--- target-i386/cpu.h	(.../qemu-vendor-drops)	(revision 3256)
+++ target-i386/cpu.h	(.../release/qemu)	(revision 3256)
@@ -154,13 +154,17 @@
 #define HF_MP_MASK           (1 << HF_MP_SHIFT)
 #define HF_EM_MASK           (1 << HF_EM_SHIFT)
 #define HF_TS_MASK           (1 << HF_TS_SHIFT)
+#define HF_IOPL_MASK         (3 << HF_IOPL_SHIFT)
 #define HF_LMA_MASK          (1 << HF_LMA_SHIFT)
 #define HF_CS64_MASK         (1 << HF_CS64_SHIFT)
 #define HF_OSFXSR_MASK       (1 << HF_OSFXSR_SHIFT)
+#define HF_VM_MASK           (1 << HF_VM_SHIFT)
 #define HF_HALTED_MASK       (1 << HF_HALTED_SHIFT)
 
-#define CR0_PE_MASK  (1 << 0)
-#define CR0_MP_MASK  (1 << 1)
+#define CR0_PE_SHIFT 0
+#define CR0_PE_MASK  (1 << CR0_PE_SHIFT)
+#define CR0_MP_SHIFT 1
+#define CR0_MP_MASK  (1 << CR0_MP_SHIFT)
 #define CR0_EM_MASK  (1 << 2)
 #define CR0_TS_MASK  (1 << 3)
 #define CR0_ET_MASK  (1 << 4)
@@ -177,7 +181,8 @@
 #define CR4_PAE_MASK  (1 << 5)
 #define CR4_PGE_MASK  (1 << 7)
 #define CR4_PCE_MASK  (1 << 8)
-#define CR4_OSFXSR_MASK (1 << 9)
+#define CR4_OSFXSR_SHIFT 9
+#define CR4_OSFXSR_MASK (1 << CR4_OSFXSR_SHIFT)
 #define CR4_OSXMMEXCPT_MASK  (1 << 10)
 
 #define PG_PRESENT_BIT	0
@@ -524,6 +529,11 @@
     int kqemu_enabled;
     int last_io_time;
 #endif
+
+#ifdef USE_KVM
+    int kvm_pending_int;
+#endif
+
     /* in order to simplify APIC support, we leave this pointer to the
        user */
     struct APICState *apic_state;
Index: hw/cirrus_vga.c
===================================================================
--- hw/cirrus_vga.c	(.../qemu-vendor-drops)	(revision 3256)
+++ hw/cirrus_vga.c	(.../release/qemu)	(revision 3256)
@@ -28,6 +28,9 @@
  */
 #include "vl.h"
 #include "vga_int.h"
+#ifndef _WIN32
+#include <sys/mman.h>
+#endif
 
 /*
  * TODO:
@@ -231,6 +234,10 @@
     int cirrus_linear_io_addr;
     int cirrus_linear_bitblt_io_addr;
     int cirrus_mmio_io_addr;
+#ifdef USE_KVM
+    unsigned long cirrus_lfb_addr;
+    unsigned long cirrus_lfb_end;
+#endif
     uint32_t cirrus_addr_mask;
     uint32_t linear_mmio_mask;
     uint8_t cirrus_shadow_gr0;
@@ -267,6 +274,10 @@
     int last_hw_cursor_y_end;
     int real_vram_size; /* XXX: suppress that */
     CPUWriteMemoryFunc **cirrus_linear_write;
+#ifdef USE_KVM
+    unsigned long map_addr;
+    unsigned long map_end;
+#endif
 } CirrusVGAState;
 
 typedef struct PCICirrusVGAState {
@@ -2520,6 +2531,52 @@
     cirrus_linear_bitblt_writel,
 };
 
+#ifdef USE_KVM
+
+#include "qemu-kvm.h"
+
+extern kvm_context_t kvm_context;
+
+static void *set_vram_mapping(unsigned long begin, unsigned long end)
+{
+    void *vram_pointer = NULL;
+
+    printf("set_vram_mapping: memory: %lx - %lx\n",
+	   begin, end);
+
+    /* align begin and end address */
+    begin = begin & TARGET_PAGE_MASK;
+    end = begin + VGA_RAM_SIZE;
+    end = (end + TARGET_PAGE_SIZE -1 ) & TARGET_PAGE_MASK;
+
+    vram_pointer = kvm_create_phys_mem(kvm_context, begin, end - begin, 1, 
+				       1, 1);
+
+    if (vram_pointer == NULL) {
+        printf("set_vram_mapping: cannot allocate memory: %m\n");
+        return NULL;
+    }
+
+    memset(vram_pointer, 0, end - begin);
+
+    printf("set_vram_mapping: return %p\n", vram_pointer);
+    return vram_pointer;
+}
+
+static int unset_vram_mapping(unsigned long begin, unsigned long end)
+{
+    /* align begin and end address */
+    end = begin + VGA_RAM_SIZE;
+    begin = begin & TARGET_PAGE_MASK;
+    end = (end + TARGET_PAGE_SIZE -1 ) & TARGET_PAGE_MASK;
+
+    kvm_destroy_phys_mem(kvm_context, begin, end - begin);
+
+    return 0;
+}
+
+#endif
+
 /* Compute the memory access functions */
 static void cirrus_update_memory_access(CirrusVGAState *s)
 {
@@ -2538,11 +2595,43 @@
         
 	mode = s->gr[0x05] & 0x7;
 	if (mode < 4 || mode > 5 || ((s->gr[0x0B] & 0x4) == 0)) {
+#ifdef USE_KVM
+            if (s->cirrus_lfb_addr && s->cirrus_lfb_end && !s->map_addr) {
+                void *vram_pointer, *old_vram;
+
+                vram_pointer = set_vram_mapping(s->cirrus_lfb_addr,
+                                                s->cirrus_lfb_end);
+                if (!vram_pointer)
+                    fprintf(stderr, "NULL vram_pointer\n");
+                else {
+                    old_vram = vga_update_vram((VGAState *)s, vram_pointer,
+                                               VGA_RAM_SIZE);
+                    qemu_free(old_vram);
+                }
+                s->map_addr = s->cirrus_lfb_addr;
+                s->map_end = s->cirrus_lfb_end;
+            }
+#endif
             s->cirrus_linear_write[0] = cirrus_linear_mem_writeb;
             s->cirrus_linear_write[1] = cirrus_linear_mem_writew;
             s->cirrus_linear_write[2] = cirrus_linear_mem_writel;
         } else {
         generic_io:
+#ifdef USE_KVM
+            if (s->cirrus_lfb_addr && s->cirrus_lfb_end && s->map_addr) {
+		int error;
+                void *old_vram = NULL;
+
+		error = unset_vram_mapping(s->cirrus_lfb_addr,
+					   s->cirrus_lfb_end);
+		if (!error)
+		    old_vram = vga_update_vram((VGAState *)s, NULL,
+                                               VGA_RAM_SIZE);
+                if (old_vram)
+                    munmap(old_vram, s->map_addr - s->map_end);
+                s->map_addr = s->map_end = 0;
+            }
+#endif
             s->cirrus_linear_write[0] = cirrus_linear_writeb;
             s->cirrus_linear_write[1] = cirrus_linear_writew;
             s->cirrus_linear_write[2] = cirrus_linear_writel;
@@ -2938,6 +3027,11 @@
     qemu_put_be32s(f, &s->hw_cursor_y);
     /* XXX: we do not save the bitblt state - we assume we do not save
        the state when the blitter is active */
+
+#ifdef USE_KVM
+    qemu_put_be32s(f, &s->real_vram_size);
+    qemu_put_buffer(f, s->vram_ptr, s->real_vram_size);
+#endif
 }
 
 static int cirrus_vga_load(QEMUFile *f, void *opaque, int version_id)
@@ -2981,6 +3075,22 @@
     qemu_get_be32s(f, &s->hw_cursor_x);
     qemu_get_be32s(f, &s->hw_cursor_y);
 
+#ifdef USE_KVM
+    {
+        int real_vram_size;
+        qemu_get_be32s(f, &real_vram_size);
+        if (real_vram_size != s->real_vram_size) {
+            if (real_vram_size > s->real_vram_size)
+                real_vram_size = s->real_vram_size;
+            printf("%s: REAL_VRAM_SIZE MISMATCH !!!!!! SAVED=%d CURRENT=%d", 
+                   __FUNCTION__, real_vram_size, s->real_vram_size);
+        }
+        qemu_get_buffer(f, s->vram_ptr, real_vram_size);
+        cirrus_update_memory_access(s);
+    }
+#endif
+
+
     /* force refresh */
     s->graphic_mode = -1;
     cirrus_update_bank_ptr(s, 0);
@@ -3136,6 +3246,15 @@
     /* XXX: add byte swapping apertures */
     cpu_register_physical_memory(addr, s->vram_size,
 				 s->cirrus_linear_io_addr);
+#ifdef USE_KVM
+    s->cirrus_lfb_addr = addr;
+    s->cirrus_lfb_end = addr + VGA_RAM_SIZE;
+
+    if (s->map_addr && (s->cirrus_lfb_addr != s->map_addr) &&
+        (s->cirrus_lfb_end != s->map_end))
+        printf("cirrus vga map change while on lfb mode\n");
+#endif
+
     cpu_register_physical_memory(addr + 0x1000000, 0x400000,
 				 s->cirrus_linear_bitblt_io_addr);
 }
Index: hw/vga_int.h
===================================================================
--- hw/vga_int.h	(.../qemu-vendor-drops)	(revision 3256)
+++ hw/vga_int.h	(.../release/qemu)	(revision 3256)
@@ -169,5 +169,6 @@
                              unsigned int color0, unsigned int color1,
                              unsigned int color_xor);
 
+void *vga_update_vram(VGAState *s, void *vga_ram_base, int vga_ram_size);
 extern const uint8_t sr_mask[8];
 extern const uint8_t gr_mask[16];
Index: hw/pc.c
===================================================================
--- hw/pc.c	(.../qemu-vendor-drops)	(revision 3256)
+++ hw/pc.c	(.../release/qemu)	(revision 3256)
@@ -22,6 +22,9 @@
  * THE SOFTWARE.
  */
 #include "vl.h"
+#ifdef USE_KVM
+#include "qemu-kvm.h"
+#endif
 
 /* output Bochs bios info messages */
 //#define DEBUG_BIOS
@@ -605,6 +608,10 @@
     nb_ne2k++;
 }
 
+#ifdef USE_KVM
+extern kvm_context_t kvm_context;
+#endif
+
 /* PC hardware initialisation */
 static void pc_init1(int ram_size, int vga_ram_size, int boot_device,
                      DisplayState *ds, const char **fd_filename, int snapshot,
@@ -674,6 +681,9 @@
     /* setup basic memory access */
     cpu_register_physical_memory(0xc0000, 0x10000, 
                                  vga_bios_offset | IO_MEM_ROM);
+#ifdef USE_KVM
+    memcpy(phys_ram_base + 0xc0000, phys_ram_base + vga_bios_offset, 0x10000);
+#endif
 
     /* map the last 128KB of the BIOS in ISA space */
     isa_bios_size = bios_size;
@@ -684,10 +694,25 @@
     cpu_register_physical_memory(0x100000 - isa_bios_size, 
                                  isa_bios_size, 
                                  (bios_offset + bios_size - isa_bios_size) | IO_MEM_ROM);
+#ifdef USE_KVM
+    memcpy(phys_ram_base + 0x100000 - isa_bios_size, phys_ram_base + (bios_offset + bios_size - isa_bios_size), isa_bios_size);
+#endif
     /* map all the bios at the top of memory */
     cpu_register_physical_memory((uint32_t)(-bios_size), 
                                  bios_size, bios_offset | IO_MEM_ROM);
+#ifdef USE_KVM
+    bios_mem = kvm_create_phys_mem(kvm_context, (uint32_t)(-bios_size),
+				       bios_size, 2, 0, 1);
+    if (!bios_mem) {
+	    exit(1);
+    }
+    memcpy(bios_mem, phys_ram_base + bios_offset, bios_size);
+
+    cpu_register_physical_memory(phys_ram_size - KVM_EXTRA_PAGES * 4096, KVM_EXTRA_PAGES * 4096,
+				 (phys_ram_size - KVM_EXTRA_PAGES * 4096) | IO_MEM_ROM);
     
+#endif
+    
     bochs_bios_init();
 
     if (linux_boot) {
Index: hw/vga.c
===================================================================
--- hw/vga.c	(.../qemu-vendor-drops)	(revision 3256)
+++ hw/vga.c	(.../release/qemu)	(revision 3256)
@@ -1359,6 +1359,22 @@
     }
 }
 
+#ifdef USE_KVM
+
+#include "kvmctl.h"
+extern kvm_context_t kvm_context;
+
+static int bitmap_get_dirty(unsigned long *bitmap, unsigned nr)
+{
+    unsigned word = nr / ((sizeof bitmap[0]) * 8);
+    unsigned bit = nr % ((sizeof bitmap[0]) * 8);
+
+    //printf("%x -> %ld\n", nr, (bitmap[word] >> bit) & 1);
+    return (bitmap[word] >> bit) & 1;
+}
+
+#endif
+
 /* 
  * graphic modes
  */
@@ -1371,6 +1387,19 @@
     uint32_t v, addr1, addr;
     vga_draw_line_func *vga_draw_line;
     
+#ifdef USE_KVM
+
+    /* HACK ALERT */
+#define BITMAP_SIZE ((8*1024*1024) / 4096 / 8 / sizeof(long))
+    unsigned long bitmap[BITMAP_SIZE];
+
+    kvm_get_dirty_pages(kvm_context, 1, &bitmap);
+
+#define cpu_physical_memory_get_dirty(addr, type) \
+    (bitmap_get_dirty(bitmap, (addr - s->vram_offset) >> TARGET_PAGE_BITS) \
+     | cpu_physical_memory_get_dirty(addr, type))
+#endif
+
     full_update |= update_basic_params(s);
 
     s->get_resolution(s, &width, &height);
@@ -1722,6 +1751,7 @@
     }
 }
 
+/* when used on xen/kvm environment, the vga_ram_base is not used */
 void vga_common_init(VGAState *s, DisplayState *ds, uint8_t *vga_ram_base, 
                      unsigned long vga_ram_offset, int vga_ram_size)
 {
@@ -1752,7 +1782,11 @@
 
     vga_reset(s);
 
+#ifndef USE_KVM
     s->vram_ptr = vga_ram_base;
+#else
+    s->vram_ptr = qemu_malloc(vga_ram_size);
+#endif
     s->vram_offset = vga_ram_offset;
     s->vram_size = vga_ram_size;
     s->ds = ds;
@@ -1843,6 +1877,7 @@
         /* XXX: vga_ram_size must be a power of two */
         pci_register_io_region(d, 0, vga_ram_size, 
                                PCI_ADDRESS_SPACE_MEM_PREFETCH, vga_map);
+	printf("vga_bios_size %d\n", vga_bios_size);
         if (vga_bios_size != 0) {
             unsigned int bios_total_size;
             s->bios_offset = vga_bios_offset;
@@ -1864,6 +1899,33 @@
     return 0;
 }
 
+void *vga_update_vram(VGAState *s, void *vga_ram_base, int vga_ram_size)
+{
+    uint8_t *old_pointer;
+
+    printf("vga_update_vram: base %p ptr %p\n", vga_ram_base, s->vram_ptr);
+    if (s->vram_size != vga_ram_size) {
+        fprintf(stderr, "No support to change vga_ram_size\n");
+        return NULL;
+    }
+
+    if (!vga_ram_base) {
+        vga_ram_base = qemu_malloc(vga_ram_size);
+        if (!vga_ram_base) {
+            fprintf(stderr, "reallocate error\n");
+            return NULL;
+        }
+    }
+
+    /* XXX lock needed? */
+    memcpy(vga_ram_base, s->vram_ptr, vga_ram_size);
+    old_pointer = s->vram_ptr;
+    s->vram_ptr = vga_ram_base;
+
+    printf("vga_update_vram: done\n");
+    return old_pointer;
+}
+
 /********************************************************/
 /* vga screen dump */
 
Index: cpu-all.h
===================================================================
--- cpu-all.h	(.../qemu-vendor-drops)	(revision 3256)
+++ cpu-all.h	(.../release/qemu)	(revision 3256)
@@ -818,6 +818,7 @@
 extern int phys_ram_fd;
 extern uint8_t *phys_ram_base;
 extern uint8_t *phys_ram_dirty;
+extern uint8_t *bios_mem;
 
 /* physical memory access */
 #define TLB_INVALID_MASK   (1 << 3)
Index: qemu-kvm.c
===================================================================
--- qemu-kvm.c	(.../qemu-vendor-drops)	(revision 0)
+++ qemu-kvm.c	(.../release/qemu)	(revision 3256)
@@ -0,0 +1,476 @@
+
+#include "config.h"
+#include "config-host.h"
+
+#ifdef USE_KVM
+
+#include "exec.h"
+
+#include "qemu-kvm.h"
+#include <kvmctl.h>
+#include <string.h>
+
+kvm_context_t kvm_context;
+
+#define NR_CPU 16
+static CPUState *saved_env[NR_CPU];
+
+static void load_regs(CPUState *env)
+{
+    struct kvm_regs regs;
+    struct kvm_sregs sregs;
+
+    /* hack: save env */
+    if (!saved_env[0])
+	saved_env[0] = env;
+
+    regs.rax = env->regs[R_EAX];
+    regs.rbx = env->regs[R_EBX];
+    regs.rcx = env->regs[R_ECX];
+    regs.rdx = env->regs[R_EDX];
+    regs.rsi = env->regs[R_ESI];
+    regs.rdi = env->regs[R_EDI];
+    regs.rsp = env->regs[R_ESP];
+    regs.rbp = env->regs[R_EBP];
+#ifdef TARGET_X86_64
+    regs.r8 = env->regs[8];
+    regs.r9 = env->regs[9];
+    regs.r10 = env->regs[10];
+    regs.r11 = env->regs[11];
+    regs.r12 = env->regs[12];
+    regs.r13 = env->regs[13];
+    regs.r14 = env->regs[14];
+    regs.r15 = env->regs[15];
+#endif
+    
+    regs.rflags = env->eflags;
+    regs.rip = env->eip;
+
+    kvm_set_regs(kvm_context, 0, &regs);
+
+#define set_seg(var, seg, default_s, default_type)	\
+  do {				    \
+      unsigned flags = env->seg.flags; \
+      unsigned valid = flags & ~DESC_P_MASK; \
+    sregs.var.selector = env->seg.selector; \
+    sregs.var.base = env->seg.base; \
+    sregs.var.limit = env->seg.limit; \
+    sregs.var.type = valid ? (flags >> DESC_TYPE_SHIFT) & 15 : default_type; \
+    sregs.var.present = valid ? (flags & DESC_P_MASK) != 0 : 1; \
+    sregs.var.dpl = env->seg.selector & 3; \
+    sregs.var.db = valid ? (flags >> DESC_B_SHIFT) & 1 : 0; \
+    sregs.var.s = valid ? (flags & DESC_S_MASK) != 0 : default_s;   \
+    sregs.var.l = valid ? (flags >> DESC_L_SHIFT) & 1 : 0;    \
+    sregs.var.g = valid ? (flags & DESC_G_MASK) != 0 : 0;      \
+    sregs.var.avl = (flags & DESC_AVL_MASK) != 0; \
+    sregs.var.unusable = 0; \
+  } while (0)
+
+
+#define set_v8086_seg(var, seg) \
+  do { \
+    sregs.var.selector = env->seg.selector; \
+    sregs.var.base = env->seg.base; \
+    sregs.var.limit = env->seg.limit; \
+    sregs.var.type = 3; \
+    sregs.var.present = 1; \
+    sregs.var.dpl = 3; \
+    sregs.var.db = 0; \
+    sregs.var.s = 1; \
+    sregs.var.l = 0; \
+    sregs.var.g = 0; \
+    sregs.var.avl = 0; \
+    sregs.var.unusable = 0; \
+  } while (0)
+
+
+    if ((env->eflags & VM_MASK)) {
+	    set_v8086_seg(cs, segs[R_CS]);
+	    set_v8086_seg(ds, segs[R_DS]);
+	    set_v8086_seg(es, segs[R_ES]);
+	    set_v8086_seg(fs, segs[R_FS]);
+	    set_v8086_seg(gs, segs[R_GS]);
+	    set_v8086_seg(ss, segs[R_SS]);
+    } else {
+	    set_seg(cs, segs[R_CS], 1, 11);
+	    set_seg(ds, segs[R_DS], 1, 3);
+	    set_seg(es, segs[R_ES], 1, 3);
+	    set_seg(fs, segs[R_FS], 1, 3);
+	    set_seg(gs, segs[R_GS], 1, 3);
+	    set_seg(ss, segs[R_SS], 1, 3);
+
+	    if (env->cr[0] & CR0_PE_MASK) {
+		/* force ss cpl to cs cpl */
+		sregs.ss.selector = (sregs.ss.selector & ~3) | 
+			(sregs.cs.selector & 3);
+		sregs.ss.dpl = sregs.ss.selector & 3;
+	    }
+    }
+
+    set_seg(tr, tr, 0, 3);
+    set_seg(ldt, ldt, 0, 2);
+
+    sregs.idt.limit = env->idt.limit;
+    sregs.idt.base = env->idt.base;
+    sregs.gdt.limit = env->gdt.limit;
+    sregs.gdt.base = env->gdt.base;
+
+    sregs.cr0 = env->cr[0];
+    sregs.cr2 = env->cr[2];
+    sregs.cr3 = env->cr[3];
+    sregs.cr4 = env->cr[4];
+    sregs.cr8 = cpu_get_apic_tpr(env);
+    sregs.apic_base = cpu_get_apic_base(env);
+    sregs.efer = env->efer;
+
+    kvm_set_sregs(kvm_context, 0, &sregs);
+}
+
+static void save_regs(CPUState *env)
+{
+    struct kvm_regs regs;
+    struct kvm_sregs sregs;
+    uint32_t hflags;
+
+    kvm_get_regs(kvm_context, 0, &regs);
+
+    env->regs[R_EAX] = regs.rax;
+    env->regs[R_EBX] = regs.rbx;
+    env->regs[R_ECX] = regs.rcx;
+    env->regs[R_EDX] = regs.rdx;
+    env->regs[R_ESI] = regs.rsi;
+    env->regs[R_EDI] = regs.rdi;
+    env->regs[R_ESP] = regs.rsp;
+    env->regs[R_EBP] = regs.rbp;
+#ifdef TARGET_X86_64
+    env->regs[8] = regs.r8;
+    env->regs[9] = regs.r9;
+    env->regs[10] = regs.r10;
+    env->regs[11] = regs.r11;
+    env->regs[12] = regs.r12;
+    env->regs[13] = regs.r13;
+    env->regs[14] = regs.r14;
+    env->regs[15] = regs.r15;
+#endif
+
+    env->eflags = regs.rflags;
+    env->eip = regs.rip;
+
+    kvm_get_sregs(kvm_context, 0, &sregs);
+
+#define get_seg(var, seg) \
+    env->seg.selector = sregs.var.selector; \
+    env->seg.base = sregs.var.base; \
+    env->seg.limit = sregs.var.limit ; \
+    env->seg.flags = \
+	(sregs.var.type << DESC_TYPE_SHIFT) \
+	| (sregs.var.present * DESC_P_MASK) \
+	| (sregs.var.dpl << DESC_DPL_SHIFT) \
+	| (sregs.var.db << DESC_B_SHIFT) \
+	| (sregs.var.s * DESC_S_MASK) \
+	| (sregs.var.l << DESC_L_SHIFT) \
+	| (sregs.var.g * DESC_G_MASK) \
+	| (sregs.var.avl * DESC_AVL_MASK)
+    
+    get_seg(cs, segs[R_CS]);
+    get_seg(ds, segs[R_DS]);
+    get_seg(es, segs[R_ES]);
+    get_seg(fs, segs[R_FS]);
+    get_seg(gs, segs[R_GS]);
+    get_seg(ss, segs[R_SS]);
+
+    get_seg(tr, tr);
+    get_seg(ldt, ldt);
+    
+    env->idt.limit = sregs.idt.limit;
+    env->idt.base = sregs.idt.base;
+    env->gdt.limit = sregs.gdt.limit;
+    env->gdt.base = sregs.gdt.base;
+
+    env->cr[0] = sregs.cr0;
+    env->cr[2] = sregs.cr2;
+    env->cr[3] = sregs.cr3;
+    env->cr[4] = sregs.cr4;
+
+    cpu_set_apic_tpr(env, sregs.cr8);
+    cpu_set_apic_base(env, sregs.apic_base);
+
+    env->efer = sregs.efer;
+
+#define HFLAG_COPY_MASK ~( \
+			HF_CPL_MASK | HF_PE_MASK | HF_MP_MASK | HF_EM_MASK | \
+			HF_TS_MASK | HF_TF_MASK | HF_VM_MASK | HF_IOPL_MASK | \
+			HF_OSFXSR_MASK | HF_LMA_MASK | HF_CS32_MASK | \
+			HF_SS32_MASK | HF_CS64_MASK | HF_ADDSEG_MASK)
+
+
+
+    hflags = (env->segs[R_CS].flags >> DESC_DPL_SHIFT) & HF_CPL_MASK;
+    hflags |= (env->cr[0] & CR0_PE_MASK) << (HF_PE_SHIFT - CR0_PE_SHIFT);
+    hflags |= (env->cr[0] << (HF_MP_SHIFT - CR0_MP_SHIFT)) & 
+	    (HF_MP_MASK | HF_EM_MASK | HF_TS_MASK);
+    hflags |= (env->eflags & (HF_TF_MASK | HF_VM_MASK | HF_IOPL_MASK)); 
+    hflags |= (env->cr[4] & CR4_OSFXSR_MASK) << 
+	    (HF_OSFXSR_SHIFT - CR4_OSFXSR_SHIFT);
+
+    if (env->efer & MSR_EFER_LMA) {
+        hflags |= HF_LMA_MASK;
+    }
+
+    if ((hflags & HF_LMA_MASK) && (env->segs[R_CS].flags & DESC_L_MASK)) {
+        hflags |= HF_CS32_MASK | HF_SS32_MASK | HF_CS64_MASK;
+    } else {
+        hflags |= (env->segs[R_CS].flags & DESC_B_MASK) >> 
+		(DESC_B_SHIFT - HF_CS32_SHIFT);
+        hflags |= (env->segs[R_SS].flags & DESC_B_MASK) >> 
+		(DESC_B_SHIFT - HF_SS32_SHIFT);
+        if (!(env->cr[0] & CR0_PE_MASK) || 
+                   (env->eflags & VM_MASK) ||
+                   !(hflags & HF_CS32_MASK)) {
+                hflags |= HF_ADDSEG_MASK;
+            } else {
+                hflags |= ((env->segs[R_DS].base | 
+                                env->segs[R_ES].base |
+                                env->segs[R_SS].base) != 0) << 
+                    HF_ADDSEG_SHIFT;
+            }
+    }
+    env->hflags = (env->hflags & HFLAG_COPY_MASK) | hflags;
+    CC_SRC = env->eflags & (CC_O | CC_S | CC_Z | CC_A | CC_P | CC_C);
+    DF = 1 - (2 * ((env->eflags >> 10) & 1));
+    CC_OP = CC_OP_EFLAGS;
+    env->eflags &= ~(DF_MASK | CC_O | CC_S | CC_Z | CC_A | CC_P | CC_C);
+
+    tlb_flush(env, 1);
+
+    env->kvm_pending_int = sregs.pending_int;
+}
+
+
+#include <signal.h>
+
+static inline void push_interrupts(CPUState *env)
+{
+    if (!(env->interrupt_request & CPU_INTERRUPT_HARD) ||
+	!(env->eflags & IF_MASK) || env->kvm_pending_int) {
+    	if ((env->interrupt_request & CPU_INTERRUPT_EXIT)) {
+	    env->interrupt_request &= ~CPU_INTERRUPT_EXIT;
+	    env->exception_index = EXCP_INTERRUPT;
+	    cpu_loop_exit();
+        }
+        return;
+    }
+
+    do {
+        env->interrupt_request &= ~CPU_INTERRUPT_HARD;
+
+        // for now using cpu 0
+	kvm_inject_irq(kvm_context, 0, cpu_get_pic_interrupt(env)); 
+    } while ( (env->interrupt_request & CPU_INTERRUPT_HARD) && (env->cr[2] & CR0_PG_MASK) );
+}
+
+void kvm_load_registers(CPUState *env)
+{
+    load_regs(env);
+}
+
+int kvm_cpu_exec(CPUState *env)
+{
+
+    push_interrupts(env);
+
+    if (!saved_env[0])
+	saved_env[0] = env;
+
+    kvm_run(kvm_context, 0);
+
+    save_regs(env);
+
+    return 0;
+}
+
+
+static int kvm_cpuid(void *opaque, uint64_t *rax, uint64_t *rbx, 
+		      uint64_t *rcx, uint64_t *rdx)
+{
+    CPUState **envs = opaque;
+    CPUState *saved_env;
+
+    saved_env = env;
+    env = envs[0];
+
+    env->regs[R_EAX] = *rax;
+    env->regs[R_EBX] = *rbx;
+    env->regs[R_ECX] = *rcx;
+    env->regs[R_EDX] = *rdx;
+    helper_cpuid();
+    *rdx = env->regs[R_EDX];
+    *rcx = env->regs[R_ECX];
+    *rbx = env->regs[R_EBX];
+    *rax = env->regs[R_EAX];
+    env = saved_env;
+    return 0;
+}
+
+static int kvm_debug(void *opaque, int vcpu)
+{
+    CPUState **envs = opaque;
+
+    env = envs[0];
+    save_regs(env);
+    env->exception_index = EXCP_DEBUG;
+    return 1;
+}
+
+static int kvm_inb(void *opaque, uint16_t addr, uint8_t *data)
+{
+    *data = cpu_inb(0, addr);
+    return 0;
+}
+
+static int kvm_inw(void *opaque, uint16_t addr, uint16_t *data)
+{
+    *data = cpu_inw(0, addr);
+    return 0;
+}
+
+static int kvm_inl(void *opaque, uint16_t addr, uint32_t *data)
+{
+    *data = cpu_inl(0, addr);
+    return 0;
+}
+
+static int kvm_outb(void *opaque, uint16_t addr, uint8_t data)
+{
+    cpu_outb(0, addr, data);
+    return 0;
+}
+
+static int kvm_outw(void *opaque, uint16_t addr, uint16_t data)
+{
+    cpu_outw(0, addr, data);
+    return 0;
+}
+
+static int kvm_outl(void *opaque, uint16_t addr, uint32_t data)
+{
+    cpu_outl(0, addr, data);
+    return 0;
+}
+
+static int kvm_readb(void *opaque, uint64_t addr, uint8_t *data)
+{
+    *data = ldub_phys(addr);
+    return 0;
+}
+ 
+static int kvm_readw(void *opaque, uint64_t addr, uint16_t *data)
+{
+    *data = lduw_phys(addr);
+    return 0;
+}
+
+static int kvm_readl(void *opaque, uint64_t addr, uint32_t *data)
+{
+    *data = ldl_phys(addr);
+    return 0;
+}
+
+static int kvm_readq(void *opaque, uint64_t addr, uint64_t *data)
+{
+    *data = ldq_phys(addr);
+    return 0;
+}
+
+static int kvm_writeb(void *opaque, uint64_t addr, uint8_t data)
+{
+    stb_phys(addr, data);
+    return 0;
+}
+
+static int kvm_writew(void *opaque, uint64_t addr, uint16_t data)
+{
+    stw_phys(addr, data);
+    return 0;
+}
+
+static int kvm_writel(void *opaque, uint64_t addr, uint32_t data)
+{
+    stl_phys(addr, data);
+    return 0;
+}
+
+static int kvm_writeq(void *opaque, uint64_t addr, uint64_t data)
+{
+    stq_phys(addr, data);
+    return 0;
+}
+
+static int kvm_io_window(void *opaque)
+{
+    return 1;
+}
+
+ 
+static int kvm_halt(void *opaque, int vcpu)
+{
+    CPUState **envs = opaque, *env;
+
+    env = envs[0];
+    save_regs(env);
+
+    if (!((env->kvm_pending_int || 
+	   (env->interrupt_request & CPU_INTERRUPT_HARD)) && 
+	  (env->eflags & IF_MASK))) {
+	    env->hflags |= HF_HALTED_MASK;
+	    env->exception_index = EXCP_HLT;
+    }
+    return 1;
+}
+ 
+static struct kvm_callbacks qemu_kvm_ops = {
+    .cpuid = kvm_cpuid,
+    .debug = kvm_debug,
+    .inb   = kvm_inb,
+    .inw   = kvm_inw,
+    .inl   = kvm_inl,
+    .outb  = kvm_outb,
+    .outw  = kvm_outw,
+    .outl  = kvm_outl,
+    .readb = kvm_readb,
+    .readw = kvm_readw,
+    .readl = kvm_readl,
+    .readq = kvm_readq,
+    .writeb = kvm_writeb,
+    .writew = kvm_writew,
+    .writel = kvm_writel,
+    .writeq = kvm_writeq,
+    .halt  = kvm_halt,
+    .io_window = kvm_io_window,
+};
+
+void kvm_qemu_init()
+{
+    kvm_context = kvm_init(&qemu_kvm_ops, saved_env);
+    kvm_create(kvm_context, phys_ram_size, (void**)&phys_ram_base);
+}
+
+int kvm_update_debugger(CPUState *env)
+{
+    struct kvm_debug_guest dbg;
+    int i;
+
+    dbg.enabled = 0;
+    if (env->nb_breakpoints || env->singlestep_enabled) {
+	dbg.enabled = 1;
+	for (i = 0; i < 4 && i < env->nb_breakpoints; ++i) {
+	    dbg.breakpoints[i].enabled = 1;
+	    dbg.breakpoints[i].address = env->breakpoints[i];
+	}
+	dbg.singlestep = env->singlestep_enabled;
+    }
+    return kvm_guest_debug(kvm_context, 0, &dbg);
+}
+
+
+#endif
Index: qemu-kvm.h
===================================================================
--- qemu-kvm.h	(.../qemu-vendor-drops)	(revision 0)
+++ qemu-kvm.h	(.../release/qemu)	(revision 3256)
@@ -0,0 +1,11 @@
+#ifndef QEMU_KVM_H
+#define QEMU_KVM_H
+
+#include "kvmctl.h"
+
+void kvm_qemu_init(void);
+void kvm_load_registers(CPUState *env);
+int kvm_cpu_exec(CPUState *env);
+int kvm_update_debugger(CPUState *env);
+
+#endif
Index: vl.c
===================================================================
--- vl.c	(.../qemu-vendor-drops)	(revision 3256)
+++ vl.c	(.../release/qemu)	(revision 3256)
@@ -87,6 +87,10 @@
 
 #include "exec-all.h"
 
+#if USE_KVM
+#include "qemu-kvm.h"
+#endif
+
 #define DEFAULT_NETWORK_SCRIPT "/etc/qemu-ifup"
 
 //#define DEBUG_UNUSED_IOPORT
@@ -4587,6 +4593,9 @@
     /* XXX: compute hflags from scratch, except for CPL and IIF */
     env->hflags = hflags;
     tlb_flush(env, 1);
+#ifdef USE_KVM
+    kvm_load_registers(env);
+#endif
     return 0;
 }
 
@@ -4751,6 +4760,10 @@
     int i;
     qemu_put_be32(f, phys_ram_size);
     for(i = 0; i < phys_ram_size; i+= TARGET_PAGE_SIZE) {
+#ifdef USE_KVM
+        if ((i>=0xa0000) && (i<0xc0000)) /* do not access video-addresses */
+            continue;
+#endif
         ram_put_page(f, phys_ram_base + i, TARGET_PAGE_SIZE);
     }
 }
@@ -4764,6 +4777,10 @@
     if (qemu_get_be32(f) != phys_ram_size)
         return -EINVAL;
     for(i = 0; i < phys_ram_size; i+= TARGET_PAGE_SIZE) {
+#ifdef USE_KVM
+        if ((i>=0xa0000) && (i<0xc0000)) /* do not access video-addresses */
+            continue;
+#endif
         ret = ram_get_page(f, phys_ram_base + i, TARGET_PAGE_SIZE);
         if (ret)
             return ret;
@@ -6070,13 +6087,17 @@
     }
 
     /* init the memory */
+#if USE_KVM
+    phys_ram_size = ram_size + vga_ram_size + bios_size + KVM_EXTRA_PAGES * 4096;
+    kvm_qemu_init();
+#else
     phys_ram_size = ram_size + vga_ram_size + bios_size;
-
     phys_ram_base = qemu_vmalloc(phys_ram_size);
     if (!phys_ram_base) {
         fprintf(stderr, "Could not allocate physical memory\n");
         exit(1);
     }
+#endif
 
     /* we always create the cdrom drive, even if no disk is there */
     bdrv_init();
Index: vl.h
===================================================================
--- vl.h	(.../qemu-vendor-drops)	(revision 3256)
+++ vl.h	(.../release/qemu)	(revision 3256)
@@ -161,6 +161,10 @@
 #define BIOS_SIZE ((256 + 64) * 1024)
 #endif
 
+#if USE_KVM
+#define KVM_EXTRA_PAGES 3
+#endif
+
 /* keyboard/mouse support */
 
 #define MOUSE_EVENT_LBUTTON 0x01

--------------090001060309040800090801--
