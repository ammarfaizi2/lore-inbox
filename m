Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932437AbWEXRSd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932437AbWEXRSd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 May 2006 13:18:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932438AbWEXRSc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 May 2006 13:18:32 -0400
Received: from nz-out-0102.google.com ([64.233.162.194]:53096 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932437AbWEXRSc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 May 2006 13:18:32 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=FYXXGrgLaq/UxaeNmkF2hne0w0G/QojHFyh1vqhQYH87KCvinxUIjq87QDVKt4lwUo9PO+i2INn6FEr9n6Dkjs+fyJukWe9xn4XsU7LNj+N9lmWdpJidepNglptId/GGLPSbvzdcObjO1laLyQM7qlS87sMwuLi9HJhsWZoBxYA=
Message-ID: <3faf05680605241018q302d5c0em6844765f81669498@mail.gmail.com>
Date: Wed, 24 May 2006 22:48:31 +0530
From: "vamsi krishna" <vamsi.krishnak@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Program to convert core file to executable.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello All,

o I have written the following program to convert a core file to a
executable, and tried to execute the converted executable but my
system __HANGED__, The kernel did'nt give any messages the complete
system was stuck.

o Theoretically , the OS loader should jump into the virtual address
specified at 'ELF_HDR.e_entry and start executing instructions from
that point if the ELF_TYPE is ET_EXEC.

o So I wrote a program which
changes ELF_TYPE form ET_CORE to ET_EXEC and modifies e_entry to
virtual address of the 'main' symbol, since the core file has valid offset
to access the PHDRS, and for ET_EXEC the elf loader just need to map
the PHDRS at the vaddr specified and start jump to e_entry.

o Is there anything I'am missing, can some experts throw light on why
kernel does not load this program, could it be a bug in the kernel code ?

o The following is the program which converts core file to executable,
its simple to use just compile it with 'gcc convertcore.c -o
convertcore' , run with 'convertcore <core-file-name> <new-exec-name>
<vaddr-of-main>'

o I dump the core by CRTL+\

really appreciate your inputs

========================<BEGIN>===============================
#include<elf.h>
#include<stdio.h>
#include<sys/types.h>
#include<sys/stat.h>
#include<fcntl.h>

#ifndef __64_BIT__
#define __32_BIT__
#endif

#ifdef __32_BIT__
#define ELF_EHDR Elf32_Ehdr
#else
#define ELF_EHDR Elf64_Ehdr
#endif

ELF_EHDR place_holder;

/*Chages the elf_header in the file with ptr */
int ChangeElfHeader(int CoreFd, int WriteFd, unsigned long vaddr){

      unsigned long got_len=0;

      if((got_len = read(CoreFd,&place_holder,sizeof(ELF_EHDR)))
              != sizeof(ELF_EHDR)){
              perror("Unable to read the ELF Header::");
              exit(1);
      }
      /*Change the ET_CORE tto ET_EXEC*/
      if(place_holder.e_type == ET_CORE) {
              place_holder.e_type = ET_EXEC;
      } else {
              fprintf(stderr,"The file is not of ELF core file");
              exit(1);
      }

      /*Change the entry */

      place_holder.e_entry = vaddr;

      /*Write back the header*/
      got_len = 0;
      if (( got_len = write(WriteFd,&place_holder,sizeof(ELF_EHDR)))
              != sizeof(ELF_EHDR)) {
              perror("Unable to write the header::");
              exit(1);
      }
      return 1;
}
