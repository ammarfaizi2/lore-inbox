Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276562AbRJCRJg>; Wed, 3 Oct 2001 13:09:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276564AbRJCRJa>; Wed, 3 Oct 2001 13:09:30 -0400
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:54766 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S276562AbRJCRJY>; Wed, 3 Oct 2001 13:09:24 -0400
From: Andreas Dilger <adilger@turbolabs.com>
Date: Wed, 3 Oct 2001 11:09:10 -0600
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
        linux-lvm@sistina.com
Subject: Re: [linux-lvm] Re: partition table read incorrectly
Message-ID: <20011003110910.F8954@turbolinux.com>
Mail-Followup-To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
	linux-kernel@vger.kernel.org, linux-lvm@sistina.com
In-Reply-To: <20011002202934.G14582@wiggy.net> <E15oUUf-0005Xw-00@the-village.bc.nu> <20011002220053.H14582@wiggy.net> <20011002150820.N8954@turbolinux.com> <20011003142633.A16089@cistron.nl> <20011003144236.A31796@cistron.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011003144236.A31796@cistron.nl>
User-Agent: Mutt/1.3.22i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Oct 03, 2001  14:42 +0200, Wichert Akkerman wrote:
> Here are the first 512 bytes for the disk which the kernel gets
> wrong (/dev/sdb):
> 
> 000000 48 4d 01 00 00 00 00 00 00 04 00 00 00 10 00 00
> 000010 00 10 00 00 00 20 00 00 00 80 00 00 00 a0 00 00
> 000020 00 48 01 00 00 f0 01 00 00 00 41 00 47 59 75 35
> 000030 50 30 6a 63 58 57 45 42 74 38 64 44 74 70 51 6d
> 000040 31 6a 50 38 57 41 31 4e 5a 46 39 65 00 00 00 00
> 000050 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> *
> 0000a0 00 00 00 00 00 00 00 00 00 00 00 00 76 67 5f 75
> 0000b0 73 65 72 00 00 00 00 00 00 00 00 00 00 00 00 00
> 0000c0 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> *
> 000120 00 00 00 00 00 00 00 00 00 00 00 00 63 6c 6f 75
> 000130 64 31 30 30 31 37 38 30 32 30 38 00 00 00 00 00
> 000140 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> *
> 0001a0 00 00 00 00 00 00 00 00 00 00 00 00 08 00 00 00
> 0001b0 01 00 00 00 01 00 00 00 02 00 00 00 70 90 23 02
> 0001c0 01 00 00 00 00 20 00 00 1b 11 00 00 80 00 00 00
> 0001d0 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> *
> 0001f0 00 00 00 00 00 00 00 00 00 00 00 00 00 00 55 aa

OK, so it turns out that LVM is NOT zeroing any of the metadata outside
of the actual allocated fields in the on-disk structs.  Since the on-disk
structs DO NOT include padding at the end, this means we leave garbage
like the DOS partition table signature on the disk.  Yuck.

Likely places to fix this are:
- pv_setup_for_create(): zap the first few MB of the PV (and the end while
  you are at it, to remove old MD RAID signatures).  This is slow, and will
  duplicate some of the I/O when writing the VGDA/PE tables, etc.
- pv_disk_t(): increase the size with padding at the end to LVM_PV_DISK_SIZE
  You will need to do the same for all of the other on-disk structures.
  You also need zero bytes from pe_on_disk.base + pe_total*sizeof(pe_disk_t)
  to pe_on_disk.base + pe_on_disk.size.  This is also a problem because the
  LVM_PV_*_SIZE were changed, so the amount of padding is not constant.
- pv_write(): ugly since it adds constant overhead.  This will be "handled"
  if pv_disk_t() is increased in size.

Cheers, Andreas
--
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert

