Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129602AbQKQRrd>; Fri, 17 Nov 2000 12:47:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129451AbQKQRr1>; Fri, 17 Nov 2000 12:47:27 -0500
Received: from hera.cwi.nl ([192.16.191.1]:26803 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S129660AbQKQRrD>;
	Fri, 17 Nov 2000 12:47:03 -0500
Date: Fri, 17 Nov 2000 18:16:59 +0100
From: Andries Brouwer <aeb@veritas.com>
To: Alexander Viro <viro@math.psu.edu>
Cc: Mikael Pettersson <mikpe@csd.uu.se>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.0-test10 truncate() change broke `dd'
Message-ID: <20001117181659.C29847@veritas.com>
In-Reply-To: <200011160058.BAA20802@harpo.it.uu.se> <Pine.GSO.4.21.0011160251450.11017-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <Pine.GSO.4.21.0011160251450.11017-100000@weyl.math.psu.edu>; from viro@math.psu.edu on Thu, Nov 16, 2000 at 03:02:31AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 16, 2000 at 03:02:31AM -0500, Alexander Viro wrote:
: On Thu, 16 Nov 2000, Mikael Pettersson wrote:
: 
:: dd implements the seek=NNN option by calling ftruncate() before
:: starting the write. This is where 2.4.0-test10 breaks, since
:: ftruncate on a block device now provokes an EACCES error.
:: Does anyone know the reason for the S_ISDIR -> !S_ISREG change in test10?
: 
: For one thing, you really don't want it working on pipes. For another -
: it's just damn meaningless on devices, symlinks and sockets. Which leaves
: regular files.
: 
: OTOH, -EACCES looks wrong - for directories we must return -EISDIR and for
: sockets ftruncate() should return -EINVAL. Adopting -EINVAL for devices
: and pipes may be a good idea... Andries, could you comment on that?

Well, open() must return EISDIR upon an attempt to open a
directory for writing. Similarly, truncate() must return EISDIR
for a directory. On the other hand, ftruncate() returns EINVAL
for a fd not open for writing (and not EISDIR).

The behaviour on files other than regular files and shared memory
is mostly undefined.

The Austin draft says (among other things)

=====================================================================
If fd is not a valid file descriptor open for writing, the
ftruncate( ) function shall fail.  If fd refers to a regular file,
the ftruncate( ) function shall cause the size of the file to be
truncated to length. If the size of the file previously exceeded
length, the extra data shall no longer be available to reads on the
file. If the file previously was smaller than this size, ftruncate( )
shall either increase the size of the file or fail.  [XSI-conformant
systems shall increase the size of the file.]  If the file size is
increased, the extended area shall appear as if it were zero-filled.
The value of the seek pointer shall not be modified by a call
to ftruncate( ).  Upon successful completion, if fd refers to a
regular file, the ftruncate( ) function shall mark for update the
st_ctime and st_mtime fields of the file and the S_ISUID and S_ISGID
bits of the file mode may be cleared. If the ftruncate( ) function is
unsuccessful, the file is unaffected.

If fd refers to a directory, ftruncate( ) shall fail.
If fd refers to any other file type, except a shared memory object,
the result is unspecified.

... [shm description omitted] ...

The ftruncate( ) function shall fail if:
EINTR	A signal was caught during execution.
EINVAL	The length argument was less than 0.
EFBIG or EINVAL	The length argument was greater than the maximum file size.
EFBIG	The file is a regular file and length is greater than
	the offset maximum established in the open file description
	associated with fd.
EIO	An I/O error occurred while reading from or writing to a file system.
EBADF or EINVAL The fd argument is not a file descriptor open for writing.
EINVAL	The fd argument references a file that was opened without write
	permission.
EROFS	The named file resides on a read-only file system.
=====================================================================

In other words, it is unspecified what happens on special files.
Of course other error returns are permitted (in non-listed situations).

Digital Unix Man says:
---------------------------------------------------------------------
The truncate() and ftruncate() functions have no effect on FIFO special
files or directories.

EAGAIN	The write operation failed due to an enforced write
	lock on the file.
EINVAL	The file is not a regular file.
---------------------------------------------------------------------


SunOS Man says:
---------------------------------------------------------------------
EINVAL fd is not a valid descriptor of a file open for writing
       or fd refers to a socket, not to a file.
---------------------------------------------------------------------


AIX Man says:
---------------------------------------------------------------------
EINVAL	The file is not a regular file.
---------------------------------------------------------------------


Etc. So - there seems little doubt that if we return an error
for non-regular files, the error should be -EINVAL.

Andries
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
