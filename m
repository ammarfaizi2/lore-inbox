Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132853AbQLNUGj>; Thu, 14 Dec 2000 15:06:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132854AbQLNUGa>; Thu, 14 Dec 2000 15:06:30 -0500
Received: from lsb-catv-1-p021.vtxnet.ch ([212.147.5.21]:4367 "EHLO
	almesberger.net") by vger.kernel.org with ESMTP id <S132853AbQLNUGY>;
	Thu, 14 Dec 2000 15:06:24 -0500
Date: Thu, 14 Dec 2000 20:35:38 +0100
From: Werner Almesberger <Werner.Almesberger@epfl.ch>
To: "Timothy A. DeWees" <whtdrgn@mail.cannet.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Kernel boot params
Message-ID: <20001214203537.J599@almesberger.net>
In-Reply-To: <003201c05f88$db6fc4a0$7930000a@hcd.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <003201c05f88$db6fc4a0$7930000a@hcd.net>; from whtdrgn@mail.cannet.com on Wed, Dec 06, 2000 at 08:31:31AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Timothy A. DeWees wrote:
>     Could someone be so kind to point me to a page where I can find
> a list of parameters I can pass to a kernel on boot.

The following script lists almost all parameters your 2.4 kernel accepts.

The exceptions are parameters obtained via non-standard means, i.e.
 - init= in init/main.c
 - mem=, nopentium, etc. in arch/*/kernel/setup.c (i386 examples)
 - anything your boot loader catches and hides (e.g. vga=, initrd=)

Only tested on i386. Probably works on other 32 bit platforms, but
not on true 64 bit platforms. Should do more error checking.

Usage:

./lss.pl /wherever/vmlinux

- Werner

----------------------------------- lss.pl ------------------------------------

#!/usr/bin/perl
open(KERNEL,$ARGV[0]) || die "open $ARGV[0]: $!";
for (split("\n",`objdump -h $ARGV[0]`)) {
    next unless /^\s*\d+\s+(\S+)\s+(\S+)\s+(\S+)\s+\S+\s+(\S+)/;
    ($size{$1}, $addr{$1}, $offset{$1}) = (hex $2, hex $3, hex $4);
}
die "kernel too old for __setup" unless defined $size{".setup.init"};
for ($i = 0; $i < $size{".setup.init"}; $i += 8) {
    sysseek(KERNEL,$offset{".setup.init"}+$i,0);
    sysread(KERNEL,$pos,4);
    $pos = unpack("L",$pos);
    sysseek(KERNEL,$pos-$addr{".data.init"}+$offset{".data.init"},0);
    sysread(KERNEL,$str,256);
    $str =~ s/\000.*/\n/s;
    print $str;
}

-- 
  _________________________________________________________________________
 / Werner Almesberger, ICA, EPFL, CH           Werner.Almesberger@epfl.ch /
/_IN_N_032__Tel_+41_21_693_6621__Fax_+41_21_693_6610_____________________/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
