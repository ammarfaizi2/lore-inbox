Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132898AbRDENyl>; Thu, 5 Apr 2001 09:54:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132899AbRDENyb>; Thu, 5 Apr 2001 09:54:31 -0400
Received: from roc-24-169-102-121.rochester.rr.com ([24.169.102.121]:522 "EHLO
	roc-24-169-102-121.rochester.rr.com") by vger.kernel.org with ESMTP
	id <S132905AbRDENy2>; Thu, 5 Apr 2001 09:54:28 -0400
Date: Thu, 05 Apr 2001 08:52:37 -0500
From: Chris Mason <mason@suse.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Xuan Baldauf <xuan--reiserfs@baldauf.org>, reiserfs-list@namesys.com
cc: Nicholas Petreley <nicholas@petreley.com>,
        Harald Dunkel <harri@synopsys.COM>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] reiserfs old data bug 2.2.x (was: ReiserFS? How
 reliable ...)
Message-ID: <322330000.986478757@tiny>
In-Reply-To: <E14kyLV-0003AB-00@the-village.bc.nu>
X-Mailer: Mulberry/2.0.6b4 (Linux/x86)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="==========1169260887=========="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==========1169260887==========
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline



On Thursday, April 05, 2001 02:13:55 AM +0100 Alan Cox
<alan@lxorguk.ukuu.org.uk> wrote:

>> This is a reiserfs security issue, but only of theoretical nature (Even
>> i= f
>> triggered, it won't harm you). But the reason for this bug is in NFS
>> (v2,=
> 
> If the blocks contained my old /etc/shadow I'd be a bit upset.
> 

I think we're talking about different things here.  Alan, I think you are
referring to the ability to get old data in files during mmap.  Where the
exploit roughly looks like this:

truncate(file, 0)
truncate(file, X)
char *foo = mmap(file, X)
write(file, foo, X)

This should produce all zeros, but under 2.2.x reiserfs can instead include
old file data.  Turns out this is because during the write, the block
pointer is inserted before the newly allocated (and zero'd) buffer was set
up to date.  If a readpage is triggered when reiserfs_file_write calls
copy_from_user, you get the old data.  The fix is to mark the buffer up to
date right after zeroing.

Two patches attached, one for 3.5.32 (uptodate_hole.diff.gz) and one for
older reiserfs versions (uptodate_hole-old.diff.gz).  Both are small,
gzip'd because my mailer is dumb.

3.5.33 should come out soon with this included.  2.4.x reiserfs doesn't
need this patch.

-chris

--==========1169260887==========
Content-Type: application/x-gunzip; name="uptodate_hole-old.diff.gz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="uptodate_hole-old.diff.gz";
 size=502

H4sICN1zzDoAA3VwdG9kYXRlX2hvbGUtb2xkLmRpZmYA7ZRfb5swFMWfyac4e4lC+E+ANq1SJZpo
NyltpzZStScLUjO8EIKwo0xb991rCGmXalXTddX6sCsEyNxzbf/ONYZhIGP58pvRM33T7VsJt0rK
OC3lS8Iyak5NR7mi1xgVJeDBcQ5s+8B14dq209I07Sn5A3F1NeLhEEY/8PUAWvXYw3DYgoI64pJG
s8MWfo2fzdc5nXMq0CkIJ8ucxKlxFJPrSEQ6bB1yIJsRzr5T9bClrQVROSPxMkloSZaFWMhceq/W
4aiQUzXVWYKOLFLSgkYC7wZ4P7q4+EzOz9Buo8MJp1E5TUkRidSsbiSj+ReRYjDAx/E4PBmNyafR
5AMJx+FpeDYh58fHl+EENzfVBFUA08W8IEzIbXTanDC5gvZWXVWFih81H8fu9ytAjmPb+v6/JaS9
OqEdwWwQWN1aQTNBsUrlWlYRR74QSFjOeCr7juXYtCPJ6UpufDGd5SVH17qr8hUDbIFqkmCtAfLY
OOLrwYoZutiX3Gpz3MCrzXGDvaZ9H8bvXLr36Q+c2rWbt+PVLLvr6Z27Wgpe5ltN3uu5NXmvFzxC
/nH6GweUZ+JXdmVfZb6BQ6L8jTOivPCI+F79g3d83/5v1Bs16hZd04cMBQgAAA==

--==========1169260887==========
Content-Type: application/x-gunzip; name="uptodate_hole.diff.gz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="uptodate_hole.diff.gz"; size=234

H4sICOpzzDoAA3VwdG9kYXRlX2hvbGUuZGlmZgCFjs1uwjAQhM/1U8wR6jjEDiUiSCh9h96tmK5V
Q/5kxwJR9d2b0B5Ke+hpVqv5ZkYIgcZ18SLy9CnN1cqGlScXyE+HdQ2lh1Q+vETC8+CBHLIo16qU
W6gsk4xz/h/+F1byC64qiFwVyQZ8lgJVxQB8MMwCtNQGGrFYPA6DDrqjszZvS7E3+rUe6wRZgvkf
jNgHbZr+cAruSssd4ze69idtorXkdRzGfmLoLimBnLy3LmdxX4L37wk/Qo599F3dzJZf5h37BHJn
ixhHAQAA

--==========1169260887==========--

