Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270227AbTHBTkm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Aug 2003 15:40:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270237AbTHBTkm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Aug 2003 15:40:42 -0400
Received: from notes.hallinto.turkuamk.fi ([195.148.215.149]:9479 "EHLO
	notes.hallinto.turkuamk.fi") by vger.kernel.org with ESMTP
	id S270227AbTHBTkk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Aug 2003 15:40:40 -0400
Message-ID: <3F2C1535.9000203@kolumbus.fi>
Date: Sat, 02 Aug 2003 22:47:01 +0300
From: =?ISO-8859-15?Q?Mika_Penttil=E4?= <mika.penttila@kolumbus.fi>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.2) Gecko/20030208 Netscape/7.02
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: switch_to() x86 changes
X-MIMETrack: Itemize by SMTP Server on marconi.hallinto.turkuamk.fi/TAMK(Release 5.0.8 |June
 18, 2001) at 02.08.2003 22:42:07,
	Serialize by Router on notes.hallinto.turkuamk.fi/TAMK(Release 5.0.10 |March
 22, 2002) at 02.08.2003 22:41:30,
	Serialize complete at 02.08.2003 22:41:30
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Some six months ago the x86 version of switch_to macro changed not to 
explicitly push and pop esi and edi. Below is pasted the current 
version, it does save esi and edi through inline assembly magic but 
never restores them....?

Also, not saving ebx has been dicussed before, afair, but couldn't 
remember/find the exact reason (other than by luck ebx isn't used by 
schedule() in such a way that would need it). Anyone put some light on this?


#define switch_to(prev,next,last) do {                    \
    unsigned long esi,edi;                        \
    asm volatile("pushfl\n\t"                    \
             "pushl %%ebp\n\t"                    \
             "movl %%esp,%0\n\t"    /* save ESP */        \
             "movl %5,%%esp\n\t"    /* restore ESP */    \
             "movl $1f,%1\n\t"        /* save EIP */        \
             "pushl %6\n\t"        /* restore EIP */    \
             "jmp __switch_to\n"                \
             "1:\t"                        \
             "popl %%ebp\n\t"                    \
             "popfl"                        \
             :"=m" (prev->thread.esp),"=m" (prev->thread.eip),    \
              "=a" (last),"=S" (esi),"=D" (edi)            \
             :"m" (next->thread.esp),"m" (next->thread.eip),    \
              "2" (prev), "d" (next));                \
} while (0)


--Mika


