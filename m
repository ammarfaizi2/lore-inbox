Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261876AbVEDPUy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261876AbVEDPUy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 May 2005 11:20:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261879AbVEDPUy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 May 2005 11:20:54 -0400
Received: from mail.3miasto.net ([153.19.176.2]:39654 "EHLO serwer.3miasto.net")
	by vger.kernel.org with ESMTP id S261876AbVEDPUo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 May 2005 11:20:44 -0400
Date: Wed, 4 May 2005 17:20:36 +0200 (CEST)
From: Leszek Koltunski <leszek@serwer.3miasto.net>
To: linux-kernel@vger.kernel.org
Subject: Cannot read from /dev/kmem
Message-ID: <Pine.NEB.4.60.0505041712240.12334@serwer.3miasto.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Kernel 2.6.11 , I cannot seem to be able to read from /dev/kmem... The 
following little proggie

#include <stdio.h>
#include <fcntl.h>
#include <errno.h>

struct {
         unsigned short limit;
         unsigned int base;
} __attribute__ ((packed)) idtr;

struct {
         unsigned short off1;
         unsigned short sel;
         unsigned char none,flags;
         unsigned short off2;
} __attribute__ ((packed)) idt;

int main()
{
         int result, kmem = open ("/dev/kmem",O_RDONLY);

         asm ("sidt %0" : "=m" (idtr));
         printf("idtr base at 0x%X\n",(int)idtr.base);

         if (kmem<0) return 1;

         if (lseek(kmem,  idtr.base + 8*0x80,SEEK_SET) != idtr.base + 
8*0x80 )
         {
                 perror("kmem lseek"); exit(1);
         }

         result = read(kmem, &idt , sizeof(idt) );

         if( result != sizeof(idt) )
         {
                 printf("result: %d, sizeof(idt)= %d errno=%d\n", result, 
sizeof(idt), errno);
         }

         close(kmem);

         return 0;
}



returns

utumno:/home/leszek/progs/module/hijack# ./test
idtr base at 0xC0423000
result: -1, sizeof(idt)= 8 errno=22


??? EINVAL

I remember this working on a 2.4.x kernel....

Leszek Koltunski
