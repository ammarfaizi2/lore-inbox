Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286331AbRLTTIT>; Thu, 20 Dec 2001 14:08:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286336AbRLTTIC>; Thu, 20 Dec 2001 14:08:02 -0500
Received: from mail.myrio.com ([63.109.146.2]:242 "HELO smtp1.myrio.com")
	by vger.kernel.org with SMTP id <S286331AbRLTTHo> convert rfc822-to-8bit;
	Thu, 20 Dec 2001 14:07:44 -0500
content-class: urn:content-classes:message
Subject: RE: ramdisk corruption problems - was: RE: pivot_root and initrd 	kern el panic woes
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Date: Thu, 20 Dec 2001 11:06:53 -0800
X-MimeOLE: Produced By Microsoft Exchange V6.0.5762.3
Message-ID: <D52B19A7284D32459CF20D579C4B0C0211CB0F@mail0.myrio.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: ramdisk corruption problems - was: RE: pivot_root and initrd 	kern el panic woes
Thread-Index: AcGJUPrffoVZ/+x3SuizKZWslMpBCgANsf8w
From: "Torrey Hoffman" <torrey.hoffman@myrio.com>
To: "Tachino Nobuhiro" <tachino@open.nm.fujitsu.co.jp>
Cc: <andersen@codepoet.org>, "linux-kernel" <linux-kernel@vger.kernel.org>,
        <viro@math.psu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yes, this does fix the problem.  Thank you very much!

Hopefully something like this will make it into 2.4.18?

(I have to admit I applied and tested your patch to 
2.4.17-rc2, and did not test -rc2 without your patch.  
However, -rc1 has the bug and I don't think any other changes 
between -rc1 and -rc2 would have fixed this.  If someone out 
there wants me to, I can recompile and test -rc2 vanilla.)

Torrey Hoffman


Tachino Nobuhiro (tachino@open.nm.fujitsu.co.jp) wrote:
 
> Hello,
> 
> Following patch may fix your problem. 
> 
> diff -r -u linux-2.4.17-rc2.org/drivers/block/rd.c 
> linux-2.4.17-rc2/drivers/block/rd.c
> --- linux-2.4.17-rc2.org/drivers/block/rd.c	Thu Dec 20 20:30:57 2001
> +++ linux-2.4.17-rc2/drivers/block/rd.c	Thu Dec 20 20:46:53 2001
> @@ -194,9 +194,11 @@
>  static int ramdisk_readpage(struct file *file, struct page * page)
>  {
>  	if (!Page_Uptodate(page)) {
> -		memset(kmap(page), 0, PAGE_CACHE_SIZE);
> -		kunmap(page);
> -		flush_dcache_page(page);
> +		if (!page->buffers) {
> +			memset(kmap(page), 0, PAGE_CACHE_SIZE);
> +			kunmap(page);
> +			flush_dcache_page(page);
> +		}
>  		SetPageUptodate(page);
>  	}
>  	UnlockPage(page);
> 
> 
>   grow_dev_page() creates not Uptodate page which has valid 
> buffers, so
> it is wrong that ramdisk_readpage() clears whole page unconditionally.
> 
> 
> At Tue, 18 Dec 2001 12:14:49 -0800,
> Torrey Hoffman wrote:
> > 
> > More information!  And a workaround!
> > 
> > I conjecture that the ramdisk driver (post 2.4.9) only grabs
> > VM pages properly if it is accessed directly, as a dd to 
> > /dev/ram0 does.  I further conjecture that accessing the 
> > ramdisk through a mounted filesystem does not grab pages 
> > properly.
> > 
> > The reason I believe this is that removing the call to 
> > "freeramdisk" from my original script avoids corruption.  
> > 
> > Another way to avoid ramdisk corruption is to 
> > "dd if=/dev/zero of=/dev/ram0 bs=1k count=4000" 
> > immediately after the call to freeramdisk.
> > 
> > If my conjecture is right, then the corruption is caused 
> > because mke2fs on a "freed" /dev/ram0 doesn't touch every 
> > block of the fs, leaving "holes" where pages are not properly 
> > grabbed from the VM. The resulting filesystem appears to work, 
> > but dd'ing from /dev/ram0 gets a broken filesystem image.
> > 
> > Note that "freeramdisk /dev/ram0" is pretty much just:
> > #define FLKFLSBUF  _IO(0x12,97) /* flush buffer cache */
> > f = open("/dev/ram0", O_RDWR);
> > ioctl(f, BLKFLSBUF);
> > 
> > To experiment for yourself, stick the following script in
> > a subdirectory which also contains a "testdir" directory
> > with about 3 MB of data.
> > 
> > - - - - - - - -
> > #!/bin/bash
> > 
> > # to tickle the bug, do the freeramdisk but not the
> > # dd from /dev/zero to /dev/ram0.  
> > 
> > freeramdisk /dev/ram0
> > #dd if=/dev/zero of=/dev/ram0 bs=1k count=4000
> > 
> > mke2fs -m0 /dev/ram0 4000
> > mount -t ext2 /dev/ram0 /mnt/ramdisk
> > rm -rf /mnt/ramdisk/*
> > 
> > cp -a ./testdir /mnt/ramdisk
> > umount /dev/ram0
> > 
> > dd if=/dev/ram0 of=ram0.img bs=1k count=4000
> > dd if=ram0.img of=/dev/ram0 bs=1k count=4000
> > 
> > mount -t ext2 /dev/ram0 /mnt/ramdisk
> > diff -q -r ./testdir /mnt/ramdisk/testdir
> > 
> > # If diff reports mismatches, you saw the bug.
> > 
> > umount /dev/ram0
> > - - - - - - - -
> > 
> > If the gods of the VM and VFS don't bother to look at 
> > it, I might take a peek at the relevant kernel code myself.  
> > Might take two months of study before I know enough though.
> > 
> > Torrey
