Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261689AbUCVR6Z (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Mar 2004 12:58:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261707AbUCVR6Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Mar 2004 12:58:25 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.106]:30870 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261689AbUCVR6R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Mar 2004 12:58:17 -0500
Date: Mon, 22 Mar 2004 09:58:07 -0800
From: Russ Weight <rweight@us.ibm.com>
To: linux-kernel@vger.kernel.org
Subject: Disassemble vmlinuz (i386)
Message-ID: <20040322175807.GA22404@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

	Admittedly, you would have to be pretty desparate to want
to disassemble vmlinuz... but I was... and I did.  There may
be other (better?) ways to do this, but since I didn't find
a complete recipe for this in my web searches, I'll post what
I did in case it might be helpful to others.

	Note that this was done on a 2.4.9 kernel.

- Russ


The short version:
==================
(1) Strip the header and decompress the kernel
(2) Write a small C program to copy the decompressed kernel
    into a shared memory segment.
(3) Run the C program under gdb - stop at a breakpoint after the
    copy and then use the gdb "disassemble" command to disassemble
	the kernel from shared memory.
(4) Clean up the addresses. If you pick a good virtual address
    for the shared memory segment, then the cleanup can be a fairly
	simple search & replace.

The details:
============

(1) Strip the header and decompress the kernel

I found the information I needed from emails posted by Randy Dunlap
regarding his CONFIG_save_kernel_config_in_kernel_image patch.

These are the steps I took:

- Search for the offset to the gzip magic number in vmlinuz

  od -A d -t x1 vmlinuz | grep '1f 8b 08 00'

  In my case I get the following:

  0019296 40 db 20 00 18 00 00 00 42 e1 0f 00 1f 8b 08 00
                                              ^^^^^^^^^^^

  The offset (decimal 19296) needs to be adjusted to the actual
  offset for the gzip header. In this case it is 19308.


- Decompress the kernel

  dd if=vmlinuz bs=1 skip=19308 | zcat > vmlinux

(2) Note that there is no elf header on the resulting file, so it
    cannot be disassembled directly.  I wrote a program to copy
    the kernel into a shared memory segment.  The code I used is
    appended to the bottom of this email.

(3) Execute the program under gdb and disassemble the kernel:

# gdb loadfile
GNU gdb Red Hat Linux (5.3.90-0.20030710.40.2.1rh)
Copyright 2003 Free Software Foundation, Inc.
GDB is free software, covered by the GNU General Public License, and you are
welcome to change it and/or distribute copies of it under certain conditions.
Type "show copying" to see the conditions.
There is absolutely no warranty for GDB.  Type "show warranty" for details.
This GDB was configured as "i386-redhat-linux"...Using host libthread_db library "/lib/libthread_db.so.1".

(gdb) break debug
Breakpoint 1 at 0x8048753
(gdb) run vmlinux
Starting program: /home/rweight/disassemble/loadfile vmlinux
File size is 2454432 bytes
Shared memory attached at shmaddr: 0x41100000
Wrote 2454432 bytes

Breakpoint 1, 0x08048753 in debug ()
(gdb) set pagination off
(gdb) set logging on
Copying output to gdb.txt.
(gdb) disassemble 0x41100000 0x41100000+2454432
.
. The disassembly will flow to the output as well as the log file
.
End of assembler dump.
(gdb) set logging off
Done logging to gdb.txt.
(gdb) continue
Continuing.

Program exited normally.
(gdb) quit
# 

The dissassembly is contained in gdb.txt


(4) I was able to specify 0x41100000 as the virtual address for the shared
    memory attachment. I then used an editor to fix up the addresses:
 	0x411XXXXX -> 0xc01XXXXX

---------------------------------------------------------------------------
C code for copying kernel text into share memory for disassembly
---------------------------------------------------------------------------
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <sys/ipc.h>
#include <sys/shm.h>
#include <stdio.h>

#define SHM_RD  0400
#define SHM_WR  0200
#define SHM_RW  SHM_RD | SHM_WR
#define NULL    0

int
debug()
{
    return 0;
}

void
usage(const char *name)
{
    fprintf(stderr, "%s <FILENAME>\n", name);
}

void
exit_on_error(const char *function)
{
    perror(function);
    exit(-1);
}

main (int argc, char **argv)
{
    key_t ipckey;
    int shmid;
    char *shmaddr, *filename;
    int fd;
    ssize_t size;
    struct stat filestat;

    if (argc != 2) {
        usage(argv[0]);
        exit(-1);
    }
    filename = argv[1];

    if (stat(filename, &filestat) == -1)
        exit_on_error("stat");

    size = filestat.st_size;
    printf("File size is %d bytes\n", size);

    if ((fd = open(filename, O_RDONLY)) == -1)
        exit_on_error("open");

    if ((ipckey = ftok(filename, 'b')) == (key_t)-1)
        exit_on_error("ftok");

    if ((shmid = shmget(ipckey, size, IPC_CREAT | IPC_EXCL | SHM_RW)) == -1)
        exit_on_error("shmget");

    if ((shmaddr = (char *)shmat(shmid, (void *)0x41100000, 0)) == (char *)-1)
        exit_on_error("shmat");

    printf("Shared memory attached at shmaddr: %p\n", shmaddr);

    /*
     * Read the entire file into the shared memory segment
     */
    if ((size = read(fd, shmaddr, size)) == (size_t)-1)
        exit_on_error("read");

    close(fd);

    printf("Wrote %d bytes\n", size);

#if 0
    /*
     * Print the first few bytes for visual comparison with od output.
     */
    {
        int i, j;
        unsigned char *p = shmaddr;
        for (i = 0; i < 5; i++) {
            for (j = 0; j < 16; j++) {
                printf("%02x ", *p++);
            }
            printf("\n");
        }
    }
    fflush(stdout);
#endif
    (void) debug();

    if (shmdt(shmaddr) == -1)
        exit_on_error("shmdt");

    if (shmctl(shmid, IPC_RMID, NULL) == -1)
        exit_on_error("shmctl");

    exit(0);
}
---------------------------------------------------------------------------
