Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266923AbSKOXeH>; Fri, 15 Nov 2002 18:34:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266839AbSKOXeH>; Fri, 15 Nov 2002 18:34:07 -0500
Received: from smtpzilla3.xs4all.nl ([194.109.127.139]:48909 "EHLO
	smtpzilla3.xs4all.nl") by vger.kernel.org with ESMTP
	id <S266940AbSKOXeB>; Fri, 15 Nov 2002 18:34:01 -0500
Date: Sat, 16 Nov 2002 00:40:48 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Rusty Russell <rusty@rustcorp.com.au>
cc: linux-kernel@vger.kernel.org
Subject: [RFC] mini user space module loader
Message-ID: <Pine.LNX.4.44.0211160002460.2113-100000@serv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Below you can find the minimum implementation to load a module from user 
space without bloating the kernel. I tested it a bit under uml and it 
seems to work fine.
In order to load the module it must be prelinked, what is done with "ld -r 
mod.o init/module.o -T modules.lds -o new.mod.o". It's not integrated into 
kbuild yet, so that step still has to be done manually, but the important 
point is that the resulting module can be loaded by the old insmod _and_ 
by the new insmod. This means we can gradually clean up the module code 
and drop the backward compatibility with 2.7, when the new tools are 
complete and stable. 
What's missing:
- argument must be parsed in the kernel (until we have a better interface 
  to pass arguments to the kernel)
- module deps have to be added (easy to do, but could as well be managed 
  in user space).

This is how the alternative could look like. The program can be easily 
turned into a library, so we can change the kernel-module interface as 
much as we like, especially we can move more out of the kernel instead 
shoving everything into it.
Any comments are welcome. If everyone thinks a kernel loader is way 
cooler, that's fine with me, but below is the proof that it's not the only 
option.

bye, Roman

#include <ctype.h>
#include <elf.h>
#include <fcntl.h>
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <unistd.h>
#include <syscall.h>
#include <sys/stat.h>

struct symbol {
	struct symbol *next;
	Elf32_Addr addr;
	char *name;
} *symlist;

//#define DPRINTF(fmt, ...) printf(fmt, ## __VA_ARGS__)
#define DPRINTF(fmt, ...)

static struct symbol *add_symbol(Elf32_Addr addr, char *name)
{
	struct symbol *sym;

	DPRINTF("%x: %s\n", addr, name);
	sym = calloc(1, sizeof(*sym));
	sym->addr = addr;
	sym->name = name;
	sym->next = symlist;
	symlist = sym;

	return sym;
}

static struct symbol *find_symbol(char *name)
{
	struct symbol *sym;

	for (sym = symlist; sym; sym = sym->next) {
		if (!strcmp(sym->name, name))
			break;
	}
	return sym;
}

int main(int ac, char **av)
{
	int fd;
	struct stat st;
	char *mod, *mod2, *ksyms, *str;
	char *name, *tmp, ch;
	char *mod_name, *mod_arg;
	Elf32_Ehdr *ehdr;
	Elf32_Shdr *shdr;
	Elf32_Addr addr, base, mod_size;
	struct symbol *sym, *name_sym, *args_sym, *this_sym;
	int i, symsize, offset, res;

	if (ac <= 1) {
		printf("usage: %s module [arg]\n", av[0]);
		exit(1);
	}
	mod_arg = ac > 2 ? av[2] : "";

	fd = open(av[1], O_RDONLY);
	if (fd == -1)
		exit(1);
	fstat(fd, &st);
	mod = malloc(st.st_size);
	read(fd, mod, st.st_size);
	close(fd);

	mod_name = strchr(av[1], '/');
	if (mod_name)
		mod_name++;
	else
		mod_name = av[1];
	tmp = strrchr(mod_name, '.');
	if (tmp)
		*tmp = 0;

	fd = open("/proc/ksyms", O_RDONLY);
	if (fd == -1)
		exit(1);
	ksyms = NULL;
	symsize = offset = 0;
	while (1) {
		if (offset + 1024 >= symsize)
			ksyms = realloc(ksyms, symsize += 4096);
		res = read(fd, ksyms + offset, symsize - offset);
		if (res <= 0)
			break;
		offset += res;
	}
	close(fd);

	for (tmp = ksyms; tmp < ksyms + offset; tmp++) {
		addr = strtoul(tmp, &tmp, 16);
		while (isspace(*tmp))
			tmp++;
		name = tmp;
		while (!isspace(*tmp))
			tmp++;
		ch = *tmp;
		*tmp = 0;
		add_symbol(addr, name);
		while (ch != '\n')
			ch = *++tmp;
	}
	this_sym = add_symbol(0, "__this_module");
	name_sym = add_symbol(0, "__module_name");
	args_sym = add_symbol(0, "__module_args");

	ehdr = (Elf32_Ehdr *)mod;
	if (memcmp(ehdr->e_ident, ELFMAG, SELFMAG) || ehdr->e_type != ET_REL)
		exit(1);

	shdr = (Elf32_Shdr *)(mod + ehdr->e_shoff);
	str = (char *)(mod + shdr[ehdr->e_shstrndx].sh_offset);
	addr = 0;
	for (i = 0; i < ehdr->e_shnum; i++) {
		DPRINTF("%d:%s: %d,%x,%d, %d,%x\n", i, str + shdr[i].sh_name,
			shdr[i].sh_type, shdr[i].sh_flags,
			shdr[i].sh_addralign, shdr[i].sh_link, shdr[i].sh_info);
		if (shdr[i].sh_flags & SHF_ALLOC) {
			addr += shdr[i].sh_addralign - 1;
			addr -= addr % shdr[i].sh_addralign;
			shdr[i].sh_addr = addr;
			addr += shdr[i].sh_size;
		}
		if (shdr[i].sh_type == SHT_SYMTAB) {
			Elf32_Sym *esym = (Elf32_Sym *)(mod + shdr[i].sh_offset);
			Elf32_Sym *end = (Elf32_Sym *)(mod + shdr[i].sh_offset + shdr[i].sh_size);
			char *symstr = (char *)(mod + shdr[shdr[i].sh_link].sh_offset);
			for (esym++; esym < end; esym++) {
				//if (!esym->st_name)
				//	goto next;
				DPRINTF("  %s:%d:%x,%d (%d,%d)\n", symstr + esym->st_name,
					esym->st_shndx, esym->st_value, esym->st_size,
					ELF32_ST_BIND(esym->st_info),
					ELF32_ST_TYPE(esym->st_info));
				if (esym->st_shndx == SHN_UNDEF) {
					sym = find_symbol(symstr + esym->st_name);
					if (!sym) {
						printf("%s undefined!\n", symstr + esym->st_name);
						exit(1);
					} else
						DPRINTF("    -> %x\n", sym->addr);
				}
			}
		}
	}

	mod_size = addr + strlen(mod_name) + strlen(mod_arg) + 2;
	DPRINTF("%x (%x)\n", addr, mod_size);
	base = syscall(SYS_create_module, mod_name, mod_size);
	mod2 = calloc(1, mod_size);
	this_sym->addr = base;
	name_sym->addr = base + addr;
	strcpy(mod2 + addr, mod_name);
	args_sym->addr = base + addr + strlen(mod_name) + 1;
	strcpy(mod2 + addr + strlen(mod_name) + 1, mod_arg);

	for (i = 0; i < ehdr->e_shnum; i++) {
		switch (shdr[i].sh_type) {
		case SHT_PROGBITS:
			if (shdr[i].sh_flags & SHF_ALLOC)
				memcpy(mod2 + shdr[i].sh_addr, mod + shdr[i].sh_offset, shdr[i].sh_size);
			break;
		case SHT_SYMTAB:
		    {
			Elf32_Sym *esym = (Elf32_Sym *)(mod + shdr[i].sh_offset);
			Elf32_Sym *end = (Elf32_Sym *)(mod + shdr[i].sh_offset + shdr[i].sh_size);
			char *symstr = (char *)(mod + shdr[shdr[i].sh_link].sh_offset);
			for (esym++; esym < end; esym++) {
				//if (!esym->st_name)
				//	continue;
				if (esym->st_shndx == SHN_UNDEF) {
					sym = find_symbol(symstr + esym->st_name);
					if (sym)
						esym->st_value = sym->addr;
				} else if (esym->st_shndx == SHN_ABS) {
					/* nothing */
				} else if (esym->st_shndx == SHN_COMMON) {
					printf("FIXME!\n");
				} else {
					if (ELF32_ST_BIND(esym->st_info) == STB_WEAK &&
					    (sym = find_symbol(symstr + esym->st_name))) {
						esym->st_value = sym->addr;
					} else
						esym->st_value += base + shdr[esym->st_shndx].sh_addr;
				}
			}
			break;
		    }
		}
	}

	for (i = 0; i < ehdr->e_shnum; i++) {
		DPRINTF("section %d\n", i);
		switch (shdr[i].sh_type) {
		case SHT_REL:
		    {
			Elf32_Rel *rel = (Elf32_Rel *)(mod + shdr[i].sh_offset);
			Elf32_Rel *end = (Elf32_Rel *)(mod + shdr[i].sh_offset + shdr[i].sh_size);
			Elf32_Sym *esym = (Elf32_Sym *)(mod + shdr[shdr[i].sh_link].sh_offset);
			char *sec_addr = mod2 + shdr[shdr[i].sh_info].sh_addr;
			Elf32_Addr sec_base = base + shdr[shdr[i].sh_info].sh_addr;

			if (!(shdr[shdr[i].sh_info].sh_flags & SHF_ALLOC))
				break;
			for (; rel < end; rel++) {
				addr = esym[ELF32_R_SYM(rel->r_info)].st_value;
				DPRINTF("%d,%x,%x,%x\n", ELF32_R_TYPE(rel->r_info),
					sec_base, rel->r_offset, addr);
				switch (ELF32_R_TYPE(rel->r_info)) {
				case R_386_32:
					*(int*)(sec_addr + rel->r_offset) += addr;
					break;
				case R_386_PC32:
					*(int*)(sec_addr + rel->r_offset) += addr - (sec_base + rel->r_offset);
					break;
				default:
					printf("Fix me!!!");
				}
			}
			break;
		    }
		case SHT_RELA:
			printf("Fix me!!!");
			break;
		}
	}
	base = syscall(SYS_init_module, mod_name, mod2);

	return 0;
}


diff -Nur linux-2.5.org/include/linux/module.h linux-minimod/include/linux/module.h
--- linux-2.5.org/include/linux/module.h	2002-11-11 19:57:11.000000000 +0100
+++ linux-minimod/include/linux/module.h	2002-11-15 23:59:28.000000000 +0100
@@ -82,6 +82,13 @@
 	const char *kernel_data;	/* Reserved for kernel internal use */
 };
 
+struct module_new
+{
+	struct module old_module;
+	struct module_symbol *syms_end;
+	char *arg;
+};
+
 struct module_info
 {
 	unsigned long addr;
@@ -278,7 +285,8 @@
   __attribute__((section(".modinfo"), unused)) = "license=" license
 
 /* Define the module variable, and usage macros.  */
-extern struct module __this_module;
+extern struct module_new __module_initdata __attribute__ ((section (".module_initdata")));
+extern struct module __this_module __attribute__ ((weak));
 
 #define THIS_MODULE		(&__this_module)
 #define MOD_INC_USE_COUNT	__MOD_INC_USE_COUNT(THIS_MODULE)
diff -Nur linux-2.5.org/init/Makefile linux-minimod/init/Makefile
--- linux-2.5.org/init/Makefile	2002-11-05 00:29:32.000000000 +0100
+++ linux-minimod/init/Makefile	2002-11-15 23:59:28.000000000 +0100
@@ -3,6 +3,7 @@
 #
 
 obj-y    := main.o version.o do_mounts.o initramfs.o
+obj-m    := module.o
 
 # files to be removed upon make clean
 clean-files := ../include/linux/compile.h
diff -Nur linux-2.5.org/init/module.c linux-minimod/init/module.c
--- linux-2.5.org/init/module.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-minimod/init/module.c	2002-11-15 23:59:46.000000000 +0100
@@ -0,0 +1,25 @@
+#include <linux/module.h>
+
+extern int init_module(void); 
+extern void cleanup_module(void);
+extern struct module_symbol __syms_start;
+extern struct module_symbol __syms_end;
+extern const struct exception_table_entry __ex_table_start;
+extern const struct exception_table_entry __ex_table_end;
+char __module_name[] __attribute__ ((weak)) = "";
+char __module_args[] __attribute__ ((weak)) = "";
+
+struct module_new __module_initdata __attribute__ ((section (".module_initdata"))) = {
+	.old_module	= {
+		.name 		= __module_name,
+		.init		= init_module,
+		.cleanup	= cleanup_module,
+		.syms		= &__syms_start,
+		.ex_table_start	= &__ex_table_start,
+		.ex_table_end	= &__ex_table_end,
+	},
+	.syms_end	= &__syms_end,
+	.arg		= __module_args,
+};
+
+struct module __this_module;
diff -Nur linux-2.5.org/kernel/module.c linux-minimod/kernel/module.c
--- linux-2.5.org/kernel/module.c	2002-11-05 00:29:33.000000000 +0100
+++ linux-minimod/kernel/module.c	2002-11-15 23:59:28.000000000 +0100
@@ -355,7 +355,7 @@
 sys_init_module(const char *name_user, struct module *mod_user)
 {
 	struct module mod_tmp, *mod;
-	char *name, *n_name, *name_tmp = NULL;
+	char *name, *n_name = NULL, *name_tmp = NULL;
 	long namelen, n_namelen, i, error;
 	unsigned long mod_user_size;
 	struct module_ref *dep;
@@ -377,7 +377,9 @@
 	   for a newer kernel.  But don't over do it. */
 	if ((error = get_user(mod_user_size, &mod_user->size_of_struct)) != 0)
 		goto err1;
-	if (mod_user_size < (unsigned long)&((struct module *)0L)->persist_start
+	if (!mod_user_size) {
+		mod_user_size = sizeof(struct module_new);
+	} else if (mod_user_size < (unsigned long)&((struct module *)0L)->persist_start
 	    || mod_user_size > sizeof(struct module) + 16*sizeof(void*)) {
 		printk(KERN_ERR "init_module: Invalid module header size.\n"
 		       KERN_ERR "A new version of the modutils is likely "
@@ -405,7 +407,11 @@
 	/* Sanity check the size of the module.  */
 	error = -EINVAL;
 
-	if (mod->size > mod_tmp.size) {
+	if (!mod->size) {
+		struct module_new *new_mod = (struct module_new *)mod;
+		mod->size = mod_tmp.size;
+		mod->nsyms = new_mod->syms_end - mod->syms;
+	} else if (mod->size > mod_tmp.size) {
 		printk(KERN_ERR "init_module: Size of initialized module "
 				"exceeds size of created module.\n");
 		goto err2;
@@ -484,6 +490,7 @@
 
 	/* Check that the user isn't doing something silly with the name.  */
 
+	if (mod->size_of_struct) {
 	if ((n_namelen = get_mod_name(mod->name - (unsigned long)mod
 				      + (unsigned long)mod_user,
 				      &n_name)) < 0) {
@@ -497,6 +504,7 @@
 		       n_name, mod_tmp.name);
 		goto err3;
 	}
+	}
 
 	/* Ok, that's about all the sanity we can stomach; copy the rest.  */
 
@@ -552,7 +560,8 @@
 	}
 
 	/* Free our temporary memory.  */
-	put_mod_name(n_name);
+	if (n_name)
+		put_mod_name(n_name);
 	put_mod_name(name);
 
 	/* Initialize the module.  */
diff -Nur linux-2.5.org/modules.lds linux-minimod/modules.lds
--- linux-2.5.org/modules.lds	1970-01-01 01:00:00.000000000 +0100
+++ linux-minimod/modules.lds	2002-11-15 23:59:53.000000000 +0100
@@ -0,0 +1,24 @@
+SECTIONS
+{
+        .module : {
+		*(.module_initdata)
+	}
+        .text : {
+                *(.text)
+                PROVIDE(init_module = 0);
+                PROVIDE(cleanup_module = 0);
+        }
+        .data : { *(.data) }
+        .syms : {
+                __syms_start = .;
+                *(__ksymtab)
+                __syms_end = .;
+        }
+        .ex_table : {
+                __ex_table_start = .;
+                *(__ex_table)
+                __ex_table_end = .;
+        }
+        .bss : { *(.bss) *(COMMON) }
+}
+

