Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290618AbSAYJsV>; Fri, 25 Jan 2002 04:48:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290619AbSAYJsO>; Fri, 25 Jan 2002 04:48:14 -0500
Received: from mailout11.sul.t-online.com ([194.25.134.85]:33245 "EHLO
	mailout11.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S290618AbSAYJsB>; Fri, 25 Jan 2002 04:48:01 -0500
Message-ID: <XFMail.20020125104730.R.Oehler@GDAmbH.com>
X-Mailer: XFMail 1.5.0 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
In-Reply-To: <3C4EA9AC.4D61831D@aitel.hist.no>
Date: Fri, 25 Jan 2002 10:47:30 +0100 (MET)
From: Ralf Oehler <R.Oehler@GDImbH.com>
To: Scsi <linux-scsi@vger.kernel.org>
Subject: RE: 2.5 oopses when dealing with bad blocks on scsi disk
Cc: linux-kernel@vger.kernel.org, Helge Hafting <helgehaf@aitel.hist.no>,
        Jens Axboe <axboe@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I know that current 2.4 kernels (still in to 2.4.18-pre7) have a bug in 
the SCSI-area which  makes the kernel crash whenever the SCSI disk 
reports an error or blank sector. This was at least since 2.4.14, 
and so it's probable that the BUG made it into the 2.5-series. 
I already reported this several times, with call chains, 
but nobody seems to really care.


After the crash one finds the following lines in the syslog buffer:
<4>Incorrect number of segments after building list
<4>kernel BUG at /usr/src/linux-2.4.17/include/asm/pci.h:147!

Jens Axboe asked me to insert a printf() before the offending 
BUG() statement to print the "<4>Incorrect" number of segments.
I did, the result was:
<4>Incorrect number of segments after building list.
<4>nents=3, i=1.
<4>kernel BUG at /usr/src/linux-2.4.17-Dbg/include/asm/pci.h:147!

The code looks:
static inline int pci_map_sg(struct pci_dev *hwdev, struct scatterlist *sg,
                             int nents, int direction)
{
        int i;

        if (direction == PCI_DMA_NONE)
                BUG();
 
        /*
         * temporary 2.4 hack
         */
        for (i = 0; i < nents; i++ ) {
                if (sg[i].address && sg[i].page)
                        BUG();
                else if (!sg[i].address && !sg[i].page)
      -------->         {printk("nents=%d, i=%d\n",nents,i); BUG();}
 
                if (sg[i].address)
                        sg[i].dma_address = virt_to_bus(sg[i].address);
                else
                        sg[i].dma_address = page_to_bus(sg[i].page) + sg[i].offset;
        }
 
        flush_write_buffers();
        return nents;
}


Please fix this BUG() before SuSE releases the next version!
I'm still offering my hardware and my time for testing,
but I can't fix the problem by myself. So please tell me what
you need, send me patches to try, or whatever else.

Regards,
        Ralf




By the way: The call chain for 2.4.18-pre7 looks like this:


Welcome to SuSE Linux 7.1 (i386) - Kernel 2.4.18-pre7 (ttyS0).

CPU:    0
EIP:    0010:[<d0851735>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010082
eax: 00000044   ebx: ce890070   ecx: c02243c8   edx: 00001be0
esi: c024a018   edi: 00000018   ebp: c024a000   esp: c0237dd4
ds: 0018   es: 0018   ss: 0018
Process swapper (pid: 0, stackpage=c0237000)
Stack: d0867340 0000009b cf7cb79c cfacf800 c0237e2c 00000000 66656400 00000006 
       cfacf810 00000002 00000003 00000282 41000031 c0220004 ce910600 d0851346 
       cfacf800 cfae9b6c 00000293 ce9106b8 ce910600 cfdbd3ac 00000092 d083466a 
Call Trace: [<d0867340>] [<d0851346>] [<d083466a>] [<d0834df8>] [<d083bb9f>] 
   [<d084e8c0>] [<d083b1fe>] [<d083b3a3>] [<d083b408>] [<d083b890>] [<d084cce9>] 
   [<d08351f7>] [<d0835099>] [<c0117aa2>] [<c01179d9>] [<c01177ca>] [<c0107f8d>] 
   [<c0105150>] [<c0105150>] [<c0105173>] [<c01051d7>] [<c0105000>] [<c0105027>] 
Code: 0f 0b 83 c4 08 83 3e 00 74 13 8b 06 05 00 00 00 40 89 46 0c 

>>EIP; d0851735 <[aic7xxx]ahc_linux_run_device_queue+3bd/934>   <=====
Trace; d0867340 <[aic7xxx].rodata.start+140/132c>
Trace; d0851346 <[aic7xxx]ahc_linux_queue+176/1a8>
Trace; d083466a <[scsi_mod]scsi_dispatch_cmd+18e/33c>
Trace; d0834df8 <[scsi_mod]scsi_done+0/ac>
Trace; d083bb9f <[scsi_mod]scsi_request_fn+2c3/2f8>
Trace; d084e8c0 <[sd_mod]sd_template+0/0>
Trace; d083b1fe <[scsi_mod]scsi_queue_next_request+3a/100>
Trace; d083b3a3 <[scsi_mod]__scsi_end_request+df/12c>
Trace; d083b408 <[scsi_mod]scsi_end_request+18/1c>
Trace; d083b890 <[scsi_mod]scsi_io_completion+3c4/3d0>
Trace; d084cce9 <[sd_mod]rw_intr+1d9/1e4>
Trace; d08351f7 <[scsi_mod]scsi_finish_command+bf/c8>
Trace; d0835099 <[scsi_mod]scsi_bottom_half_handler+1f5/210>
Trace; c0117aa2 <bh_action+1a/40>
Trace; c01179d9 <tasklet_hi_action+5d/80>
Trace; c01177ca <do_softirq+5a/ac>
Trace; c0107f8d <do_IRQ+a1/b4>
Trace; c0105150 <default_idle+0/28>
Trace; c0105150 <default_idle+0/28>
Trace; c0105173 <default_idle+23/28>
Trace; c01051d7 <cpu_idle+3f/54>
Trace; c0105000 <_stext+0/0>
Trace; c0105027 <rest_init+27/28>
Code;  d0851735 <[aic7xxx]ahc_linux_run_device_queue+3bd/934>
00000000 <_EIP>:
Code;  d0851735 <[aic7xxx]ahc_linux_run_device_queue+3bd/934>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  d0851737 <[aic7xxx]ahc_linux_run_device_queue+3bf/934>
   2:   83 c4 08                  add    $0x8,%esp
Code;  d085173a <[aic7xxx]ahc_linux_run_device_queue+3c2/934>
   5:   83 3e 00                  cmpl   $0x0,(%esi)
Code;  d085173d <[aic7xxx]ahc_linux_run_device_queue+3c5/934>
   8:   74 13                     je     1d <_EIP+0x1d> d0851752
<[aic7xxx]ahc_linux_run_device_queue+3da/934>
Code;  d085173f <[aic7xxx]ahc_linux_run_device_queue+3c7/934>
   a:   8b 06                     mov    (%esi),%eax
Code;  d0851741 <[aic7xxx]ahc_linux_run_device_queue+3c9/934>
   c:   05 00 00 00 40            add    $0x40000000,%eax
Code;  d0851746 <[aic7xxx]ahc_linux_run_device_queue+3ce/934>
  11:   89 46 0c                  mov    %eax,0xc(%esi)

 <0>Kernel panic: Aiee, killing interrupt handler!







Regards, 
        Ralf


On 23-Jan-2002 Helge Hafting wrote:
|    One of my scsi disks has got some bad blocks.  
|    Accessing them (via ext2 on top of raid-0) usually results
|    in a wait and a io error. 
|    
|    badblocks and e2fsck -l 
|    runs fine, but e2fsck -c causes oopses and
|    sometimes ends up shutting the disk down.  I've been unable
|    to capture any oops so far due to the several pages 
|    of output that follows.
|    
|    This happens with 2.5.2dj2 (with ALSA).  Other
|    2.5 kernels I have also struggle with this.
|    Accessing the bad blocks through ext2 does not
|    update the bad block inode, I thought it should.
|    
|    I plan on moving data to another disk and
|    replace the faulty one later.  I can run experiments
|    on the bad one if the fs/driver people here
|    wants more information.
|    
|    The disks are 2 quantum atlas IV, connected to
|    a tekram adapter using the SYM53C8XX v. 2 driver.
|    Both disks have several partitions, some used
|    in raid-0.  
|    
|    Helge Hafting


 ---------------------------------------------------------------------------
|  Ralf Oehler                                                    
|  GDA - Gesellschaft fuer Digitale                              _/
|        Archivierungstechnik mbH & CoKG                        _/
|                                               #/_/_/_/ _/_/_/_/ _/_/_/_/
|  E-Mail:      R.Oehler@GDAmbH.com            _/    _/ _/    _/       _/
|  Tel.:        +49 6182-9271-23              _/    _/ _/    _/ _/    _/
|  Fax.:        +49 6182-25035               _/_/_/_/ _/_/_/#/ _/_/_/#/
|  Mail:        GDA, Bensbruchstraﬂe 11,          _/
|               D-63533 Mainhausen         _/_/_/_/
|  HTTP:        www.GDAmbH.com
 ---------------------------------------------------------------------------

time is a funny concept
