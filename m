Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267250AbUBSNeK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 08:34:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267252AbUBSNeK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 08:34:10 -0500
Received: from ultra12.almamedia.fi ([193.209.83.38]:8427 "EHLO
	ultra12.almamedia.fi") by vger.kernel.org with ESMTP
	id S267250AbUBSNeD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 08:34:03 -0500
Message-ID: <4034BB7E.4ED20C2@users.sourceforge.net>
Date: Thu, 19 Feb 2004 15:34:54 +0200
From: Jari Ruusu <jariruusu@users.sourceforge.net>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.22aa1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jan Rychter <jan@rychter.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Oopsing cryptoapi (or loop device?) on 2.6.*
References: <402A4B52.1080800@centrum.cz> <402A7765.FD5A7F9E@users.sourceforge.net>
		 <m265e9oyrs.fsf@tnuctip.rychter.com>
		 <402F877C.C9B693C1@users.sourceforge.net>
		 <m2k72n9pth.fsf@tnuctip.rychter.com>
		 <40322094.83061A32@users.sourceforge.net>
		 <m24qtpikmd.fsf@tnuctip.rychter.com>
		 <4033714A.FFFEBD6C@users.sourceforge.net> <m2ekssf4ml.fsf@tnuctip.rychter.com>
Content-Type: multipart/mixed;
 boundary="------------7109221C9B11A492EB33BC49"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------7109221C9B11A492EB33BC49
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Jan Rychter wrote:
> And, just wondering -- if loop-AES works so much better, why hasn't it
> been included in the kernel?

Because I stopped wasting my time with mainline kernels long time ago, and
because mainline folks seemed to prefer the most vulnerable loop crypto
implementation they could find (i.e. cryptoloop).

Just look at mainline folks merging another equally vulnerable and exploitable
implementation (i.e. dm-crypt), with exactly same vulnerabilities that
cryptoloop has, just in different package.

In loop-AES, "bad key management" issues were fixed years ago, and more
stronger IV was merged last year. Mainline folks still seem to be
puzzled/clueless with these issues.

-

Markku-Juhani O. Saarinen discovered watermark attack against cryptoloop,
here is his paper:

    http://www.tcs.hut.fi/~mjos/doc/diskenc.pdf

[just before posting I tested above link and it returns "You don't have
permission to access /~mjos/doc/diskenc.pdf on this server", ugh]

This attack exploits weakness in IV computation and knowledge of how file
systems place files on disk. This attack works with file systems that have
soft block size of 1024 or greater. At least ext2, ext3, reiserfs and minix
have such property. Don't know about xfs. This attack makes it possible to
detect presense of specially crafted watermarked files, such as, unreleased
Hollywood movies, cruise missile service manuals, and other content that you
did not create yourself. Watermarked files contain special bit patterns that
can be detected without decryption.

I have attached source for two programs, one to create such watermarked
files, and one to detect watermarks from ciphertext.

For example, if I were to encode my first name Jari as a watermark, I would
use ASCII characters 74 97 114 105. This example uses encodings 10...13.

    # mount -t ext2 /dev/fd0 /mnt -o loop=/dev/loop0,encryption=AES128
    Password:
    # ./create-watermark-encodings 10:74 11:97 12:114 13:105 >/mnt/watermarks
    # umount /mnt

And then to detect these watermarks, I do:

    # dd if=/dev/fd0 bs=64k | ./detect-watermark-encodings
    22+1 records in
    22+1 records out
    1474560 bytes scanned
    watermark encoding 10, count 74
    watermark encoding 11, count 97
    watermark encoding 12, count 114
    watermark encoding 13, count 105
    
Summary:
- cryptoloop and dm-crypt on-disk formats are FUBAR. cryptoloop and
  dm-crypto developers and users don't have any choice here. The _have_ to
  start using stronger crypto.
- Used cipher or key kength or password does not matter.
- loop-AES single-key mode on-disk format is equally FUBAR.  
- loop-AES multi-key mode is not vulnerable.
- Anyone still setting up new encrypted file systems using cryptoloop or
  current dm-crypt or single-key loop-AES, is committing security
  malpractice.

-- 
Jari Ruusu  1024R/3A220F51 5B 4B F9 BB D3 3F 52 E9  DB 1D EB E3 24 0E A9 DD
--------------7109221C9B11A492EB33BC49
Content-Type: application/octet-stream;
 name="cryptoloop-exploit.tar.bz2"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="cryptoloop-exploit.tar.bz2"

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
--------------7109221C9B11A492EB33BC49--

