Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262920AbUCRUST (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 15:18:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262924AbUCRUSR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 15:18:17 -0500
Received: from mailgate2.mysql.com ([213.136.52.47]:33944 "EHLO
	mailgate.mysql.com") by vger.kernel.org with ESMTP id S262920AbUCRUSA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 15:18:00 -0500
Subject: Re: True  fsync() in Linux (on IDE)
From: Peter Zaitsev <peter@mysql.com>
To: Chris Mason <mason@suse.com>
Cc: Jens Axboe <axboe@suse.de>, Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1079640699.11062.1.camel@watt.suse.com>
References: <1079572101.2748.711.camel@abyss.local>
	 <20040318064757.GA1072@suse.de> <1079639060.3102.282.camel@abyss.local>
	 <20040318194745.GA2314@suse.de>  <1079640699.11062.1.camel@watt.suse.com>
Content-Type: text/plain
Organization: MySQL
Message-Id: <1079641026.2447.327.camel@abyss.local>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 18 Mar 2004 12:17:08 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-03-18 at 12:11, Chris Mason wrote:

> > I believe some missed set_page_writeback() calls caused fsync() to never
> > really wait on anything, pretty broken... IIRC, it's fixed in latest
> > -mm, or maybe it's just pending for next release.
> 
> This should have only been broken in -mm.  Which kernels exactly are you
> comparing?  Maybe the 3ware array defaults to different writecache
> settings under 2.6?

I'm trying RH AS 3.0  kernel, however I have the same behavior on my 
SuSE 8.2 workstation. 

I use 2.6.3 kernel for tests now (It is not the latest I know) 
EXT3 file system.

3WARE has writeback cache setting in both cases. 


Here is the test program I was using: 


#include <stdio.h>
#include <fcntl.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <errno.h>


char buffer[4096] __attribute__((__aligned__(4096)));

main()
{
  int rc2,rc;
  int i;
  buffer[0]=(char)getpid();
  rc=open("write",O_RDWR | O_CREAT,0666);
  if (rc==-1) printf("Error at open: %d\n",errno);
  for(i=0;i<1000;i++)
   {
    rc2=write(rc,&buffer,4096);
    printf(".");
    fflush(stdout);
    if (rc2<0)
      {
        printf("Error code: %d\n",errno);
        return;
      }
  fsync(rc);
   }

}





-- 
Peter Zaitsev, Senior Support Engineer
MySQL AB, www.mysql.com

Meet the MySQL Team at User Conference 2004! (April 14-16, Orlando,FL)
  http://www.mysql.com/uc2004/

