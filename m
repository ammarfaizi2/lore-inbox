Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932300AbWEHFII@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932300AbWEHFII (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 May 2006 01:08:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932306AbWEHFII
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 May 2006 01:08:08 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:38919 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S932300AbWEHFIH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 May 2006 01:08:07 -0400
Date: Mon, 8 May 2006 07:08:09 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Linus Torvalds <torvalds@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: [git patches] kbuild fixes for -rc
Message-ID: <20060508050809.GA2247@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus.
Please pull following fixes from the kbuild tree.

git pull git://git.kernel.org/pub/scm/linux/kernel/git/sam/kbuild.git

The modpost change repairing mips is the biggest change
but boils down to a fix for a binutils issue.
Other fixes are more cornercases.
Also the fix from Randy brings down the number of false
positives section mismatch warnings with allmodconfig.

diffstat + full log + full diff added below.

	Sam

Atsushi Nemoto:
      kbuild: fix modpost segfault for 64bit mipsel kernel

Jan Beulich:
      kbuild: Do not overwrite makefile as anohter user

Pavel Roskin:
      kbuild: removing .tmp_versions considered harmful

Randy Dunlap:
      kbuild modpost - relax driver data name

Sam Ravnborg:
      kbuild: fix gen_initramfs_list.sh
      kbuild: drivers/video/logo/ - fix ident glitch

 Makefile                      |   20 +++++++++-----------
 drivers/video/logo/Makefile   |    2 +-
 scripts/gen_initramfs_list.sh |    6 +++++-
 scripts/mkmakefile            |    5 ++++-
 scripts/mod/modpost.c         |   17 ++++++++++++-----
 scripts/mod/modpost.h         |   19 +++++++++++++++++++
 6 files changed, 50 insertions(+), 19 deletions(-)

commit fd5f0cd6b0cef59ba18e5ac13be5b2775fa6ec28
Author: Jan Beulich <jbeulich@novell.com>
Date:   Tue May 2 12:33:20 2006 +0200

    kbuild: Do not overwrite makefile as anohter user
    
    Change the conditional of the outputmakefile rule to be evaluated entirely
    in make, and add a conditional to not touch the generated makefile when e.g.
    running 'make install' as root while the build was done as non-root. Also
    adjust the comment describing this, and move the message printing and
    redirection to mkmakefile.
    
    Signed-off-by: Jan Beulich <jbeulich@novell.com>
    Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

commit cc873e1aa1fa916a485294117a9846e668505671
Author: Sam Ravnborg <sam@mars.ravnborg.org>
Date:   Sun Apr 30 23:59:16 2006 +0200

    kbuild: drivers/video/logo/ - fix ident glitch
    
    Jan Engelhardt <jengelh@linux01.gwdg.de> wrote:
    while compiling 2.6.17-rc2 with allyesconfig, this showed up:
    ...
      LOGO  drivers/video/logo/logo_superh_clut224.c
      CC      drivers/video/logo/logo_linux_mono.o
    ...
    
    A tab had sneaked in. Convert it to a few spaces.
    Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

commit 46ed981d5d203703a01137cc58c841d34e90c147
Author: Sam Ravnborg <sam@mars.ravnborg.org>
Date:   Sun Apr 30 23:56:33 2006 +0200

    kbuild: fix gen_initramfs_list.sh
    
    Create correct dependencies when specifying your own file with
    list of files etc. to include in initramfs.
    Reported by: Andre Noll <maan@skl-net.de>
    
    Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

commit 72ee59b5797e5d6fe32b5cf3473660a50a02db40
Author: Randy Dunlap <rdunlap@xenotime.net>
Date:   Sat Apr 15 11:17:12 2006 -0700

    kbuild modpost - relax driver data name
    
    Relax driver data name from *_driver to *driver.
    This fixes the 26 section mismatch warnings in drivers/ide/pci.
    
    Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
    Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

commit fca1dff218163ffd34d1e9e0b9b244e8c8803601
Author: Pavel Roskin <proski@gnu.org>
Date:   Mon Apr 24 15:55:27 2006 -0400

    kbuild: removing .tmp_versions considered harmful
    
    Remove *.mod files but not .tmp_versions for external builds
    
    When "make install" is run as root, .tmp_versions is re-created and
    becomes owned by root.  Subsequent "make" run by user fails because
    .tmp_versions cannot be removed.
    
    Signed-off-by: Pavel Roskin <proski@gnu.org>
    Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

commit c8d8b837ebe4b4f11e1b0c4a2bdc358c697692ed
Author: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Date:   Tue Apr 25 01:53:43 2006 +0900

    kbuild: fix modpost segfault for 64bit mipsel kernel
    
    64bit mips has different r_info layout.  This patch fixes modpost
    segfault for 64bit little endian mips kernel.
    
    Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
    Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

 
diff --git a/Makefile b/Makefile
index 6bf9962..9e4c569 100644
--- a/Makefile
+++ b/Makefile
@@ -344,16 +344,14 @@ # To avoid any implicit rule to kick in,
 scripts/basic/%: scripts_basic ;
 
 PHONY += outputmakefile
-# outputmakefile generate a Makefile to be placed in output directory, if
-# using a seperate output directory. This allows convinient use
-# of make in output directory
+# outputmakefile generates a Makefile in the output directory, if using a
+# separate output directory. This allows convenient use of make in the
+# output directory.
 outputmakefile:
-	$(Q)if test ! $(srctree) -ef $(objtree); then \
-	$(CONFIG_SHELL) $(srctree)/scripts/mkmakefile              \
-	    $(srctree) $(objtree) $(VERSION) $(PATCHLEVEL)         \
-	    > $(objtree)/Makefile;                                 \
-	    echo '  GEN    $(objtree)/Makefile';                   \
-	fi
+ifneq ($(KBUILD_SRC),)
+	$(Q)$(CONFIG_SHELL) $(srctree)/scripts/mkmakefile \
+	    $(srctree) $(objtree) $(VERSION) $(PATCHLEVEL)
+endif
 
 # To make sure we do not include .config for any of the *config targets
 # catch them early, and hand them over to scripts/kconfig/Makefile
@@ -796,8 +794,8 @@ prepare2: prepare3 outputmakefile
 prepare1: prepare2 include/linux/version.h include/asm \
                    include/config/MARKER
 ifneq ($(KBUILD_MODULES),)
-	$(Q)rm -rf $(MODVERDIR)
 	$(Q)mkdir -p $(MODVERDIR)
+	$(Q)rm -f $(MODVERDIR)/*
 endif
 
 archprepare: prepare1 scripts_basic
@@ -1086,8 +1084,8 @@ # We are always building modules
 KBUILD_MODULES := 1
 PHONY += crmodverdir
 crmodverdir:
-	$(Q)rm -rf $(MODVERDIR)
 	$(Q)mkdir -p $(MODVERDIR)
+	$(Q)rm -f $(MODVERDIR)/*
 
 PHONY += $(objtree)/Module.symvers
 $(objtree)/Module.symvers:
diff --git a/drivers/video/logo/Makefile b/drivers/video/logo/Makefile
index 4ef5cd1..b985dfa 100644
--- a/drivers/video/logo/Makefile
+++ b/drivers/video/logo/Makefile
@@ -34,7 +34,7 @@ # Gray 256
 extra-y += $(call logo-cfiles,_gray256,pgm)
 
 # Create commands like "pnmtologo -t mono -n logo_mac_mono -o ..."
-quiet_cmd_logo = LOGO	$@
+quiet_cmd_logo = LOGO    $@
 	cmd_logo = scripts/pnmtologo \
 			-t $(patsubst $*_%,%,$(notdir $(basename $<))) \
 			-n $(notdir $(basename $<)) -o $@ $<
diff --git a/scripts/gen_initramfs_list.sh b/scripts/gen_initramfs_list.sh
index 56b3bed..331c079 100644
--- a/scripts/gen_initramfs_list.sh
+++ b/scripts/gen_initramfs_list.sh
@@ -200,7 +200,11 @@ input_file() {
 			print_mtime "$1" >> ${output}
 			cat "$1"         >> ${output}
 		else
-			grep ^file "$1" | cut -d ' ' -f 3
+			cat "$1" | while read type dir file perm ; do
+				if [ "$type" == "file" ]; then
+					echo "$file \\";
+				fi
+			done
 		fi
 	elif [ -d "$1" ]; then
 		dir_filelist "$1"
diff --git a/scripts/mkmakefile b/scripts/mkmakefile
index a22cbed..7f9d544 100644
--- a/scripts/mkmakefile
+++ b/scripts/mkmakefile
@@ -10,7 +10,10 @@ # $3 - version
 # $4 - patchlevel
 
 
-cat << EOF
+test ! -r $2/Makefile -o -O $2/Makefile || exit 0
+echo "  GEN     $2/Makefile"
+
+cat << EOF > $2/Makefile
 # Automatically generated by $0: don't edit
 
 VERSION = $3
diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index cd00e9f..b36e884 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -487,14 +487,14 @@ static int strrcmp(const char *s, const 
  *   atsym   =__param*
  *
  * Pattern 2:
- *   Many drivers utilise a *_driver container with references to
+ *   Many drivers utilise a *driver container with references to
  *   add, remove, probe functions etc.
  *   These functions may often be marked __init and we do not want to
  *   warn here.
  *   the pattern is identified by:
  *   tosec   = .init.text | .exit.text | .init.data
  *   fromsec = .data
- *   atsym = *_driver, *_template, *_sht, *_ops, *_probe, *probe_one
+ *   atsym = *driver, *_template, *_sht, *_ops, *_probe, *probe_one
  **/
 static int secref_whitelist(const char *tosec, const char *fromsec,
 			    const char *atsym)
@@ -502,7 +502,7 @@ static int secref_whitelist(const char *
 	int f1 = 1, f2 = 1;
 	const char **s;
 	const char *pat2sym[] = {
-		"_driver",
+		"driver",
 		"_template", /* scsi uses *_template a lot */
 		"_sht",      /* scsi also used *_sht to some extent */
 		"_ops",
@@ -709,10 +709,17 @@ static void check_sec_ref(struct module 
 		for (rela = start; rela < stop; rela++) {
 			Elf_Rela r;
 			const char *secname;
+			unsigned int r_sym;
 			r.r_offset = TO_NATIVE(rela->r_offset);
-			r.r_info   = TO_NATIVE(rela->r_info);
+			if (hdr->e_ident[EI_CLASS] == ELFCLASS64 &&
+			    hdr->e_machine == EM_MIPS) {
+				r_sym = ELF64_MIPS_R_SYM(rela->r_info);
+				r_sym = TO_NATIVE(r_sym);
+			} else {
+				r_sym = ELF_R_SYM(TO_NATIVE(rela->r_info));
+			}
 			r.r_addend = TO_NATIVE(rela->r_addend);
-			sym = elf->symtab_start + ELF_R_SYM(r.r_info);
+			sym = elf->symtab_start + r_sym;
 			/* Skip special sections */
 			if (sym->st_shndx >= SHN_LORESERVE)
 				continue;
diff --git a/scripts/mod/modpost.h b/scripts/mod/modpost.h
index b14255c..89b96c6 100644
--- a/scripts/mod/modpost.h
+++ b/scripts/mod/modpost.h
@@ -39,6 +39,25 @@ #define ELF_R_SYM   ELF64_R_SYM
 #define ELF_R_TYPE  ELF64_R_TYPE
 #endif
 
+/* The 64-bit MIPS ELF ABI uses an unusual reloc format. */
+typedef struct
+{
+  Elf32_Word    r_sym;		/* Symbol index */
+  unsigned char r_ssym;		/* Special symbol for 2nd relocation */
+  unsigned char r_type3;	/* 3rd relocation type */
+  unsigned char r_type2;	/* 2nd relocation type */
+  unsigned char r_type1;	/* 1st relocation type */
+} _Elf64_Mips_R_Info;
+
+typedef union
+{
+  Elf64_Xword	r_info_number;
+  _Elf64_Mips_R_Info r_info_fields;
+} _Elf64_Mips_R_Info_union;
+
+#define ELF64_MIPS_R_SYM(i) \
+  ((__extension__ (_Elf64_Mips_R_Info_union)(i)).r_info_fields.r_sym)
+
 #if KERNEL_ELFDATA != HOST_ELFDATA
 
 static inline void __endian(const void *src, void *dest, unsigned int size)
