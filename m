Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266155AbUHSNmu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266155AbUHSNmu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Aug 2004 09:42:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266163AbUHSNmu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Aug 2004 09:42:50 -0400
Received: from mailer.nec-labs.com ([138.15.108.3]:23723 "EHLO
	mailer.nec-labs.com") by vger.kernel.org with ESMTP id S266155AbUHSNmh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Aug 2004 09:42:37 -0400
Message-ID: <4124AE51.2060700@nec-labs.com>
Date: Thu, 19 Aug 2004 09:42:41 -0400
From: Lei Yang <leiyang@nec-labs.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040114
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Kernel Newbies Mailing List <kernelnewbies@nl.linux.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
CC: Lei Yang <leiyang@nec-labs.com>
Subject: problem with fwrite
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 19 Aug 2004 13:42:36.0738 (UTC) FILETIME=[6346CA20:01C485F2]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This is not really a kernel issue, apologize if anyone thinks that this 
is not the right place to post it. But I am writing a kernel module and 
got stuck on fwrite, really hope someone could point out what stupid 
mistake I've made. I wrote a very simple code to test the idea, what I 
really want to do in fred() is to read from 'dest' and write to 'src'. 
It seems that upon running , fgetc doesn't get anything from in_stream, 
so the first char it gets is an EOF and it breaks. Just why fwrite 
didn't write anything to in_stream?

If this is not the right way to do it, what is ?

Appreciate any comments, even harsh ones.

TIA
Lei

// in test.c

#include <stdio.h>

fred(char *dest, size_t *destlen, char *src, size_t size)
{
     FILE *in_stream = tmpfile();
     FILE *out_stream = tmpfile();
     fwrite(src, 1, size, in_stream);

     int c, i;
     for(i = 0;;i++)
     {
   	c = fgetc(in_stream);
   	fprintf(stderr, "get char %c\n", c);
	if ( c == EOF) break;
   	fputc(c, out_stream);
      }

     *destlen = i;
	
     fseek(out_stream, 0, SEEK_SET); //rewind
     fread(dest, 1, *destlen, out_stream);
     fclose(in_stream);
     fclose(out_stream);
     fprintf(stderr, "buf = `%s', size = %d\n", dest, *destlen);
}

int main(void)
{
   static char source[] = "really hope this works ";

   char *bp = malloc (2048);
   size_t destlen;

   fred(bp, &destlen, source, strlen(source));

   fprintf(stderr, "buf = `%s', size = %d\n", bp, destlen);
   return 0;
}
