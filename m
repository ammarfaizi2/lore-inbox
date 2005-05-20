Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261473AbVETOFh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261473AbVETOFh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 May 2005 10:05:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261470AbVETN7W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 May 2005 09:59:22 -0400
Received: from alog0061.analogic.com ([208.224.220.76]:43482 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261429AbVETNsr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 May 2005 09:48:47 -0400
Date: Fri, 20 May 2005 09:48:35 -0400 (EDT)
From: "Richard B. Johnson" <linux-os@analogic.com>
Reply-To: linux-os@analogic.com
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Screen regen buffer at 0x00b8000
Message-ID: <Pine.LNX.4.61.0505200944060.5921@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Why can't I consistantly write to the VGA screen regen buffer
and have it appear on the screen????

It looks like access there is cached??? One needs to change
VT consoles to make it appear!!

The screen-regen buffer at this address is hardware, in the
chip! It should not be cached!




#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <unistd.h>
#include <string.h>
#include <signal.h>
#include <fcntl.h>
#include <errno.h>
#include <time.h>
#include <sys/mman.h>


#define ERRORS(s)  do { \
     fprintf(stderr,"Error from line %d, file %s, call %s, (%s)\n",\
     __LINE__,__FILE__,(s), strerror(errno)); \
     exit(EXIT_FAILURE); } while(0)

#define TYPE (MAP_FIXED|MAP_SHARED|MAP_FILE|MAP_LOCKED)
#define PROT (PROT_READ|PROT_WRITE)

#define SCREEN 0x000b8000
#define ATTRIB 0x1700
#define COL 64
#define FAIL -1

static const char ln[]=" Link is ";
static const char up[]="up   ";
static const char dn[]="down ";

int dummy;

int link_stat()       // Dummy for testing
{
     dummy ^= 1;
     return dummy;
} 
// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

int main(int args, char *argv[])
{
     unsigned short upmsg[sizeof(up) + sizeof(ln)];
     unsigned short dnmsg[sizeof(dn) + sizeof(ln)];
     size_t i, j, len;
     int fd;
     unsigned short *sp, *rp;
#if 0
     if(fork())
         return 0;
#endif

     len = getpagesize();
     if((fd = open("/dev/mem", O_RDWR)) == FAIL)
         ERRORS("open");
     if((sp = mmap((void *)SCREEN, len, PROT, TYPE, fd, SCREEN))==MAP_FAILED)
         ERRORS("mmap");
     for(i=0; i< sizeof(ln)-1; i++)
     {
         upmsg[i] = (unsigned short) ln[i] | ATTRIB;
         dnmsg[i] = (unsigned short) ln[i] | ATTRIB;
     }
     for(j=0; j< sizeof(up)-1; j++)
     {
         upmsg[i] = (unsigned short) up[j] | ATTRIB;
         dnmsg[i] = (unsigned short) dn[j] | ATTRIB;
         i++;
     }
     i *= sizeof(unsigned short);
     rp = &sp[COL];
     (void)nice(20);
     for(;;)
     {
         if(link_stat())
             memcpy(rp, upmsg, i);
         else
             memcpy(rp, dnmsg, i);
         usleep(500000);
     }
     return 0;      // Not reached
}


Cheers,
Dick Johnson
Penguin : Linux version 2.6.11.9 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by Dictator Bush.
                  98.36% of all statistics are fiction.
