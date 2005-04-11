Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261744AbVDKJGj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261744AbVDKJGj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Apr 2005 05:06:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261750AbVDKJGi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Apr 2005 05:06:38 -0400
Received: from s1.mailresponder.info ([193.24.237.10]:2569 "EHLO
	s1.mailresponder.info") by vger.kernel.org with ESMTP
	id S261744AbVDKJGK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Apr 2005 05:06:10 -0400
Subject: smbfs: lseek returns EINVAL when using large files.
From: Mathieu Fluhr <mfluhr@nero.com>
To: Linux Kernel ML <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: Ahead Software AG.
Date: Mon, 11 Apr 2005 11:07:43 +0200
Message-Id: <1113210463.1744.11.camel@c-l-175>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

It seems that the smbfs driver does not handle correctly large files
(>2GB). The thing is that statting them is correct (for example, the
st_size field is correctly set), but as soon as you try to make a lseek
with an offset larget than INT_MAX, you get a EINVAL error.

Note: This is not coming out of the remote samba server (Tested with
under windows, and it is working fine).

I'm using a 2.6.10 kernel without external patches. I parsed the 2.6.11
changelog to see if this problem has been fixed, but I didn't found
anything related. If this has already been discussed, just let me
know ;-)

You can reproduce this bug with this little program:

-8<------------------------------------------

/* Enable large file support for x86 */
#define _FILE_OFFSET_BITS 64

#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <unistd.h>
#include <limits.h>
#include <stdio.h>

int main(int argc, char **argv)
{
  int fd = open(argv[1], O_RDONLY);
  if(fd == -1)
    perror("open");

  struct stat st;
  fstat(fd, &st);

  printf("filesize: %llu\n", st.st_size);

  /* Go at end... */
  if(lseek(fd, 0, SEEK_END) == (off_t)(-1))
    perror("lseek");

  close(fd);
  return 0;
}

-8<------------------------------------------

Best Regards,
Mathieu Fluhr


