Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275184AbRIZNu6>; Wed, 26 Sep 2001 09:50:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275183AbRIZNut>; Wed, 26 Sep 2001 09:50:49 -0400
Received: from [195.66.192.167] ([195.66.192.167]:32017 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S275197AbRIZNub>; Wed, 26 Sep 2001 09:50:31 -0400
Date: Wed, 26 Sep 2001 16:44:24 +0300
From: VDA <VDA@port.imtp.ilyichevsk.odessa.ua>
X-Mailer: The Bat! (v1.44)
Reply-To: VDA <VDA@port.imtp.ilyichevsk.odessa.ua>
Organization: IMTP
X-Priority: 3 (Normal)
Message-ID: <1328774675.20010926164424@port.imtp.ilyichevsk.odessa.ua>
To: Andrea Arcangeli <andrea@suse.de>, Rik van Riel <riel@conectiva.com.br>,
        Alexander Viro <viro@math.psu.edu>,
        Daniel Phillips <phillips@bonn-fries.net>
CC: linux-kernel@vger.kernel.org
Subject: VM swap visualization program
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi VM folks,

I put together this small proggy. Maybe it could be of some
use for you.
-- 
Best regards, VDA
mailto:VDA@port.imtp.ilyichevsk.odessa.ua
-----------------------------------------
// (c) 2001 Vlasenko Denis Alexander
// licensed under the terms of the GPL

#include <stdio.h>
#include <stdlib.h>

const int TRY_TIMES = 16;
const int DELAY_US = 1000000;
const int BUFCOUNT = 8;
#define BUFDELAY 1,2,3,5,8,13,21,34 
const int BUFSIZE = 1 * 1024*1024;

#define STR(a) STR2((a))
#define STR2(a) #a

static inline long long rdtsc()
{
        unsigned int low,high;
        __asm__ __volatile__("rdtsc" : "=a" (low), "=d" (high));
        return low + (((long long)high)<<32);
}
     
long measure_touch_buf(char *buffer, int size)
{
        char *temp;
        int i;
        unsigned long long before,after,min;

        before = rdtsc();
        memset(buffer,0,size);
        after = rdtsc();
        if (before>after) {
                printf("timer overflow\n");
                return (~0UL)>>1;
        } else {
                return after-before;
        }               
}

long measure_unswapped_time(char *buffer, int size)
{
        int i;
        long min = (~0UL)>>1;
        
        // dummy run to ensure coherent mem/cache state
        measure_touch_buf(buffer, size);
        // pick fastest run
        for (i=0;i<TRY_TIMES;i++) {
                long t=measure_touch_buf(buffer, size);
                if(min>t) min=t;
        }
        return min;
}

int main()
{
        int i;
        long count;
        char *buffer[8];
        int buf_freq[8] = { BUFDELAY };
        long unswapped_time,t;

        printf( "VM swap visualization program (Ctrl-C to exit)\n"
                "%i buffers of %i kb each, touched once per " STR(BUFDELAY) " secs\n"
                "Once buffer is touched, a big letter is printed if buffer\n"
                "got swapped out, else small letter is printed.\n\n",
                BUFCOUNT,
                BUFSIZE/1024
        );
        for (i=0;i<BUFCOUNT;i++) {
                buffer[i] = malloc(BUFSIZE);
                if(!buffer[i]) {
                        printf("Malloc failed.\n");
                        exit(1);
                }
        }
        
        printf("Calibrating...");
        unswapped_time = measure_unswapped_time(buffer[0],BUFSIZE);
        printf(" %li cycles per buffer\n\n",unswapped_time);

        for (i=0;i<BUFCOUNT;i++) {
                measure_touch_buf(buffer[i],BUFSIZE);
        }

        count=0;        
        while(1) {
                usleep(DELAY_US);
                for (i=0;i<BUFCOUNT;i++) {
                        if(count%buf_freq[i]==0) {
                                t = measure_touch_buf(buffer[i],BUFSIZE);
                                if(t>unswapped_time*2) {
                                        putchar('A'+i); 
                                } else {
                                        putchar('a'+i); 
                                }
                                fflush(stdout);
                        }
                }
                putchar('.');
                fflush(stdout);
                count++;
        }
        return 0;
}


