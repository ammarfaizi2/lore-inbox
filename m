Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261645AbTIYAuy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Sep 2003 20:50:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261646AbTIYAuy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Sep 2003 20:50:54 -0400
Received: from ns1.triode.net.au ([202.147.124.1]:35538 "EHLO
	iggy.triode.net.au") by vger.kernel.org with ESMTP id S261645AbTIYAuu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Sep 2003 20:50:50 -0400
Message-ID: <3F723A04.2000609@torque.net>
Date: Thu, 25 Sep 2003 10:42:44 +1000
From: Douglas Gilbert <dougg@torque.net>
Reply-To: dougg@torque.net
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en, es-es, es
MIME-Version: 1.0
To: Andries.Brouwer@cwi.nl
CC: linux-kernel@vger.kernel.org
Subject: Re: rfc: test whether a device has a partition table
References: <UTC200309242029.h8OKTo008219.aeb@smtp.cwi.nl>
In-Reply-To: <UTC200309242029.h8OKTo008219.aeb@smtp.cwi.nl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andries.Brouwer@cwi.nl wrote:
> As everyone knows it is a bad idea to let the kernel guess
> whether there is a partition table on a given block device,
> and if so, of what type.
> Nevertheless this is what almost everybody does.
> 
> Until now the philosophy was: floppies do not have a partition table,
> disks do have one, and for ZIP drives nobody knows. With USB we get
> more types of block device that may or may not have a partition table
> (and if they have none, usually there is a FAT filesystem with bootsector).
> In such cases the kernel assumes a partition table, and creates a mess
> if there was none. Some heuristics are needed.
> 
> Many checks are possible (for a DOS-type partition table: boot indicator
> must be 0 or 0x80, partitions are not larger than the disk,
> non-extended partitions are mutually disjoint; for a boot sector:
> it starts with a jump, the number of bytes per sector is 512 or
> at least a power of two, the number of sectors per cluster is 1
> or at least a power of two, the number of reserved sectors is 1 or 32,
> the number of FAT copies is 2, ...).
> 
> I tried a minimal test, and the below is good enough for the
> boot sectors and DOS-type partition tables that I have here.
> 
> So, question: are there people with DOS-type partition tables
> or FAT fs bootsectors where the below gives the wrong answer?
> I would be interested in a copy of the sector.
> 
> I expect to submit some sanity check to DOS-type partition table
> parsing, and hope to recognize with high probability the presence
> of a full disk FAT filesystem.
> 
> Andries
> 
> ------------ sniffsect.c -----------------
> 
> /*
>  * Given a block device, does it have a DOS-type partition table?
>  * Or does it behave like a floppy and have a whole-disk filesystem?
>  * Or is it something else?
>  *
>  * Return 1 for pt, -1 for boot sect, 0 for unknown.
>  */
> 
> #include <stdio.h>
> #include <fcntl.h>
> 
> /* DOS-type partition */
> struct partition {
> 	unsigned char bootable;             /* 0 or 0x80 */
> 	unsigned char begin_chs[3];
> 	unsigned char systype;
> 	unsigned char end_chs[3];
> 	unsigned char start_sect[4];
> 	unsigned char nr_sects[4];
> };
> 
> int sniffsect(unsigned char *p) {
> 	struct partition *pt;
> 	int i, n;
> 	int maybept = 1;
> 	int maybebs = 1;
> 
> 	/* Both DOS-type pt and boot sector have a 55 aa signature */
> 	if (p[510] != 0x55 || p[511] != 0xaa)
> 		return 0;
> 
> 	/* A partition table has boot indicators 0 or 0x80 */
> 	for (i=0; i<4; i++) {
> 		pt = (struct partition *)(p + 446 + 16*i);
> 		if (pt->bootable != 0 && pt->bootable != 0x80)
> 			maybept = 0;
> 	}
> 
> 	/* A boot sector has a power of two as #sectors/cluster */
> 	n = p[13];
> 	if (n == 0 || (n & (n-1)) != 0)
> 		maybebs = 0;
> 
> 	/* A boot sector has a power of two as #bytes/sector */
> 	n = (p[12] << 8) + p[11];
> 	if (n == 0 || (n & (n-1)) != 0)
> 		maybebs = 0;
> 
> 	return maybept - maybebs;
> }
> 
> int main(int argc, char **argv) {
> 	unsigned char sect[512];
> 	int fd, n;
> 
> 	if (argc != 2) {
> 		fprintf(stderr, "Call: sniffsect file\n");
> 		exit(1);
> 	}
> 
> 	fd = open(argv[1], O_RDONLY);
> 	if (fd == -1) {
> 		perror(argv[1]);
> 		fprintf(stderr, "Cannot open %s\n", argv[1]);
> 		exit(1);
> 	}
> 
> 	n = read(fd, sect, sizeof(sect));
> 	if (n != sizeof(sect)) {
> 		if (n == -1)
> 			perror(argv[1]);
> 		fprintf(stderr, "Cannot read 512 bytes from %s\n", argv[1]);
> 		exit(1);
> 	}
> 
> 	n = sniffsect(sect);
> 	printf((n == 1) ? "partition table\n" :
> 	       (n == -1) ? "boot sector\n" : "no idea\n");
> 	return 0;
> }
> 

I have a USB 500 MB USB key that confuses linux (both 2.4 and
2.6) since it has no partition table. It shows up on my laptop as:

$ cat /proc/scsi/scsi
Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
   Vendor: Prolific Model: USBFlashDisk     Rev: 1.00
   Type:   Direct-Access                    ANSI SCSI revision: 02

I can mount it with:
$ mount /dev/sda /mnt/extra
$ df
Filesystem           1K-blocks      Used Available Use% Mounted on
/dev/hda3             14108400   9458612   3933100  71% /
none                    192256         0    192256   0% /dev/shm
/dev/sda                511856    103328    408528  21% /mnt/extra

sniffsect correctly identifies the difference between the USB
"floppy" and my main disk:
$ ./sniffsect /dev/sda
boot sector
$ ./sniffsect /dev/hda
partition table

Doug Gilbert


