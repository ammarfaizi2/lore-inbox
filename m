Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261312AbVF1LZG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261312AbVF1LZG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 07:25:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261320AbVF1LZB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 07:25:01 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:5034 "EHLO e34.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S261312AbVF1LYX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 07:24:23 -0400
Date: Tue, 28 Jun 2005 16:54:12 +0530
From: Vivek Goyal <vgoyal@in.ibm.com>
To: gdb@sources.redhat.com, dan@debian.org
Cc: Fastboot mailing list <fastboot@lists.osdl.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Morton Andrew Morton <akpm@osdl.org>, bunk@stusta.de, alexn@dsv.su.se
Subject: Re: [Fastboot] Re: [-mm patch] i386: enable REGPARM by default
Message-ID: <20050628112412.GB5652@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
References: <20050624200916.GJ6656@stusta.de> <20050624132826.4cdfb63c.akpm@osdl.org> <20050627132941.GD3764@in.ibm.com> <20050627140029.GB29121@nevyn.them.org> <20050628045111.GB4296@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050628045111.GB4296@in.ibm.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Thanks. Any idea what might be amiss with my case where I am not seeing 
> proper function parameter values while analyzing kdump generated crash
> dump with gdb. I am using following gdb and gcc versions.
> 
> GNU gdb Red Hat Linux (6.1post-1.20040607.62rh)
> gcc (GCC) 3.4.3 20041212 (Red Hat 3.4.3-9.EL4)
> 

Some more info. I dumped the stack contents and it seems that stack is fine 
and parameters are intact on stack. So now it seems to be a matter of 
how gdb is interpreting the stack contents. Any guess, what the problem is?
Why func2() and func1() are not showing right parameter values. 

Unfortunately I lost the previous dump image and vmlinux. I have taken a
fresh dump and reproduced the problem again. So I am reporting all the 
details again.

- Test Patch
- gdb back trace
- Raw stack dump
- Relevant vmlinux objdump output.

Thanks
Vivek 

Following is the test patch I applied on 2.6.12-rc6-mm1.

---

 linux-2.6.12-rc6-mm1-1M-root/kernel/ksysfs.c |   23 +++++++++++++++++++++++
 1 files changed, 23 insertions(+)

diff -puN kernel/ksysfs.c~kdump-gdb-stack-debug kernel/ksysfs.c
--- linux-2.6.12-rc6-mm1-1M/kernel/ksysfs.c~kdump-gdb-stack-debug	2005-06-27 16:32:18.000000000 +0530
+++ linux-2.6.12-rc6-mm1-1M-root/kernel/ksysfs.c	2005-06-28 11:01:57.000000000 +0530
@@ -30,6 +30,19 @@ static ssize_t hotplug_seqnum_show(struc
 KERNEL_ATTR_RO(hotplug_seqnum);
 #endif
 
+int func2(int a, int *b, char c)
+{
+	printk("a=%d, b=%p, c=%c \n", a, b, c);
+	panic("Vivek: Invoked panic\n");
+	return 0;
+}
+int func1(int a, int *b, char c)
+{
+	printk("a=%d, b=%p, c=%c\n", a, b, c);
+	func2(a, b, c);
+	return 0;
+}
+
 #ifdef CONFIG_KEXEC
 #include <asm/kexec.h>
 
@@ -38,6 +51,15 @@ static ssize_t crash_notes_show(struct s
 	return sprintf(page, "%p\n", (void *)crash_notes);
 }
 KERNEL_ATTR_RO(crash_notes);
+static ssize_t stack_debug_show(struct subsystem *subsys, char *page)
+{
+	int a=20;
+	int *b=&a;
+	char c='d';
+	func1(a, b, c);
+	return sprintf(page, "%s\n", "copied");
+}
+KERNEL_ATTR_RO(stack_debug);
 #endif
 
 decl_subsys(kernel, NULL, NULL);
@@ -49,6 +71,7 @@ static struct attribute * kernel_attrs[]
 #endif
 #ifdef CONFIG_KEXEC
 	&crash_notes_attr.attr,
+	&stack_debug_attr.attr,
 #endif
 	NULL
 };


Following is the stack trace I received from gdb when it opened kdump
generated kernel dump image.

(gdb) bt
#0  0xc0113d22 in crash_get_current_regs (regs=0xec9cfe6c)
    at arch/i386/kernel/crash.c:102
#1  0xc0113d9d in crash_save_self (saved_regs=0xec9cfe6c)
    at arch/i386/kernel/crash.c:134
#2  0xc013d19a in crash_kexec (regs=0x3) at kernel/kexec.c:1059
#3  0xc011c999 in panic (fmt=0x3 <Address 0x3 out of bounds>)
    at kernel/panic.c:86
#4  0xc014086a in func2 (a=3, b=0x3, c=100 'd') at kernel/ksysfs.c:36
#5  0xc01408a5 in func1 (a=20, b=0xc044cae8, c=100 'd') at kernel/ksysfs.c:42
#6  0xc01408f8 in stack_debug_show (subsys=0xc044cb00,
    page=0x3 <Address 0x3 out of bounds>) at kernel/ksysfs.c:59
#7  0xc0198e3f in subsys_attr_show (kobj=0xc044cb18, attr=0x3,
    page=0x3 <Address 0x3 out of bounds>) at fs/sysfs/file.c:30
#8  0xc0198ed8 in fill_read_buffer (dentry=0x1, buffer=0xefd9bda0)
    at fs/sysfs/file.c:86
#9  0xc0198fe7 in sysfs_read_file (file=0x1,
    buf=0x3 <Address 0x3 out of bounds>, count=3, ppos=0x3)
    at fs/sysfs/file.c:153
#10 0xc0160599 in vfs_read (file=0xedafd560,
    buf=0x804d858 <Address 0x804d858 out of bounds>, count=4096,
    pos=0xec9cffa4) at fs/read_write.c:238
#11 0xc0160871 in sys_read (fd=3, buf=0x3 <Address 0x3 out of bounds>, count=3)
    at fs/read_write.c:321


Following is the raw stack dump. I have tried segregating/mapping calls to 
func1 and func2.


(gdb) info registers
eax            0x3      3
ecx            0xec9cfe6c       -325255572
edx            0x1      1
ebx            0xec9cfe6c       -325255572
esp            0xec9cfe60       0xec9cfe60
ebp            0xc044cae8       0xc044cae8
esi            0x3      3
edi            0x14     20
eip            0xc0113d22       0xc0113d22
eflags         0x46     70
cs             0x60     96
ss             0x68     104
ds             0x7b     123
es             0x7b     123
fs             0x0      0
gs             0x33     51

(gdb) x/100x 0xec9cfe60
0xec9cfe60:     0xc0113d9d      0xec9cfe6c      0x00000003      0xec9cfe6c
0xec9cfe70:     0xec9cfe6c      0x00000001      0x00000003      0x00000000
0xec9cfe80:     0xc044c000      0x00000003      0x00000000      0xc0113a75
0xec9cfe90:     0x00000004      0x013ef000      0x01455498      0x00000001
0xec9cfea0:     0x013ef000      0xefc948a0      0xec9cff1c      0x00000014
0xec9cfeb0:     0xc044cae8      0xc013d19a      0xefc948a0      0x00000064
0xec9cfec0:     0xc011c999      0x00000000      0xc054e140      0xc03f3d4e
0xec9cfed0:     0xec9cfee0      0x00000064      0xc014086a      0xc03f3d39
0xec9cfee0:     0x00000014
                0xec9cff1c
                0x00000064
                0xc01408a5      (Call to func2)
0xec9cfef0:     0x00000014      (parameter a)
                0xec9cff1c      (parameter b)
                0x00000064      (parameter c)
                0x00000064
0xec9cff00:     0xc044cb00   
                0xc044cb18  
                0xc04537a0 
                0xc01408f8      (Call to func1)
0xec9cff10:     0x00000014      (parameter a)
                0xec9cff1c      (parameter b)
                0x00000064      (parameter c)
                0x00000014
0xec9cff20:     0xc0198e3f      0xc044cb00      0xeccfc000      0xefd9bda0


Following is objdump output of vmlinux. (Snippet of relevant portion)

c0140836 <func2>:
c0140836:       83 ec 10                sub    $0x10,%esp
c0140839:       0f be 44 24 1c          movsbl 0x1c(%esp),%eax
c014083e:       c7 04 24 26 3d 3f c0    movl   $0xc03f3d26,(%esp)
c0140845:       89 44 24 0c             mov    %eax,0xc(%esp)
c0140849:       8b 44 24 18             mov    0x18(%esp),%eax
c014084d:       89 44 24 08             mov    %eax,0x8(%esp)
c0140851:       8b 44 24 14             mov    0x14(%esp),%eax
c0140855:       89 44 24 04             mov    %eax,0x4(%esp)
c0140859:       e8 b6 c9 fd ff          call   c011d214 <printk>
c014085e:       c7 04 24 39 3d 3f c0    movl   $0xc03f3d39,(%esp)
c0140865:       e8 c5 c0 fd ff          call   c011c92f <panic>


c014086a <func1>:
c014086a:       57                      push   %edi
c014086b:       56                      push   %esi
c014086c:       53                      push   %ebx
c014086d:       83 ec 10                sub    $0x10,%esp
c0140870:       8b 7c 24 20             mov    0x20(%esp),%edi
c0140874:       8b 74 24 24             mov    0x24(%esp),%esi
c0140878:       0f be 5c 24 28          movsbl 0x28(%esp),%ebx
c014087d:       89 5c 24 0c             mov    %ebx,0xc(%esp)
c0140881:       89 74 24 08             mov    %esi,0x8(%esp)
c0140885:       89 7c 24 04             mov    %edi,0x4(%esp)
c0140889:       c7 04 24 4f 3d 3f c0    movl   $0xc03f3d4f,(%esp)
c0140890:       e8 7f c9 fd ff          call   c011d214 <printk>
c0140895:       89 5c 24 08             mov    %ebx,0x8(%esp)
c0140899:       89 74 24 04             mov    %esi,0x4(%esp)
c014089d:       89 3c 24                mov    %edi,(%esp)
c01408a0:       e8 91 ff ff ff          call   c0140836 <func2>
c01408a5:       31 c0                   xor    %eax,%eax
c01408a7:       83 c4 10                add    $0x10,%esp
c01408aa:       5b                      pop    %ebx
c01408ab:       5e                      pop    %esi
c01408ac:       5f                      pop    %edi
c01408ad:       c3                      ret

c01408d1 <stack_debug_show>:
c01408d1:       83 ec 10                sub    $0x10,%esp
c01408d4:       8d 44 24 0c             lea    0xc(%esp),%eax
c01408d8:       c7 44 24 0c 14 00 00    movl   $0x14,0xc(%esp)
c01408df:       00
c01408e0:       c7 44 24 08 64 00 00    movl   $0x64,0x8(%esp)
c01408e7:       00
c01408e8:       89 44 24 04             mov    %eax,0x4(%esp)
c01408ec:       c7 04 24 14 00 00 00    movl   $0x14,(%esp)
c01408f3:       e8 72 ff ff ff          call   c014086a <func1>
c01408f8:       8b 44 24 18             mov    0x18(%esp),%eax
c01408fc:       c7 44 24 08 6d 3d 3f    movl   $0xc03f3d6d,0x8(%esp)
c0140903:       c0
c0140904:       c7 44 24 04 36 67 40    movl   $0xc0406736,0x4(%esp)
c014090b:       c0
c014090c:       89 04 24                mov    %eax,(%esp)
c014090f:       e8 64 94 0c 00          call   c0209d78 <sprintf>
c0140914:       83 c4 10                add    $0x10,%esp
c0140917:       c3                      ret
