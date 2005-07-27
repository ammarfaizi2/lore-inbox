Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262491AbVG0Sw6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262491AbVG0Sw6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Jul 2005 14:52:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261688AbVG0SsF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Jul 2005 14:48:05 -0400
Received: from agf.customers.acn.gr ([213.5.17.156]:60384 "EHLO
	enigma.wired-net.gr") by vger.kernel.org with ESMTP id S261342AbVG0Sr2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Jul 2005 14:47:28 -0400
Message-ID: <57497.62.1.12.61.1122490407.squirrel@webmail.wired-net.gr>
In-Reply-To: <17127.14026.575904.182205@cerise.gclements.plus.com>
References: <Pine.LNX.4.61.0507250842380.3913@praktifix.dwd.de>
    <17125.51475.763052.283552@cerise.gclements.plus.com>
    <Pine.LNX.4.61.0507260638110.22613@praktifix.dwd.de>
    <40710.62.1.10.61.1122396787.squirrel@webmail.wired-net.gr>
    <17127.14026.575904.182205@cerise.gclements.plus.com>
Date: Wed, 27 Jul 2005 21:53:27 +0300 (EEST)
Subject: Re: superblock & inode's
From: "Nanakos Chrysostomos" <nanakos@wired-net.gr>
To: "Glynn Clements" <glynn@gclements.plus.com>
Cc: nanakos@wired-net.gr, linux-c-programming@vger.kernel.org
Reply-To: nanakos@wired-net.gr
User-Agent: SquirrelMail/1.4.4-rc1
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I looked the sources and the programs use the libext2fs library.I found it
in the sources but it is loss of time reading it just to understand and
retrieve some simple things.So i finally did this below,but i am stack
only in one thing.How to parse the information for a data block that
contains the info for the dir's & files , e.g / directory.Please check the
code below.
The data block allocates 8 blocks ( in my machine 4096 bytes ),the data
are struct ext2_dir_entry_2 structures.But the name lenght isn't always
the same so i cant parse it just knowing the sizeof the structure.Maybe an
iteration with llseek will help.Can someone help me with this algorithm???
Have you got sth to propose????


#include <ext2fs/ext2_fs.h>
#include <fcntl.h>
#include <math.h>


int main()
{
	int fd,of;
	char buf[8*4096];
	int count=0;
	struct ext2_super_block s;
	struct ext2_group_desc g;
	struct ext2_inode i;
	struct ext2_dir_entry_2 dir;
	int block_size,is=0,dir_entry_size;

	fd = open("/dev/hdb2",O_RDONLY);

	lseek(fd,1024L,0);

	read(fd,&s,sizeof(s));

	printf("%d inodes (%d free)\n",s.s_inodes_count,s.s_free_inodes_count);
	printf("%d blocks (%d free)\n",s.s_blocks_count,s.s_free_blocks_count);


	block_size = s.s_log_block_size;

	block_size = pow(2,block_size)*1024;

	printf("Block size: %d\n",block_size);

	printf("Volume name: %s\n",s.s_volume_name);
	printf("Inode size : %d\n",s.s_inode_size);


	lseek(fd,4096L,0);

	read(fd,&g,sizeof(g));

	printf("Inodes Table Block:%d\n",g.bg_inode_table);


	lseek(fd,4*4096L+128L,0); /*inode 2 */

	read(fd,&i,sizeof(i));


	printf("Pointer to data block:%d\n",i.i_block[0]);
	printf("Data blocks occupied:%d\n",i.i_blocks);


	dir_entry_size = sizeof(dir);

	printf("%d\n",dir_entry_size);

	/* Read data block and retrieve directory & file information */
	lseek(fd,i.i_block[0]*4096L,0);
	is += read(fd,&dir,12);
	printf("name:%s inode:%d name_len:%d rec_len:%d
file_type:%d\n",dir.name,dir.inode,dir.name_len,dir.rec_len,dir.file_type);


	is += read(fd,&dir,19);
	printf("name:%s inode:%d name_len:%d rec_len:%d
file_type:%d\n",dir.name,dir.inode,dir.name_len,dir.rec_len,dir.file_type);

	is += read(fd,&dir,12);
	printf("name:%s inode:%d name_len:%d rec_len:%d
file_type:%d\n",dir.name,dir.inode,dir.name_len,dir.rec_len,dir.file_type);

	close(fd);

	return 0;
}

