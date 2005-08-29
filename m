Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751143AbVH2MQ2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751143AbVH2MQ2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Aug 2005 08:16:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751183AbVH2MQ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Aug 2005 08:16:28 -0400
Received: from mf2.realtek.com.tw ([220.128.56.22]:45572 "EHLO
	mf2.realtek.com.tw") by vger.kernel.org with ESMTP id S1751143AbVH2MQ1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Aug 2005 08:16:27 -0400
Message-ID: <002501c5ac93$6ef754c0$106215ac@realtek.com.tw>
From: "colin" <colin@realtek.com.tw>
To: <linux-kernel@vger.kernel.org>
Subject: A problem about DIRECT IO on ext3
Date: Mon, 29 Aug 2005 20:15:43 +0800
MIME-Version: 1.0
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1506
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1506
X-MIMETrack: Itemize by SMTP Server on msx/Realtek(Release 6.5.3|September 14, 2004) at
 2005/08/29 =?Bog5?B?pFWkyCAwODoxNjowNw==?=,
	Serialize by Router on msx/Realtek(Release 6.5.3|September 14, 2004) at
 2005/08/29 =?Bog5?B?pFWkyCAwODoxNjowOQ==?=,
	Serialize complete at 2005/08/29 =?Bog5?B?pFWkyCAwODoxNjowOQ==?=
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset="big5"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi all,
I wrote a simple program to test direct io, and found that there are some
strange behaviors of it on "ext3".
My simple program is below. Assume that the executable file name is
"directio". If I do the following:
    1. cp directio aaa
    2. ./directio directio aaa

The size of aaa is about the same with directio. This is wrong.
It should be 3 times the size of directio because there are 2 write
operations and one lseek to the file end.

If the second file is not opened with "O_DIRECT", the result is correct.

What's the problem of direct io? I found that if I remove the instruction of
lseek, the result is correct.
Is there any problem of lseek when doing direct io on ext3?
My platform is 2.6.11.

Regards,
Colin








#define _GNU_SOURCE

#include <stdio.h>
#include <fcntl.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <stdlib.h>


int main(int argc, char **argv) {

int fd1, fd2, count;
char *ptr1, *ptr2;

if(argc == 3) {
  fd1 = open(argv[1], O_RDONLY | O_DIRECT, S_IRWXU);
  fd2 = open(argv[2], O_RDWR | O_CREAT | O_DIRECT);
} else {
  printf("Error syntax\n");
  exit(1);
}
printf("%d\n", lseek(fd2, 0, SEEK_END));

ptr1 = malloc(4096 + 4096-1);
ptr2 = (void*)((int)ptr1 - (int)ptr1 % 4096 + 4096);

do {
  count = read(fd1, ptr2, 4096);
  if(!count)
    break;
  write(fd2, ptr2, 4096);
  write(fd2, ptr2, 4096);
} while(count > 0);

free(ptr1);
close(fd1);
close(fd2);
}





