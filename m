Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266537AbTAFKyl>; Mon, 6 Jan 2003 05:54:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266546AbTAFKyl>; Mon, 6 Jan 2003 05:54:41 -0500
Received: from TYO202.gate.nec.co.jp ([202.32.8.202]:47074 "EHLO
	TYO202.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id <S266537AbTAFKyj>; Mon, 6 Jan 2003 05:54:39 -0500
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Embed __this_module in module itself.
References: <20021227104328.143DD2C05D@lists.samba.org>
Reply-To: Miles Bader <miles@gnu.org>
System-Type: i686-pc-linux-gnu
Blat: Foop
From: Miles Bader <miles@lsi.nec.co.jp>
Date: 06 Jan 2003 20:03:12 +0900
In-Reply-To: <20021227104328.143DD2C05D@lists.samba.org>
Message-ID: <buou1gma6bz.fsf@mcspd15.ucom.lsi.nec.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When I try to build modules using 2.5.54, the resulting .ko files lack
the .gnu.linkonce.* sections, which causes the kernel module loader to
fail on them -- those sections _are_ present in the .o files, but the
linker apparently removes them!

Any clues why it's doing this (I tried GNU ld versions 2.13.2.1 and
2.11.92.0.12.3, and both act the same)?  Is there something
arch-specific I need to do?

[The .ko file is produce by just doing `ld -r', e.g.:

   v850e-elf-ld   -r -o drivers/block/loop.ko drivers/block/loop.o

For instance, for the loop device, here's the output of `readelf -S loop.o':

---------------- begin ----------------
There are 25 section headers, starting at offset 0x1d99c:

Section Headers:
  [Nr] Name              Type            Addr     Off    Size   ES Flg Lk Inf Al
  [ 0]                   NULL            00000000 000000 000000 00      0   0  0
  [ 1] .text             PROGBITS        00000000 000034 00186c 00  AX  0   0  2
  [ 2] .rela.text        RELA            00000000 01ea40 0005c4 0c     23   1  4
  [ 3] .data             PROGBITS        00000000 0018a0 0000a4 00  WA  0   0  4
  [ 4] .rela.data        RELA            00000000 01f004 000078 0c     23   3  4
  [ 5] .bss              NOBITS          00000000 001944 000008 00  WA  0   0  4
  [ 6] .call_table_data  PROGBITS        00000000 001944 000000 00  WA  0   0  1
  [ 7] .call_table_text  PROGBITS        00000000 001944 000000 00  AX  0   0  1
  [ 8] .stab             PROGBITS        00000000 001944 008538 0c     10   0  4
  [ 9] .rela.stab        RELA            00000000 01f07c 000b10 0c     23   8  4
  [10] .stabstr          STRTAB          00000000 009e7c 013448 00      0   0  1
  [11] .plt              NOBITS          00000000 01d2c8 000000 00  AX  0   0  8
  [12] .init.plt         NOBITS          00000000 01d2c8 000000 00  AX  0   0  8
  [13] .gnu.linkonce.thi PROGBITS        00000000 01d2c8 0000b0 00  WA  0   0  4
  [14] .rela.gnu.linkonc RELA            00000000 01fb8c 000024 0c     23   d  4
  [15] .rodata           PROGBITS        00000000 01d378 0001bf 00   A  0   0  1
  [16] __obsparm         PROGBITS        00000000 01d538 000080 00  WA  0   0  4
  [17] __ksymtab         PROGBITS        00000000 01d5b8 000080 00   A  0   0  4
  [18] .rela__ksymtab    RELA            00000000 01fbb0 000018 0c     23  11  4
  [19] .init.text        PROGBITS        00000000 01d638 000220 00  AX  0   0  2
  [20] .rela.init.text   RELA            00000000 01fbc8 000138 0c     23  13  4
  [21] .comment          PROGBITS        00000000 01d858 00002d 00      0   0  1
  [22] .shstrtab         STRTAB          00000000 01d885 000115 00      0   0  1
  [23] .symtab           SYMTAB          00000000 01dd84 000710 10     24  34  4
  [24] .strtab           STRTAB          00000000 01e494 0005ab 00      0   0  1
Key to Flags:
  W (write), A (alloc), X (execute), M (merge), S (strings)
  I (info), L (link order), G (group), x (unknown)
  O (extra OS processing required) o (OS specific), p (processor specific)
----------------  end  ----------------


and here's the output of `readelf -S loop.ko'

---------------- begin ----------------
There are 23 section headers, starting at offset 0x1d938:

Section Headers:
  [Nr] Name              Type            Addr     Off    Size   ES Flg Lk Inf Al
  [ 0]                   NULL            00000000 000000 000000 00      0   0  0
  [ 1] .plt              NOBITS          00100000 000038 000000 00  AX  0   0  8
  [ 2] .text             PROGBITS        00100000 000038 00191c 00 WAX  0   0  4
  [ 3] .rela.text        RELA            00000000 01dcd0 0005e8 0c     21   2  4
  [ 4] .call_table_data  PROGBITS        0010191c 001954 000000 00  WA  0   0  1
  [ 5] .call_table_text  PROGBITS        0010191c 001954 000000 00  AX  0   0  1
  [ 6] .rodata           PROGBITS        0010191c 001954 0001bf 00   A  0   0  1
  [ 7] .data             PROGBITS        00101adc 001b14 0000a4 00  WA  0   0  4
  [ 8] .rela.data        RELA            00000000 01e2b8 000078 0c     21   7  4
  [ 9] .bss              NOBITS          00101b80 001bb8 000008 00  WA  0   0  4
  [10] .stab             PROGBITS        00000000 001bb8 008538 0c     12   0  4
  [11] .rela.stab        RELA            00000000 01e330 000b10 0c     21   a  4
  [12] .stabstr          STRTAB          00000000 00a0f0 013448 00      0   0  1
  [13] .comment          PROGBITS        00000000 01d538 00002d 00      0   0  1
  [14] .init.plt         NOBITS          00000030 01d568 000000 00  AX  0   0  8
  [15] __obsparm         PROGBITS        00000030 01d568 000080 00  WA  0   0  4
  [16] __ksymtab         PROGBITS        000000b0 01d5e8 000080 00   A  0   0  4
  [17] .rela__ksymtab    RELA            00000000 01ee40 000018 0c     21  10  4
  [18] .init.text        PROGBITS        00000130 01d668 000220 00  AX  0   0  2
  [19] .rela.init.text   RELA            00000000 01ee58 000138 0c     21  12  4
  [20] .shstrtab         STRTAB          00000000 01d888 0000b0 00      0   0  1
  [21] .symtab           SYMTAB          00000000 01ef90 000780 10     22  3b  4
  [22] .strtab           STRTAB          00000000 01f710 0005ab 00      0   0  1
Key to Flags:
  W (write), A (alloc), X (execute), M (merge), S (strings)
  I (info), L (link order), G (group), x (unknown)
  O (extra OS processing required) o (OS specific), p (processor specific)
----------------  end  ----------------


Thanks,

-Miles
-- 
Somebody has to do something, and it's just incredibly pathetic that it
has to be us.  -- Jerry Garcia
