Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264513AbTLTPnp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Dec 2003 10:43:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264531AbTLTPnp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Dec 2003 10:43:45 -0500
Received: from uni00du.unity.ncsu.edu ([152.1.13.100]:28032 "EHLO
	uni00du.unity.ncsu.edu") by vger.kernel.org with ESMTP
	id S264513AbTLTPnW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Dec 2003 10:43:22 -0500
From: jlnance@unity.ncsu.edu
Date: Sat, 20 Dec 2003 10:43:15 -0500
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Test program with VM or FS problems
Message-ID: <20031220154315.GA12763@ncsu.edu>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="CE+1k2dSO48ffgeK"
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--CE+1k2dSO48ffgeK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Andrew,
    About a year ago I told you I would get you some more information
about a problem I was seeing that might be in the Linux VM or ext{2,3}
code.  Well I finally have it!!  Sorry it took me so long :-)
    Given all you have to do with 2.6, I suspect this is not a good
time for you to look at this.  I am going to CC linux-kernel and hope
that someone over there finds this interesting.  I am sending it to
you not because I expect you to look at it right now, but because I
think it makes an interesting testcase for FS development.  I hope
it can be of some use to you.
    The attached program implements an external sort algorithm.
External sorting is a way to sort data that is too large to fit into
memory.  Instead of moving the data around in memory, it moves data
around on disk.  The algorithm is based on mergesort.
    All the external sort algorithms I found in books assumed the
data was stored on magnetic tape, and would repeatedly stream 
through it.  I designed this one with the assumption that the data
was on disk, and tried to optimize the access patterns to take
advantage of the file system caching.  Unfortunatly I do not think
the cache is working as well as it could be.
    For example, I have a laptop with 288M of ram, running the kernel
that came with fedora-core1.  I run the attached program as:

  ./exsort 3000000 300000

Which means create a file with 3,000,000 records, with each group
of 300,000 records already in sorted order.  This file ends up
being about 235M.  The sort algorithm needs a temporary file with
will grow to about 1/2 the size of the input file, but only at
the end of the run.  For most of the run the temp file is smaller
than this.  So for most of the run both files will fit into the
memory of the machine.  Thus I would expect the program to run
quickly, because it will not need to touch the disk.  Things are
in cache.  This is not what I see.  Instead the program seems to
be very much disk bound.  I dont know if this indicates a problem
in the kernel or if I am just expecting too much from the cache.
But I think it makes an interesting testcase.
    I have not tested this with a 2.6 kernel.  I ran this program
on ext3.  I have tested a similar program on ext2 and ext3.  It
runs better on ext2 since the journal is not there, but it is
still not as fast as I think it should be.
    The program is attached.  I hope you find it useful, and I would
love go hear your opinions about what it might be doing to the VM & FS.

Thanks,

Jim

--CE+1k2dSO48ffgeK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="exsort.c"

#define _XOPEN_SOURCE 500 /* Allows pread/pwrite prototypes */
#define _FILE_OFFSET_BITS 64

/* 
 * 
 * Copyright (c) 2003 Patricia Jewell Nance
 * 
 * Permission is hereby granted, free of charge, to any person obtaining a
 * copy of this software and associated documentation files (the "Software"), 
 * to deal in the Software without restriction, including without limitation
 * the rights to use, copy, modify, merge, publish, distribute, sublicense,
 * and/or sell copies of the Software, and to permit persons to whom the
 * Software is furnished to do so, subject to the following conditions:
 * 
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 * 
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
 * THE X CONSORTIUM BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
 * WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF
 * OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 * 
 * Except as contained in this notice, the name of Patricia Nance shall not be
 * used in advertising or otherwise to promote the sale, use or other dealings
 * in this Software without prior written authorization from her.
 * 
 */

#ifndef EXSORT_H
#define EXSORT_H

#include <stdlib.h>
#include <stdio.h>

/* exsort() sorts a disk file.  The algorithm used is an external merge
 * sort, and is optimized for sorting extreamly large files, specifically
 * files much larger than the physical memory of the machine.  External
 * sorting (sorting files too large to hold in memory) is covered fairly
 * well in the literature (see Sedgwigk).  This implementation differs
 * from most common implementations in two important ways:
 *
 * 1 - Care has been taken to maximize utilization of the operating systems
 *     buffer cache.  Many external sorting algorithms were developed for
 *     sorting data stored on magnetic tape.  Tape streams well and rewinds
 *     poorly, so these algorithms read the tapes sequentially from beginning
 *     to end.  The same algorithms will work when implemented on top of
 *     disk files rather than tape drives.  However, since disk files support
 *     efficient seeking, the algorithms can be redesigned to run faster by
 *     allowing more seeks.
 *
 * 2 - This implementation supports sorting variable sized records.  All
 *     descriptions of external sorting (and most of sorting in general)
 *     that I am aware of assume that the records being sorted are all
 *     of the same size.  This is often an inconvienient assumption.  This
 *     implementation supports sorting files with variable sized records.
 *     To see why this might be useful, remember that alphabatizing a list
 *     of words requires sorting a list of variable sized records.
 *
 * The algroithm is I/O bound.  Its running time should be proportional
 * to the log of the number of records because the file must be read
 * log2(num_records) times.  This number can be reduced by writing the
 * file in sorted chunks rather than in a compleatly random order.  The
 * blksize paramater is used to specify the chunksize.  The chunksize
 * is given in units of records NOT BYTES.  All the chunks must have
 * an equal number of records, except for the last, which may be smaller.
 */
int exsort(
    /* File descriptor referencing the file to be sorted.  Open for
     * Read/Write on a seekable file */
  int  fd,

    /* File descriptor referencing a scratch file for use by the sorting
     * algorithm.  The contents of this file will be destroyed and it will
     * grow in size to 1/2 the size of the file being sorted.  This descriptor
     * must be open Read/Write and be seekable */
  int  sfd,

    /* If file has been presorted into blocks of N sorted
     * records, the blocksize goes here.  Note that any file
     * can be considered to have been presorted into blocks
     * of 1 sorted record, so 1 will always work.  However,
     * significant speed improvements are possible if the
     * file has been sorted into larger blocks */
  size_t blksize,

    /* The comparison function.  Returns 1 if rec1>rect2, -1 if
     * rec2>rec1, and 0 if rec1==rec2.  Token is the token passed in as
     * the last argument to exsort */
  int (*cmp)(void *token, void *rec1, void *rec2),

    /* The size function.  Returns the size of the record pointed to
     * by buff IFF the size is less than or equal to len.  If the size
     * exceeds len, then this function returns 0 */
  size_t (*size)(void *token, void *buff, size_t len),

    /* User supplied data.  This pointer is passed as the token argument
     * to the size() and cmp() function pointers, and may be utilized
     * for any purpose by those functions.  It is not dereferenced by
     * any exsort code */
  void *token
);
                     
#endif /* End of exsort.h */

#define _XOPEN_SOURCE 500 /* Allows pread/pwrite prototypes */

#if 1
# define JLN_DEBUG(x) printf x 
#else
# define JLN_DEBUG(x)
#endif

#include <stdlib.h>
#include <string.h>
#include <sys/uio.h>
#include <unistd.h>
#include <assert.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <errno.h>
/* #include "exsort.h" */

static int
write_at(int fd, char *buf, size_t count, off_t start)
{
  size_t off = 0;
  do {
    ssize_t bw = pwrite(fd, buf+off, count-off, start+off);

    if(bw>0) {
      off += bw;
    } else {
      /* Some sort of write error occured */
      if(bw==0 || errno!=EINTR) {
        return -1;
      }
    }

  } while(off<count);

  return 0;
}

/* copy len bytes from the source file descriptor s_fd to the destination
 * file descriptor d_fd, starting from source offset s_off and destination
 * offset d_off.  The file position of both s_fd, and d_fd is not changed
 * by this function.  Returns -1 on error and 0 on success */
static int
move_bytes(int s_fd, off_t s_off, int d_fd, off_t d_off, off_t len)
{
  off_t  bleft = len;
  off_t  roff  = s_off;
  off_t  woff  = d_off;

  /* We use a while loop because we do not want to report an error if
   * someone passes in a len of 0, and this is the easiest way to do
   * that.  No one should be passing in 0 lengths though */
  while(bleft>0) {
    char buf[8192];
    size_t  rs = bleft>sizeof(buf)? sizeof(buf) : bleft;
    ssize_t br = pread(s_fd, buf, rs, roff);
    if(br>0) {
      if(write_at(d_fd, buf, br, woff)) {
        return -1;
      }

      /* If we made it here both the read and the write moved br bytes of
       * data.  This is a good place to update our counters and offsets */
      roff  += br;
      woff  += br;
      bleft -= br;

    } else {
      /* Some sort of read problem occured */
      if(br==0 || (errno!=EINTR)) {
        return -1;
      }
    }
  }
  return 0;
}

struct IObuf
{
  int    ifd;
  char  *buf;
  size_t length;
  size_t used;
  off_t  off;
};

struct MergeInfo {
  off_t   left;
  size_t  s;
  ssize_t off;
};

struct SortBlock
{
  off_t  start;
  off_t  length;
  off_t  records;
};

struct ExsortInfo
{
  int (*cmp)(void *token, void *rec1, void *rec2);
  size_t (*size)(void *token, void *buff, size_t len);
  void *token;
};

static void
bind_buffer(int fd, struct IObuf *buf)
{
  buf->ifd  = fd;
  buf->used = 0;
  buf->off  = 0;
}

static void
seek_buffer(off_t start_pos, struct IObuf *buf)
{
  buf->off = start_pos;
}

static void
shift_buffer(size_t count, struct IObuf *buf)
{
  if(count>=buf->used) {
    buf->used = 0;
  } else {
    size_t nused = buf->used - count;
    memmove(buf->buf, buf->buf+count, nused);
    buf->used = nused;
  }
  buf->off += count;
}

static ssize_t
fill_buffer(struct IObuf *buf)
{
  ssize_t rv;
  do {
    rv = pread(buf->ifd, buf->buf, buf->length, buf->off);
  } while(rv==-1 && errno==EINTR);
  buf->used = rv;
  return rv;
}

static ssize_t
append_buffer(struct IObuf *buf)
{
  size_t delta = buf->used;
  ssize_t rv;
  do {
    rv = pread(buf->ifd, buf->buf+delta, buf->length-delta, buf->off+delta);
  } while(rv==-1 && errno==EINTR);
  buf->used += rv;
  return rv;
}

static int
double_buffer(struct IObuf *buf)
{
  buf->length = buf->length? 2*buf->length : 4096;
  buf->buf    = realloc(buf->buf, buf->length);
  return buf->buf? 0 : -1;
}

static void
free_buffer(struct IObuf *buf)
{
  if(!buf->buf) return;
  free(buf->buf);
  buf->buf = 0;
}

/* Originally I had ideas about making this function merge two chunks rather
 * than just determining how large a chunk was.  We could save a read pass
 * through the file that way.  However trying to combine the merge logic
 * along with the buffer resizing, EOF detection, and error handling makes
 * the logic of the code very difficult to follow.  And after I got it
 * implemented it actually seemed to be slower than the original which
 * just looked for the chunk.  While I a convinced that it is in theory
 * possible to make the code faster by merging two chunks here, I dont
 * feel like the gain is worth the pain of the complexity.
 */
static int
find_chunk(
    struct SortBlock *s,
    int fd,
    int  *hit_eof,
    off_t r_off,
    size_t blksize,
    struct IObuf *topbuf,
    struct IObuf *botbuf,
    struct ExsortInfo *info
    )
{
  size_t i;
  ssize_t r;
  ssize_t boff;
  off_t   w_off = 0;

  s->start   = r_off;
  s->length  = 0;
  s->records = 0;

  boff = 0;
  bind_buffer(fd, botbuf);
  seek_buffer(r_off, botbuf);
  for(i=0;;) {
    ssize_t left = botbuf->used - boff;

    if(left>0) {
      char   *buff = botbuf->buf + boff;
      size_t  s = info->size(info->token, buff, left);
      if(s>0 && s<=left) {
        boff += s;
        if(++i>=blksize) {
          /* This is the last block, make sure to flush */
          assert(boff<=botbuf->used);
          shift_buffer(boff, botbuf);
          w_off += boff;
          break; /* We are done with the bottom */
        }
        continue; /* Skip the buffer filling code below */
      }
    }

    /* If we get here it means we need to read a record which is not
     * fully in the buffer.  This could either happen because the
     * buffer is too small, or because the buffer needs to be flushed
     * and refilled */
    if(boff==0 && botbuf->length==botbuf->used) {
      /* The buffer is too small, we must make it larger.  We grow both
       * topbuf and botbuf because latter we want to assue that any
       * record will fit into either buffer */
      if(double_buffer(topbuf)) return -1;
      if(double_buffer(botbuf)) return -1;
      r = append_buffer(botbuf);
      if(r<1) {
        /* We have a partial record in the buffer, thus we should be
         * able to read the rest of the record.  If the read failed
         * it is a fatal error */
        return -1;
      }
    } else {
      /* The buffer has old data in it.  Flush and refill and try again */
      if(boff) {
        assert(boff<=botbuf->used);
        shift_buffer(boff, botbuf);
        w_off += boff;
        boff   = 0;
      }
      r = append_buffer(botbuf);
      if(r<1) {
        if(r==0) {
          /* There is no more data, we hit EOF */
          *hit_eof   = 1;
          s->length  = w_off;
          s->records = i;
          return 0;
        } else {
          return -1; /* Some sort of fatal error */
        }
      }
    }
  }

  s->length  = w_off;
  s->records = blksize;

  return 0;
}

static int
write_vec(int fd, struct iovec *iov, size_t count)
{
  for(;;) {
    ssize_t wb = writev(fd, iov, count);
    if(wb>0) return 0;
    if(wb!=-1 || errno!=EINTR) {
      return -1;
    }
  }
}

static int
merge_adjacent(
    int                fd,
    int                sfd, 
    struct SortBlock  *tblock,
    struct SortBlock  *bblock,
    struct IObuf      *topbuf,
    struct IObuf      *botbuf,
    struct ExsortInfo *info)
{
  struct iovec  iov[4096];
  const  size_t nio   = sizeof(iov)/sizeof(iov[0]);
  size_t        idx;
  off_t         pos;
  struct MergeInfo binfo, tinfo, *inf;

  binfo.left = bblock->records;
  tinfo.left = tblock->records;

  /* Copy the bottom block into the scratch file */
  if(move_bytes(fd, bblock->start, sfd, 0, bblock->length)) {
    return -1;
  }

  /* Position the file descriptor for the writev calls */
  if(lseek(fd, bblock->start, SEEK_SET)==-1) {
    return -1;
  }

  /* Do the merging */
  idx = 0;
  bind_buffer(sfd, botbuf);
  seek_buffer(0,   botbuf);

  bind_buffer(fd,  topbuf);
  seek_buffer(tblock->start, topbuf);
  tinfo.off = binfo.off = 0;
  pos       = bblock->start;

  /* We know that the buffers are large enough to hold the largest record.
   * thus we can be sure that they contain at least 1 record. */
  if(fill_buffer(botbuf)<1) return -1;
  if(fill_buffer(topbuf)<1) return -1;

  assert(tinfo.left>0 && binfo.left>0);
  tinfo.s = info->size(info->token, topbuf->buf, topbuf->used - tinfo.off);
  binfo.s = info->size(info->token, botbuf->buf, botbuf->used - binfo.off);

  if(tinfo.left>0 && binfo.left>0) for(;;) {
    struct IObuf *iobuf;
    size_t left;
    char *record;
    char *trecord = topbuf->buf + tinfo.off;
    char *brecord = botbuf->buf + binfo.off;
    int   cval = info->cmp(info->token, brecord, trecord);

    if(cval<=0) { /* Get record from bottom */
      inf = &binfo;
      record = brecord;
      iobuf  = botbuf;
    } else {      /* Get record from top */
      inf = &tinfo;
      record = trecord;
      iobuf  = topbuf;
    }

    left = iobuf->used - inf->off;

    inf->off += inf->s;
    if(idx>0 && ((char*)iov[idx-1].iov_base)+iov[idx-1].iov_len == record) {
      iov[idx-1].iov_len += inf->s;
    } else {
      iov[idx].iov_base = record;
      iov[idx].iov_len  = inf->s;
      ++idx;
    }

    /* If there are reasons to flush our iovectors to disk, we set inf->s
     * to zero, which will cause the flush block to be entered below.  Note
     * that the way things are set up we only call info->size() once.  Either
     * here or at the bottom of the flush block */
    if(--inf->left<1 || left<=inf->s || idx+1>nio) {
      inf->s = 0;
    } else {
      inf->s = info->size(info->token, record+inf->s, left-inf->s);
    }

    if(inf->s<1) {
      /* This is the flush block.  We have an iovec with data that needs to
       * be written to disk.  This is where we dump it. */
      if(write_vec(fd, iov, idx)) {
        return -1;
      }

      idx = 0;

      if(binfo.off) {
        shift_buffer(binfo.off, botbuf);
        pos       += binfo.off;
        binfo.off  = 0;
      }

      if(tinfo.off) {
        shift_buffer(tinfo.off, topbuf);
        pos       += tinfo.off;
        tinfo.off  = 0;
      }

      if(inf->left<1) {
        /* This is the only non-error exit from the for(;;) loop.  If we are
         * here one of the two blocks we are merging has become empty. */
        break;
      }

      /* Refill the buffer */
      if(append_buffer(iobuf)<1) {
        return -1;
      }
      inf->s = info->size(info->token, iobuf->buf, iobuf->used - inf->off);
    }
  }

  if(tinfo.left)  {
    /* We do not have to do anything for this case.  The records are
     * already in the correct positions */
  } else if(binfo.left) {
    /* Move bytes from scratch file back into regular file */
    off_t len = bblock->length - botbuf->off;
    if(move_bytes(sfd, botbuf->off, fd, pos, len)) {
      return -1;
    }
  }

  bblock->records += tblock->records;
  bblock->length  += tblock->length;

  return 0;
}

static int exsort_real(
    int                fd,
    int                sfd,
    size_t             blksize,
    struct ExsortInfo *info,
    struct IObuf      *topbuf,
    struct IObuf      *botbuf
    )
{
  struct SortBlock  stack[64];
  int               sp      = 0;
  int               hit_eof = 0;
  off_t             r_off   = 0;
  int               Scount  = 0;

  for(;;) {
  ++Scount;
    if(hit_eof && sp==1) {
      /* We are done!! */
      return 0;
    } else if(hit_eof ||
      (sp>1 && 2*stack[sp-1].records>stack[sp-2].records)) {
      /* Merge stack[sp-1] and stack[sp-2] */
      struct SortBlock *tb = &stack[sp-1];
      struct SortBlock *bb = &stack[sp-2];

      JLN_DEBUG(("Merge: depth=%d records/size %lld/%lld and %lld/%lld\n",
      sp-1, (long long)tb->records, (long long)tb->length,
      (long long) bb->records, (long long)bb->length));

      if(merge_adjacent(fd, sfd, tb, bb, topbuf, botbuf, info)) {
        return -1;
      }
      --sp;
    } else {
      /* Scan the input file looking for a new chunk */
      struct SortBlock *s = &stack[sp];
      int rv;
      
      JLN_DEBUG(("Search:  Looking for new data at offset %lld\n",
      (long long) r_off));
      rv = find_chunk(s, fd, &hit_eof, r_off, blksize, topbuf, botbuf, info);

      if(rv<0) {
        return -1; /* error */
      }
      if(s->records>0) {
        ++sp;
        r_off = s->start + s->length;
      }
    }

#if 0
    printf("Scount = %d ", Scount);
    fflush(0);
    system("md5sum testfile");
    if(Scount==61)
      exit(1);
#endif
  }
}

int exsort(
    int  fd,
    int  sfd,
    size_t blksize,
    int (*cmp)(void *token, void *rec1, void *rec2),
    size_t (*size)(void *token, void *buff, size_t len),
    void *token
    )
{
  struct ExsortInfo info    = {cmp, size, token};
  struct IObuf      topbuf  = {0};
  struct IObuf      botbuf  = {0};
  int               rv      = -1;

  if(!double_buffer(&topbuf) && !double_buffer(&botbuf)) {
    rv = exsort_real(fd, sfd, blksize, &info, &topbuf, &botbuf);
  }

  free_buffer(&botbuf);
  free_buffer(&topbuf);

  return rv;
}

/* End of exsort.c */
/* Start of test.c.  Test program for exsort */
#include <stdlib.h>
#include <stdio.h>
#include <stdarg.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <sys/time.h>
#include <fcntl.h>

/* #include "exsort.h" */

static void die(char *fmt, ...)
{
  va_list ap;
  va_start(ap, fmt);
  vfprintf(stderr, fmt, ap);
  va_end(ap);
  exit(-1);
}

/* Creates a test file to be sorted.  The file contains max records, and
 * they are blocked into chunks of csize sorted records.
 */
static int
create_test_file(const char *fname, size_t max, size_t csize)
{
  int dmax;
  size_t ctmp;
  size_t i;
  FILE  *fp = fopen(fname, "w");

  if(!fp)
    return -1;

  for(dmax=0, ctmp=csize; ctmp>0; ctmp /= 26) ++dmax;

  /* We divide i by 2 in the loop below so that we generate duplicate entries */
  for(i=0; i<max; i++) {
    char   buf[80];
    size_t i2   = i/2;
    size_t blkn = i2/csize;
    size_t coff = i%csize;
    size_t mod  = blkn%62;
    size_t ctmp;
    int    pos, len, c, i;

    /* Pick a character to start the block with */
    if(mod<26) c = 'z' - mod;
    else if(mod<52) c = 'A' + mod - 26;
    else c = '0' + mod - 52;

    /* Pick a string length */
    len = 73 - (blkn%72);

    /* Now write len characters and follow that by another sequence of
     * chars that will be in sorted order */
    for(i=0; i<len; i++) {
      buf[i]=c;
    }
    buf[len]='-';
    buf[len+1]=0;
    if(fputs(buf, fp)<0) {
      return -1;
    }

    ctmp = coff;
    for(pos=dmax; pos>=0; --pos) {
      buf[pos]='a' + ctmp%26;
      ctmp /= 26;
    }
    buf[dmax+1] = '\n';
    buf[dmax+2] = '\0';
    if(fputs(buf, fp)<0) {
      return -1;
    }
  }

  if(fflush(fp)) {
    return -1;
  }

  fsync(fileno(fp));
  if(fclose(fp)<0) {
    return -1;
  }
  
  return 0;
}

struct prof
{
  size_t cmp;
  size_t size;
};

static int str_cmp(void *token, void *rec1, void *rec2)
{
  signed char *r1 = (char*) rec1;
  signed char *r2 = (char*) rec2;

  ((struct prof*)token)->cmp++;

  for(;;++r1, ++r2) {
    int del = *r2;

    /* Stop the comparison when the first whitespace character is reached
     * OR when the end of the line is reached */
    if(del=='\n' || del==' ' || del=='\t') {
      if(*r1=='\n' || *r1==' ' || *r1=='\t') return 0;
      return -1;
    }

    del    -= *r1;
    if(del) {
      if(*r1=='\n' || *r1==' ' || *r1=='\t') return 1;
      return del>0? -1 : 1;
    }
  }
}

static size_t str_size(void *token, void *buff, size_t len)
{
  char *cp = (char*) buff;
  size_t i;
  ((struct prof*)token)->size++;

  for(i=0; i<len; i++) {
    if(cp[i]=='\n') {
      return i+1;
    }
  }

  return 0;
}

int main(int ac, char **av)
{
  const char fname[] = "testfile";
  char       tname[sizeof(fname)+6];
  int        fd, tfd;
  size_t     nele  = 25000;
  size_t     csize = 1;
  struct stat sbuf;
  struct prof prof = {0};
  double delt;
  struct timeval tb, te;

  if(ac>1) {
    size_t s = strtol(av[1], 0, 0);
    if(s>0) {
      nele = s;
    }
    if(ac>2) {
      s = strtol(av[2], 0, 0);
      if(s>0) {
        csize = s;
      }
    }
  }

  strcpy(tname, fname);
  strcat(tname, ".tmp");

  printf("Creating file with %ld elements\n", (long)nele);
  if(create_test_file(fname, nele, csize)) {
    die("Failed to create test file\n");
  }

  if(stat(fname, &sbuf)==0) {
    printf("File size is %lld bytes\n", (long long)sbuf.st_size);
  }

  fd  = open(fname, O_RDWR, 0);
  if(fd==-1) die("Can not open %s\n", fname);

  tfd = open(tname, O_RDWR | O_CREAT | O_TRUNC, 0660);
  if(tfd==-1) die("Can not open %s\n", tname);

  gettimeofday(&tb, 0);
  if(exsort(fd, tfd, csize, str_cmp, str_size, &prof)) {
    die("exsort failed.  Errno = %d\n", errno);
  }
  gettimeofday(&te, 0);

  delt = te.tv_sec - tb.tv_sec + 1e-6*(te.tv_usec - tb.tv_usec);
  printf("Sort of %d elements took %8.6f seconds\n", nele, delt);
  printf("Profile: %u cmp() calls, %u size() calls\n", prof.cmp, prof.size);

  return 0;
}

--CE+1k2dSO48ffgeK--
