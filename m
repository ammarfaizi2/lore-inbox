Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265887AbUHMO5J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265887AbUHMO5J (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Aug 2004 10:57:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265897AbUHMO5I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Aug 2004 10:57:08 -0400
Received: from web61309.mail.yahoo.com ([216.155.196.152]:19632 "HELO
	web61309.mail.yahoo.com") by vger.kernel.org with SMTP
	id S265887AbUHMO4t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Aug 2004 10:56:49 -0400
Message-ID: <20040813145649.99935.qmail@web61309.mail.yahoo.com>
Date: Sat, 14 Aug 2004 00:56:49 +1000 (EST)
From: =?iso-8859-1?q?Zhan=20Rongkai?= <zhanrk2000@yahoo.com.au>
Subject: About the decompression of compressed kernel image
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, everyone:

I am porting linux-2.6.4 to a new architecture
processor. And i have created a compressed kernel
image. Here is my creation steps:

  - Use objcopy to translate the 'linux/vmlinux' to
'arch/$(ARCH)/boot/compressed/vmlinux.bin'

  - Use 'gzip -f -9' to compress
'arch/$(ARCH)/boot/compressed/vmlinux.bin' to
'arch/$(ARCH)/boot/compressed/vmlinux.bin.gz'
    
    NOTE: The two commands: "gzip -f -9
arch/$(ARCH)/boot/compressed/vmlinux.bin' and
    'gzip -f -9 <
arch/$(ARCH)/boot/compressed/vmlinux.bin >
arch/$(ARCH)/boot/compressed/vmlinux.bin.gz' ouput two
copies of 
    'vmlinux.bin.gz' with different file size. Is it
ok? Why?

  - Use the command 'ld -r -b binary' to generate
'arch/$(ARCH)/boot/compressed/piggy.o' from
    'arch/$(ARCH)/boot/compressed/vmlinux.bin.gz'

  - Then I link the three object files
'compressed/head.o compressed/misc.o
compressed/piggy.o' together, and i get the compressed
    kernel image -
'arch/$(ARCH)/boot/compressed/vmlinux'.

  - At last, i use objcopy to translate
'arch/$(ARCH)/boot/compressed/vmlinux' to
'arch/$(ARCH)/boot/zImage'

The head.S mainly does four jobs: clear bss section,
setup stack, call decompress_kernel() funcion and jump
to the entry point of
the decompressed kernel image. It has no problems.

When I download the 'zImage' into the target board,
and execute it (bootloader is ok). It print the
following messages:

-------------------------------------------------------------------------------------
Uncompressing
Linux.....................................................................................................................................
inbuf: 0x0000BA44
insize: 0x000724BF
inptr: 0x000724BF
output_ptr: 0x00410000
bytes_out: 0x00410000
                                                      
                                            
                                                      
                                            
ran out of input data
                                                      
                                            
 -- System halted
-------------------------------------------------------------------------------------

The following is the result of objdump to the
'arch/$(ARCH)/boot/compressed/vmlinux':

---------------------------------------------
0007df03 g       .text  00000000 input_data_end
0000ba44 g       .text  00000000 input_data
0000ba40 g       .text  00000000 input_len
---------------------------------------------

The file size of the
'arch/$(ARCH)/boot/compressed/vmlinux.bin.gz' is
468159 bytes:

-------------------------------------------------------------------
-rwxr-xr-x    1 root     root       468159  8 13 16:24
vmlinux.bin.gz
-------------------------------------------------------------------

So, &input_data_end[0] - &input_data[0] = 0x0007df03 -
0000ba44 = 468159. It is right!

The error message "ran out of input data" is due to
call to the function fill_inbuf(), which is defined in
misc.c file.
When things should be over, why gunzip() still calls
get_byte() ???

The following are the contents of the linker script
template file and misc.c source file:

--------------------------------------------------------------------
SECTIONS
{
	. = ZTEXTADDR;

	.text : {
		_stext = .;
		*(.start)
		*(.text)
		*(.fixup)
		*(.gnu.warning)
		*(.rodata)
		*(.rodata.*)
		. = ALIGN(8);
		input_len = .;
		LONG(input_data_end - input_data)
		input_data = .; 
		arch/$(ARCH)/boot/compressed/piggy.o(.data)
		input_data_end = .;
		. = ALIGN(4);
	}
	_etext = .;

	.data : { *(.data) }
	.got : { *(.got) *(.got.plt) }
	
	_edata = .;
	
	__bss_start = .;
	.bss	: { *(.bss) }
	_end = .;
}
--------------------------------------------------------------------

misc.c:

--------------------------------------------------------------------
#include <linux/config.h>
#include <asm/uaccess.h>

#include "./puts.c"

#define ZDEBUG

#ifdef ZDEBUG
#include "./vsprintf.c"
#endif

/*
 * Why do we do this? Don't ask me..
 *
 * Incomprehensible are the ways of bootloaders.
 */
void* memset(void* s, int c, size_t n)
{
	int i;
	char *ss = (char*)s;

	for (i=0; i<n; i++)
		ss[i] = c;
	return s;
}

void* memcpy(void* __dest, __const void* __src, size_t
__n)
{
	int i;
	char *d = (char *)__dest, *s = (char *)__src;

	for (i=0; i<__n; i++)
		d[i] = s[i];
	return __dest;
}

#define memzero(s, n)     memset((s), 0, (n))

/*
 * gzip delarations
 */
#define OF(args)  args
#define STATIC static

typedef unsigned char  uch;
typedef unsigned short ush;
typedef unsigned long  ulg;

#define WSIZE 0x8000		/* Window size must be at least
32k, */
				/* and a power of two */

static uch *inbuf;		/* input buffer */
static uch window[WSIZE];	/* Sliding window buffer */

static unsigned insize = 0;	/* valid bytes in inbuf */
static unsigned inptr = 0;	/* index of next byte to be
processed in inbuf */
static unsigned outcnt = 0;	/* bytes in output buffer
*/

/* gzip flag byte */
#define ASCII_FLAG   0x01 /* bit 0 set: file probably
ascii text */
#define CONTINUATION 0x02 /* bit 1 set: continuation
of multi-part gzip file */
#define EXTRA_FIELD  0x04 /* bit 2 set: extra field
present */
#define ORIG_NAME    0x08 /* bit 3 set: original file
name present */
#define COMMENT      0x10 /* bit 4 set: file comment
present */
#define ENCRYPTED    0x20 /* bit 5 set: file is
encrypted */
#define RESERVED     0xC0 /* bit 6,7:   reserved */

#define get_byte()  (inptr < insize ? inbuf[inptr++] :
fill_inbuf())

/* Diagnostic functions */
#ifdef DEBUG
#  define Assert(cond,msg) {if(!(cond)) error(msg);}
#  define Trace(x) fprintf x
#  define Tracev(x) {if (verbose) fprintf x ;}
#  define Tracevv(x) {if (verbose>1) fprintf x ;}
#  define Tracec(c,x) {if (verbose && (c)) fprintf x
;}
#  define Tracecv(c,x) {if (verbose>1 && (c)) fprintf
x ;}
#else
#  define Assert(cond,msg)
#  define Trace(x)
#  define Tracev(x)
#  define Tracevv(x)
#  define Tracec(c,x)
#  define Tracecv(c,x)
#endif

static int  fill_inbuf(void);
static void flush_window(void);
static void error(char *m);
static void gzip_mark(void **);
static void gzip_release(void **);

/* They are defined in the linker script file
'vmlinux.lds.in' */
extern char input_data[];
extern int input_len;
extern char input_data_end[];

static unsigned long bytes_out = 0;
static uch *output_data;
static unsigned long output_ptr = 0;

static void *malloc(int size);
static void free(void *where);
static void error(char *m);
static void gzip_mark(void **);
static void gzip_release(void **);

/* The variable '_end' is defined in the linker script
file 
 * linux/arch/frvnommu/boot/compressed/vmlinux.lds.in
 */
extern int _end;
static ulg free_mem_ptr;
static ulg free_mem_end_ptr;

#define HEAP_SIZE 0x10000

#include "../../../../lib/inflate.c"

static void *malloc(int size)
{
	void *p;

	if (size <0) error("Malloc error");
	if (free_mem_ptr <= 0) error("Memory error");

	free_mem_ptr = (free_mem_ptr + 3) & ~3;	/* Align */

	p = (void *)free_mem_ptr;
	free_mem_ptr += size;

	if (free_mem_ptr >= free_mem_end_ptr)
		error("Out of memory");
	
	return p;
}

static void free(void *where)
{
	/* Don't care: gzip_mark & gzip_release do the free
*/
}

static void gzip_mark(void **ptr)
{
	*ptr = (void *) free_mem_ptr;
}

static void gzip_release(void **ptr)
{
	free_mem_ptr = (long) *ptr;
}

/*
===========================================================================
 * Fill the input buffer. This is called only when the
buffer is empty
 * and at least one byte is really needed.
 */
int fill_inbuf(void)
{	
	if (insize != 0) {
		printf("\ninbuf: 0x%.8lX\n", (unsigned long)inbuf);
		printf("insize: 0x%.8lX\n", (unsigned long)insize);
		printf("inptr: 0x%.8lX\n", (unsigned long)inptr);
		printf("output_ptr: 0x%.8lX\n", (unsigned
long)output_ptr);
		printf("bytes_out: 0x%.8lX\n", (unsigned
long)bytes_out);
		error("ran out of input data");
	}
	
	inbuf = input_data;
	insize = &input_data_end[0] - &input_data[0];
	inptr = 1;
	return inbuf[0];
}

/*
===========================================================================
 * Write the output window window[0..outcnt-1] and
update crc and bytes_out.
 * (Used for the decompressed data only.)
 */
void flush_window(void)
{
	ulg c = crc;
	unsigned n;
	uch *in, *out, ch;

	in = window;
	out = &output_data[output_ptr];
	for (n = 0; n < outcnt; n++) {
		ch = *out++ = *in++;
		c = crc_32_tab[((int)c ^ ch) & 0xff] ^ (c >> 8);
	}
	crc = c;
	bytes_out += (ulg)outcnt;
	output_ptr += (ulg)outcnt;
	outcnt = 0;
	
	puts(".");
}

static void error(char *x)
{
	puts("\n\n");
	puts(x);
	puts("\n\n -- System halted");

	while(1);	/* Halt */
}

#define STACK_SIZE (4096)
long user_stack[STACK_SIZE]; /* 16KB stack */
long *stack_start = &user_stack[STACK_SIZE];

void decompress_kernel(void)
{
	output_data		= (uch *)TEXTADDR;
	free_mem_ptr 		= (long)&_end;
	free_mem_end_ptr	= free_mem_ptr + HEAP_SIZE;

	makecrc();
	puts("Uncompressing Linux...");
	gunzip();
	puts(" done, booting the kernel.\n");
}
--------------------------------------------------------------------

Find local movie times and trailers on Yahoo! Movies.
http://au.movies.yahoo.com
