Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267432AbUG2J4x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267432AbUG2J4x (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 05:56:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267431AbUG2J4x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 05:56:53 -0400
Received: from [217.67.22.1] ([217.67.22.1]:51686 "EHLO mail.6com.net")
	by vger.kernel.org with ESMTP id S267425AbUG2J4t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 05:56:49 -0400
Date: Thu, 29 Jul 2004 11:56:48 +0200
From: Jan Oravec <jan.oravec@6com.sk>
To: linux-kernel@vger.kernel.org
Subject: LSI 53c1030 (Fusion MPT) performance with O_SYNC
Message-ID: <20040729095648.GA27925@omega.6com.net>
Reply-To: Jan Oravec <jan.oravec@6com.sk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Operating-System: UNIX
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,


I have got a new dual-Opteron server based on Tyan S2880 motherboard with
LSI53C1030 U320 controller onboard - there are 15kRPM Fujitsu disks.

I've noticed poor performance with MySQL/InnoDB when compared to another
S2880-based box with IDE disks.

I've tracked it to this:

Let's have this code (notice the O_SYNC) and enough large test file.

#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <unistd.h>

int main(int argc, void **argv)
{
  char buffer[64];
  int fd, i;

  fd=open(argv[1], O_WRONLY|O_SYNC);
  
  lseek(fd, 0, SEEK_SET);
  for(i=0; i<10000; i++)
    write(fd, buffer, 64);
  
  return 0;
}


The results are:

LSI53C1030:
$ time ./a.out testfile 

real    0m4.218s
user    0m0.002s
sys     0m0.219s


IDE:
$ time ./a.out testfile 

real    0m1.767s
user    0m0.002s
sys     0m0.356s


Changing size of written amount of data to 4096 the time ratio between
LSI53C1030 and IDE is around 1:1.


Both boxes are running vanilla 2.6.7 kernel.


Any help appreciated,


Jan


PS: please CC, I am not on the list.
