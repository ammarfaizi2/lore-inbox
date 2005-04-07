Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262499AbVDGQCo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262499AbVDGQCo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Apr 2005 12:02:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262500AbVDGQCo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Apr 2005 12:02:44 -0400
Received: from smtp101.rog.mail.re2.yahoo.com ([206.190.36.79]:34186 "HELO
	smtp101.rog.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S262499AbVDGQC0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Apr 2005 12:02:26 -0400
Message-ID: <42555993.4020108@cogent.ca>
Date: Thu, 07 Apr 2005 12:02:27 -0400
From: Andrew Thomas <Andrew.Thomas@cogent.ca>
Organization: Cogent Real-Time Systems Inc.
User-Agent: Mozilla Thunderbird 1.0RC1 (Windows/20041201)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: oops in misc_register, kernel 2.6.9+, using udev
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I am trying to install the srripc module - source at:
     http://www.cogent.ca/Software/SRR.html
on a Linux 2.6.x kernel with udev support.  The kernel generates an oops
in misc_register, which is essentially the first call that the module
makes on initialization.  Oops output is attached below.

The module runs perfectly without udev support.  Udev support is
standard on Fedora Core and other distributions, and I want to run with
the stock distribution kernel if possible.  I have read the source for
other misc drivers, tried 4 different kernels, two different
distributions, scoured the web, and lurked in this mailing list.  I
cannot find my error, and frankly, I don't think the kernel should oops
here - it should return an error if the input is mildly malformed.

I have tried running the module with no entry in /dev and with a
manually created entry in /dev, with the same results.  I attach code
snippets relevant to the misc_register call below.

FWIW, I am running this within VMWare Workstation 4.5.2.

Any insight would be greatly appreciated.

Thanks,
	Andrew Thomas

-------- Code relevant to misc_register ---------

#define SRR_MINOR	171

static struct file_operations srr_fops = {
	.owner = 	THIS_MODULE,
	.poll =		srr_poll,
	.ioctl =	srr_ioctl,
	.open =		srr_open,
	.flush =	srr_flush,
	.release =	srr_release
};

static struct miscdevice SrrMiscDevice =
{
	.minor = 	SRR_MINOR,
	.name =		"srripc",
	.fops =		&srr_fops,
	.devfs_name =	"srripc"
};

static int __init srr_module_init(void)
{
	int		result;

	INIT_LIST_HEAD (&SrrMiscDevice.list);

	SrrMiscDevice.minor = SRR_MINOR;

	printk ("SRRIPC: Register misc device %d\n", srr_minor);
	result = misc_register (&SrrMiscDevice);
	printk ("SRRIPC: Register misc device complete\n");
	...
}

module_init (srr_module_init);

-------------------- oops -----------------------

SRRIPC: Register misc device 171
Unable to handle kernel NULL pointer dereference at virtual address 00000021
  printing eip:
c025612d
*pde = 00000000
Oops: 0000 [#1]
Modules linked in: srripc parport_pc lp parport autofs4 sunrpc button
battery ac md5 ipv6 uhci_hcd snd_ens1371 snd_rawmidi snd_seq_device
snd_pcm_oss snd_mixer_oss snd_pcm snd_timer snd_page_alloc
snd_ac97_codec snd soundcore gameport pcnet32 mii floppy dm_snapshot
dm_zero dm_mirror ext3 jbd dm_mod BusLogic sd_mod scsi_mod
CPU:    0
EIP:    0060:[<c025612d>]    Not tainted VLI
EFLAGS: 00010286   (2.6.9)
EIP is at misc_register+0xd/0x1e0
eax: 00000021   ebx: c03c74c0   ecx: c03c4738   edx: c03c4738
esi: 00000021   edi: c03d5be0   ebp: c03c7480   esp: c6ee2f60
ds: 007b   es: 007b   ss: 0068
Process modprobe (pid: 4721, threadinfo=c6ee2000 task=ca839480)
Stack: 0000001c 0000001e c03c74c0 d2a18380 c03c74c0 d2a18380 c03c7480
d2834034
        d2a18280 d2a1520c 000000ab c03c74c0 c0147623 c8da23a0 fffffff7
00b7eba0
        c6ee2000 c017ab61 c6ee2fac 00012bf5 b7fd1008 0805aab8 00000000
c6ee2000
Call Trace:
  [<d2834034>] srr_module_init+0x34/0x1e5 [srripc]
  [<c0147623>] sys_init_module+0x203/0x340
  [<c017ab61>] sys_read+0x41/0x70
  [<c010684d>] sysenter_past_esp+0x52/0x71
Code: 00 00 e8 77 91 ec ff eb b4 31 c0 89 47 10 e9 3b ff ff ff 8d 74 26
00 8d bc 27 00 00 00 00 57 bf e0 5b 3d c0 56 89 c6 53 83 ec 10 <8b> 00
c7 04 24 10 49 39 c0 89 44 24 04 e8 91 f8 ec ff ba 6b 00



-- 
Andrew Thomas, President, Cogent Real-Time Systems Inc.
162 Guelph Street, Suite 253, Georgetown, Ontario L7G 5X7, Canada
Phone: 905-286-1081, Email: Andrew.Thomas@cogent.ca, Web: www.cogent.ca

