Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135471AbRDZXaz>; Thu, 26 Apr 2001 19:30:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135484AbRDZXap>; Thu, 26 Apr 2001 19:30:45 -0400
Received: from p3EE3C808.dip.t-dialin.net ([62.227.200.8]:56077 "HELO
	emma1.emma.line.org") by vger.kernel.org with SMTP
	id <S135471AbRDZXab>; Thu, 26 Apr 2001 19:30:31 -0400
Date: Fri, 27 Apr 2001 01:30:28 +0200
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: 2.2.19 NFSv3 client breaks fdopen(3)
Message-ID: <20010427013028.A30741@emma1.emma.line.org>
Mail-Followup-To: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <20010426192632.A18492@maggie.dt.e-technik.uni-dortmund.de> <15080.24119.524229.296133@charged.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <15080.24119.524229.296133@charged.uio.no>; from trond.myklebust@fys.uio.no on Thu, Apr 26, 2001 at 19:43:19 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Apr 2001, Trond Myklebust wrote:

> Please note that if glibc is checking this return value, it will still
> screw up if file->f_pos > 0x7fffffff, which can and does happen
> against certain servers (particularly IRIX).

Do servers have directories that are this large? It'd take quite some
files to get a directory itself (not counting its files) exceed 2 GB,
wouldn't it?

> As I've said before: it is a bug for glibc to be relying on seekdir if
> we want to support non-POSIX compliant filesystems under Linux.

There's no seekdir. No telldir. Just a "get ofile current position".

Meanwhile, I took a glance at fileops.c and iofdopen.c of the glibc
source RPM that SuSE 7.0 uses, there is no seekdir like stuff involved,
it's just that when glibc rolls the dice to get a FILE structure filled,
it gathers the current file position, since someone might have called
read before fdopen. I think that's legitimate.

Here's the excerpt, glibc-2.1/libio/fileops.c, ll. 255 ff.:

_IO_FILE *
_IO_new_file_attach (fp, fd)
     _IO_FILE *fp;
     int fd;
{
  if (_IO_file_is_open (fp))
    return NULL;
  fp->_fileno = fd;
  fp->_flags &= ~(_IO_NO_READS+_IO_NO_WRITES);
  fp->_flags |= _IO_DELETE_DONT_CLOSE;
  /* Get the current position of the file. */
  /* We have to do that since that may be junk. */
  fp->_offset = _IO_pos_BAD;
  if (_IO_SEEKOFF (fp, (_IO_off64_t)0, _IO_seek_cur, _IOS_INPUT|_IOS_OUTPUT)
      == _IO_pos_BAD && errno != ESPIPE)
    return NULL;
  return fp;
}

No seekdir. (would be pointless since seekdir does not return a value)
Not even telldir. Just plain fdopen. Is a plain fdopen supposed to fail
just because some clients don't understand the semantics some server
uses; not even considering who's fault it might be? Certainly not.

> --- /mnt/3/linux-2.2.19/fs/nfs/dir.c	Sun Mar 25 08:37:38 2001
> +++ linux-2.2.19/fs/nfs/dir.c	Thu Apr  5 14:37:59 2001
> @@ -454,6 +454,9 @@

Thanks, will try.

-- 
Matthias Andree
