Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263468AbTJZT26 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Oct 2003 14:28:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263469AbTJZT24
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Oct 2003 14:28:56 -0500
Received: from fep04-mail.bloor.is.net.cable.rogers.com ([66.185.86.74]:1572
	"EHLO fep04-mail.bloor.is.net.cable.rogers.com") by vger.kernel.org
	with ESMTP id S263468AbTJZT2w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Oct 2003 14:28:52 -0500
Date: Sun, 26 Oct 2003 14:28:51 -0500
From: Sean Estabrooks <seanlkml@rogers.com>
To: linux-kernel@vger.kernel.org
Subject: modification time not set correctly after mmap updates
Message-Id: <20031026142851.384b9857.seanlkml@rogers.com>
Reply-To: seanlkml@rogers.com
Organization: 
X-Mailer: Sylpheed version 0.9.4-gtk2-20030802 (GTK+ 2.2.3; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH LOGIN at fep04-mail.bloor.is.net.cable.rogers.com from [24.103.218.41] using ID <seanlkml@rogers.com> at Sun, 26 Oct 2003 14:27:40 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


mtime is not being updated after changes to files via mmap, at least not
on 2.6.0-test7.   Problem shows up on both ext3 and reiserfs.

Below is an ugly little program which updates a test file without
affecting its modification time.

I tried this on 2.4.23 and got the same behavior so perhaps i'm
misinterpreting this passage from the mmap man page:

 The  st_ctime  and st_mtime field for a file mapped with PROT_WRITE
 and MAP_SHARED will be updated after a write  to  the  mapped region, 
 and before  a  subsequent msync() with the MS_SYNC or MS_ASYNC
 flag, if one occurs.

Cheers,
Sean



#include <stdio.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <sys/mman.h>
/* You'll need a file "test.txt" with a few bytes in it */
/* After running this proggy: file is changed but its mtime isn't */
#define SIZE 20
int main()
{
        int fd;
        char *mbuf;
 
        fd = open("test.txt", O_RDWR);
        mbuf = mmap(0, SIZE, PROT_READ|PROT_WRITE, MAP_SHARED, fd, 0);
        mbuf[1]='x';
        msync(mbuf, SIZE, MS_SYNC);
        munmap(mbuf, SIZE);
        fsync(fd);
        close(fd);
 
        return 0;
}
