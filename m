Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S273031AbTHFLIL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 07:08:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274996AbTHFLIL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 07:08:11 -0400
Received: from angband.namesys.com ([212.16.7.85]:22699 "EHLO
	angband.namesys.com") by vger.kernel.org with ESMTP id S273031AbTHFLIG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 07:08:06 -0400
Date: Wed, 6 Aug 2003 15:08:05 +0400
From: Oleg Drokin <green@namesys.com>
To: linux-kernel@vger.kernel.org
Subject: Spurious -EIO when reading a file being written with O_DIRECT?
Message-ID: <20030806110805.GG14457@namesys.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="bg08WKrSYDhXBjb5"
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--bg08WKrSYDhXBjb5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello!

   We were reported a problem where if a file being written in directio mode
   and being read at the same time (in "normal/buffered" mode), then reading
   process gets -EIO when near the end of file.

   Initially I thought this is reiserfs-only problemm and digged in that
   direction, but then it turned out reiserfs does everything correctly
   and the VFS itself seems to be racey (my current suspiction is directio
   process uses get_block() that extends the file <schedule> reading process
   gets the buffer and submits io, then waits for page to become uptodate
   <schedule> direct io process unmaps buffer's metadata
   As a result - that page never becomes uptodate and we get -EIO from do_generic_file_read. )
   If I take i_sem around call to do_generic_file_read in generic_file_read (in 2.4.21-pre10),
   that of course helps (this is of course not a correct fix, but just a demonstration
   that some VFS race is in place).
   The same problem can be observed on ext2 in both 2.4.21-pre10 and in 2.6.0-test2
   Attached is test_directio.c program, compile it and run with some filename as argument,
   immediately start "tail" with same filename and you'd get almost immediate
   I/O error from tail on 2.4 and you'd get same I/O error in 2.6 only after some more waiting.

   Is this something known and expected (or may be somebody have a fix already? ;) )?

Bye,
    Oleg

--bg08WKrSYDhXBjb5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="test_directio.c"

#include <stdio.h>
#include <fcntl.h>
#include <stdint.h>

#define  BLOCK_SIZE (4096) 

#warning ARCH DEPENDENT fixup for your arch
#define O_DIRECT 040000 // ARCH DEPENDENT fixup for your arch */

static char buf[128 * BLOCK_SIZE];


int main(int argc, char** argv)
{
	int fd;
	char* aligned_buf = (char*)(( (uintptr_t)&buf + (BLOCK_SIZE-1)) & ~(BLOCK_SIZE-1));
	int aligned_size = sizeof(buf) - BLOCK_SIZE;
	
	
	if (-1 == ( fd = open (argv[1], O_RDWR | O_CREAT | O_DIRECT))) {
		perror("open: ");
		return 1;
	}
	
	while (1) {
		if( aligned_size!=write(fd, aligned_buf, aligned_size)) {
			perror("write: ");
			return 1;
		}
	}
}

--bg08WKrSYDhXBjb5--
