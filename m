Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266391AbSKGGrv>; Thu, 7 Nov 2002 01:47:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266392AbSKGGrv>; Thu, 7 Nov 2002 01:47:51 -0500
Received: from 205-158-62-92.outblaze.com ([205.158.62.92]:19914 "HELO
	ws3-2.us4.outblaze.com") by vger.kernel.org with SMTP
	id <S266391AbSKGGrs>; Thu, 7 Nov 2002 01:47:48 -0500
Message-ID: <20021107065421.20283.qmail@email.com>
Content-Type: text/plain; charset="iso-8859-15"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
From: "Clayton Weaver" <cgweav@email.com>
To: linux-kernel@vger.kernel.org
Date: Thu, 07 Nov 2002 01:54:21 -0500
Subject: Re: [2.4.19] read(2) and page aligned buffers
X-Originating-Ip: 172.173.167.54
X-Originating-Server: ws3-2.us4.outblaze.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(It's not an alignment issue. Still broken read()ing whole file
into page-aligned malloc() buffers and MAP_PRIVATE|MAP_ANONYMOUS mmap()
buffers, while not broken mmap()ing the file directly.)

Ok, bizarrely enough (or not), I couldn't reproduce it with a
test program that isolates the functions that return error
in my program in a program of their own that just reads a
dir, open()s files, malloc()s space, read()s the file into the space,
free()s the buffer, and close()s the file. I even incorporated
the sha1 checksum functions from textutils that I use in the actual
program seeing the error into the test program and ran the buffers
through them, still without reproducing the error. I used one of the dirs
where I actually see the errors with malloc() + read() that I originally
reported.

But the test program isn't significantly different from the would-be
production code that sees the error. I've posted it below in case
it is informative.

(preliminaries: the file size is ok, it's an lstat() st_size that
 mmap(...MAP_SHARED...) has no issues with. The open() in the
 caller of gethash() is merely 

     fd = open(fdata->name, O_RDONLY);
     if (fd >= 0) {

followed by an fcntl() read lock, etc. Eventually it gets down to

     if (gethash(fd, fdata->size, fdata->name,
		 REC_CHKSUM(*current)) == NULL) {
       return -1;
     }

Here is gethash(), the version that sees the error from read():

/*****
 * gethash():
 *
 * args: const int fd            open file descriptor for file to checksum
 *       const off_t len         length of file
 *       const char * pathname   for error reporting
 *       void * outsum           where to put checksum
 *
 * returns:  void * (outsum) or NULL
 *
 * Notes: Takes a file and size as args, and returns the address of
 *        outsum with the checksum in the first sizeof(checksum)
 *        bytes (outsum can point to the tail of an f_rec or to some
 *        other buffer with sufficient space). sizeof(checksum)
 *        is 20 bytes for sha1 checksums.
 *
 *        Calls sha1 code lifted from gnu sha.c in gnu textutils-2.0.21.
 *****/

/* assume that the appropriate #includes are up here */

void * gethash(const int, const off_t, const char *, void *);

/* extern prototypes; see headers */

void * gethash(const int fd, const off_t len, const char * pathname,
	       void * outsum)
{
  const char * funcname = "gethash()";
  struct sha_ctx bchk_ctx;
  void * filebuf;

#ifndef NDEBUG
  if (!len || !pathname || !outsum) {
    bchk_err(funcname, nullarg);
    return NULL;
  }
#endif

  sha_init_ctx(&bchk_ctx);

  filebuf = xmalloc((size_t) len);
  if (!filebuf) {
    return NULL;
  }

  if (wrap_read(fd, filebuf, (size_t) len) != (ssize_t) len) {
    rpt_syserr(funcname, read_err, pathname, NULL);
    return NULL;
  }

  /* (from the version that works fine)
  filebuf = wrap_mmap((size_t) len, PROT_READ, (int) fd);
  if (filebuf == NULL) {
    rpt_syserr(funcname, mmap_err, pathname, NULL);
    return NULL;
  }
  */

  /* sha_process_bytes() does its own % 64 check and calls
     sha_process_block() internally to process chunks that are
     a multiple of 64 bytes before handling any remainder < 64 */

  sha_process_bytes(filebuf, (size_t) len, &bchk_ctx);
  (void) sha_finish_ctx(&bchk_ctx, outsum);
  free(filebuf);
  /*  (void) munmap(filebuf, (size_t) len); */

  return outsum;
}

Here is wrap_read() (assume that the appropriate #includes are there):

/* read() wrapper with incremental retry on interrupt */

ssize_t wrap_read(int fd, void * buf, size_t count)
{
  ssize_t retval;
  ssize_t tmpret;

#ifndef NDEBUG
  const char * funcname = "wrap_read()";
  if (!buf || !count || fd < 0) {
    bchk_err(funcname, nullarg);
    return -1;
  }
#endif

  retval = 0;
  errno = 0;
  do {
    tmpret = read(fd, ((char *) buf + retval), count - retval);
    if (tmpret + retval == (ssize_t) count) {
      return (ssize_t) count;
    }
    else {
      switch (tmpret) {
      case -1:
	switch(errno) {
	case EINTR:
	case EAGAIN:
	  break;

	default:  /* real error */
	  return retval;
	  break;
	}
	break;

      case 0:
	return retval;
	break;

      default: /* partial read */
	switch(errno) {
	case EINTR:    /* interrupted by signal */
	case EAGAIN:   /* O_NONBLOCK ? */
	  retval += tmpret;
	  break;

	default:  /* real error */
	  return (tmpret + retval);
	  break;
	}
	break;
      }
    }
  } while (retval < count);

  return retval;
}

And that's bloody it.

?

(I thought, "stack", but what's downstream? 2 sha1 calls that
don't seem to do anything evil in the test program that attempted
to isolate the error and free(). Doesn't add up.)

Regards,

Clayton Weaver
<mailto: cgweav@email.com>


-- 
_______________________________________________
Sign-up for your own FREE Personalized E-mail at Mail.com
http://www.mail.com/?sr=signup

Single & ready to mingle? lavalife.com:  Where singles click. Free to Search!
http://www.lavalife.com/mailcom.epl?a=2116

