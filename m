Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129383AbRAIVWw>; Tue, 9 Jan 2001 16:22:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129406AbRAIVWd>; Tue, 9 Jan 2001 16:22:33 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:21139 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S129383AbRAIVW3>;
	Tue, 9 Jan 2001 16:22:29 -0500
Date: Tue, 9 Jan 2001 16:22:27 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Mathieu Chouquet-Stringer <mchouque@e-steel.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Floppy disk strange behavior
In-Reply-To: <m3itnoihys.fsf@shookay.e-steel.com>
Message-ID: <Pine.GSO.4.21.0101091540330.9953-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 9 Jan 2001, Mathieu Chouquet-Stringer wrote:

> I use GRUB to boot my system. Basically, when you want to install GRUB on a
> floppy disk, you do that:
> 
> dd if=stage1 of=/dev/fd0 bs=512 count=1
> dd if=stage2 of=/dev/fd0 bs=512 seek=1
> 
> But since kernel 2.3.xx (I don't remember exactly), I got this error
> message when I try to do the second dd (even as root):
> dd: advancing past 1 blocks in output file `/dev/fd0': Permission denied

dd bug. It tries to ftruncate() the output file and gets all upset when
kernel refuses to truncate a block device (surprise, surprise).

Workaround: use conv=notrunc.

Proper fix:
ed src/dd.c <<EOF
/^main/
/^$/i
	struct stat stat_buf;
.
/HAVE_FTRUNCATE/i
	if (fstat(STDOUT_FILENO, &stat_buf) < 0)
	        error (1, errno, "%s", output_file);
	if (!S_ISREG(stat_buf.st_mode))
		conversions_mask |= C_NOTRUNC;
.
w
q
EOF

Notice that for regular files dd will truncate everything past its
output unless you say notrunc. This behaviour obviously makes no
sense for devices - they have fixed size and there's no way in hell
to truncate a floppy (well, there is, but it requires manual
operations ;-) The _only_ possible behaviour for anything except
regular files is notrunc one. Patch above forces notrunc for everything
that is not a regular file.

Basically, dd(1) expects kernel to fake success for ftruncate() on the
things that can't be truncated. Bad idea. 2.2 didn't bother to report
error in that case, so this bug didn't show up. 2.4 (and many other
Unices) return error and dd fails when you have block device as output file,
non-zero as initial seek and don't have notrunc.

Try to build GNU dd on other Unices and you will be able to trigger that
bug on quite a few of them.

ftruncate(2) is _not_ supposed to succeed on anything other than regular
files. I.e. dd(1) should not call it and expect success if file is not
regular. Plain and simple...

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
