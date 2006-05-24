Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932351AbWEXRZD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932351AbWEXRZD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 May 2006 13:25:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932443AbWEXRZC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 May 2006 13:25:02 -0400
Received: from nz-out-0102.google.com ([64.233.162.197]:35959 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932351AbWEXRZA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 May 2006 13:25:00 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=PWmRBnycjAPQioX4suMWXw6EghBuCFjMblK5sPLJv9SYs92tSv8pCu7wMj2F6RCjMguXlaJyGQadOapOhg3Vm56t+1MUmyzH9tUh/2CmJGVT3FfLqwkZQ3xpEg9HmIFvw3N3E7vUpVjTjePQyQTcM94beEwzxQKhHx6ov9uJc14=
Message-ID: <3faf05680605241025g722bf73dma0c0d1b3e0554e8b@mail.gmail.com>
Date: Wed, 24 May 2006 22:55:00 +0530
From: "vamsi krishna" <vamsi.krishnak@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Program to convert core file to executable.
In-Reply-To: <3faf05680605241018q302d5c0em6844765f81669498@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <3faf05680605241018q302d5c0em6844765f81669498@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hello All,
>
> o I have written the following program to convert a core file to a
> executable, and tried to execute the converted executable but my
> system __HANGED__, The kernel did'nt give any messages the complete
> system was stuck.
>
> o Theoretically , the OS loader should jump into the virtual address
> specified at 'ELF_HDR.e_entry and start executing instructions from
> that point if the ELF_TYPE is ET_EXEC.
>
> o So I wrote a program which
> changes ELF_TYPE form ET_CORE to ET_EXEC and modifies e_entry to
> virtual address of the 'main' symbol, since the core file has valid offset
> to access the PHDRS, and for ET_EXEC the elf loader just need to map
> the PHDRS at the vaddr specified and start jump to e_entry.
>
> o Is there anything I'am missing, can some experts throw light on why
> kernel does not load this program, could it be a bug in the kernel code ?
>
> o The following is the program which converts core file to executable,
> its simple to use just compile it with 'gcc convertcore.c -o
> convertcore' , run with 'convertcore <core-file-name> <new-exec-name>
> <vaddr-of-main>'
>
> o I dump the core by CRTL+\
>
> really appreciate your inputs
>
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

static void finishWriting(int coreFd, int writeFd) {

      unsigned char write_buffer[4*1024];
      int got_len = -1;

      while( (got_len = read(coreFd,write_buffer,4096)) != 0) {
              if(write(writeFd,write_buffer,got_len) != got_len ){
                      perror("Unable to to write the length which was read:");
                      exit(1);
              }
      }
      close(writeFd);
      close(coreFd);

}

int main(int argc,char* argv[]){

      int coreFd;
      int writeFd;
      unsigned long vaddr;

      if( argc < 3 ) {
              fprintf(stderr,"Usage core2elf core.file exe.file.name");
              exit(1);
      }
      if( (coreFd = open(argv[1],O_RDONLY)) < 0) {
              perror("Unable to open the core file:");
              exit(1);
      }
      if ((writeFd = open(argv[2],O_WRONLY| O_CREAT)) < 0) {
              perror("Unable to open the write file::");
              exit(1);
      }
      sscanf(argv[3],"%lx",&vaddr);
      ChangeElfHeader(coreFd,writeFd,vaddr);
      finishWriting(coreFd,writeFd);


}
=========================<END>===========================

Best Regards,
Vamsi kundeti.
