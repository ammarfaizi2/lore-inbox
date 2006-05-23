Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750865AbWEWAkQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750865AbWEWAkQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 May 2006 20:40:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751201AbWEWAkQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 May 2006 20:40:16 -0400
Received: from cyrus.iparadigms.com ([64.140.48.8]:45055 "EHLO
	cyrus.iparadigms.com") by vger.kernel.org with ESMTP
	id S1750865AbWEWAkP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 May 2006 20:40:15 -0400
Message-ID: <447259E7.8050706@iparadigms.com>
Date: Mon, 22 May 2006 17:40:07 -0700
From: fitzboy <fitzboy@iparadigms.com>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041124)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Avi Kivity <avi@argo.co.il>
CC: linux-kernel@vger.kernel.org
Subject: Re: tuning for large files in xfs
References: <447209A8.2040704@iparadigms.com> <44720DB8.4060200@argo.co.il> <447211E1.7080207@iparadigms.com> <447212B5.1010208@argo.co.il>
In-Reply-To: <447212B5.1010208@argo.co.il>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 >
 > What's your testing methodology?
 >

here is my code... pretty simple, opens the file and reads around to a 
random block, 32k worth (note, doing a 2k read doesn't make much of a 
difference, only marginal, from 6.7ms per seek down to 6.1).

int main (int argc, char* argv[]) {
   char buffer[256*1024];
   int fd = open(argv[1],O_RDONLY);
   struct stat s;
   fstat(fd,&s);
   s.st_size=s.st_size-(s.st_size%256*1024);
   initTimers();
   srandom(startSec);
   long long currentPos;
   int currentSize=32*1024;
   int startTime=getTimeMS();
   for (int currentRead = 0;currentRead<10000;currentRead++) {
     currentPos=random();
     currentPos=currentPos*currentSize;
     currentPos=currentPos%s.st_size;
     if (pread(fd,buffer,currentSize,currentPos) != currentSize)
     std::cout<<"couldn't read in"<<std::endl;
   }
   std::cout << "blocksize of 
"<<currentSize<<"took"<<getTimeMS()-startTime<<" ms"<<std::endl;
}

 > You can try to measure the amount of seeks going to the disk by using
 > iostat, and see if that matches your test program.
 >

I used iostat and found exactly what I was expecting: 10,000 rounds x 16 
   (number of 2k blocks in a 32k read) x 4 (number of 512 blocks per 2k 
block) = 640,000 reads, which is what iostat told me. so now my question 
remains, if each seek is supposed to average 3.5ms, how come I am seeing 
an average of 6-7ms?

