Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262829AbVCPV7Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262829AbVCPV7Y (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 16:59:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262828AbVCPV6E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 16:58:04 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.141]:19402 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262826AbVCPVyT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 16:54:19 -0500
Date: Wed, 16 Mar 2005 15:45:58 -0600
From: Jake Moilanen <moilanen@austin.ibm.com>
To: Paul Mackerras <paulus@samba.org>
Cc: akpm@osdl.org, linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org,
       anton@samba.org, olof@austin.ibm.com, benh@kernel.crashing.org,
       amodra@bigpond.net.au
Subject: Re: [PATCH 1/2] No-exec support for ppc64
Message-Id: <20050316154558.7c634a23.moilanen@austin.ibm.com>
In-Reply-To: <16951.52721.139394.592636@cargo.ozlabs.ibm.com>
References: <20050308165904.0ce07112.moilanen@austin.ibm.com>
	<20050308170826.13a2299e.moilanen@austin.ibm.com>
	<20050310032213.GB20789@austin.ibm.com>
	<20050310162513.74191caa.moilanen@austin.ibm.com>
	<16949.25552.640180.677985@cargo.ozlabs.ibm.com>
	<20050314155125.68dcff70.moilanen@austin.ibm.com>
	<16950.3484.416343.832453@cargo.ozlabs.ibm.com>
	<20050315155135.11b942ef.moilanen@austin.ibm.com>
	<16951.52721.139394.592636@cargo.ozlabs.ibm.com>
Organization: IBM
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Mar 2005 17:10:57 +1100
Paul Mackerras <paulus@samba.org> wrote:

> Jake Moilanen writes:
> 
> > It does not work w/o the sys_mprotect.  It will hang in one of the first
> > few binaries.
> 
> Hmmm, what distro is this with?  I just tried a kernel with the patch
> below on a SLES9 install and a Debian install and it came up and ran
> just fine in both cases.

I'm not sure that the patch you sent is actually doing protection
correctly.

To test I commented out this line:

> +#define elf_read_implies_exec(ex, have_pt_gnu_stack)	(!(have_pt_gnu_stack))

and then ran a non-pt_gnu_stack binary which should have executed on a non-exec 
segment, it did not segfault.  
 
> + *
> + * Note due to the way vm flags are laid out, the bits are XWR
>   */
>  #define __P000	PAGE_NONE
> -#define __P001	PAGE_READONLY_X
> +#define __P001	PAGE_READONLY
>  #define __P010	PAGE_COPY
>  #define __P011	PAGE_COPY_X
>  #define __P100	PAGE_READONLY
>  #define __P101	PAGE_READONLY_X
> -#define __P110	PAGE_COPY
> +#define __P110	PAGE_COPY_X
>  #define __P111	PAGE_COPY_X


I think the problem was this hunk.  __P011 should be PAGE_COPY and
__P100 should be PAGE_READONLY_X.

Here is a patch ontop of the last patch you sent to fix this problem and
take another crack at doing the sys_mprotect less hackish.  

Signed-off-by: Jake Moilanen <moilanen@austin.ibm.com>

---

 linux-2.6.11.4-paulus-moilanen/fs/binfmt_elf.c             |   18 +++++++++----
 linux-2.6.11.4-paulus-moilanen/include/asm-ppc64/pgtable.h |    4 +-
 2 files changed, 15 insertions(+), 7 deletions(-)

diff -puN fs/binfmt_elf.c~more-nx fs/binfmt_elf.c
--- linux-2.6.11.4-paulus/fs/binfmt_elf.c~more-nx       2005-03-16 09:35:28 -06:00
+++ linux-2.6.11.4-paulus-moilanen/fs/binfmt_elf.c      2005-03-16 11:03:15 -06:00
@@ -88,7 +88,7 @@ static struct linux_binfmt elf_format =

 #define BAD_ADDR(x)    ((unsigned long)(x) > TASK_SIZE)

-static int set_brk(unsigned long start, unsigned long end)
+static int set_brk(unsigned long start, unsigned long end, int prot)
 {
        start = ELF_PAGEALIGN(start);
        end = ELF_PAGEALIGN(end);
@@ -99,6 +99,9 @@ static int set_brk(unsigned long start,
                up_write(&current->mm->mmap_sem);
                if (BAD_ADDR(addr))
                        return addr;
+
+               sys_mprotect(start, end-start, prot);
+
        }
        current->mm->start_brk = current->mm->brk = end;
        return 0;
@@ -529,6 +532,7 @@ static int load_elf_binary(struct linux_
        struct files_struct *files;
        int have_pt_gnu_stack, executable_stack = EXSTACK_DEFAULT;
        unsigned long def_flags = 0;
+       int bss_prot = 0;
        struct {
                struct elfhdr elf_ex;
                struct elfhdr interp_elf_ex;
@@ -811,7 +815,7 @@ static int load_elf_binary(struct linux_
                           before this one. Map anonymous pages, if needed,
                           and clear the area.  */
                        retval = set_brk (elf_bss + load_bias,
-                                         elf_brk + load_bias);
+                                         elf_brk + load_bias, bss_prot);
                        if (retval) {
                                send_sig(SIGKILL, current, 0);
                                goto out_free_dentry;
@@ -883,15 +887,19 @@ static int load_elf_binary(struct linux_

                k = elf_ppnt->p_vaddr + elf_ppnt->p_filesz;

-               if (k > elf_bss)
+               if (k > elf_bss) {
                        elf_bss = k;
+                       bss_prot = elf_prot;
+               }
                if ((elf_ppnt->p_flags & PF_X) && end_code < k)
                        end_code = k;
                if (end_data < k)
                        end_data = k;
                k = elf_ppnt->p_vaddr + elf_ppnt->p_memsz;
-               if (k > elf_brk)
+               if (k > elf_brk) {
                        elf_brk = k;
+                       bss_prot = elf_prot;
+               }
        }

        loc->elf_ex.e_entry += load_bias;
@@ -907,7 +915,7 @@ static int load_elf_binary(struct linux_
         * mapping in the interpreter, to make sure it doesn't wind
         * up getting placed where the bss needs to go.
         */
-       retval = set_brk(elf_bss, elf_brk);
+       retval = set_brk(elf_bss, elf_brk, bss_prot);
        if (retval) {
                send_sig(SIGKILL, current, 0);
                goto out_free_dentry;
diff -puN include/asm-ppc64/pgtable.h~more-nx include/asm-ppc64/pgtable.h
--- linux-2.6.11.4-paulus/include/asm-ppc64/pgtable.h~more-nx   2005-03-16 09:35:44 -06:00
+++ linux-2.6.11.4-paulus-moilanen/include/asm-ppc64/pgtable.h  2005-03-16 09:35:53 -06:00
@@ -137,8 +137,8 @@
 #define __P000 PAGE_NONE
 #define __P001 PAGE_READONLY
 #define __P010 PAGE_COPY
-#define __P011 PAGE_COPY_X
-#define __P100 PAGE_READONLY
+#define __P011 PAGE_COPY
+#define __P100 PAGE_READONLY_X
 #define __P101 PAGE_READONLY_X
 #define __P110 PAGE_COPY_X
 #define __P111 PAGE_COPY_X

_
