Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265982AbSL1UKr>; Sat, 28 Dec 2002 15:10:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265589AbSL1UKr>; Sat, 28 Dec 2002 15:10:47 -0500
Received: from packet.digeo.com ([12.110.80.53]:31971 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S265570AbSL1UKe>;
	Sat, 28 Dec 2002 15:10:34 -0500
Message-ID: <3E0E071F.F6819548@digeo.com>
Date: Sat, 28 Dec 2002 12:18:39 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.52 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Justin T. Gibbs" <gibbs@scsiguy.com>
CC: James Bottomley <James.Bottomley@steeleye.com>,
       Rik van Riel <riel@conectiva.com.br>,
       Tomas Szepe <szepe@pinerecords.com>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       Samuel Flory <sflory@rackable.com>, Janet Morgan <janetmor@us.ibm.com>,
       linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] aic7xxx bouncing over 4G
References: <200212281500.gBSF0pc01929@localhost.localdomain> <712898112.1041103010@aslan.scsiguy.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 28 Dec 2002 20:18:44.0549 (UTC) FILETIME=[5224EF50:01C2AEAE]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Justin T. Gibbs" wrote:
> 
> > So far, the only bug report I have is from Andrew Morton proving that it
> > still  doesn't get it's bounce buffers right.
> 
> That hasn't applied since 6.2.10 or so.  2.5.X is still using 6.2.4.
> 

2.5.53 is using 6.2.24, and it is bounce buffering highmem I/O.  6.2.4
was OK in this regard.

$ dd if=/dev/zero of=/mnt/sde5/foo bs=1M count=4000
$ oprofpp -l -i /boot/vmlinux

...
c0133010 72       0.175854    bad_range
c0134c44 74       0.180739    __set_page_dirty_nobuffers
c0135a74 79       0.192951    poison_obj
c0136e90 86       0.210048    kmem_cache_alloc
c0196f4c 88       0.214933    ext2_get_branch
c01333a4 89       0.217375    __rmqueue
c01304a4 90       0.219818    unlock_page
c0133658 92       0.224703    buffered_rmqueue
c0130294 95       0.23203     add_to_page_cache
c0131a38 99       0.2418      generic_file_aio_write_nolock
c014ea54 110      0.268666    __find_get_block
c01972d8 136      0.332169    ext2_get_block
c0135aa4 141      0.344381    check_poison_obj
c013b174 1517     3.70515     __blk_queue_bounce       <<<<<
c01e9548 2904     7.09279     __copy_from_user
c01089f8 33209    81.1103     poll_idle

  Linux version 2.5.53 (akpm@mnm) (gcc version 2.95.3 20010315 (release)) #178 SMP Sat Dec 28 12:09:10 PST 2002
  3264MB HIGHMEM available.
  896MB LOWMEM available.
...
  highmem bounce pool size: 64 pages
...
  aic7xxx: PCI Device 0:10:0 failed memory mapped test.  Using PIO.
  ahc_pci:0:10:0: Host Adapter Bios disabled.  Using default SCSI device parameters
  scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.24
          <Adaptec 29160 Ultra160 SCSI adapter>
          aic7892: Ultra160 Wide Channel A, SCSI Id=7, 32/253 SCBs
  
  (scsi0:A:0): 40.000MB/s transfers (20.000MHz, offset 31, 16bit)
    Vendor: QUANTUM   Model: ATLAS IV 9 SCA    Rev: 0B0B
    Type:   Direct-Access                      ANSI SCSI revision: 03
  (scsi0:A:1): 40.000MB/s transfers (20.000MHz, offset 31, 16bit)
    Vendor: QUANTUM   Model: ATLAS 10K 9SCA    Rev: UC81
    Type:   Direct-Access                      ANSI SCSI revision: 03
  (scsi0:A:2): 40.000MB/s transfers (20.000MHz, offset 15, 16bit)
    Vendor: SEAGATE   Model: ST19101W          Rev: 0014
    Type:   Direct-Access                      ANSI SCSI revision: 02
  (scsi0:A:4): 40.000MB/s transfers (20.000MHz, offset 31, 16bit)
    Vendor: QUANTUM   Model: QM39100TD-SCA     Rev: N1B0
    Type:   Direct-Access                      ANSI SCSI revision: 02
  scsi scan: host 0 channel 0 id 4 lun 0 identifier too long, length 60, max 50. Device might be improperly identified.
  (scsi0:A:5): 40.000MB/s transfers (20.000MHz, offset 63, 16bit)
    Vendor: FUJITSU   Model: MAF3364L SUN36G   Rev: 1213
    Type:   Direct-Access                      ANSI SCSI revision: 02
    Vendor: ESG-SHV   Model: SCA HSBP M4       Rev: 0.63
    Type:   Processor                          ANSI SCSI revision: 02
  scsi1 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.24
          <Adaptec aic7880 Ultra SCSI adapter>
          aic7880: Ultra Wide Channel A, SCSI Id=7, 16/253 SCBs
  
  (scsi1:A:0): 40.000MB/s transfers (20.000MHz, offset 8, 16bit)
    Vendor: QUANTUM   Model: ATLAS 10K 9SCA    Rev: UC81
    Type:   Direct-Access                      ANSI SCSI revision: 03
  (scsi1:A:1): 40.000MB/s transfers (20.000MHz, offset 8, 16bit)
    Vendor: QUANTUM   Model: ATLAS 10K 9SCA    Rev: UCH0
    Type:   Direct-Access                      ANSI SCSI revision: 03
  (scsi1:A:2): 40.000MB/s transfers (20.000MHz, offset 8, 16bit)
    Vendor: QUANTUM   Model: ATLAS 10K 9SCA    Rev: UC81
    Type:   Direct-Access                      ANSI SCSI revision: 03
  (scsi1:A:4): 40.000MB/s transfers (20.000MHz, offset 8, 16bit)
    Vendor: QUANTUM   Model: ATLAS 10K 9SCA    Rev: UCP0
    Type:   Direct-Access                      ANSI SCSI revision: 03
  (scsi1:A:5): 40.000MB/s transfers (20.000MHz, offset 8, 16bit)
    Vendor: FUJITSU   Model: MAF3364L SUN36G   Rev: 1213
    Type:   Direct-Access                      ANSI SCSI revision: 02
    Vendor: ESG-SHV   Model: SCA HSBP M4       Rev: 0.63
    Type:   Processor                          ANSI SCSI revision: 02
  SCSI device sda: drive cache: write back
  SCSI device sda: 17942584 512-byte hdwr sectors (9187 MB)
   sda: sda1
  Attached scsi disk sda at scsi0, channel 0, id 0, lun 0
  SCSI device sdb: drive cache: write back
  SCSI device sdb: 17938986 512-byte hdwr sectors (9185 MB)
   sdb: sdb1
  Attached scsi disk sdb at scsi0, channel 0, id 1, lun 0
  SCSI device sdc: drive cache: write back
  SCSI device sdc: 17783240 512-byte hdwr sectors (9105 MB)
   sdc: sdc1
  Attached scsi disk sdc at scsi0, channel 0, id 2, lun 0
  SCSI device sdd: drive cache: write back
  SCSI device sdd: 17783249 512-byte hdwr sectors (9105 MB)
   sdd: sdd1 < sdd5 >
  Attached scsi disk sdd at scsi0, channel 0, id 4, lun 0
  SCSI device sde: drive cache: write through
  SCSI device sde: 71132959 512-byte hdwr sectors (36420 MB)
   sde: sde1 < sde5 sde6 sde7 >
  Attached scsi disk sde at scsi0, channel 0, id 5, lun 0
  SCSI device sdf: drive cache: write back
  SCSI device sdf: 17938986 512-byte hdwr sectors (9185 MB)
   sdf: sdf1
  Attached scsi disk sdf at scsi1, channel 0, id 0, lun 0
  SCSI device sdg: drive cache: write back
  SCSI device sdg: 17938986 512-byte hdwr sectors (9185 MB)
   sdg: sdg1
  Attached scsi disk sdg at scsi1, channel 0, id 1, lun 0
  SCSI device sdh: drive cache: write back
  SCSI device sdh: 17938986 512-byte hdwr sectors (9185 MB)
   sdh: sdh1
  Attached scsi disk sdh at scsi1, channel 0, id 2, lun 0
  SCSI device sdi: drive cache: write back
  SCSI device sdi: 17938986 512-byte hdwr sectors (9185 MB)
   sdi: sdi1 < sdi5 sdi6 >
  Attached scsi disk sdi at scsi1, channel 0, id 4, lun 0
  SCSI device sdj: drive cache: write through
  SCSI device sdj: 71132959 512-byte hdwr sectors (36420 MB)
   sdj: sdj1 < sdj5 sdj6 >
  Attached scsi disk sdj at scsi1, channel 0, id 5, lun 0
