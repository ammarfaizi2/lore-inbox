Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267413AbUHDUgK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267413AbUHDUgK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Aug 2004 16:36:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267411AbUHDUgK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Aug 2004 16:36:10 -0400
Received: from kerberos2.troja.mff.cuni.cz ([195.113.28.3]:25192 "HELO
	kerberos2.troja.mff.cuni.cz") by vger.kernel.org with SMTP
	id S267413AbUHDUgE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Aug 2004 16:36:04 -0400
Received: from argo.troja.mff.cuni.cz (195.113.28.11)
  by vger.kernel.org with SMTP; 4 Aug 2004 20:36:02 -0000
Date: Wed, 4 Aug 2004 22:36:02 +0200 (MET DST)
From: Pavel Kankovsky <peak@argo.troja.mff.cuni.cz>
To: linux-kernel@vger.kernel.org
Subject: Re: Linux kernel file offset pointer races
In-Reply-To: <Pine.LNX.4.44.0408041220550.26961-100000@isec.pl>
Message-ID: <20040804214056.6369.0@argo.troja.mff.cuni.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Aug 2004, Paul Starzetz wrote:

> static ssize_t mtrr_read(struct file *file, char *buf, size_t len,
>                          loff_t *ppos)
> {
> [1] if (*ppos >= ascii_buf_bytes) return 0;
> [2] if (*ppos + len > ascii_buf_bytes) len = ascii_buf_bytes - *ppos;
>     if ( copy_to_user (buf, ascii_buffer + *ppos, len) ) return -EFAULT;
> [3] *ppos += len;
>     return len;
> }  /*  End Function mtrr_read  */
>
> It is quite easy to see that since copy_to_user can  sleep,  the  second
> reference  to  *ppos  may  use  another  value.  Or in other words, code
> operating on the file->f_pos variable through a pointer must  be  atomic
> in  respect  to  the current thread. We expect even more troubles in the
> SMP case though.

Oh no! Another old bug getting bored of being ignored and promoting itself
into a security vulnerability (see Bugtraq/Full-Disclosure archive for a 
complete story).

IMHO, the proper fix is to serialize all operations modifying a shared
file pointer (file->f_pos): read(), readv(), write(), writev(),
lseek()/llseek(). As far as I can tell, this is required by POSIX:

  [read() specification]
  On files that support seeking (for example, a regular file), the
  read() shall start at a position in the file given by the file offset
  associated with fildes. The file offset shall be incremented by the
  number of bytes actually read.

  [write() specification]
  On a regular file or other file capable of seeking, the actual writing
  of data shall proceed from the position in the file indicated by the
  file offset associated with fildes. Before successful return from
  write(), the file offset shall be incremented by the number of bytes
  actually written.

  [write() specification]
  If the O_APPEND flag of the file status flags is set, the file offset
  shall be set to the end of the file prior to each write and no
  intervening file modification operation shall occur between changing the
  file offset and the write operation.

Moreover, there should probably be some kind of serialization between
groups of reads from a file (read: inode) and individual writes to the
same file even among different struct file:

  [read() rationale]
  I/O is intended to be atomic to ordinary files and pipes and
  FIFOs. Atomic means that all the bytes from a single operation that
  started out together end up together, without interleaving from other
  I/O operations.

  [write() rationale]
  Writes can be serialized with respect to other reads and writes. If a
  read() of file data can be proven (by any means) to occur after a
  write() of the data, it must reflect that write(), even if the calls are
  made by different processes. A similar requirement applies to multiple
  write operations to the same file position.

--Pavel Kankovsky aka Peak  [ Boycott Microsoft--http://www.vcnet.com/bms ]
"Resistance is futile. Open your source code and prepare for assimilation."



