Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274837AbTHFWYV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 18:24:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274953AbTHFWYV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 18:24:21 -0400
Received: from gateway.cal.trlabs.ca ([209.115.224.130]:30724 "EHLO
	gateway.cal.trlabs.ca") by vger.kernel.org with ESMTP
	id S274837AbTHFWYM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 18:24:12 -0400
Message-ID: <3F318016.7020801@cal.trlabs.ca>
Date: Wed, 06 Aug 2003 16:24:22 -0600
From: Scott Jacobsen <jacobsen@cal.trlabs.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: mmap, PCI, segmentation fault, Dell Dimension 4550
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.  Sorry for the intrusion but I've searched the archives and can't 
seem to find the answer for my problem.

After using mmap() map a peripheral card's PCI base address registers to 
user space on my Dell Dimension 4550 (Dell BIOS), I cause a segmentation 
fault by accessing the mapped memory.

My OS is Redhat 9 and the underlying kernel is 2.4.20-8.  The code works 
fine on a generic computer (Award BIOS) running exactly the same kernel.

My driver for the card also maps the PCI base address registers in 
kernel space for the driver's usage, but like I mentioned, the code 
works fine on the other computer.

Here's my code and command line output (please pardon my non-gdb testing 
procedure):

////////////////////// code /////////////////////////

int Software_Radio::get_bars()
{
   printf("get_bars\n");		// TEST LINE
   uchar config_data[256];
   off_t physical_bars[5];

   if(ioctl(filep, CONFIG_READ, config_data) == -1)
     perror("\nSoftware_Radio::get_bars() ioctl() CONFIG_READ failed");

   physical_bars[0]=((off_t)config_data[PCI_BASE_ADDRESS_0] |
		   ((off_t)config_data[PCI_BASE_ADDRESS_0 + 1] << 8) |
		   ((off_t)config_data[PCI_BASE_ADDRESS_0 + 2] << 16) |
		   ((off_t)config_data[PCI_BASE_ADDRESS_0 + 3] << 24) );
   physical_bars[1]=((off_t)config_data[PCI_BASE_ADDRESS_1] |
		   ((off_t)config_data[PCI_BASE_ADDRESS_1 + 1] << 8) |
		   ((off_t)config_data[PCI_BASE_ADDRESS_1 + 2] << 16) |
		   ((off_t)config_data[PCI_BASE_ADDRESS_1 + 3] << 24) );
   physical_bars[2]=((off_t)config_data[PCI_BASE_ADDRESS_2] |
		   ((off_t)config_data[PCI_BASE_ADDRESS_2 + 1] << 8) |
		   ((off_t)config_data[PCI_BASE_ADDRESS_2 + 2] << 16) |
		   ((off_t)config_data[PCI_BASE_ADDRESS_2 + 3] << 24) );
   physical_bars[3]=((off_t)config_data[PCI_BASE_ADDRESS_3] |
		   ((off_t)config_data[PCI_BASE_ADDRESS_3 + 1] << 8) |
		   ((off_t)config_data[PCI_BASE_ADDRESS_3 + 2] << 16) |
		   ((off_t)config_data[PCI_BASE_ADDRESS_3 + 3] << 24) );
   physical_bars[4]=((off_t)config_data[PCI_BASE_ADDRESS_4] |
		   ((off_t)config_data[PCI_BASE_ADDRESS_4 + 1] << 8) |
		   ((off_t)config_data[PCI_BASE_ADDRESS_4 + 2] << 16) |
		   ((off_t)config_data[PCI_BASE_ADDRESS_4 + 3] << 24) );

   int fd;
   if((fd=open("/dev/mem",O_RDWR)) < 0) {
     perror("opening /dev/mem");
     return -1;
   }
   unsigned long * remapped_bars[5];
   void * temp;
   for (int i = 0; i < 5; i++) {
     if((temp = mmap(0,bar_sizes[i],PROT_WRITE | PROT_READ,
		    MAP_SHARED | MAP_FILE, fd, physical_bars[i])) < 0) {
       printf("MMAP failed.  Reason: %s\n",strerror(errno));
       return -1;
     }
     remapped_bars[i] = (unsigned long *)temp;
   }
   bar0 = remapped_bars[0];
   printf("bar0 = 0x%x\n",&bar0);	// TEST LINE
   printf("bar0[15] = 0x%x\n",bar0[0]);  // THIS LINE, OR ANY bar0[0] 
CAUSES A SEGMENTATION FAULT
   bar1 = remapped_bars[1];
   bar2 = remapped_bars[2];
   bar3 = remapped_bars[3];
   bar4 = remapped_bars[4];
   close(fd);
}

/////////////////// command line //////////////////

[root@jacobsen swr]# ./test
main:line 1			
opening device /dev/sidrv0
get_bars
bar0 = 0xbfffe0b0
Segmentation fault
[root@jacobsen swr]#


//////////////////////////////////////////////////

Any suggestions?

Thanks,

Scott Jacobsen
MSc(Eng) Student
University of Calgary

