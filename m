Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262689AbTCYP5o>; Tue, 25 Mar 2003 10:57:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262690AbTCYP5o>; Tue, 25 Mar 2003 10:57:44 -0500
Received: from [170.210.46.46] ([170.210.46.46]:43528 "EHLO
	scdt.frc.utn.edu.ar") by vger.kernel.org with ESMTP
	id <S262689AbTCYP5m> convert rfc822-to-8bit; Tue, 25 Mar 2003 10:57:42 -0500
Content-Type: text/plain;
  charset="iso-8859-1"
From: Edgardo Hames <ehames@scdt.frc.utn.edu.ar>
Organization: UTN
To: linux-kernel@vger.kernel.org
Subject: Error accessing memory between 0xc0000 and 0x100000
Date: Tue, 25 Mar 2003 13:08:36 -0300
User-Agent: KMail/1.4.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200303251308.36565.ehames@scdt.frc.utn.edu.ar>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everybody. I'm trying to write a simple device driver to read and write 
memory at addresses beween 0xc0000 and 0x100000, but when I try to load the 
module I get the following error:

memalloc: successful request base=0xd0000, size=0x10000
Unable to handle kernel paging request at virtual address 000d0001
 printing eip:
c182b0b6
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<c182b0b6>]    Not tainted
EFLAGS: 00010282

EIP is at  (2.4.18diskless)
eax: 000d0000   ebx: 00010000   ecx: c026fed8   edx: 00000000
esi: 00000000   edi: 00000000   ebp: c058bf28   esp: c058bf10
ds: 0018   es: 0018   ss: 0018
Process insmod (pid: 220, stackpage=c058b000)
Stack: c182b160 000d0000 00010000 c182b130 00000000 c182b000 0806a810 c01159f5
       00000000 c07a2000 00000220 c07a5000 00000060 ffffffea 00000008 c0638640
       00000060 c1819000 c182b060 000005a4 00000000 00000000 00000000 00000000
Call Trace: [<c182b160>]
[<c182b130>]
[<c01159f5>]
[<c182b060>]
[<c0108ac3>]

Code: c6 40 01 41 83 c4 10 eb 1d 90 50 53 ff 35 9c b5 82 c1 68 a0


Can you help me out, please? Here is the code for my driver:
/***************************** DRIVER CODE ******************************/
int major = 0;
MODULE_PARM(major, "i");

unsigned long isa_base = 0xc0000;
MODULE_PARM(isa_base, "l");

unsigned long isa_max = 0x100000;
MODULE_PARM(isa_max, "l");

MODULE_AUTHOR("Edgardo Hames");
MODULE_LICENSE("GPL");

//#define BUFFER "Hello, world!"

int memalloc_init(void)
{
	int result = 0;
	unsigned long region_size = isa_max - isa_base;

	if (! check_mem_region(isa_base, region_size)) {
		request_mem_region(isa_base, region_size, "memalloc");
		printk("memalloc: successful request base=0x%lx, size=0x%lx\n",
			isa_base, region_size);
//		isa_memcpy_toio(isa_base, BUFFER, strlen(BUFFER));
		writeb ('A', isa_base+1);
	} else {
		printk("memalloc: failed request base=0x%lx, size=0x%lx\n",
			isa_base, region_size);
		return -EBUSY;
	}
	return result;
}

void memalloc_cleanup(void)
{
//#define BUFSIZE 100

	unsigned long region_size = isa_max - isa_base;
//	char buf[BUFSIZE];
	
//	memset(buf, 0, BUFSIZE);
//	isa_memcpy_fromio(buf, isa_base, BUFSIZE);
	printk("Leí: %c\n", readb(isa_base+1));
	release_mem_region(isa_base, region_size);
	printk("Successfully unloading memalloc.\n");
}

module_init(memalloc_init);
module_exit(memalloc_cleanup);

/************************* END OF DRIVER CODE **************************/

Thanks
Ed
-- 
If you cannot convince them, confuse them.
Truman's Law

