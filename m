Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932097AbWEWIF6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932097AbWEWIF6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 May 2006 04:05:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751316AbWEWIF5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 May 2006 04:05:57 -0400
Received: from gateway.argo.co.il ([194.90.79.130]:55562 "EHLO
	argo2k.argo.co.il") by vger.kernel.org with ESMTP id S1751304AbWEWIF5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 May 2006 04:05:57 -0400
Message-ID: <4472C25C.2090909@argo.co.il>
Date: Tue, 23 May 2006 11:05:48 +0300
From: Avi Kivity <avi@argo.co.il>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: fitzboy <fitzboy@iparadigms.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: tuning for large files in xfs
References: <447209A8.2040704@iparadigms.com> <44720DB8.4060200@argo.co.il> <447211E1.7080207@iparadigms.com> <447212B5.1010208@argo.co.il> <447259E7.8050706@iparadigms.com>
In-Reply-To: <447259E7.8050706@iparadigms.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 23 May 2006 08:05:51.0244 (UTC) FILETIME=[B51094C0:01C67E3F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

fitzboy wrote:
> >
> > What's your testing methodology?
> >
>
> here is my code... pretty simple, opens the file and reads around to a 
> random block, 32k worth (note, doing a 2k read doesn't make much of a 
> difference, only marginal, from 6.7ms per seek down to 6.1).
>
> int main (int argc, char* argv[]) {
>   char buffer[256*1024];
>   int fd = open(argv[1],O_RDONLY);
>   struct stat s;
>   fstat(fd,&s);
>   s.st_size=s.st_size-(s.st_size%256*1024);
>   initTimers();
>   srandom(startSec);
>   long long currentPos;
>   int currentSize=32*1024;
>   int startTime=getTimeMS();
>   for (int currentRead = 0;currentRead<10000;currentRead++) {
>     currentPos=random();
>     currentPos=currentPos*currentSize;
This will overflow. I think that

      currentPos = drand48() * s.st_size;

will give better results

>     currentPos=currentPos%s.st_size;

I'd suggest aligning currentPos to currentSize. Very likely your 
database does the same. Won't matter much on a single-threaded test though.

>     if (pread(fd,buffer,currentSize,currentPos) != currentSize)
>     std::cout<<"couldn't read in"<<std::endl;
>   }
>   std::cout << "blocksize of 
> "<<currentSize<<"took"<<getTimeMS()-startTime<<" ms"<<std::endl;
> }
>
> > You can try to measure the amount of seeks going to the disk by using
> > iostat, and see if that matches your test program.
> >
>
> I used iostat and found exactly what I was expecting: 10,000 rounds x 
> 16   (number of 2k blocks in a 32k read) x 4 (number of 512 blocks per 
> 2k block) = 640,000 reads, which is what iostat told me. so now my 
> question remains, if each seek is supposed to average 3.5ms, how come 
> I am seeing an average of 6-7ms?
>

Sorry, I wasn't specific enough: please run iostat -x /dev/whatever 1 
and look at the 'r/s' (reads per second) field. If that agrees with what 
your test says, you have a block layer or lower problem, otherwise it's 
a filesystem problem.

-- 
error compiling committee.c: too many arguments to function

