Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271672AbRICKnG>; Mon, 3 Sep 2001 06:43:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271673AbRICKm4>; Mon, 3 Sep 2001 06:42:56 -0400
Received: from thebsh.namesys.com ([212.16.0.238]:22285 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S271672AbRICKmq>; Mon, 3 Sep 2001 06:42:46 -0400
Message-ID: <3B935AA3.C4615F99@namesys.com>
Date: Mon, 03 Sep 2001 14:25:39 +0400
From: Hans Reiser <reiser@namesys.com>
Organization: Namesys
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.4 i686)
X-Accept-Language: en, ru
MIME-Version: 1.0
To: thunder7@xs4all.nl
CC: parisc-linux@lists.parisc-linux.org, linux-kernel@vger.kernel.org,
        Jeff Mahoney <jeffm@suse.com>
Subject: Re: documented Oops running big-endian reiserfs on parisc architecture
In-Reply-To: <20010902105538.A15344@middle.of.nowhere>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




Well, I should have read the next email before saying these patches seemed to be
stable.

Jeff?

Hans

thunder7@xs4all.nl wrote:
> 
> Well, I watched the number of files in /lost+found grow every time I
> had to pull the plug from my HP C200, so I added a 'sync' option in
> /etc/fstab and tried to get reiserfs working.
> 
> I patched my 2.4.9-pa13 kernel with
> 
> endian-safe-reiserfs-for-2.4.8.patch
> 
> which went without warnings or errors. A patched
> reiserfs-progs-3.x.0k-pre9 also built well (despite what the configure
> scripts says, you _need_ automake).
> 
> Creating a reiserfs-partition went without a hitch.
> 
> running bonnie -s 128 on it did this:
> 
> Adding Swap: 1041400k swap-space (priority -1)
> eth0: Setting half-duplex based on MII#1 link partner capability of 0021.
> reiserfs: checking transaction log (device 08:03) ...
> Using r5 hash to sort names
> ReiserFS version 3.6.25
> bonnie[163]: Unaligned data reference 28
> 
>      YZrvWESTHLNXBCVMcbcbcbcbOGFRQPDI
> PSW: 00000000000001001111111100001110
> r0-3     00000000 102ec550 10197d0c 26f24838
> r4-7     26f24848 27054e40 00000011 00000020
> r8-11    0000000a 26f06580 00000020 26f247a0
> r12-15   27088d1c ffffffff 26f24838 00000001
> r16-19   26f24708 faf02c68 0006a248 26f24852
> r20-23   0000000f 00000003 03000000 00000002
> r24-27   0000000a 0000000a 26f24848 102d4010
> r28-31   26f24848 01000000 26f24b40 10196fc8
> sr0-3    00000000 00000004 00000000 00000004
> sr4-7    00000000 00000000 00000000 00000000
> 
> IASQ: 00000000 00000000 IAOQ: 10197d10 10197d14
>  IIR: 0c7c1093    ISR: 00000000  IOR: 26f24846
>  ORIG_R28: 00000000
> pa8200:/var/log#
> 
> After reading in the archives about ksymoops, I looked up this part of
> my System.map:
> 
> 101979e0 T reiserfs_lookup
> 101979e0 t .L1432
> 10197ad4 t reiserfs_add_entry
> 10197e50 t .L1512
> 10197f28 t .L1510
> 10198068 T reiserfs_create
> 
> objdump -d /boot/linux-2.4.9-pa13 revealed:
> 
> 10197cbc:       d6 d6 0b 18     depw,z r22,7,8,r22
> 10197cc0:       d6 b5 0a 10     depw,z r21,15,16,r21
> 10197cc4:       41 33 01 fe     ldb ff(sr0,r9),r19
> 10197cc8:       0a d5 02 75     or r21,r22,r21
> 10197ccc:       d6 94 09 08     depw,z r20,23,24,r20
> 10197cd0:       0a b4 02 74     or r20,r21,r20
> 10197cd4:       0a 93 02 73     or r19,r20,r19
> 10197cd8:       d2 75 18 f8     extrw,u r19,7,8,r21
> 10197cdc:       d2 74 19 f8     extrw,u r19,15,8,r20
> 10197ce0:       0c 73 12 16     stb  r19,b(sr0,r3)
> 10197ce4:       d2 73 1a f8     extrw,u r19,23,8,r19
> 10197ce8:       0c 75 12 10     stb  r21,8(sr0,r3)
> 10197cec:       0c 74 12 12     stb  r20,9(sr0,r3)
> 10197cf0:       e8 86 a9 e4     b,l 102a51e8 <memcpy>,%r2
> 10197cf4:       0c 73 12 14     stb  r19,a(sr0,r3)
> 10197cf8:       08 06 02 59     copy r6,r25
> 10197cfc:       08 04 02 5a     copy r4,r26
> 10197d00:       d7 20 1c 1d     depwi 0,31,3,r25
> 10197d04:       e8 0d a5 d8     call 101b1ff8 <padd_item>
> 10197d08:       08 08 02 58     copy r8,r24
> 10197d0c:       00 01 0e 74     rsm 1,r20
> 10197d10:       0c 7c 10 93     ldw  e(sr0,r3),r19
> 10197d14:       d6 60 1f 1f     depwi 0,7,1,r19
> 10197d18:       0c 73 12 9c     stw  r19,e(sr0,r3)
> 10197d1c:       00 14 18 60     mtsm r20
> 10197d20:       85 e0 26 32     cmpib,=,n 0,r15,10198040 <.L1510+0x118>
> 10197d24:       00 01 0e 74     rsm 1,r20
> 10197d28:       0c 7c 10 93     ldw  e(sr0,r3),r19
> 10197d2c:       d6 7f 1f 5f     depwi -1,5,1,r19
> 10197d30:       0c 73 12 9c     stw  r19,e(sr0,r3)
> 10197d34:       00 14 18 60     mtsm r20
> 10197d38:       08 00 02 54     copy r0,r20
> 10197d3c:       08 00 02 55     copy r0,r21
> 10197d40:       37 c6 3e 51     ldo -d8(sp),r6
> 10197d44:       37 cd 3d c1     ldo -120(sp),r13
> 10197d48:       6b d4 3e 51     stw r20,-d8(sr0,sp)
> 10197d4c:       6b d5 3e 59     stw r21,-d4(sr0,sp)
> 10197d50:       6b d4 3e 61     stw r20,-d0(sr0,sp)
> 10197d54:       6b d5 3e 69     stw r21,-cc(sr0,sp)
> 10197d58:       08 0c 02 59     copy r12,r25
> 10197d5c:       6b c6 3e 01     stw r6,-100(sr0,sp)
> 10197d60:       6b cd 3f 99     stw r13,-34(sr0,sp)
> 10197d64:       08 08 02 58     copy r8,r24
> 10197d68:       08 05 02 5a     copy r5,r26
> 10197d6c:       eb ff b4 4d     b,l 10197798 <reiserfs_find_entry>,%r2
> 
> which makes the error somewhere around here in
> fs/reiserfs/namei.c, function reiserfs_add_entry, after call to
> padd_item, before call to reiserfs_find_entry:
> 
>     /* copy name */
>     memcpy ((char *)(deh + 1), name, namelen);
>     /* padd by 0s to the 4 byte boundary */
>     padd_item ((char *)(deh + 1), ROUND_UP (namelen), namelen);
> 
>     /* entry is ready to be pasted into tree, set 'visibility' and 'stat data in entry' attributes */
>     mark_de_without_sd (deh);
>     visible ? mark_de_visible (deh) : mark_de_hidden (deh);
> 
>     /* find the proper place for the new entry */
>     memset (bit_string, 0, sizeof (bit_string));
>     de.de_gen_number_bit_string = (char *)bit_string;
>     retval = reiserfs_find_entry (dir, name, namelen, &path, &de);
> 
> And there I'm stuck. I'm sending this to the parisc-list to document the
> failure, and to linux-kernel to reach some reiserfs-experts, perhaps.
> 
> I'm willing to test anything!
> 
> Good luck,
> Jurriaan
> --
> "I have seen her. That is enough, perhaps."
> Pug smiled. "You are a rare man."
>         Raymond E Feist - The King's Buccaneer
> GNU/Linux 2.4.9-ac5 SMP/ReiserFS 2x1402 bogomips load av: 0.04 0.01 0.06
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
