Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262632AbRFCAUM>; Sat, 2 Jun 2001 20:20:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262606AbRFCAUC>; Sat, 2 Jun 2001 20:20:02 -0400
Received: from spruce.he.net ([216.218.159.210]:10503 "EHLO spruce.he.net")
	by vger.kernel.org with ESMTP id <S262632AbRFCATs>;
	Sat, 2 Jun 2001 20:19:48 -0400
Message-ID: <3B19807C.EF764456@BitWagon.com>
Date: Sat, 02 Jun 2001 17:10:36 -0700
From: John Reiser <jreiser@BitWagon.com>
Organization: -
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.5-15 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: bug in load_elf_binary  [PATCH]
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In kernel 2.4.3 and 2.2.18, there is a bug in fs/binfmt_elf.c function
load_elf_binary().  An ET_DYN file that asks for a PT_INTERP, and whose
first PT_LOAD is not at 0, gets AT_PHDR that is (load_bias + 2 * p_vaddr),
instead of the correct (load_bias + p_vaddr).  The patch for 2.4.3 is

--- fs/OLDbinfmt_elf.c  Mon Mar 19 17:05:16 2001
+++ fs/binfmt_elf.c     Sat Jun  2 16:20:54 2001
@@ -632,5 +632,5 @@
                                load_bias += error -
                                             ELF_PAGESTART(load_bias + vaddr);
-                               load_addr += error;
+                               load_addr += load_bias;
                        }
                }
=====
Please cc: me if appropriate; I'm not subscribed.

To demonstrate the problem on i386:
cat >foo.s <<EOF
	.section ".interp"
	.asciz "/tmp/ld-linux.so.2"
	.text
_start:	.weak _start
main:	.weak main
foo:
	jmp foo
EOF

gcc -nostartfiles -o foo.so foo.s      
# Now, binary edit foo.so to change Elf32_Ehdr.e_type from ET_EXEC to ET_DYN.
# The 'short' at file offset 0x10 goes from 2 to 3.

cp  /lib/ld-linux.so.2  /tmp
# Now, binary edit /tmp/ld-linux.so.2 so that it begins with an infinite loop.
# "objdump -f" gives the entry address.  (short)0xfeeb is an infinite loop.

nice ldd foo.so &  # Here is the failure.  Start in background at low priority.

cat /proc/<pid_of_foo.so>/maps  # I see  pid_of_foo.so = 2 + pid_of_nice
# output:
# 88048000-88049000 r-xp 00000000 03:07 2207  foo.so  # load_bias is 0x80000000
# 88049000-8804a000 rw-p 00000000 03:07 2207  foo.so

gdb foo.so <pid_of_foo.so>  # Attach to process, and look at its memory.
x/64x $esp  # and continue until seeing the AT_* on the stack.  I see

# 0xbffffa90:     0xbfffffe8      0x00000000      0x00000003      0x90090034
# 0xbffffaa0:     0x00000004      0x00000020      0x00000005      0x00000005
# 0xbffffab0:     0x00000006      0x00001000      0x00000007      0x40000000
# 0xbffffac0:     0x00000008      0x00000000      0x00000009      0x88048114

# which shows AT_PHDR at 0xbffffa9c of 0x90090034
#                  which is too big by 0x08048000  [p_vaddr of first PT_LOAD]
#         because the correct value is 0x88048034.
# Note that  AT_ENTRY at 0xbffffacc is 0x88048114  which is correct.

-- 
John Reiser, jreiser@BitWagon.com
