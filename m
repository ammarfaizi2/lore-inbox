Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129873AbQLTPpV>; Wed, 20 Dec 2000 10:45:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129849AbQLTPpC>; Wed, 20 Dec 2000 10:45:02 -0500
Received: from shasta.gate.net ([216.219.246.6]:49356 "EHLO shasta.gate.net")
	by vger.kernel.org with ESMTP id <S129781AbQLTPox>;
	Wed, 20 Dec 2000 10:44:53 -0500
Message-ID: <000301c06a97$85f75a00$7d1a24cf@master>
From: "Steve Grubb" <ddata@gate.net>
To: <linux-kernel@vger.kernel.org>
Subject: [Test Case] performance enhancement for simple_strtoul
Date: Wed, 20 Dec 2000 10:14:12 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Here's the test case for the suggested simple_strtoul function. I just
finished testing on a P3 where it seems to show a 16-20% speed improvement
over the current algorithm.

compile it as:

gcc  /usr/src/linux/lib/ctype.c strtoul_test.c -o strtoul_test

You can change the numeric base value with this define to 8, 10, or 16 to
see the speed change for each numeric representation:

#define BASE  10

Have fun,
Steve Grubb

------strtoul_test.c----------

#include <unistd.h>
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <sys/resource.h>
#include <linux/ctype.h>

struct timeval last_stopwatch_time;


void stopwatch()
{
    struct timeval now;
    int delta;

    gettimeofday(&now, 0);
    delta = (now.tv_sec - last_stopwatch_time.tv_sec) * 1000000 +
    (now.tv_usec - last_stopwatch_time.tv_usec);
    printf ("Stopwatch: elapsed time %d.%03d seconds\n\n",
    delta / 1000000, (delta / 1000) % 1000);


    last_stopwatch_time = now;
}

unsigned long old_simple_strtoul(const char *cp,char **endp,unsigned int
base)
{
 unsigned long result = 0,value;
 if (!base) {
  base = 10;
  if (*cp == '0') {
   base = 8;
   cp++;
   if ((*cp == 'x') && isxdigit(cp[1])) {
    cp++;
    base = 16;
   }
  }
 }
 while (isxdigit(*cp) && (value = isdigit(*cp) ? *cp-'0' : (islower(*cp)
? toupper(*cp) : *cp)-'A'+10) < base) {
  result = result*base + value;
  cp++;
 }
 if (endp)
  *endp = (char *)cp;
 return result;
}

unsigned long new_simple_strtoul2(const char *cp,char **endp,unsigned int
base)
{
 unsigned char c;
 unsigned long result = 0;
 if (!base) {
  base = 10;
  if (*cp == '0') {
   base = 8;
   cp++;
   if ((*cp == 'x') && isxdigit(cp[1])) {
    cp++;
    base = 16;
   }
  }
 }
 c = *cp;
 switch (base) {
  case 10:
   while (isdigit(c)) {
    result = (result*10) + (c & 0x0f);
    c = *(++cp);
   }
   break;
  case 16:
   while (isxdigit(c)) {
    result = (result<<4);
    if (c&0x40)
      result += (c & 0x07) + 9;
    else
     result += (c & 0x0f);
    c = *(++cp);
   }
   break;
  case 8:
   while (isdigit(c)) {
    if ((c&0x37) == c)
     result = (result<<3) + (c & 0x07);
    else
     break;
    c = *(++cp);
   }
 }
 if (endp)
  *endp = (char *)cp;
 return result;
}

#define NUMBER_TO_TEST 32768
#define BASE  10
char f[3][3] = { "%d", "%X", "%o"};
char str[NUMBER_TO_TEST][32];
unsigned long r[NUMBER_TO_TEST];

int main()
{
 int rn, i, j, iterations = 1000;
 time_t tm;

 time(&tm);
 srand((unsigned) tm);
 rn = rand();

 // do setup here
 for (i=0; i<NUMBER_TO_TEST; i++) {
  r[i] = rand()%0x7FFFFFF;
  switch (BASE) {
  case 10:
   sprintf(&str[i][0], &f[0][0], r[i]);
   break;
  case 16:
   sprintf(&str[i][0], &f[1][0], r[i]);
   break;
  case 8:
   sprintf(&str[i][0], &f[2][0], r[i]);
  }
 }

 puts("Starting old algorithm");
 sleep(5);  // let the system settle down
    gettimeofday(&last_stopwatch_time, 0);
    for (i=0; i<iterations; i++) {
  for (j=0; j<NUMBER_TO_TEST; j++) {
   old_simple_strtoul(&str[j][0], NULL, BASE);
  }
    }
 stopwatch();

    puts("New algorithm");
    sleep(5);  // let the system settle down
    gettimeofday(&last_stopwatch_time, 0);
    for (i=0; i<iterations; i++) {
    for (j=0; j<NUMBER_TO_TEST; j++) {
        new_simple_strtoul2(&str[j][0], NULL, BASE);
    }
    }
    stopwatch();

    puts("Now checking values");
    for (i=0; i<NUMBER_TO_TEST; i++) {
    unsigned long t = new_simple_strtoul2(&str[i][0], NULL, BASE);
    if (r[i] != t) {
        switch (BASE) {
        case 10:
        printf("is %s conv %d\n", &str[i][0], t);
        break;
        case 16:
        printf("is %s conv %x\n", &str[i][0], t);
        break;
        case 8:
        printf("is %s conv %o\n", &str[i][0], t);
        }
        break;
    }
    }

 return 0;
}


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
