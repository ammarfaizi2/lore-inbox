Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030279AbVLFWEu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030279AbVLFWEu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 17:04:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030274AbVLFWEu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 17:04:50 -0500
Received: from web34109.mail.mud.yahoo.com ([66.163.178.107]:44142 "HELO
	web34109.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1030277AbVLFWEt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 17:04:49 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=nVbaJnjfGOCDIL/GWZtFmE6C1tEiLYIjRynA2fjKS3UPyCKJJYC1W2FaDywpXjJ3EhThOH2UTWWKp86Io1ukjNutDcpH1Bj2ivo9C5tqb90oJvn5FDB6NuYwNT4xdB1Wa2YdLksMsH6gD4qypF4F/3eVAGYkIv5XkKZrPo+vDnQ=  ;
Message-ID: <20051206220448.82860.qmail@web34109.mail.mud.yahoo.com>
Date: Tue, 6 Dec 2005 14:04:48 -0800 (PST)
From: Kenny Simpson <theonetruekenny@yahoo.com>
Subject: another nfs puzzle
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-1990726021-1133906688=:79032"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--0-1990726021-1133906688=:79032
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Id: 
Content-Disposition: inline

Hi again,
  I am seeing some odd behavior with O_DIRECT.  If a file opened with O_DIRECT has a page mmap'd,
and the file is extended via pwrite, then the mmap'd region seems to get lost - i.e. it neither
takes up system memory, nor does it get written out.

The attached file demonstrates this.
Compile with -DABUSE to trigger the bad case.
This behavior does not happen with an ext3 partition.

ethereal shows the behavior to be a large amount of block reads, with single byte writes every so
often.  Viewing the resultant file from other hosts or even the original host shows the file is
grown, but is zero-filled, not 'a'-filled.

-Kenny



		
__________________________________________ 
Yahoo! DSL – Something to write home about. 
Just $16.99/mo. or less. 
dsl.yahoo.com 

--0-1990726021-1133906688=:79032
Content-Type: text/x-csrc; name="dtest.c"
Content-Description: 862959384-dtest.c
Content-Disposition: inline; filename="dtest.c"

#define _GNU_SOURCE

#include <sys/mman.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <unistd.h>

#include <stdio.h>
#include <string.h>

/*
 * the 'abusive' case is where we
 *   grow the file via pwrite
 *   unmap the previous mapping,
 *   do the new mapping
 *
 * the non-abusive case we
 *   unmap the previous mapping
 *   grow the file
 *   do the new mapping
 *
 * the difference being that in the abusive case,
 * we maintain a mapping during the pwrite.
 *
 * If we grow the file via pwrite and maintain a
 * mapping, the mapped pages are never written out.
 *
 * If we either grow the file via ftruncate or remove
 * old mappings before growing the file, then all is
 * fine.
 */

#ifdef ABUSE
#define UNMAP_AFTER() munmap(mapping, size)
#define UNMAP_BEFORE() struct eat_semi
#else
#define UNMAP_AFTER() struct eat_semi
#define UNMAP_BEFORE() munmap(mapping, size)
#endif

int main(int argc, char* argv[])
{
  int fd;
  unsigned int const size = 4096 * 1024;
  unsigned int offset = 0;

  if (argc != 2) {
    printf("usage: %s <filename>\n", argv[0]);
    return 0;
  }

  fd = open(argv[1], O_RDWR | O_CREAT | O_TRUNC | O_LARGEFILE | O_DIRECT, 0644);
  if (fd < 0) {
    perror("open");
    return 0;
  }

  pwrite64(fd, "", 1, offset + size);
  //ftruncate64(fd, offset + size);
  char* mapping = (char*)mmap64(0, size, PROT_READ | PROT_WRITE, MAP_SHARED, fd, offset);
  memset(mapping, 'a', size);
  UNMAP_BEFORE();

  for (;;) {
    offset += size;

    pwrite64(fd, "", 1, offset + size);
    //ftruncate64(fd, offset + size);
    UNMAP_AFTER();
    mapping = (char*)mmap64(0, size, PROT_READ | PROT_WRITE, MAP_SHARED, fd, offset);
    memset(mapping, 'a', size);
    UNMAP_BEFORE();
  }

  close(fd);

  return 0;
}

--0-1990726021-1133906688=:79032--
