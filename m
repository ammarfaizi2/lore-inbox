Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129707AbQK3OtS>; Thu, 30 Nov 2000 09:49:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129807AbQK3OtJ>; Thu, 30 Nov 2000 09:49:09 -0500
Received: from horus.its.uow.edu.au ([130.130.68.25]:64171 "EHLO
        horus.its.uow.edu.au") by vger.kernel.org with ESMTP
        id <S129707AbQK3OtA>; Thu, 30 Nov 2000 09:49:00 -0500
Message-ID: <3A26625E.446AE3D@uow.edu.au>
Date: Fri, 01 Dec 2000 01:21:18 +1100
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.0-test11-ac4 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Alexander Viro <viro@math.psu.edu>
CC: Andries.Brouwer@cwi.nl, torvalds@transmeta.com,
        linux-kernel@vger.kernel.org, tigran@veritas.com,
        "Stephen C. Tweedie" <sct@redhat.com>,
        Lawrence Walton <lawrence@the-penguin.otak.com>
Subject: Re: corruption
In-Reply-To: <UTC200011292154.WAA150996.aeb@aak.cwi.nl> <Pine.GSO.4.21.0011291716190.17068-100000@weyl.math.psu.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In thread "File corruption part deux", Lawrence Walton wrote:
> 
> my system has been acting slightly odd on all the pre 12 kernels
> with the fs going read only with out any messages until now.
> no opps or anything like that, but I did get this just now.
> 
> EXT2-fs error (device sd(8,2)): ext2_readdir:
> bad entry in directory #458430: directory entry
> across blocks - offset=152, inode=3393794200,
> rec_len=12440, name_len=73
>

3393794200 == 0xca493098.  A kernel address. And 152 is 0x98,
which is equal to N * 0x20 + 0x18. Read on...

I am somewhat reluctant to report this problem because I always
run kernels with the lowish latency patch, but having reviewed
the effects of that patch on fs/*.c I don't think it's to blame.
Plus it's been 100% stable for months.

I believe that the problem I've observed is caused by or exposed
by the O_SYNC changes.  Or maybe not.

Running test11-ac4 on *very* vanilla machines.  x86 UP, IDE, 3c905
and really nothing else.  No APM, fat, vfat, isofs, USB, audio, etc.
It has happened on two different machines which have been 100% reliable
for a year.

The problem is corruption of in-core files.  It has only started
happening in the past few days.  It happened after two days uptime.
In the most recent case my /bin/ls went bad.  I took a copy and
rebooted.  After reboot /bin/ls had a correct MD5 sum. Here's
the diff:

--- ls.good	Thu Nov 30 15:07:11 2000
+++ ls.bad	Thu Nov 30 15:07:04 2000
@@ -1589,7 +1589,7 @@
 006340: C7 85 F8 BF FF FF 00 00 00 00 E9 EA 02 00 00 90      >@@@@@@@@@@@@@@@@<
 006350: 8B BD FC BF FF FF 8D B5 00 E0 FF FF 57 68 00 20      >@@@@@@@@@@@@Wh@ <
 006360: 00 00 56 E8 3C B2 FF FF 83 C4 0C 85 C0 0F 84 DD      >@@V@<@@@@@@@@@@@<
-006370: 02 00 00 6A 0A 56 E8 49 B0 FF FF 83 C4 08 85 C0      >@@@j@V@I@@@@@@@@<
+006370: 02 00 00 6A 0A 56 E8 49 78 73 62 C6 78 73 62 C6      >@@@j@V@Ixsb@xsb@<
 006380: 75 2E 8D 9D 00 C0 FF FF 8B BD FC BF FF FF 57 68      >u.@@@@@@@@@@@@Wh<
 006390: 00 20 00 00 53 E8 0A B2 FF FF 83 C4 0C 85 C0 74      >@ @@S@@@@@@@@@@t<
 0063A0: 0F 6A 0A 53 E8 1B B0 FF FF 83 C4 08 85 C0 74 D8      >@j@S@@@@@@@@@@t@<
@@ -1709,7 +1709,7 @@
 006AC0: 00 00 00 FF 75 DF 83 E8 03 40 40 2B 44 24 58 83      >@@@@u@@@@@@+D$X@<
 006AD0: C0 02 89 44 24 14 EB 08 C7 44 24 14 01 00 00 00      >@@@D$@@@@D$@@@@@<
 006AE0: 8B 4C 24 3C F6 C1 01 74 5B 8B 44 24 5C 8B 74 24      >@L$<@@@t[@D$\@t$<
-006AF0: 14 89 C2 83 E0 03 74 16 7A 0F 83 F8 02 74 05 38      >@@@@@@t@z@@@@t@8<
+006AF0: 14 89 C2 83 E0 03 74 16 F8 7A 62 C6 F8 7A 62 C6      >@@@@@@t@@zb@@zb@<
 006B00: 22 74 2F 42 38 22 74 2A 42 38 22 74 25 42 8B 02      >"t/B8"t*B8"t%B@@<
 006B10: 84 E0 75 08 84 C0 74 1A 84 E4 74 15 A9 00 00 FF      >@@u@@@t@@@t@@@@@<
 006B20: 00 74 0D 83 C2 04 A9 00 00 00 FF 75 E1 83 EA 03      >@t@@@@@@@@@u@@@@<
@@ -1733,7 +1733,7 @@
 006C40: 4C 24 54 40 51 50 E8 C9 A7 FF FF 83 C4 08 83 7C      >L$T@QP@@@@@@@@@|<
 006C50: 24 1C 00 74 38 C6 00 2C 8B 5C 24 3C 40 8B 4C 24      >$@@t8@@,@\$<@@L$<
 006C60: 3C 83 E3 01 F6 C1 02 74 0E 8B 74 24 58 56 50 E8      ><@@@@@@t@@t$XVP@<
-006C70: A0 A7 FF FF 83 C4 08 85 DB 74 12 C6 00 5F 8B 4C      >@@@@@@@@@t@@@_@L<
+006C70: A0 A7 FF FF 83 C4 08 85 78 7C 62 C6 78 7C 62 C6      >@@@@@@@@x|b@x|b@<
 006C80: 24 5C 40 51 50 E8 8A A7 FF FF 83 C4 08 C6 00 2F      >$\@QP@@@@@@@@@@/<
 006C90: 31 FF 8B 74 24 60 40 56 50 E8 76 A7 FF FF 83 C4      >1@@t$`@VP@v@@@@@<
 006CA0: 08 8B 4C 24 30 8B 29 85 ED 74 31 90 8D 74 26 00      >@@L$0@)@@t1@@t&@<


Note that in both my cases (and, apparently, Lawrence's) the
corrupted data consists of two identical kernel addresses which
have the value

	N * 0x20 + 0x18

and they are always equal.  And they occur at a file offset
of

	N * 0x20 + 0x18

Which leads one to believe that someone somewhere is doing
an init_list_head() on a wild pointer.

Or, more likely, someone is doing a list_del() on a list_head
which points at recycled memory, and that list_head resides
within a structure at offset 0x18.

And that description perfectly matches the new i_dirty_buffers
field in struct inode.

Which would perhaps indicate that one of the following statements:

- the list_del in buffer_insert_inode_queue() or

- the list_del in __remove_inode_queue()

- the list_del in fsync_inode_buffers()

has gotten itself a wild pointer.


Other possible candidates apart from i_dirty_buffers which
have a list_head at offset 0x18 and whose list_dels should
be reviewed are:

- request_queue.elevator.queue
- dentry.d_hash
- anything which has a timer_list at offset 0x18
- anything which has a waitqueue at offset 0x14

There may be others which have list_heads at 0x38, 0x58, ...

This doesn't just happen a single time.  The first time it happened
during a CVS commit at least eight files on the server ended up with
this corruption, as did /usr/lib/netscape/netscape-communicator,
so we had a whole bunch of corruptions happening in a short
period of time.

It takes a very bad kernel bug to be able to crash netscape.

Anyway, something to be thinking about.  I've written the
canonical list_head debugging code.  I'll run that overnight
and finish it off tomorrow.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
