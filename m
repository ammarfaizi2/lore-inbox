Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261456AbSIWViF>; Mon, 23 Sep 2002 17:38:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261404AbSIWVhj>; Mon, 23 Sep 2002 17:37:39 -0400
Received: from air-2.osdl.org ([65.172.181.6]:57618 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S261456AbSIWVga>;
	Mon, 23 Sep 2002 17:36:30 -0400
Date: Mon, 23 Sep 2002 14:41:44 -0700
From: Dave Olien <dmo@osdl.org>
To: Daniel Phillips <phillips@arcor.de>
Cc: axboe@suse.de, _deepfire@mail.ru, linux-kernel@vger.kernel.org
Subject: Re: DAC960 in 2.5.38, with new changes
Message-ID: <20020923144144.A15852@acpi.pdx.osdl.net>
References: <20020923120400.A15452@acpi.pdx.osdl.net> <E17tZyv-0003be-00@starship>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <E17tZyv-0003be-00@starship>; from phillips@arcor.de on Mon, Sep 23, 2002 at 10:39:00PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, Sep 23, 2002 at 10:39:00PM +0200, Daniel Phillips wrote:
> 
> Applied, booted, up and running.  I'll attempt to follow your work -
> you are clearly way out in front of everybody in understanding this
> driver.
> 
> Minor whitespace suggestion: don't worry too much about breaking up
> lines to fit in 80 columns.  It's nice where it works, but where it
> just makes more lines, don't bother.  We are going to go do spelling
> patches to shorten a lot of those names anyway.

thanks.
I'd been wondering whether there was a guidline for this.
I'll relax my 80 column constraints.

> 
> What test do you use to determine that some blocks are incorrectly
> written?

I wrote something really simple.  The amazing thing was that it
turned up a problem relatively quickly, just running one instance
of the programs at a time.  i.e. no parallelism. 
I haven't walked through this code yet. But, I've noticed several
pdflush kernel daemons running on my 8-way system.  So, I'm guessing
IF there ARE any SMP races (I'm not claiming that there ARE any races),
these daemons could possibly uncover them even though I'm running only once
instance of the reader/writer applcations.

I'll include the test programs source code at the bottom of the mail.
It's just a pair of C programs.  The first one writes a unique
pattern (a device id, a block number, and a "sequence number") at the
beginning of each 512-byte block.  The second one reads the blocks
back, checking the pattern.

I'm going to play with Iozone later this week.

> 
> I think you're right.  It's hard to imagine why it would be good to
> optimize the module unload/reload case for DAC, and if there is a
> correctness argument, I personally would rather find out about it the
> hard way than never know it.

..... stuff deleted..

> 
> Hopefully somebody with one of those will jump into the thread.  Where
> in the mass of DAC init output do we look for the controller type?
> 
> -- 
> Daniel

I think that's a good approach.  Hopefully people with more device
types will apprear as we get closer to completion.

The way to identify the type of controller is to read the current_status
file in the /proc/rd/c0 directory.

cd /dev/rd/c0; less current_status

The first lines of My current_status file reads:

***** DAC960 RAID Driver Version 2.4.11 of 11 October 2001 *****
Copyright 1998-2001 by Leonard N. Zubkoff <lnz@dandelion.com>
Configuring Mylex eXtremeRAID 2000 PCI RAID Controller
  Firmware Version: 7.00-03, Channels: 4, Memory Size: 64MB
  PCI Bus: 11, Device: 8, Function: 0, I/O Address: Unassigned
  PCI Address: 0xFC000000 mapped at 0xF8800000, IRQ Channel: 24
  Controller Queue Depth: 512, Maximum Blocks per Command: 2048
  Driver Queue Depth: 511, Scatter/Gather Limit: 128 of 257 Segments
  Physical Devices:


>From the first line, it looks like we should change the Version
number and date of the driver. It Might be useful during testing.
Maybe change version number to 2.5.??, and the date to the date
of the latest patch applied.

On the third line, "eXtremeRAID 2000", can be mapped to the internal
device types by looking in DAC960.h, looking at the lines:

/*
  Define the DAC960 Controller Hardware Types.
*/

typedef enum
{
  DAC960_BA_Controller =                        1,      /* eXtremeRAID 2000 */
  DAC960_LP_Controller =                        2,      /* AcceleRAID 352 */
  DAC960_LA_Controller =                        3,      /* DAC1164P */
  DAC960_PG_Controller =                        4,      /* DAC960PTL/PJ/PG */
  DAC960_PD_Controller =                        5,      /* DAC960PU/PD/PL/P */
  DAC960_P_Controller =                         6       /* DAC960PU/PD/PL/P */
}
DAC960_HardwareType_T;

So my controller uses all the DAC960_BA_*, or DAC960_V2 routines.

The controller types DAC960_BA_Controller, and DAC960_LP_Controller
are both V2 type controllers.  The others are type V1 controllers.

Here's the two test programs I ran to uncover the data problem I had last
week. (They're embarassingly simple).  Both programs take three
arguments:

	pathname to a partition to write, and then read.
	a "device id" that uniquely identifies that partition
	a "sequence number" that uniquely identifies the a partitular
		invocation of the program.  

	So for example, I ran the programs in pairs:

	wpath /dev/rd/c0d0p1 1010 1001; cpath /dev/rd/c0d0p1 1010 1001

	The next time I ran the pair of programs on the same partition,
	I'd change the "sequence number" argument to distinguish blocks
	written previously, from blocks being newly written.

	These programs write only a small amount of the partition.
	But, this was enough to uncover a problem with 2.5.34.  But,
	the problem rarely appeared at the beginning of the partition.  

Another thing I do is run mke2fs and e2fsck on the partitions.
The latest thing I tried successfully was to run mke2fs on all partitions
on all logical devices in parallel.  So, there were 16 mke2fs programs
running in parallel.  Then, run 16 e2fsck in parallel.  On 2.5.38, the
e2fsck's all run successfully. Use the -f flag to force
checking on clean file systems. 


--------------------------write pattern---------------------------------------


#include <sys/types.h>
#include <stdlib.h>
#include <fcntl.h>

char *dev_path;
int dev_id;
int seq_no;
int fd;

struct block_record {
	int	disk_id;
	int	block_no;
	int	sequence_no;
	int	pad;
};

#define BLK_SIZE	512
#define NBLKS_PER_BUF	1024
#define BUF_SIZE (BLK_SIZE*NBLKS_PER_BUF)
#define BUF_ALIGN	4096
#define NUM_BUFS	1024

void *io_buf;
int  block_no;


fill_buffer()
{
	int i;
	void *bufp;
	struct block_record *brp;

	for (i = 0, bufp = io_buf; i < NBLKS_PER_BUF; i++) {
		brp = (struct block_record *)bufp;
        	brp->disk_id =  dev_id;
        	brp->block_no = block_no;
        	brp->sequence_no = seq_no;
		bufp += BLK_SIZE;
		block_no++;
	}
}

int
write_buffer()
{
	ssize_t wsize;

	wsize = write(fd, io_buf, BUF_SIZE);

	if (wsize < 0) {
		perror("write error");
		return -1;
	}

	if (wsize < BUF_SIZE)
		printf("last size written\n", wsize);

	return 0;
}


write_file()
{
	int i;

	for (i = 0; i < NUM_BUFS; i++) {
		fill_buffer();
		if (write_buffer())
			break;
	}
}

main(int argc, char **argv)
{

	dev_path = argv[1];
	dev_id = atoi(argv[2]);
	seq_no = atoi(argv[3]);

	printf("path %s id %d seq %d\n", dev_path, dev_id, seq_no);

	if ((fd  = open(dev_path, O_RDWR)) <= 0) {
		perror("open failed");
		exit(-1);
	}

	if (posix_memalign(&io_buf, BUF_ALIGN, BUF_SIZE)) {
		perror("buffer alloc failed");
		exit(-1);
	}

	write_file();
	exit(0);
}


------------ check pattern -----------------------------------------------

#include <sys/types.h>
#include <stdlib.h>
#include <fcntl.h>

char *dev_path;
int dev_id;
int seq_no;
int fd;

struct block_record {
	int	disk_id;
	int	block_no;
	int	sequence_no;
	int	pad;
};

#define BLK_SIZE	512
#define NBLKS_PER_BUF	1024
#define BUF_SIZE (BLK_SIZE*NBLKS_PER_BUF)
#define BUF_ALIGN	4096
#define ERR_LIMIT	500
#define NUM_BUFS        1024

void *io_buf;
int  block_no;
int err_cnt;

print_diff(int block_no, struct block_record *brp)
{
	printf("disk_id %d block_no %d sequence_no %d\n",
		brp->disk_id, brp->block_no, brp->sequence_no);
}

int err_flipflop = 0;

check_buffer(ssize_t rsize)
{
	int i;
	void *bufp;
	struct block_record *brp;

	printf("begin new buffer at block_no %d\n", block_no);

	for (i = 0, bufp = io_buf; i < NBLKS_PER_BUF; i++) {
		brp = (struct block_record *)bufp;
        	if ((brp->disk_id !=  dev_id) ||
        		(brp->block_no != block_no) ||
        		(brp->sequence_no != seq_no)) {
			/*
			 * Mismatch!  Print the error ONLY
			 * if the previous buffer was NOT
			 * a mismatch.
			 */
			if (err_flipflop == 0) {
				err_flipflop = 1;
				printf("difference in block_no %d\n", block_no);
				print_diff(block_no, brp);
				err_cnt++;
				if (err_cnt > ERR_LIMIT) {
					printf("err limit reached\n");
					exit(-1);
				}
			}
		} else if (err_flipflop == 1) {
				/*
				 * We have a match, and the
				 * Previous  block was a Mis-match.
				 */
				printf("Matching in block_no %d\n", block_no);
				print_diff(block_no, brp);
				err_flipflop = 0;
		}
		bufp += BLK_SIZE;
		block_no++;
		if (bufp - io_buf > rsize) {
			printf("early check end\n");
			break;
		}
	}
}

ssize_t
read_buffer()
{
	ssize_t rsize;

	rsize = read(fd, io_buf, BUF_SIZE);

	if (rsize < 0) {
		perror("rrite error");
		return -1;
	}

	if (rsize < BUF_SIZE)
		printf("last size read\n", rsize);

	return rsize;
}


read_file()
{
	ssize_t rsize;
	int i;

	for (i = 0; i < NUM_BUFS; i++) {
		rsize = read_buffer();
		check_buffer(rsize);
	}
}

main(int argc, char **argv)
{

	dev_path = argv[1];
	dev_id = atoi(argv[2]);
	seq_no = atoi(argv[3]);

	printf("path %s id %d seq %d\n", dev_path, dev_id, seq_no);

	if ((fd  = open(dev_path, O_RDWR)) < 0) {
		perror("open failed");
		exit(-1);
	}

	if (posix_memalign(&io_buf, BUF_ALIGN, BUF_SIZE)) {
		perror("buffer alloc failed");
		exit(-1);
	}

	read_file();
	exit(0);
}
