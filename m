Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268816AbUHLVm3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268816AbUHLVm3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Aug 2004 17:42:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268824AbUHLVl5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Aug 2004 17:41:57 -0400
Received: from kerberos2.troja.mff.cuni.cz ([195.113.28.3]:6000 "HELO
	kerberos2.troja.mff.cuni.cz") by vger.kernel.org with SMTP
	id S268575AbUHLViT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Aug 2004 17:38:19 -0400
Received: from argo.troja.mff.cuni.cz (195.113.28.11)
  by vger.kernel.org with SMTP; 12 Aug 2004 21:38:17 -0000
Date: Thu, 12 Aug 2004 23:38:13 +0200 (MET DST)
From: Pavel Kankovsky <peak@argo.troja.mff.cuni.cz>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux kernel file offset pointer races
In-Reply-To: <1091796995.16306.20.camel@localhost.localdomain>
Message-ID: <20040812223057.CF9.0@argo.troja.mff.cuni.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 Aug 2004, Alan Cox wrote:

> On Mer, 2004-08-04 at 21:36, Pavel Kankovsky wrote:
> > IMHO, the proper fix is to serialize all operations modifying a shared
> > file pointer (file->f_pos): read(), readv(), write(), writev(),
> > lseek()/llseek(). As far as I can tell, this is required by POSIX:
> 
> Not if you want to get any useful work done. No Unix does this.

...serialize all operations modifying a shared file pointer wrt operations
modifying the *same* pointer.

> The situation with multiple parallel lseek/read/writes is somewhat
> undefined anyway since you don't know if the seek or the write
> occurred first in user space.

buffer[0] = 0;
lseek(fd, 0, SEEK_SET);
write(fd, buffer, 1);
lseek(fd, 0, SEEK_SET);

if (fork() > 0) {
  buffer[0] = 1;
  write(fd, buffer, 1000000);
}
else {
  while (buffer[0] == 0)
    pread(fd, buffer, 1, 0);
  lseek(fd, 1234, SEEK_SET);
}

lseek(...1234...) cannot occur before write(...1000000) starts but it can
occur before the big write() ends (unless write() is atomic).

There is a similar scenario with a big read() but it is somewhat more
complicated because it needs a piece of shared memory.

> O_APPEND is a bit different, as are pread/pwrite but those are dealt
> with using locking for files.

Two write()'s are serialized by inode semaphore. But as far as can tell,
there is no serialization between read()'s and write()'s. A read()
overlapping a simultaneous write() might produce inconsistent results,
e.g.:

1. read() starts at offset 0
2. read() reads a page of data and blocks
3. write() starts at offset 0
4. write() writes two pages of data and block
5. read() wakes up, reads two pages of data
6. write() wakes up, writes a page of data
7. read() finished
8. write() finished

In this scenario, the 1st and 3rd pages read by read() contain the old
data (before write()) but the 2nd page contains the new data (after
write()). This is absurd.

BTW: What about writev() (esp. with O_APPEND)? It appears Linux
implementation makes it possible to interleave parts of writev() with
other writes.

Moreover, there appears to be a race condition between locks_verify_area()
and the actual I/O operation(s).

--Pavel Kankovsky aka Peak  [ Boycott Microsoft--http://www.vcnet.com/bms ]
"Resistance is futile. Open your source code and prepare for assimilation."

