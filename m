Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293529AbSBZGbG>; Tue, 26 Feb 2002 01:31:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293531AbSBZGau>; Tue, 26 Feb 2002 01:30:50 -0500
Received: from taifun.devconsult.de ([212.15.193.29]:24069 "EHLO
	taifun.devconsult.de") by vger.kernel.org with ESMTP
	id <S293530AbSBZGaa>; Tue, 26 Feb 2002 01:30:30 -0500
Date: Tue, 26 Feb 2002 07:30:27 +0100
From: Andreas Ferber <aferber@techfak.uni-bielefeld.de>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: How to check the kernel compile options ?
Message-ID: <20020226073027.A20261@devcon.net>
Mail-Followup-To: "Randy.Dunlap" <rddunlap@osdl.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20020216015834.D28176@devcon.net> <Pine.LNX.4.33L2.0202221150420.2938-100000@dragon.pdx.osdl.net> <20020223080223.A32501@devcon.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="jI8keyz6grp/JLjh"
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020223080223.A32501@devcon.net>; from aferber@techfak.uni-bielefeld.de on Sat, Feb 23, 2002 at 08:02:24AM +0100
Organization: dev/consulting GmbH
X-NCC-RegID: de.devcon
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--jI8keyz6grp/JLjh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Feb 23, 2002 at 08:02:24AM +0100, Andreas Ferber wrote:

> At the moment I'm just writing a tool which does all parts in one turn
> (using zlib), to make it faster and more robust (the script above may
> fail for example if the kernel image has more than one block of gzip
> compressed data embedded). (It's actually working already, but the
> code needs some heavy cleanup before it can be released to the public
> ;-) Come back in a few days for news...

Here we go again. Attached to this mail you find the announced kernel
config extractor. It is also available via HTTP: 

http://www.myipv6.de/patches/kconfig/dumpkconfig.c

It requires zlib to do the decompression stuff. As it is currently
lacking a Makefile, you have to compile it by hand (maybe you have to
add -I or -L parameters if you don't have zlib installed in the
standard search path):

gcc -o dumpkconfig dumpkconfig.c -lz

If you call it without arguments, it tries to read the kernel image
from stdin. Alternatively, you can give it a filename at the command
line.

It works on compressed kernel images as well as on uncompressed ones
(e.g. vmlinux or /proc/kcore). Obviously, CONFIG_PROC_CONFIG has to be
enabled for dumpkconfig to work, and you have to choose GZIP
compression for /proc/config. bzip2 compression is not yet supported
(and probably never will be, at least not by me), as is "none"
compression (Which has no magic to search for and no "end of data"
marker like gzip data, so it would be rather difficult to do. One
could add some to the kernel code, but I don't think it's worth it).

The code (and especially the error handling[1]) is still a bit wacky
and is missing documentation, but it is working fine here, so I
release it anyways.

If you experience any problems, please let me know.

Andreas

[1] Although this might turn out to be a feature in some cases, as
    gzip decompression errors are currently handled by ending the gzip
    stream and searching for the next gzip magic, which should make
    things more robust against spurious gzip magics in the kernel code.
-- 
       Andreas Ferber - dev/consulting GmbH - Bielefeld, FRG
     ---------------------------------------------------------
         +49 521 1365800 - af@devcon.net - www.devcon.net

--jI8keyz6grp/JLjh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="dumpkconfig.c"

/* dumpkconfig.c - read config data from kernel image
   Copyright (C) 2002 Andreas Ferber <af@myipv6.de>

   This program is free software; you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation; either version 2, or (at your option)
   any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   Along with this program; if not, write to the Free Software Foundation,
   Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.  */

/*
 * This is a first attempt at extracting configuration data compiled in
 * via the kconfig patch (http://www.myipv6.de/patches/kconfig/) from a
 * kernel image without booting it. It only works if you enabled
 * CONFIG_PROC_CONFIG with gzip compression (CONFIG_PROC_CONFIG_GZ),
 * bzip2 or none compression are not yet supported (and probably will
 * never be).
 *
 * It will work on both a compressed (vmlinuz) or an uncompressed kernel
 * image (e.g. vmlinux or /proc/kcore), whatever you prefer.
 *
 * It needs zlib to extract the compressed data. Compile it with
 *
 *     gcc -o dumpkconfig dumpkconfig.c -lz
 *
 * Command line interface is very simple at the moment: without
 * arguments it tries to read stdin, otherwise it tries to open the file
 * named by the first command line parameter. The only other parameter
 * recognized at the moment is "--help"/"-h", which prints a usage
 * message and exits.
 */

#include <assert.h>
#include <stddef.h>
#include <stdlib.h>
#include <stdarg.h>
#include <stdio.h>
#include <unistd.h>
#include <string.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <errno.h>
#include <zlib.h>

/* size of stream buffers */
#define BUF_SIZE 8192

/* stream data */
struct streambuf {
    int type;
    char *buf, *buf_base;
    size_t buf_size;
    size_t buf_avail;
    size_t pos;
    int err:1,
        eof:1,
        eof_pending:1;
    union {
        struct {
            FILE *fd;
            char *fname;
        } f;
        struct {
            z_streamp zstrm;
            struct streambuf *input;
        } z;
    } src;
    size_t (*read) (struct streambuf *s, void *buf, size_t size);
    void (*close) (struct streambuf *s);
};

#define STREAM_FILE 1
#define STREAM_GZIP 2

/* gzip file header flags
 * unfortunately, zlib.h doesn't define these flags, so we have to
 * define it here */
#define ASCII_FLAG   0x01 /* bit 0 set: file probably ascii text */
#define HEAD_CRC     0x02 /* bit 1 set: header CRC present */
#define EXTRA_FIELD  0x04 /* bit 2 set: extra field present */
#define ORIG_NAME    0x08 /* bit 3 set: original file name present */
#define COMMENT      0x10 /* bit 4 set: file comment present */
#define RESERVED     0xE0 /* bits 5..7: reserved */

void error(const char *msg, ...)
{
    va_list args;
    va_start(args, msg);
    vfprintf(stderr, msg, args);
    va_end(args);
}

#define FATAL(msg) do { perror(msg); exit(EXIT_FAILURE); } while (0)

/*
 * Generic stream methods
 */

/* create a new empty stream object and allocate a buffer for it */
struct streambuf *alloc_stream(void)
{
    struct streambuf *s;

    s = calloc(1, sizeof(struct streambuf));
    if (s == NULL)
        FATAL("malloc");

    s->buf_base = malloc(BUF_SIZE);
    if (s->buf_base == NULL)
        FATAL("malloc");
    s->buf = s->buf_base;

    s->buf_size = BUF_SIZE;

    return s;
}

/* free a stream object and it's buffer */
void free_stream(struct streambuf *s)
{
    free(s->buf_base);
    free(s);
}

/* fill the stream buffer via the ->read() function */
int fill_buffer(struct streambuf *s)
{
    /* stop buffer fill if at least 80% are filled */
    size_t min_fill = (s->buf_size/10)*8;

    if (s->err)
        return 0;

    if (s->buf != s->buf_base) {
        if (s->buf_avail != 0)
            memmove(s->buf_base, s->buf, s->buf_avail);
        s->buf = s->buf_base;
    }

    while (!s->eof_pending && !s->eof && s->buf_avail < min_fill) {
        size_t r = s->read(s, s->buf+s->buf_avail, s->buf_size-s->buf_avail);
        if (s->err)
            return 0;
        s->buf_avail += r;
    }
    if (s->eof_pending && s->buf_avail == 0)
        s->eof = 1;
    return 1;
}

void consume(struct streambuf *s, size_t bytes)
{
    if (bytes < s->buf_avail) {
        s->buf += bytes;
        s->pos += bytes;
        s->buf_avail -= bytes;
    }
    else {
        s->pos += s->buf_avail;
        s->buf_avail = 0;
    }
    if (s->buf_avail == 0) {
        s->buf = s->buf_base;
        if (s->eof_pending)
            s->eof = 1;
    }
}

void close_stream(struct streambuf *s)
{
    s->close(s);
    free_stream(s);
}

size_t file_stream_read(struct streambuf *s, void *buf, size_t size)
{
    size_t r;
    
    assert(s->type == STREAM_FILE);

    r = fread(buf, 1, size, s->src.f.fd);
    if (ferror(s->src.f.fd))
        FATAL(s->src.f.fname);
    if (feof(s->src.f.fd))
        s->eof_pending = 1;
    return r;
}

void file_stream_close(struct streambuf *s)
{
    if (s->src.f.fd)
        fclose(s->src.f.fd);
    if (s->src.f.fname)
        free(s->src.f.fname);
}

struct streambuf *file_stream_new(const char *fname)
{
    struct streambuf *s;

    s = alloc_stream();

    s->type = STREAM_FILE;

    s->read = file_stream_read;
    s->close = file_stream_close;

    if (fname == NULL) {
        s->src.f.fd = stdin;
        return s;
    }

    if ((s->src.f.fname = strdup(fname)) == NULL)
        FATAL("strdup");

    if ((s->src.f.fd = fopen(fname, "r")) == NULL)
        FATAL(fname);

    return s;
}

voidpf zlib_alloc(voidpf opaque, uInt items, uInt size)
{
    return malloc(items*size);
}

void zlib_free(voidpf opaque, voidpf mem)
{
    free(mem);
}

size_t z_stream_read(struct streambuf *s, void *buf, size_t size)
{
    z_streamp z = s->src.z.zstrm;
    struct streambuf *src = s->src.z.input;
    int zerr;

    assert(s->type == STREAM_GZIP);
    assert(!s->err);

    if (s->eof || s->eof_pending)
        return 0;

    if (!fill_buffer(src)) {
        s->err = 1;
        return 0;
    }

    z->next_in = src->buf;
    z->avail_in = src->buf_avail;
    z->next_out = buf;
    z->avail_out = size;

    zerr = inflate(z, Z_SYNC_FLUSH);
    if (zerr < 0) {
        s->err = 1;
        return 0;
    }
    if (zerr == Z_STREAM_END)
        s->eof_pending = 1;
    consume(src, src->buf_avail-z->avail_in);

    return size-z->avail_out;
}

void z_stream_close(struct streambuf *s)
{
    assert(s->type == STREAM_GZIP);

    if (s->src.z.zstrm) {
        inflateEnd(s->src.z.zstrm);
        free(s->src.z.zstrm);
        s->src.z.zstrm = NULL;
    }
}

int skip_to_gzip_magic(struct streambuf *s)
{
    static char magic[] = { 0x1f, 0x8b, 0x08 };
    static int magic_len = sizeof(magic);

    while (1) {
        if (!fill_buffer(s))
            return 0;
        while (s->buf_avail >= sizeof(magic)) {
            char *p = memchr(s->buf, magic[0], s->buf_avail-magic_len+1);
            if (!p) {
                consume(s, s->buf_avail-magic_len+1);
                break;
            }
            if (memcmp(p, magic, magic_len) == 0) {
                consume(s, p-s->buf);
                return 1;
            }
            consume(s, p-s->buf+1);
        }
        if (s->eof_pending) {
            consume(s, s->buf_avail);
            return 0;
        }
    }
    /* not reached */
}

int skip_gzip_header(struct streambuf *s)
{
    int flags;

    if (!fill_buffer(s))
        return 0;

    flags = s->buf[3];
    consume(s, 10); /* 10 == basic gzip header size */
    if (flags & EXTRA_FIELD) {
        int extra = ((unsigned char)s->buf[1]<<8)+(unsigned char)s->buf[0];
        consume(s, extra+2);
    }
    if (flags & ORIG_NAME) {
        char *p = memchr(s->buf, '\0', s->buf_avail);
        if (p)
            consume(s, p-s->buf);
    }
    if (flags & COMMENT) {
        char *p = memchr(s->buf, '\0', s->buf_avail);
        if (p)
            consume(s, p-s->buf);
    }
    if (flags & HEAD_CRC)
        consume(s, 2);

    return 1;
}

int try_zlib_init(struct streambuf *s)
{
    struct streambuf *src = s->src.z.input;
    z_streamp z = s->src.z.zstrm;
    int zerr;

    if (!fill_buffer(src))
        goto err_input;

    z->zalloc = zlib_alloc;
    z->zfree = zlib_free;

    z->next_in = src->buf;
    z->avail_in = src->buf_avail;
    z->next_out = s->buf;
    z->avail_out = s->buf_size;

    /* give negative window size to inflateInit2, because gzip files do
     * not contain zlib headers which are expected otherwise */
    if ((zerr = inflateInit2(z, -MAX_WBITS)) != Z_OK)
        goto err_zinit;

    zerr = inflate(z, Z_SYNC_FLUSH);
    if (zerr < 0)
        goto err_decomp;

    s->buf_avail = s->buf_size-z->avail_out;
    if (zerr == Z_STREAM_END)
        s->eof_pending = 1;
    consume(src, src->buf_avail-z->avail_in);

    return 1;

err_decomp:
    inflateEnd(z);
err_zinit:
    consume(src, 1);
err_input:
    return 0;
}

struct streambuf *z_stream_new(struct streambuf *src)
{
    struct streambuf *s;
    z_streamp z;

    s = alloc_stream();

    s->type = STREAM_GZIP;

    s->read = z_stream_read;
    s->close = z_stream_close;

    s->src.z.input = src;
    z = calloc(1, sizeof(z_stream));
    if (z == NULL)
        FATAL("malloc");
    s->src.z.zstrm = z;

    while (skip_to_gzip_magic(src)) {
        if (!skip_gzip_header(src))
            break;
        if (try_zlib_init(s))
            return s; /* we got the zlib stream up and running, cross fingers... */
        if (src->err)
            break;
    }

    /* no gzip data to work on found (or source error...) */
    free(z);
    free_stream(s);
    return NULL;
}

void z_stream_finish(struct streambuf *s)
{
    assert(s->type == STREAM_GZIP);

    while (!s->eof && !s->err) {
        consume(s, s->buf_avail);
        fill_buffer(s);
    }

    consume(s, s->buf_avail);
}

void dump_stream(struct streambuf *s, int fd)
{
    do {
        write(fd, s->buf, s->buf_avail);
        consume(s, s->buf_avail);
        fill_buffer(s);
    } while (!s->eof && !s->err);
}

int is_config(struct streambuf *s)
{
    static char magic[] = "CONFIG_";
    static int magic_len = sizeof(magic)-1;
    char *p;

    if ((p = memchr(s->buf, magic[0], s->buf_avail-magic_len)) != NULL)
        if (memcmp(p, magic, magic_len) == 0)
            return 1;
    return 0;
}

int dump_if_config(struct streambuf *s)
{
    if (!fill_buffer(s))
        return 0;
    if (is_config(s)) {
        dump_stream(s, STDOUT_FILENO);
        if (s->err) {
            error("Error dumping config data: %s\n", s->src.z.zstrm->msg);
            exit(EXIT_FAILURE);
        }
        return 1;
    }
    return 0;
}

int extract_config(const char *fname)
{
    struct streambuf *f, *v, *c;
    int ret = 1;

    f = v = c = NULL;

    /* open outmost stream directly reading from file */
    f = file_stream_new(fname);
    if (f == NULL)
        return 0;

    /* outer gzip encoding... */
    while ((v = z_stream_new(f)) != NULL) {
        if (dump_if_config(v))
            goto cleanup;
        /* inner gzip encoding... */
        while ((c = z_stream_new(v)) != NULL) {
            if (dump_if_config(c))
                goto cleanup;
            z_stream_finish(c);
            close_stream(c);
        }
        z_stream_finish(v);
        close_stream(v);
    }

    error("No config data found.\n"
          "Did you enable CONFIG_PROC_CONFIG and CONFIG_PROC_CONFIG_GZ?\n");
    ret = 0;

cleanup:
    if (c)
        close_stream(c);
    if (v)
        close_stream(v);
    if (f)
        close_stream(f);
    return ret;
}

void usage(const char *me)
{
    fprintf(stderr, "Usage: %s [kernelimage]\n", me);
    exit(EXIT_SUCCESS);
}

int main(int argc, char *argv[])
{
    if (argc > 2)
        usage(argv[0]);
    if (argc == 2) {
        if (strcmp(argv[1], "--help") == 0 || strcmp(argv[1], "-h") == 0)
            usage(argv[0]);
        return !extract_config(argv[1]);
    }
    /* no filename, use stdin */
    return !extract_config(NULL);
}

/*
 * vi:ts=4 sw=4 expandtab
 * vi:tags=./tags,./../tags,./../../tags,tags,../tags,../../tags
 */

--jI8keyz6grp/JLjh--
