Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262277AbSJJKX2>; Thu, 10 Oct 2002 06:23:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263331AbSJJKX2>; Thu, 10 Oct 2002 06:23:28 -0400
Received: from wiprom2mx1.wipro.com ([203.197.164.41]:7390 "EHLO
	wiprom2mx1.wipro.com") by vger.kernel.org with ESMTP
	id <S262277AbSJJKX1>; Thu, 10 Oct 2002 06:23:27 -0400
From: "Saji Kumar VR" <saji.kumar@wipro.com>
To: "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Cc: "Saji Kumar VR" <saji.kumar@wipro.com>
Subject: re: Problem with sethostname() ??
Date: Thu, 10 Oct 2002 16:00:20 +0530
Message-ID: <PCENKBHIJBDCDPIIAICPMEJBCBAA.saji.kumar@wipro.com>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPartTM-000-514cf334-e0a4-4908-8e2f-6f4a75976d68"
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is a multi-part message in MIME format.

------=_NextPartTM-000-514cf334-e0a4-4908-8e2f-6f4a75976d68
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit


-----Original Message-----
From: saji kumar [mailto:saji.kumar@wipro.com]
Sent: Thursday, October 10, 2002 3:39 PM
To: suresh.babu@wipro.com; linux-kernel@vger.kernel.org
Cc: Kiran Vijayakumar
Subject: RE: Problem with sethostname() ??


Hi,

 If U see the code for __generic_copy_from_user() in
arch/i386/lib/usercopy.c ( from my understanding copy_from_user() boils down
to this function),

 unsigned long
__generic_copy_from_user(void *to, const void *from, unsigned long n)
{
        prefetchw(to);
        if (access_ok(VERIFY_READ, from, n))
                __copy_user_zeroing(to,from,n);
        else
                memset(to, 0, n);
        return n;
}

here, if access_ok() fails, which is the case here (when an invalid from
address is given), it memsets() the "to" address to zero,
which is the reason for the hostname being reset to NULL (please correct me
if I am wrong somewhere)

I ran this program on 2.5 kernel with the memset() removed, & it gave no
problem..

Can anyone please explain, why do we need to reset the "to" address ?

Rgds,
Saji
-----Original Message-----
From: Suresh babu V. [mailto:suresh.babu@wipro.com]
Sent: Thursday, October 10, 2002 10:48 AM
To: linux-kernel@vger.kernel.org
Cc: 'Saji Kumar VR'
Subject: Problem with sethostname() ??


Hi,
        While attempting for some testing with sethostname() call, I got
this problem . As explained in the man page the sethostname call is
failing(ret val = -1 & errno = EFAULT(14)) for invalid address and valid
length. But the problem is after running the following test, hostname is
getting reset to NULL. I tested in both 2.4 & 2.5 kernels.
Any comments on this??
#include <stdio.h>
#include <unistd.h>
#include <string.h>
#include <errno.h>

main()
{
int ret, errno;
unsigned short int len;
char host[50]="tmphost"; /* hostname max size is 64 */
errno = 0;
len = sizeof(host);
/* valid length and invalid address, expected err is EFAULT */
ret = sethostname((void *)-1, len);
printf("return val : %d, err no: %d \n",ret,errno);
}
        I saw the code of sys_sethostname() function (sys.c) , in which
copy_from_user() is being called. I would like to know is it required to
validate the name argument before calling copy_from_user() to avoid such
problems.
        We can expect similar problem in setdomainname() also in which same
sort of code is used.
PS : Please CC me your replies as I havn't subscribed to the list.
Thanks,
Suresh.


------=_NextPartTM-000-514cf334-e0a4-4908-8e2f-6f4a75976d68
Content-Type: text/plain;
	name="Wipro_Disclaimer.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="Wipro_Disclaimer.txt"

**************************Disclaimer**************************************************    
 
 Information contained in this E-MAIL being proprietary to Wipro Limited is 'privileged' 
and 'confidential' and intended for use only by the individual or entity to which it is 
addressed. You are notified that any use, copying or dissemination of the information 
contained in the E-MAIL in any manner whatsoever is strictly prohibited.

****************************************************************************************

------=_NextPartTM-000-514cf334-e0a4-4908-8e2f-6f4a75976d68--
