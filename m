Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275371AbTHGOtf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 10:49:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275350AbTHGOsa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 10:48:30 -0400
Received: from gateway.cal.trlabs.ca ([209.115.224.130]:34826 "EHLO
	gateway.cal.trlabs.ca") by vger.kernel.org with ESMTP
	id S275364AbTHGOqt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 10:46:49 -0400
Message-ID: <3F326650.1090607@cal.trlabs.ca>
Date: Thu, 07 Aug 2003 08:46:40 -0600
From: Scott Jacobsen <jacobsen@cal.trlabs.ca>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.0.2) Gecko/20030208 Netscape/7.02
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: mmap, PCI, segmentation fault, Dell Dimension 4550
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Oops.  Private variable for the Software_Radio class.

unsigned long * bar0, *bar1, *bar2, *bar3, *bar4

Thx.

David B. Stevens wrote:

> Scott,
>
> Maybe I'm blind but where is bar0[x] ... defined.
>
> Cheers,
>   Dave
>
>
> Scott Jacobsen wrote:
>
>> Hi.  Sorry for the intrusion but I've searched the archives and can't 
>> seem to find the answer for my problem.
>>
>> After using mmap() map a peripheral card's PCI base address registers 
>> to user space on my Dell Dimension 4550 (Dell BIOS), I cause a 
>> segmentation fault by accessing the mapped memory.
>>
>> My OS is Redhat 9 and the underlying kernel is 2.4.20-8.  The code 
>> works fine on a generic computer (Award BIOS) running exactly the 
>> same kernel.
>>
>> My driver for the card also maps the PCI base address registers in 
>> kernel space for the driver's usage, but like I mentioned, the code 
>> works fine on the other computer.
>>
>> Here's my code and command line output (please pardon my non-gdb 
>> testing procedure):
>>
>> ////////////////////// code /////////////////////////
>>
>> int Software_Radio::get_bars()
>> {
>>   printf("get_bars\n");        // TEST LINE
>>   uchar config_data[256];
>>   off_t physical_bars[5];
>>
>>   if(ioctl(filep, CONFIG_READ, config_data) == -1)
>>     perror("\nSoftware_Radio::get_bars() ioctl() CONFIG_READ failed");
>>
>>   physical_bars[0]=((off_t)config_data[PCI_BASE_ADDRESS_0] |
>>            ((off_t)config_data[PCI_BASE_ADDRESS_0 + 1] << 8) |
>>            ((off_t)config_data[PCI_BASE_ADDRESS_0 + 2] << 16) |
>>            ((off_t)config_data[PCI_BASE_ADDRESS_0 + 3] << 24) );
>>   physical_bars[1]=((off_t)config_data[PCI_BASE_ADDRESS_1] |
>>            ((off_t)config_data[PCI_BASE_ADDRESS_1 + 1] << 8) |
>>            ((off_t)config_data[PCI_BASE_ADDRESS_1 + 2] << 16) |
>>            ((off_t)config_data[PCI_BASE_ADDRESS_1 + 3] << 24) );
>>   physical_bars[2]=((off_t)config_data[PCI_BASE_ADDRESS_2] |
>>            ((off_t)config_data[PCI_BASE_ADDRESS_2 + 1] << 8) |
>>            ((off_t)config_data[PCI_BASE_ADDRESS_2 + 2] << 16) |
>>            ((off_t)config_data[PCI_BASE_ADDRESS_2 + 3] << 24) );
>>   physical_bars[3]=((off_t)config_data[PCI_BASE_ADDRESS_3] |
>>            ((off_t)config_data[PCI_BASE_ADDRESS_3 + 1] << 8) |
>>            ((off_t)config_data[PCI_BASE_ADDRESS_3 + 2] << 16) |
>>            ((off_t)config_data[PCI_BASE_ADDRESS_3 + 3] << 24) );
>>   physical_bars[4]=((off_t)config_data[PCI_BASE_ADDRESS_4] |
>>            ((off_t)config_data[PCI_BASE_ADDRESS_4 + 1] << 8) |
>>            ((off_t)config_data[PCI_BASE_ADDRESS_4 + 2] << 16) |
>>            ((off_t)config_data[PCI_BASE_ADDRESS_4 + 3] << 24) );
>>
>>   int fd;
>>   if((fd=open("/dev/mem",O_RDWR)) < 0) {
>>     perror("opening /dev/mem");
>>     return -1;
>>   }
>>   unsigned long * remapped_bars[5];
>>   void * temp;
>>   for (int i = 0; i < 5; i++) {
>>     if((temp = mmap(0,bar_sizes[i],PROT_WRITE | PROT_READ,
>>             MAP_SHARED | MAP_FILE, fd, physical_bars[i])) < 0) {
>>       printf("MMAP failed.  Reason: %s\n",strerror(errno));
>>       return -1;
>>     }
>>     remapped_bars[i] = (unsigned long *)temp;
>>   }
>>   bar0 = remapped_bars[0];
>>   printf("bar0 = 0x%x\n",&bar0);    // TEST LINE
>>   printf("bar0[15] = 0x%x\n",bar0[0]);  // THIS LINE, OR ANY bar0[0] 
>> CAUSES A SEGMENTATION FAULT
>>   bar1 = remapped_bars[1];
>>   bar2 = remapped_bars[2];
>>   bar3 = remapped_bars[3];
>>   bar4 = remapped_bars[4];
>>   close(fd);
>> }
>>
>> /////////////////// command line //////////////////
>>
>> [root@jacobsen swr]# ./test
>> main:line 1           opening device /dev/sidrv0
>> get_bars
>> bar0 = 0xbfffe0b0
>> Segmentation fault
>> [root@jacobsen swr]#
>>
>>
>> //////////////////////////////////////////////////
>>
>> Any suggestions?
>>
>> Thanks,
>>
>> Scott Jacobsen
>> MSc(Eng) Student
>> University of Calgary
>>
>> -
>> To unsubscribe from this list: send the line "unsubscribe 
>> linux-kernel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> Please read the FAQ at  http://www.tux.org/lkml/
>>
>
>
>

-- 
TRLabs
#280, 3553 - 31 Street NW
Calgary, Alberta T2L 2K7
Canada

Phone: 403-210-3530
Fax: 403-282-5870

Email: jacobsen@cal.trlabs.ca

 





-- 
TRLabs
#280, 3553 - 31 Street NW
Calgary, Alberta T2L 2K7
Canada

Phone: 403-210-3530
Fax: 403-282-5870

Email: jacobsen@cal.trlabs.ca

 


