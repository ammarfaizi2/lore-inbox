Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265844AbUFIQ4X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265844AbUFIQ4X (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jun 2004 12:56:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265852AbUFIQ4W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jun 2004 12:56:22 -0400
Received: from thumper2.emsphone.com ([199.67.51.102]:48774 "EHLO
	thumper2.allantgroup.com") by vger.kernel.org with ESMTP
	id S265844AbUFIQzb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jun 2004 12:55:31 -0400
Date: Wed, 9 Jun 2004 11:54:42 -0500
From: Andy <genanr@emsphone.com>
To: linux-kernel@vger.kernel.org
Cc: cattelan@sgi.com, linux-xfs@oss.sgi.com, nathans@sgi.com,
       ctierney@hpti.com
Subject: XFS over NFS corruption
Message-ID: <20040609165442.GA9569@thumper2>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Kj7319i9nmIyA2yE"
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Kj7319i9nmIyA2yE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

I thought I had seen the bug even writing to an non-XFS nfs server, but I
can't absolutely confirm this at the time (I was not doing the testing at the
time, and some of the result may not have been accurate)

But, the description of bug #198 on the XFS bugzilla, does sound like what I
am seeing.  

What I do in my tests is take a file of offsets (every group of 4 bytes
contains the offset of the 1st byte of the group) and copy that file to an
nfs mounted volume and then compare the local copy to the remote copy
(copying to several systems, each server is also receiving from several
systems).  After a while I will see errors in the compare, data appearing at
the wrong offset in the file.  The amount of data is small (<64k), always an
8k boundary at a large offset discrepancy (100's of megs).  I've attached
the mkoffsetfile.c and cmpoffsets.c programs used for testing.

Sample of cmpoffsets output :

431128576-431161343 (32768) (held data from 738426880-738459647)
 starts at a 65536-byte block
 ends at a 524288-byte block

Hope this helps.

Andy

--Kj7319i9nmIyA2yE
Content-Type: text/x-csrc; charset=us-ascii
Content-Disposition: attachment; filename="mkoffsetfile.c"

#include <stdio.h>
#include <netinet/in.h>

int main(void)
{
	unsigned int i;
	unsigned int o;
	FILE *out = fopen("offsets","w");
	for (i = 0;i<1536*1024*1024; i+=4)
	{
		o = htonl(i);
		fwrite(&o,1,4,out);
	}
	return 0;
}

--Kj7319i9nmIyA2yE
Content-Type: text/x-csrc; charset=us-ascii
Content-Disposition: attachment; filename="cmpoffsets.c"

#if 0 /* Magic self-executing C source code.  Run "sh cmpoffsets.c"   -dnelson
set -ex
gcc -g -Wall -O2 -march=i686 $0 -o cmpoffsets
exit 0
*/
#endif


#include <stdio.h>
#include <netinet/in.h>
#include <stdlib.h>

unsigned int boundarycheck(unsigned int number);

int main(int argc, char **argv)
{
	unsigned int i;
	FILE *in;
	int tosmall = 0;
	unsigned int firstbad = -1, lastbad = -1;
	unsigned int firstbadoff = 0, lastbadoff = 0;
	int failed = 0;

	if (argc != 2)
	{
		printf("Usage: cmpoffsets file.copy\n");
		exit(1);
	}
	in = fopen(argv[1], "rb");
	if (!in)
	{
		perror("cannot open file");
		exit(1);
	}
	setvbuf(in, malloc(65536), _IOFBF, 65536);

	for (i = 0; i < 1536 * 1024 * 1024 && !tosmall; i += 4)
	{
		unsigned int o;

		if (fread(&o, 4, 1, in) != 1)
		{
			o = htonl(i);
			tosmall = 1;
		}
		o = ntohl(o);
		if (o != i)
		{
			failed = 1;
			if (lastbad != i - 4)
			{
				firstbad = i;
				firstbadoff = o;
			}
			lastbad = i;
			lastbadoff = o;
		} else
		{
			if (lastbad == i - 4)
			{
				if (firstbad == lastbad)
				{	/* range of one */
					printf("%u (4) (held data from %u)\n", firstbad, firstbadoff);
				} else
				{	/* range > 1 */
					printf("%u-%u (%u) (held data from %u-%u)\n", firstbad, lastbad + 3,
					       lastbad + 4 - firstbad,
					       firstbadoff, lastbadoff + 3);
					if (boundarycheck(firstbadoff) > 2048)
						printf(" starts at a %u-byte block\n", boundarycheck(firstbadoff));
					if (boundarycheck(lastbadoff + 4) > 2048)
						printf(" ends at a %u-byte block\n", boundarycheck(lastbadoff + 4));
				}

				firstbad = lastbad = -1;
			}
		}
	}
	if (tosmall)
	{
		printf("file is truncated\n");
		failed = 1;
	}
	return failed;
}

unsigned int boundarycheck(unsigned int number)
{
	long long block = 1;
	while (block < number)
	{
		block *= 2;
		if (number / block * block != number)
			break;
	}
	return block;
}

--Kj7319i9nmIyA2yE--
