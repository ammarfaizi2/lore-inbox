Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261240AbUK0FzW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261240AbUK0FzW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Nov 2004 00:55:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261930AbUK0Fwz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Nov 2004 00:52:55 -0500
Received: from web13523.mail.yahoo.com ([216.136.174.161]:2434 "HELO
	web13523.mail.yahoo.com") by vger.kernel.org with SMTP
	id S262147AbUK0Fs4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Nov 2004 00:48:56 -0500
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  b=MTA2rOKR5/15G0YdoxwtL7fZGDY3Ey0O6QDXUyapCZh2f0IQpeHGK/rY/rE0W0+yi3KLXlgiVKJHlmswAv5+bNdW7HguS7bt4LPPP643YKehP/4txx8X4Todv9EQPWqCjIvzf9y3rL01EtisZh9J95AaFUeZA7KMomQ15Vg7wak=  ;
Message-ID: <20041127054852.47669.qmail@web13523.mail.yahoo.com>
Date: Fri, 26 Nov 2004 21:48:52 -0800 (PST)
From: Richard Patterson <vectro@yahoo.com>
Subject: Seekable pipes
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I want to implement an interface for seekable pipes
(and FIFOs) in the Linux kernel.  The basic idea of
this is that when the reader issues a seek(), this
information can be passed onto the writer, who will
continue writing from the new location. Since the
reader doesn't have to do anything special, this
allows user-space programs to simulate real files,
providing features such as network filesystems and
database large-objects, all in user space.

However, I have a few questions. On looking through
fs/pipe.c, I see inode fields READERS and WRITERS.
Similarly, I see open functions independent of
do_pipe() -- such as pipe_read_open(). Does that mean
it is possible to have multiple writers and readers on
a single pipe, or is this just to implement of dup
and dup2? Obviously my idea is much more complex in
the event of multiple actors on a single pipe.

My other question relates to pipefs -- is this just a
dummy filesystem to give a home to pipe inodes, or
something more? Can you open existing pipes using
pipefs?

Finally, let me propose how I would modify the syscall
interface to implement this behavior:
1) New IOCTL SEEKPIPE_START, when called on the
writing
   fd, makes the entire pipe seekable. This must be 
   called before any data has been written to the
   pipe. At this time the writer also provides an 
   initial file size, to be used in case of fstat() 
   or SEEK_END. Note, however, that this length is not

   actually enforced, if the writer cares to provide 
   data past it.
2) When reader calls lseek() on a seekable pipe, any
   buffer data is discarded. Write()s to the pipe fail
   with EINVAL until --
3) The writer calls lseek twice in response. The first
   call is of the form lseek(fd, SEEK_CUR, 0), and 
   returns the new index requested by the reader. The 
   second is of the form lseek(fd, SEEK_SET, x) and 
   should confirm this number. If the requested 
   location is beyond the writer's idea of 
   end-of-file, the writer may so indicate by calling 
   lseek(fd, SEEK_END, 0) followed by write(fd, buf,
0).

There are a few other miscellaneous interface issues
to
address. If the writer uses select() or poll(), the
seek-pending condition is considered an uncleared
error. The writer may update it's idea of the file
size
with the same SEEKPIPE_START system call, and the
reader may access this value with fstat -- we just
store it in the inode. If anyone can think of other
points, feel free.
 
An strace-style example may make this paradigm
clearer. R and W indicate Reader and Writer,
respectively.

  pipe([5, 6])                       = 0
R close(6)                           = 0
R read(5, buf, 32768)                = (unfinished...)
W close(5)                           = 0
W ioctl(6, SEEKPIPE_START, 20480)    = 0
W write(6, bigbuf, 4096)             = 4096
R (read resumed)                     = 4096
W write(6, bigbuf+4096, 4096)        = 4096
W write(6, bigbuf+8192, 4096)        = (unfinished...)
-- The ioctl aside, so far this is just another pipe.
-- Then the reader seeks...
R lseek(5, SEEK_SET, 10000)          = 10000
W (write resumed)                    = -1 (EINVAL)
-- which wakes the writer...
R read(5, buf, 32768)                = (unfinished...)
W lseek(6, SEEK_CUR, 0)              = 10000
W write(6, bigbuf+10000, 4096)       = -1 (EINVAL)
W lseek(6, SEEK_SET, 10000)          = 10000
W write(6, bigbuf+10000, 4096)       = 4096
-- If the writer tries to write before confirming the
-- seek, it gets back EINVAL. Once the writer seeks to
-- match the reader, we go back into standard pipe 
-- mode.
R (read resumed)                     = 4096
W write(6, bigbuf+14096, 4096)       = 4096
W write(6, bigbuf+18192, 4096)       = (unfinished...)
-- Next, the reader tries to seek past the end of the
-- file. Note that, just as with a regular file, the
-- seek is allowed.
R lseek(5, SEEK_SET, 50000)          = 50000
R read(5, buf, 32768)                = (unfinished...)
W (write resumed)                    = -1 (EINVAL)
W lseek(6, SEEK_CUR, 0)              = 50000
W lseek(6, SEEK_END, 0)              = 50000
W write(6, buf, 0)                   = (unfinished...)
-- The combination of the second lseek and the write 
-- tell the kernel the reader has seeked too far. So
-- we wake the reader up with 0 bytes.
R (read resumed)                     = 0

Any comments or suggestions on this idea or its 
implementation are strongly requested.

Thanks in advance,

--Ian Turner



		
__________________________________ 
Do you Yahoo!? 
The all-new My Yahoo! - Get yours free! 
http://my.yahoo.com 
 

