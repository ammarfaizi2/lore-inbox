Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130383AbQKRA3f>; Fri, 17 Nov 2000 19:29:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130579AbQKRA30>; Fri, 17 Nov 2000 19:29:26 -0500
Received: from smtp-fwd.valinux.com ([198.186.202.196]:63758 "EHLO
	mail.valinux.com") by vger.kernel.org with ESMTP id <S130383AbQKRA3O>;
	Fri, 17 Nov 2000 19:29:14 -0500
Date: Fri, 17 Nov 2000 15:59:13 -0800
From: "H . J . Lu" <hjl@valinux.com>
To: linux kernel <linux-kernel@vger.kernel.org>
Subject: lseek/llseek allows the negative offset
Message-ID: <20001117155913.A26622@valinux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# gcc x.c
# ./a.out
lseek on -100000: -100000
write: File too large

Should kernel allow negative offsets for lseek/llseek?


-- 
H.J. Lu (hjl@valinux.com)
---
#include <fcntl.h>
#include <unistd.h>
#include <stdio.h>

extern loff_t llseek (int fd, loff_t offset, int whence);

int
main ()
{
  int fd = open ("/tmp/foo.out", O_CREAT | O_RDWR, 0600);
  off_t res, pos;
  loff_t lres, lpos;
  char buffer [] = "negative offset";

  if (fd < 0)
    {
      perror ("open");
      return 1;
    }

  pos = -100000;
  res = lseek (fd, pos, SEEK_SET);
  if (res == (off_t) -1L)
    {
      perror ("lseek");
      close (fd);
      return 1;
    }
  printf ("lseek on %ld: %ld\n", pos, res);

  if (write (fd, buffer, sizeof (buffer)) != sizeof (buffer))
    {
      perror ("write");
      close (fd);
      return 1;
    }

  lpos = -100000LL;
  lres = llseek (fd, lpos, SEEK_SET);
  if (lres == (loff_t) -1L)
    {
      perror ("llseek");
      close (fd);
      return 1;
    }

  
  printf ("llseek on %lld: %lld\n", lpos, lres);

  if (write (fd, buffer, sizeof (buffer)) != sizeof (buffer))
    {
      perror ("write");
      close (fd);
      return 1;
    }

  close (fd);

  return 0;
}
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
