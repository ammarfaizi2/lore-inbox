Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267271AbTBIM3J>; Sun, 9 Feb 2003 07:29:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267274AbTBIM3I>; Sun, 9 Feb 2003 07:29:08 -0500
Received: from mail.netone.com.tr ([193.192.100.127]:11979 "EHLO
	gtms01.netone.com.tr") by vger.kernel.org with ESMTP
	id <S267270AbTBIM26>; Sun, 9 Feb 2003 07:28:58 -0500
Message-ID: <010f01c2d038$0dbe0c60$0100a8c0@bora>
From: =?iso-8859-9?B?Qm9yYSDeYWhpbg==?= <borasah@netone.com.tr>
To: <linux-kernel@vger.kernel.org>
Subject: Some Doubts About bootsect.S & Setup.S
Date: Sun, 9 Feb 2003 14:23:02 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-9"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.00.2615.200
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2615.200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Kernel: 2.4.19

I know these questions are simple especially for this mailing list but up to
now i have not reached a result in my investigations.

This is a bit long question series...

I am examining bootsect.S & setup.S especially for bzImage. Overall, I
understand the code but i have some doubts about some subjects.

---
1)
sread:  .word 0             # sectors read of current track
head:   .word 0             # current head
track:  .word 0             # current track

Since a diskette can have at most 2 heads, 80 tracks and 36 sectors per
track, why are these not bytes instead of words especially since space is at
such a tight premium in this code?

2) In the read_track function there are two pushas. I assume while the
second pusha is related to printing the dot to screen, the other is used in
some error conditions.

In the second, instead of two pushes (push ax & push bx; because they are
used "int 0x10 - AH = 0x0E") pusha had been used so 8 - 4 = 4 bayt was
reserved to other command or data.

First pusha situation: In fact, read_track function relies only AX & BX.
Other registers such as CX & DX are changed according to head, track... If
no error is in place, AX & BX isnt changed so pusha is somewhat redundant
but if an error occurs, AL is changed no BX. In this situation, if we do
"push ax" instead of "pusha", the result is 6 byte because this requires two
pops. However because of pusha and popa, original code in the bootsect.S
only 3 byte covers. Is this
correct? If correct then again we return the first question. (We made a
great effort to save place but in regard to head, track symbols we were a
bit generous, werent we?)

3) if read_track fails we jump bad_rt. There, we print some registers to
screen using "int 0x10 - AH = 0x0E". This int. gets four parameters. While
we print dots to screen, we are supplying four parameters.
    movw $0xe2e, %ax   # loading... message 2e = .
    movw $7, %bx
    int $0x10
In error messages, we are supplying two parameters. Such as
    movw $0xe05 + 'A' - 1, %ax
    subb %cl, %al
    int $0x10

or printing newline,

print_nl:
 movw $0xe0d, %ax  # CR
 int $0x10
 movb $0xa, %al  # LF
 int  $0x10

I also tried to print dots supplying two parameters and it worked so If it
works why is it supplied four parameters to print dots to screen?

4) If i understand the code correctly for "make bzImage", we move kernel
from con. mem to ext. mem in 64K chunks. Default system size -in the comment
section of bootsect.S- is said "system is at most (8*65536-4096) bytes
long". But where 4096 come from? In the tools/build.c file:
    ...
    sz = sb.st_size;
    ...
    sys_size = (sz + 15) / 16;
    ...

and besides Tigran Avaizan HowTo/Book -Linux 2.4 Internals- "The upper limit
on the bzImage size produced at this step is ... and 0xFFFF paragraphs
(0xFFFF0 = 1048560 bytes) for booting raw image, e.g. from floppy disk or
CD-ROM (El-Torito emulation mode)." This is not exactly true but the thing I
surprised or I dont understand is paragraph word. How it can be? Because
full 64K has been read from disk, it is moved from con. mem to ext. mem and
then in the Setup.S file:
bootsect_ex:
    movb %cs:bootsect_dst_base+2, %ah
    shlb $4, %ah    # we now have the number of moved frames in %ax
    xorb %al, %al
is done. Let's say the first 64KB, then AX = 1000. So this means we can move
64K. Again,  i dont understand where does 16(paragraph) come from?
---

Someone(H. Peter Anvin) tell me that these codes was old and broken, and was
getting nuked in 2.5. But I examined 2.5.56 in the point of booting on his
suggestion. But there is no change. bootsect.S same,  build.c same(at least
generally. I didnt examine thoroughly) and in the means of bootsect_kludge,
yes, setup.S same(It seems Install.sh was only added by him).

Thanks for advance...

Sory for my bad English...

Ps: I am not subscribed to this list hence pls. cc your reply to me.

Bora Sahin
Regards


