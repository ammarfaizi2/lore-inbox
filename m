Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267773AbUHWWrb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267773AbUHWWrb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 18:47:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267993AbUHWWqm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 18:46:42 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:19977 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S267825AbUHWWcE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 18:32:04 -0400
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: Andi Kleen <ak@muc.de>
Subject: Re: Obvious one-liner - Use 3DNOW on MK8
Date: Tue, 24 Aug 2004 01:31:58 +0300
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org
References: <2vOfA-7Vg-7@gated-at.bofh.it> <20040823195842.GA7952@muc.de> <200408240124.43828.vda@port.imtp.ilyichevsk.odessa.ua>
In-Reply-To: <200408240124.43828.vda@port.imtp.ilyichevsk.odessa.ua>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_eBnKBwW/BfPdfeR"
Message-Id: <200408240131.58218.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_eBnKBwW/BfPdfeR
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

These are test programs.

copy_load.c:

            for(i = 0; i < N; i++)
                mem[i*SIZE+1] = 'b';          /* force copy */
            strchr(mem, 'c') == mem+N*SIZE-1 || printf("BUG\n");        /* read all */

This forces page copying, and then touches every byte.
--
vda

--Boundary-00=_eBnKBwW/BfPdfeR
Content-Type: text/x-csrc;
  charset="koi8-r";
  name="copy_load.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="copy_load.c"

#include <stdlib.h>
#include <unistd.h>
#include <sys/mman.h>

#define N (256/4)
#define SIZE 4096

int main()
{
    int i,k;
    unsigned char *mem = mmap(0, N*SIZE, PROT_READ|PROT_WRITE,
  	MAP_PRIVATE|MAP_ANONYMOUS, 0, 0);
    if(mem == MAP_FAILED)
    	perror("mmap");
    memset(mem, 'a', N*SIZE); /* force page clearing */
    mem[N*SIZE-1]='c';
    //for(i = 0; i < N; i++) mem[i*SIZE] = i; /* force page clearing */

    for(k = 0; k < 5000; k++) {
	int pid;
	pid = fork();
	if(pid == 0) {
    	    /* child */
    	    for(i = 0; i < N; i++)
    	        mem[i*SIZE+1] = 'b';          /* force copy */
    	    //printf("copy complete\n");
	    strchr(mem, 'c') == mem+N*SIZE-1 || printf("BUG\n");	/* read all */
    	    exit(0);
	} else if(pid == -1) {
    	    perror("fork");
	} else {
    	    /* parent */
    	    waitpid(pid, NULL, 0);
	}
    }
    munmap(mem, N*SIZE);
}

--Boundary-00=_eBnKBwW/BfPdfeR
Content-Type: text/x-csrc;
  charset="koi8-r";
  name="zero_load.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="zero_load.c"

#include <stdlib.h>
#include <unistd.h>
#include <sys/mman.h>

#define N (320/4)
#define SIZE 4096

int dummy;

int main()
{
    int k;
    for(k = 0; k < 20000; k++) {
	int i = 0;
	int pid;
	unsigned char *mem,*p;
	mem = mmap(0, N*SIZE, PROT_READ|PROT_WRITE,
  		MAP_PRIVATE|MAP_ANONYMOUS, 0, 0);
	if(mem == MAP_FAILED)
    	    perror("mmap");
	for(i = 0; i < N; i++) mem[i*SIZE] = i; /* force page allocation and clearing */
	//memset(mem, 'a', N*SIZE); /* force page clearing */
	p = mem;
	while(p != mem+N*SIZE) { i += *p; p+=32; } /* use data */
	dummy = i;
	munmap(mem, N*SIZE);
    }
}

--Boundary-00=_eBnKBwW/BfPdfeR--

