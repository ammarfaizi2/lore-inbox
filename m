Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261795AbVDEQUQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261795AbVDEQUQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 12:20:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261798AbVDEQUQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 12:20:16 -0400
Received: from zproxy.gmail.com ([64.233.162.194]:19726 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261795AbVDEQTw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 12:19:52 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding;
        b=V++5n8W/AO2+wg13p2spwQmdwpI9WY2IiuT1SeSXyabBgcI6Rihbo3Qeg0Oc31PMjQYTaD23twbSY0grf7bmchX5EPBoW3D3GMpfnVNULpCi/RzpdHG+u4LYnMeKvEwJFNwKNuhSBptO4EMp5MhWNlcNXWxtu1Ilat4fpWN7/9E=
Message-ID: <a80eebd4050405091928aaf200@mail.gmail.com>
Date: Tue, 5 Apr 2005 18:19:51 +0200
From: Sen Horak <sen.horak@gmail.com>
Reply-To: Sen Horak <sen.horak@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Hugetlpages Vs small pages
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

My config: Pentium M/1400MHz/1MB L2/64 entry D-TLB
Kernel: 2.6.7-vanilla

I tried running a microbenchmark in which I "touched" every 4k in a
loop in 2 separate 4MB regions:

1)  mapped from a hugetlbfs partition (MAP_FIXED)
2)  mapped anonymously (MAP_ANONYMOUS)

The result I'm getting is that both seem to be delivering the same
performance, with an edge for MAP_ANONYMOUS.

>From hugetlbfs:   3515154447  cycles
MAP_ANONYMOUS:  3461527548 cycles
[using rdtsc]

samples  %        symbol name
630      100.000  main
samples  %        symbol name
624      100.000  main
[using oprofile]

Can somebody explain why this is happening? Unfortunately, there is no
hardware performance counter that allows one to measure D-TLB misses
on the Pentium,  so I can't measure that.

Regards,
Sen

void *init_huge_page(int size) {
    fd = open("/mnt/superpage/x", O_CREAT|O_RDWR, 0755);
    if (fd < 0) {
            perror("Open failed");
            exit(errno);
    }
    addr = (unsigned long) mmap(0x80000000, 4*1024*1024,
(PROT_READ|PROT_WRITE), MAP_SHARED|MAP_FIXED, fd, 0);
    if (addr==-1) {
            perror("mmap failed");
            exit(errno);
    }
    else
        printf("Address=%x\n",addr);
    return (void *) addr;
}

void exit_huge_page(int size) {
    if (addr!=-1) munmap(addr,size);
    close(fd);
}


int main(int argc,char *argv[])
{
  int j,i;
  unsigned long cnt1,cnt2;

  void *p=init_huge_page(BUFSIZE);

  setpriority(PRIO_PROCESS, 0, -20);
  rdtsc(cnt1);
  for(j=0;j<1000;j++) {
      for(i=0;i<(4*1024*1024);i+=1024) {
          ((char *)p)[i]='H';
      }
  }
  rdtsc(cnt2);
  printf("%0.2f\n",(cnt2-cnt1)/1000000000.0);
  exit_huge_page(BUFSIZE);
