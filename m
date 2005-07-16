Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262129AbVGPImr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262129AbVGPImr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Jul 2005 04:42:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261944AbVGPIk0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Jul 2005 04:40:26 -0400
Received: from [202.125.86.130] ([202.125.86.130]:12270 "EHLO
	ns2.astrainfonets.net") by vger.kernel.org with ESMTP
	id S261987AbVGPIja convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Jul 2005 04:39:30 -0400
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: FC3 module sys_print how...
X-MimeOLE: Produced By Microsoft Exchange V6.5.6944.0
Date: Sat, 16 Jul 2005 13:50:44 +0530
Message-ID: <4EE0CBA31942E547B99B3D4BFAB34811610FB2@mail.esn.co.in>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: FC3 module sys_print how...
Thread-Index: AcWJOUqxTOeYBlB5RrGl3xooah1rAwApANVw
From: "Mukund JB." <mukundjb@esntechnologies.co.in>
To: <linux-os@analogic.com>
Cc: "Linux kernel" <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Richard,

Thanks for the copy.
I will try it now.
I know we should not try to open, Read, write files from the kernel
module.
We have problem with our flash media driver hanging at certain
instances.
And when it hangs you know I can't see the /var/log/messages.
After the reboot, I do NOT find the complete set of messages in
/var/log/messages.
When debug messages are exceeding the limits, is there a better solution
than writing to the file.

Regards,
Mukund Jampala

>-----Original Message-----
>From: Richard B. Johnson [mailto:linux-os@analogic.com]
>Sent: Friday, July 15, 2005 6:19 PM
>To: Mukund JB.
>Cc: Linux kernel
>Subject: Re: FC3 module sys_print how...
>
>
>It's no longer exported. You can either modify your kernel to
>export it or you can use that attached work-around to extract
>the symbol offset from /boot/System.map.
>
>Please note that manipulating files from within a module has
>never been supported. It just "sort of" works sometimes. In
>your demo code, it will work because the process-context that
>obtains the file-handle is the process that is running 'insmod'.
>If somebody else tried to write to that file after the module
>was installed, all bets are off. I strongly suggest that
>you provide hooks in your module (ioctl() or mmap(), etc) that
>a user-mode helper program can use to send or receive file-data
>from your module.
>
>
>On Fri, 15 Jul 2005, Mukund JB. wrote:
>>
>>
>> Dear Linux-lovers.
>>
>>
>>
>> I am trying to build a 2.6.10 linux kernel module to print messages
to a
>> file. I have done this 2.4 and I was successful but I am failing
here.
>>
>>
>>
>> I am using the sys_open, sys_write calls to do so.
>>
>> I am getting a compilation warning and I find no .ko file created
>> finally instead I find an .o.ko file.
>>
>>
>>
>> *** WARNIG: "sys_write" [/home/cf.o.ko] undefined!
>>
>> Below is the module code. Please suggest me what could be the
problem:-
>>
>>
>>
>>
>>
>> #include <linux/kernel.h>
>>
>> #include <linux/module.h>
>>
>> #include <linux/moduleparam.h>
>>
>> #include <asm/fcntl.h>        /* for O_WRONLY */
>>
>> #include <linux/syscalls.h>   /* for sys_ functions */
>>
>> #include <asm/uaccess.h>      /* for set_fs(), get_fs() etc. */
>>
>> #include <linux/string.h>     /* for string length */
>>
>> #include <linux/slab.h>       /* for kmalloc */
>>
>>
>>
>> MODULE_LICENSE("GPL");
>>
>> /*
>>
>> #define DBG
>>
>> #define PRINTK(fmt,arg...) printk("DBG INFO <%s> | "
>> fmt,__FUNCTION__,##arg)
>>
>> #else
>>
>> #define PRINTK(fmt,arg...) while(0)
>>
>> #endif
>>
>> */
>>
>>
>>
>> typedef struct tagWRITE_TEST
>>
>> {
>>
>>      unsigned long fd;
>>
>>      unsigned long x;
>>
>>
>>
>> }WRITE_TEST, *PWRITE_TEST;
>>
>>
>>
>> PWRITE_TEST ptest;
>>
>>
>>
>> void SysPrint(char * pString, ...)
>>
>> {
>>
>>      static char buff[1024];
>>
>>      va_list ap;
>>
>>
>>
>>      va_start(ap,pString);
>>
>>      vsprintf((char *)buff, pString, ap);
>>
>>      va_end(ap);
>>
>>
>>
>>      sys_write(ptest->fd,(char *)buff,(size_t)strlen(buff));
>>
>> }
>>
>>
>>
>> int init_module(void)
>>
>> {
>>
>>
>>
>>      printk("<%s> invoked!\n",__FUNCTION__);
>>
>>      printk("File Creation Testing in Kernel Module!\n");
>>
>>
>>
>>      set_fs(get_ds());
>>
>>
>>
>>      /* allocate the memory for structre */
>>
>>      ptest = (PWRITE_TEST)kmalloc(sizeof(WRITE_TEST),GFP_KERNEL);
>>
>>      if(ptest == NULL)
>>
>>      {
>>
>>            printk("Structure Memory Allocation Fails!\n");
>>
>>            return -ENOMEM;
>>
>>      }
>>
>>
>>
>>      ptest->fd = sys_open("srcdebug.txt", O_CREAT | O_WRONLY, 644);
>>
>>      if (ptest->fd == 0)
>>
>>      {
>>
>>            SysPrint("File Creation Error!!!\n");
>>
>>            return 1;
>>
>>      }
>>
>>
>>
>>      SysPrint("File Creation Testing in Kernel Module!\n");
>>
>>      SysPrint("Srinivas Testing the File Creation\n");
>>
>>      sys_close(ptest->fd);
>>
>>
>>
>>      return 0;
>>
>> }
>>
>>
>>
>> void cleanup_module(void)
>>
>> {
>>
>>      printk("Good bye!\n");
>>
>>
>>
>>      /* free the allocated memory */
>>
>>      kfree(ptest);
>>
>> }
>>
>>
>>
>> Regards,
>>
>> Mukund jampala
>>
>>
>>
>>
>> -
>> To unsubscribe from this list: send the line "unsubscribe
linux-kernel"
>in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> Please read the FAQ at  http://www.tux.org/lkml/
>>
>
>Cheers,
>Dick Johnson
>Penguin : Linux version 2.6.12 on an i686 machine (5537.79 BogoMips).
>  Notice : All mail here is now cached for review by Dictator Bush.
>                  98.36% of all statistics are fiction.
