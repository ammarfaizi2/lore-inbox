Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131668AbQKBOYj>; Thu, 2 Nov 2000 09:24:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131918AbQKBOY3>; Thu, 2 Nov 2000 09:24:29 -0500
Received: from dialup379.canberra.net.au ([203.33.188.251]:9988 "EHLO
	didi.localnet") by vger.kernel.org with ESMTP id <S131668AbQKBOYQ>;
	Thu, 2 Nov 2000 09:24:16 -0500
Message-ID: <000b01c044d8$18275730$0200a8c0@W2K>
From: "Nick Piggin" <s3293115@student.anu.edu.au>
To: "Linux-Kernel" <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.0-test9 Oopses
Date: Fri, 3 Nov 2000 01:20:44 +1100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just  a note that this oops still occurs in test10. The problem occurs
because get_devfs_entry_from_vfs_inode in devfs_follow_link (and/or
devfs_read_link), seems to return invalid or incorrect devfs entries whose
.u.symlink.linkname is null which causes the line:
        if (*link == '/') {
in fs/namei.c: __vfs_follow_link to oops.

The oops is due to trying to follow an sg? link in /dev.

Nick.

----- Original Message -----
From: "Nick Piggin" <s3293115@student.anu.edu.au>
To: "Linux-Kernel" <linux-kernel@vger.kernel.org>
Sent: Wednesday, October 25, 2000 9:16 PM
Subject: 2.4.0-test9 Oopses


> Did the following with 2.4.0-test9 + reiserfs 3.6.18 (all ext2 filesystem,
> however) and all ide block devices.
>
> scsi0 : SCSI host adapter emulation for IDE ATAPI devices
> Vendor: RICOH     Model: CD-R/RW MP7060A   Rev: 1.50
> Type:   CD-ROM                             ANSI SCSI revision: 02
> Vendor: ATAPI     Model: CD-ROM DRIVE-24X  Rev: U40M
> Type:   CD-ROM                             ANSI SCSI revision: 02
> Detected scsi CD-ROM sr0 at scsi0, channel 0, id 0, lun 0
> Detected scsi CD-ROM sr1 at scsi0, channel 0, id 1, lun 0
> sr0: scsi3-mmc drive: 24x/24x writer cd/rw xa/form2 cdda tray
> sr1: scsi3-mmc drive: 20x/20x xa/form2 cdda tray
> scsi : 0 hosts left.
>
> (loaded ide-scsi modules as you can see)
[snip]
> Doing cdrecord -scanbus I
> got these two oopses
>
> Unable to handle kernel NULL pointer dereference at virtual address
00000000
>  printing eip:
> c013a551
> Oops: 0000
> CPU:    0
> EIP:    0010:[vfs_follow_link+33/368]
> EFLAGS: 00010217
> eax: 00000000   ebx: c3c5bf90   ecx: 00000341   edx: c02b6040
> esi: 00000000   edi: 00000000   ebp: 00000000   esp: c3c5befc
> ds: 0018   es: 0018   ss: 0018
> Process devfsd (pid: 12, stackpage=c3c5b000)
> Stack: c3c5bf90 00000000 c0a01e20 c3c5bf90 00000000 c01547cf c3c5bf90
> 00000000
>        c3c5a000 c0138143 c0a01e20 c3c5bf90 c09c0b40 c3d69000 00000000
> c3c5bf90
>        bfffecdc 00000001 bfffecdc c3c5bf94 00000009 c0a01e20 c3d69005
> 00000003
> Call Trace: [devfs_follow_link+31/48] [path_walk+1683/1952]
> [__user_walk+60/96] [sys_chown+22/80] [sys_chown16+48/64]
> [system_call+51/56]
> Code: 80 3f 2f 0f 85 c6 00 00 00 53 e8 90 d2 ff ff ba 00 e0 ff ff
>
> Unable to handle kernel NULL pointer dereference at virtual address
00000000
>  printing eip:
> c013a551
> Oops: 0000
> CPU:    0
> EIP:    0010:[vfs_follow_link+33/368]
> EFLAGS: 00010217
> eax: 00000000   ebx: c081df80   ecx: 00000341   edx: c02b6040
> esi: c0a01b20   edi: 00000000   ebp: 00000000   esp: c081ded0
> ds: 0018   es: 0018   ss: 0018
> Process cdrecord (pid: 758, stackpage=c081d000)
> Stack: c081df80 c0a01b20 c0a01b20 c081df80 00000000 c01547cf c081df80
> 00000000
>        c081c000 c0138143 c0a01b20 c081df80 c09c0b40 c117d000 00000000
> 00000002
>        00000003 00000001 08074094 c081df84 00000001 c0a01b20 c117d005
> 00000003
> Call Trace: [devfs_follow_link+31/48] [path_walk+1683/1952]
> [open_namei+128/1504] [filp_open+59/96] [sys_open+67/208]
> [system_call+51/56]
> Code: 80 3f 2f 0f 85 c6 00 00 00 53 e8 90 d2 ff ff ba 00 e0 ff ff
>
>
>

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
