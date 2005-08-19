Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751176AbVHSPoU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751176AbVHSPoU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Aug 2005 11:44:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964814AbVHSPoS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Aug 2005 11:44:18 -0400
Received: from ppsw-0.csi.cam.ac.uk ([131.111.8.130]:12471 "EHLO
	ppsw-0.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S1751174AbVHSPoR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Aug 2005 11:44:17 -0400
X-Cam-SpamDetails: Not scanned
X-Cam-AntiVirus: No virus found
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
Subject: Re: Kernel bug: Bad page state: related to generic symlink code
	and mmap
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Cc: vandrove@vc.cvut.cz, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, linware@sh.cvut.cz,
       fsdevel <linux-fsdevel@vger.kernel.org>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20050819142025.GA29811@parcelfarce.linux.theplanet.co.uk>
References: <1124450088.2294.31.camel@imp.csi.cam.ac.uk>
	 <20050819142025.GA29811@parcelfarce.linux.theplanet.co.uk>
Content-Type: multipart/mixed; boundary="=-xAsYf53A8akk1eDtQ5qA"
Organization: Computing Service, University of Cambridge, UK
Date: Fri, 19 Aug 2005 16:44:06 +0100
Message-Id: <1124466246.2294.65.camel@imp.csi.cam.ac.uk>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-xAsYf53A8akk1eDtQ5qA
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, 2005-08-19 at 15:20 +0100, Al Viro wrote:
> On Fri, Aug 19, 2005 at 12:14:48PM +0100, Anton Altaparmakov wrote:
> > There is a bug somewhere in 2.6.11.4 and I can't figure out where it is.
> > I assume it is present in older and newer kernels, too as the related
> > code hasn't changed much AFAICS and googling for "Bad page state"
> > returns rather a lot of hits relating to both older (up to 2.5.70!) and
> > newer kernels...
> > 
> > Note: PLEASE do not stop reading because you read ncpfs below as I am
> > pretty sure it is not ncpfs related!  And looking at google a lot of
> > people have reported such similar problems since 2.5.70 or so and they
> > were all told to go away as they have bad ram.  That is impossible
> > because this happens on well over 600 workstations and several servers
> > 100% reproducible.  Many different types of hardware, different makes,
> > difference age, all running smp kernels even if single cpu.  You can't
> > tell me they all have bad ram.  Windows works fine and Linux works fine
> > except for that one specific problem which is 100% reproducible...
> > 
> > The bug only appears, but it appears 100% reproducibly when a cross
> > volume symlink on ncpfs is accessed using nautilus under gnome.  I.e.
> > double click on a cross volume symlink on ncpfs in nautilus and the
> > machine locks up solid.
> 
> Ugh...  Could you at least tell what does nautilus attempt to do at that
> point?  Something that wouldn't show up with simple ls -l <symlink> or
> cat <symlink> >/dev/null, judging by the above, but what?

One important thing I forgot to add is that the symlink must point to a
directory not a file.  If it points to a file all works fine.

I tried stracing nautilus to answer your question.  And this time for
the first time instead of a Bad page state I got a BUG() triggered in
fs/namei.c, the arrow below marks the spot:

void page_put_link(struct dentry *dentry, struct nameidata *nd)
{
	if (!IS_ERR(nd_get_link(nd))) {
		struct page *page;
		page = find_get_page(dentry->d_inode->i_mapping, 0);
		if (!page)
---->			BUG();
		kunmap(page);
		page_cache_release(page);
		page_cache_release(page);
	}
}

Here is the BUG output:

kernel BUG at fs/namei.c:2329!
invalid operand: 0000 [#1]
SMP
Modules linked in: autofs4 nls_cp850 nls_utf8 ncpfs subfs fuse snd
soundcore speedstep_lib freq_table thermal processor fan button battery
ac nvram ipt_REJECT iptable_filter ip_tables af_packet edd joydev evdev
st video1394 ohci1394 raw1394 ieee1394 capability sg sr_mod dm_mod e1000
uhci_hcd usbcore i2c_i801 i2c_core hw_random parport_pc lp parport
reiserfs ide_cd cdrom ide_disk aic7xxx aic79xx via82cxxx ata_piix libata
piix ide_core sd_mod scsi_mod
CPU:    3
EIP:    0060:[<c0174e3e>]    Tainted: G     U VLI
EFLAGS: 00010246   (2.6.11.4-21.8-smp)
EIP is at page_put_link+0x3e/0x50
eax: 00000000   ebx: 00000000   ecx: d9c75654   edx: 00000000
esi: 00000000   edi: d9d30000   ebp: ffac2000   esp: d9d31eac
ds: 007b   es: 007b   ss: 0068
Process nautilus (pid: 21910, threadinfo=d9d30000 task=f5caf550)
Stack: d9c75654 c0171659 00000000 00004000 c2025060 00000001 d9d31f1c
dff3ec80
       d9c75654 001d981f 00000003 d9eb2014 00000000 d9d30000 d9d31f1c
00000000
       d9eb2000 c0171e96 d9eb2000 d9d31f1c 00000001 d9eb2000 c017211f
08542878
Call Trace:
 [<c0171659>] link_path_walk+0x929/0xe80
 [<c0171e96>] path_lookup+0xa6/0x1c0
 [<c017211f>] __user_walk+0x2f/0x70
 [<c016c6fd>] vfs_stat+0x1d/0x60
 [<c016ce5f>] sys_stat64+0xf/0x30
 [<c0109051>] do_syscall_trace+0xb1/0x175
 [<c01040d7>] syscall_call+0x7/0xb
Code: 31 d2 8b 80 a8 00 00 00 e8 80 e6 fc ff 85 c0 89 c3 74 18 89 d8 e8
93 5e fa ff 89 d8 e8 2c 80 fd ff 89 d8 5b e9 24 80 fd ff 5b c3 <0f> 0b
19 09 76 bb 32 c0 eb de 90 8d b4 26 00 00 00 00 83 ec 28

The compressed strace output is attached.  It was tracing the main
nautilus process (strace -f -F -o /strace.log -p 21910) which is where
the bug was hit as well.  FWIW I attached strace to the process just
before double-clicking on the symlink in the nautilus window...

Looking at the bottom of the strace.log file it seems like two possibly
concurrent stat64() calls of the symlink were running, one of which did
not complete...  (note this was done on a dual-cpu machine with
hyperthreading enabled, i.e. it appears to have four cpus).

Does this help?

Let me know if I can provide any other details...  (I can provide an ssh
connection to a machine for testing purposes if required.)

Best regards,

        Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/

--=-xAsYf53A8akk1eDtQ5qA
Content-Disposition: attachment; filename=strace.log.bz2
Content-Type: application/x-bzip; name=strace.log.bz2
Content-Transfer-Encoding: base64

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


--=-xAsYf53A8akk1eDtQ5qA--

