Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130552AbRDTUff>; Fri, 20 Apr 2001 16:35:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131276AbRDTUf0>; Fri, 20 Apr 2001 16:35:26 -0400
Received: from dsr-gw.dsrnet.com ([208.203.147.5]:33478 "EHLO
	dsr-gw.dsrnet.com") by vger.kernel.org with ESMTP
	id <S130552AbRDTUfJ>; Fri, 20 Apr 2001 16:35:09 -0400
Message-ID: <3AE09DD8.2FA3CB63@dsrnet.com>
Date: Fri, 20 Apr 2001 16:36:40 -0400
From: Dave <dwelling@dsrnet.com>
Reply-To: dwelling@dsrnet.com
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.4.0 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: SMP not using all 4GB Mem
Content-Type: multipart/mixed;
 boundary="------------1524602D1F1D06A6579A0ADF"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------1524602D1F1D06A6579A0ADF
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

I have attached a question concerning using 4GB of memory on an SMP.

Thanks for the time,
Dave

--------------1524602D1F1D06A6579A0ADF
Content-Type: text/plain; charset=us-ascii;
 name="MEMQUESTION.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="MEMQUESTION.txt"

SMP Not using all 4GB Ram Question:
---------------------------------------------------------------------
I am using a Compaq Proliant 8500 SMP with 8 550 Mhz processors and 4GB of RAM.
Using Kernel 2.4.3 and Redhat 6.2

I have the (4GB) High Memory Support enabled.

I seem not to be able to use more that 1GB of memory.

The Following is my /proc/meminfo file

----------------------------------------------------------------------
        total:    used:    free:  shared: buffers:  cached:
Mem:  3952427008 339447808 3612979200        0 256139264 25030656
Swap: 1048633344        0 1048633344
MemTotal:      3859792 kB
MemFree:       3528300 kB
MemShared:           0 kB
Buffers:        250136 kB
Cached:          24444 kB
Active:          16628 kB
Inact_dirty:    257952 kB
Inact_clean:         0 kB
Inact_target:      172 kB
HighTotal:     3014624 kB
HighFree:      2978372 kB
LowTotal:       845168 kB
LowFree:        549928 kB
SwapTotal:     1024056 kB
SwapFree:      1024056 kB
--------------------------------------------------------------

I wrote the following program that simply allocates 100M of memory
and then write to it.

#include <stdio.h>


int main (void)
{

  char *p;
  unsigned int i;
  p = malloc (100000000);

  while (1)
    {
      for (i=0;i<100000000;i++)
        *(p+i) = 5;
      sleep (1);
      for (i=0;i<100000000;i++)
        *(p+i) = 6;
      sleep(1);
    }
}

I can run 9 copies of this program to take up 900M of memory.  When 
I attempt to start the 10th process, the whole world goes nuts.  The
X-window that it was started in closes and I continue to get a 
signal 11 interrupt whenever I run a shell command or attempt to compile.

I have another program that will allocate ~2GB of memory and then write data to
it.  It attempts to read the data back and fails around the 850-900M mark. 


#include <stdio.h>
#include <string.h>
#include <sys/mman.h>

int main (void)

{

  int done = 0;
  unsigned int i = 0x7feee800; 
  char *p;
  char *p2;
  unsigned int x;


   p = malloc(i);
      
   sleep (1);
 
   for (x=0;x<i;x++)
    {
    *(p+x) = 5;
    if (*(p+x) !=5)
      {
       printf("first Error %x  %x Address = %x \n", p, x, p+x);
              free(p);
	      return (0);  
      }  
    }


for (x=0;x<i;x++)
    if (*(p+x) !=5)
      {
       printf("5 Error %x  %x Address = %x Value = %x \n", p, x, p+x, *(p+x));
            free(p); 
	    return (0); 
       sleep(1); 
      }

  memset(p, 10, i);
  for (x=0;x<(i-1);x++)
    if (p[x] !=10)
      {
       printf("A Error %i  %x\n", p[x], x);
       /* free(p);
	  return (0);*/
      }
  
  printf("Done\n");
  free(p);
  return (0);

}
--------------------------

Example Run Result:

5 Error 4010f008  32650ff8 Address = 72760000 Value 67

------------------------

The failing address is always a multiple of 0x10000.


Could you give me some info on what I am doing wrong?  

Thanks for your time, 
Dave


--------------1524602D1F1D06A6579A0ADF--

