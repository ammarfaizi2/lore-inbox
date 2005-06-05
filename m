Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261627AbVFEWfm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261627AbVFEWfm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Jun 2005 18:35:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261626AbVFEWfl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Jun 2005 18:35:41 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:55819 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S261627AbVFEWfc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Jun 2005 18:35:32 -0400
Date: Mon, 6 Jun 2005 00:35:28 +0200
From: Willy Tarreau <willy@w.ods.org>
To: linux-kernel@vger.kernel.org
Cc: mpm@selenic.com
Subject: Easy trick to reduce kernel footprint
Message-ID: <20050605223528.GA13726@alpha.home.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Here's a simple trick for all those who try to squeeze their kernels to the
absolute smallest size.

I recently discovered p7zip which comes with the LZMA compression algorithm,
which is somewhat better than gzip and bzip2 on most datasets, and I also
noticed that this tool provides support for gzip and bzip2 outputs. So I tried
to produce some of those standard outputs, and observed a slight gain compared
to the default tools. The reason is that we can change the number of passes and
the dictionnary size.

So as an experiment, I used it to compress my kernel+initramfs and I could
gain about 2% (23 kB) which is not bad at all for embedded systems. Don't
ask about the '.' after '-si' in the '7za' command line, it's just that the
tool expects a file name, and I didn't managed to fix it, the source is some
sort of obfuscated c++ code (who said "pleonasm" ?) ported from windows, but
at least it works.  Out of curiosity, I also tried both bzip2 and the LZMA
algorithm, although that's not fair because the decompressor code would have
to be changed to support them.

Size of the 2.6.12-rc4-mm2 vmlinux compiled without the initramfs image :

  bash-3.00$ size vmlinux 
     text    data     bss     dec     hex filename
  1024458  123712   73580 1221750  12a476 vmlinux

Size of the initramfs :
  -rw-rw-r--  1 willy users 1014272 2005-05-27 16:31 usr/initramfs_data.cpio

Now the resulting bzImage size with various compression methods

     size  command
  1197277  make
  1197275  make cmd_gzip="gzip -9c <\$< >\$@"
  1173550  make cmd_gzip="7za a -tgzip -mx9 -mpass=4 -so -si . <\$< >\$@"
  1207599  make cmd_gzip="bzip2 -c9 <\$< >\$@"
  1051705  make cmd_gzip="rm -f \$@;7za a -t7z -mx9 -md=64m -si \$@ < \$<"

Surprizingly, bzip2 makes a bigger kernel. The gzip implementation in 7za
saves 23 kB (2%) on the overall image without touching any code. The LZMA
implementation could save 145 kB (12%), but would require a different
extraction code (I've already seen patches to bring LZMA support on 2.4).

Note: I don't know who implemented the if_changed macro in the makefile which
allows us to pass cmd_gzip here, but it was an excellent idea.

Regards,
Willy

