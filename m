Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129219AbQKXC2W>; Thu, 23 Nov 2000 21:28:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129255AbQKXC2M>; Thu, 23 Nov 2000 21:28:12 -0500
Received: from hera.cwi.nl ([192.16.191.1]:41691 "EHLO hera.cwi.nl")
        by vger.kernel.org with ESMTP id <S129219AbQKXC16>;
        Thu, 23 Nov 2000 21:27:58 -0500
Date: Fri, 24 Nov 2000 02:57:45 +0100 (MET)
From: Andries.Brouwer@cwi.nl
Message-Id: <UTC200011240157.CAA140709.aeb@aak.cwi.nl>
To: alan@lxorguk.ukuu.org.uk, bernds@redhat.com, linux-kernel@vger.kernel.org,
        torvalds@transmeta.com
Subject: gcc 2.95.2 is buggy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yesterday night I wrote

> Note: this is not yet a confirmed compiler bug

but in the meantime there is good confirmation.
This really is a bug in gcc 2.95.2.

>From bernds@redhat.com Thu Nov 23 10:45:07 2000
> Please, could you send me ...

>From torvalds@transmeta.com Thu Nov 23 18:00:48 2000
> Can we get a show of hands?

Below a demo program.

Andries

-------------------- bug.c -----------------------------
/*
 * bug.c - aeb, 001124
 *
 * This program shows a bug in gcc 2.95.2.
 * It should print 0x0 and exit.
 * For me it prints 0x84800000.
 *
 * Compile with:
 *    gcc -Wall -O2 -o bug bug.c
 */
#include <stdio.h>

struct inode {
	long long		i_size;
	struct super_block	*i_sb;
};

struct file {
	long long		f_pos;
};

struct super_block {
	int			s_blocksize;
	unsigned char		s_blocksize_bits;
	int			s_hs;
};

static char *
isofs_bread(unsigned int block)
{
	printf("0x%x\n", block);
	exit(0);
}

static int
do_isofs_readdir(struct inode *inode, struct file *filp)
{
	int bufsize = inode->i_sb->s_blocksize;
	unsigned char bufbits = inode->i_sb->s_blocksize_bits;
	unsigned int block, offset;
	char *bh = NULL;
	int hs;

 	if (filp->f_pos >= inode->i_size)
		return 0;
 
	offset = filp->f_pos & (bufsize - 1);
	block = filp->f_pos >> bufbits;
	hs = inode->i_sb->s_hs;

	while (filp->f_pos < inode->i_size) {
		if (!bh)
			bh = isofs_bread(block);

		hs += block << bufbits;

		if (hs == 0)
			filp->f_pos++;

		if (offset >= bufsize)
			offset &= bufsize - 1;

		if (*bh)
			filp->f_pos++;

		filp->f_pos++;
	}
	return 0;
}

struct super_block s;
struct inode i;
struct file f;

int
main(int argc, char **argv){
	s.s_blocksize = 512;
	s.s_blocksize_bits = 9;
	i.i_size = 2048;
	i.i_sb = &s;
	f.f_pos = 0;

	do_isofs_readdir(&i,&f);
	return 0;
}
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
