Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282849AbRK0H5z>; Tue, 27 Nov 2001 02:57:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282846AbRK0H5o>; Tue, 27 Nov 2001 02:57:44 -0500
Received: from mail0.epfl.ch ([128.178.50.57]:3601 "HELO mail0.epfl.ch")
	by vger.kernel.org with SMTP id <S282847AbRK0H5T>;
	Tue, 27 Nov 2001 02:57:19 -0500
Message-ID: <3C03475D.6090303@epfl.ch>
Date: Tue, 27 Nov 2001 08:57:17 +0100
From: Nicolas Aspert <Nicolas.Aspert@epfl.ch>
Organization: LTS-DE-EPFL
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6) Gecko/20011120
X-Accept-Language: en-us
MIME-Version: 1.0
To: Didier Moens <moensd@xs4all.be>
CC: Robert Love <rml@tech9.net>, skraw@ithnet.com,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [Fwd: Re: OOPS in agpgart (2.4.13, 2.4.15pre7)]
In-Reply-To: <linux.kernel.3C021570.4000603@dmb.rug.ac.be> <3C022BB4.7080707@epfl.ch> <1006808870.817.0.camel@phantasy> <3C02BF41.1010303@xs4all.be>
Content-Type: multipart/mixed;
 boundary="------------080405080702010108030102"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080405080702010108030102
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Didier Moens wrote:

 > Dear Robert, Nicolas, Stephan,   :)
 >
 >
 > I got two patches :
 >
 >
 > 1. From Stephan, to test whether my assumption about the secondary
 > device was right :
 >
 > Stephan wrote :
 >
 > But if you want you can check that out pretty simple: just add a "break"
 > right
 > after the case :
 >
 >                 case PCI_DEVICE_ID_INTEL_830_M_0:
 > ---> break;
 >
 >                         i810_dev = pci_find_device(PCI_VENDOR_ID_INTEL,
 >


What is the result if you place the 'break' a few lines below, just
before the 'agp_bridge.type = NOT_SUPPORTED;' ? Does the module still
loads ?


 > This patch left me with a loaded agpgart, and accelerated X (DRM/DRI).
 > The acceleration is still not up to par with an ATI Mobility-128 (30%
 > lower, while it should be at least 200% faster), but I suspect an X
 > CVS-problem here.
 >
 > Quitting and restarting X leaves me with a locked black screen.
 >


The origin of the problem is not obvious... as you said, it could be a
DRI/DRM/X related problem (-> hard to trace). In order to be sure AGP is 
functioning correctly, I suggest that you run this good old test program 
(attached) after loading the AGP module (but before starting X). I 
buried out this little fellow from the utah-glx project. All it does is 
trying to write some data to the agp memory. Try it with both flavors of 
the module (mine+your fix and the one from Stephan), and share the 
output with us ;-)

Good luck


 > Conclusion : Stephan's break-patch loads agpgart, loads X, and locks
 > when reloading X ; Nicolas' patch (when combined with Stephan's first
 > patch) loads agpgart and locks X hard.
 >



-- 
Nicolas Aspert      Signal Processing Laboratory (LTS)
Swiss Federal Institute of Technology (EPFL)


--------------080405080702010108030102
Content-Type: text/plain;
 name="testgart.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="testgart.c"

#include <stdio.h>
#include <unistd.h>
#include <sys/ioctl.h>
#include <fcntl.h>
#include <sys/mman.h>
#include <sys/time.h>
#include <linux/types.h>
#include <linux/agpgart.h>
#include <asm/mtrr.h>
#include <errno.h>

unsigned char *gart;
int gartfd;
int mtrr;

int usec( void ) {
  struct timeval tv;
  struct timezone tz;
  
  gettimeofday( &tv, &tz );
  return (tv.tv_sec & 2047) * 1000000 + tv.tv_usec;
}

int MemoryBenchmark( void *buffer, int dwords ) {
  int             i;
  int             start, end;
  int             mb;
  int             *base;
  
  base = (int *)buffer;
  start = usec();
  for ( i = 0 ; i < dwords ; i += 8 ) {
    base[i] =
      base[i+1] =
      base[i+2] =
      base[i+3] =
      base[i+4] =
      base[i+5] =
      base[i+6] =
      base[i+7] = 0x15151515;         /* dmapad nops */
  }
  end = usec();
  mb = ( (float)dwords / 0x40000 ) * 1000000 / (end - start);
  printf("MemoryBenchmark: %i mb/s\n", mb );
  return mb;
}

int insert_gart(int page, int size)
{
   agp_allocate entry;
   agp_bind bind;
   
   entry.type = 0;
   entry.pg_count = size;
#ifdef DEBUG
   printf("Using AGPIOC_ALLOCATE\n");
#endif
   if(ioctl(gartfd, AGPIOC_ALLOCATE, &entry) != 0)
    {
      perror("ioctl(AGPIOC_ALLOCATE)");
      exit(1);
    }
   
   bind.key = entry.key;
   bind.pg_start = page;
#ifdef DEBUG
   printf("Using AGPIOC_BIND\n");
#endif
   if(ioctl(gartfd, AGPIOC_BIND, &bind))
     {
	perror("ioctl(AGPIOC_BIND)");
	exit(1);
     }
   
   printf("entry.key : %i\n", entry.key);
   
   return(entry.key);
}

int unbind_gart(int key)
{
   agp_unbind unbind;
   
   unbind.key = key;
#ifdef DEBUG
   printf("Using AGPIOC_UNBIND\n");
#endif
   if(ioctl(gartfd, AGPIOC_UNBIND, &unbind) != 0)
     {
	perror("ioctl(AGPIOC_UNBIND)");
	exit(1);
     }
   
   return(0);
}

int bind_gart(int key, int page)
{
   agp_bind bind;
   
   bind.key = key;
   bind.pg_start = page;
#ifdef DEBUG
   printf("Using AGPIOC_BIND\n");
#endif
   if(ioctl(gartfd, AGPIOC_BIND, &bind) != 0)
     {
	perror("ioctl(AGPIOC_BIND)");
	exit(1);
     }
   
   return(0);
}

int remove_gart(int key)
{
#ifdef DEBUG
   printf("Using AGPIOC_DEALLOCATE\n");
#endif
  if(ioctl(gartfd, AGPIOC_DEALLOCATE, key) != 0)
    {
      perror("ioctl(GARTIOCREMOVE)");
      exit(1);
    }
   
   return(0);
}

void openmtrr(void) 
{
   if ((mtrr = open("/proc/mtrr", O_WRONLY, 0)) == -1) 
     {
	if (errno == ENOENT) {
	   perror("/proc/mtrr not found: MTRR not enabled\n");
	}  else {
	   perror("Error opening /proc/mtrr:");
	   perror("MTRR not enabled\n");
	   exit(1);
	}
	return;
     }
}

int CoverRangeWithMTRR( int base, int range, int type )
{
   int          count;   
      
   /* set it if we aren't just checking the number */
   if ( type != -1 ) {
      struct mtrr_sentry sentry;
      
      sentry.base = base;
      sentry.size = range;
      sentry.type = type;
      
      if ( ioctl(mtrr, MTRRIOC_ADD_ENTRY, &sentry) == -1 ) {
	 perror("mtrr");
	 exit(1);
      }
   }
   
}

int init_agp(void)
{
   agp_info info;
   agp_setup setup;

#ifdef DEBUG
   printf("Using AGPIOC_ACQUIRE\n");
#endif
   if(ioctl(gartfd, AGPIOC_ACQUIRE) != 0)
     {
	perror("ioctl(AGPIOC_ACQUIRE)");
	exit(1);
     }
#ifdef DEBUG
   printf("Using AGPIOC_INFO\n");
#endif
   if(ioctl(gartfd, AGPIOC_INFO, &info) != 0)
     {
	perror("ioctl(AGPIOC_INFO)");
	exit(1);
     }
   
   printf("version: %i.%i\n", info.version.major, info.version.minor);
   printf("bridge id: 0x%lx\n", info.bridge_id);
   printf("agp_mode: 0x%lx\n", info.agp_mode);
   printf("aper_base: 0x%lx\n", info.aper_base);
   printf("aper_size: %i\n", info.aper_size);
   printf("pg_total: %i\n", info.pg_total);
   printf("pg_system: %i\n", info.pg_system);
   printf("pg_used: %i\n", info.pg_used);

   openmtrr();
   if (mtrr != -1) { 
     CoverRangeWithMTRR(info.aper_base, info.aper_size * 0x100000, 
       MTRR_TYPE_WRCOMB);
   }

   gart = mmap(NULL, info.aper_size * 0x100000, PROT_READ | PROT_WRITE, MAP_SHARED, gartfd, 0);

   if(gart == (unsigned char *) 0xffffffff)
     {
	perror("mmap");
	close(gartfd);
	exit(1);
     }	
   
   setup.agp_mode = info.agp_mode;
#ifdef DEBUG
   printf("Using AGPIOC_SETUP\n");
#endif
   if(ioctl(gartfd, AGPIOC_SETUP, &setup) != 0)
     {
	perror("ioctl(AGPIOC_SETUP)");
	exit(1);
     }
   
   return(0);
}

int xchangeDummy;

void FlushWriteCombining( void ) {
	__asm__ volatile( " push %%eax ; xchg %%eax, %0 ; pop %%eax" : : "m" (xchangeDummy));
	__asm__ volatile( " push %%eax ; push %%ebx ; push %%ecx ; push %%edx ; movl $0,%%eax ; cpuid ; pop %%edx ; pop %%ecx ; pop %%ebx ; pop %%eax" : /* no outputs */ :  /* no inputs */ );
}

void BenchMark()
{
  int i, worked = 1;

  i = MemoryBenchmark(gart, (1024 * 1024 * 4) / 4) +
    MemoryBenchmark(gart, (1024 * 1024 * 4) / 4) +
    MemoryBenchmark(gart, (1024 * 1024 * 4) / 4);
  
  printf("Average speed: %i mb/s\n", i /3);
  
  printf("Testing data integrity (1st pass): ");
  fflush(stdout);
   
  FlushWriteCombining();
  
  for (i=0; i < 8 * 0x100000; i++)
    {
      gart[i] = i % 256;
    }
   
  FlushWriteCombining();
   
  
  for (i=0; i < 8 * 0x100000; i++)
    {
       if(!(gart[i] == i % 256))
	 {
#ifdef DEBUG
	    printf("failed on %i, gart[i] = %i\n", i, gart[i]);
#endif
	    worked = 0;
	 }
    }
  
  if (!worked)
    printf("failed on first pass!\n");
  else
    printf("passed on first pass.\n");
   
   unbind_gart(0);
   unbind_gart(1);
   bind_gart(0, 0);
   bind_gart(1, 1024);

   worked = 1;
   printf("Testing data integrity (2nd pass): ");
   fflush(stdout);
   
   for (i=0; i < 8 * 0x100000; i++)
    {
       if(!(gart[i] == i % 256))
	 {
#ifdef DEBUG
	    printf("failed on %i, gart[i] = %i\n", i, gart[i]);
#endif
	    worked = 0;
	 }
    }

   if (!worked)
    printf("failed on second pass!\n");
  else
    printf("passed on second pass.\n");
}

int main()
{
   int i;
   int key;
   int key2;
   agp_info info;
  
   gartfd = open("/dev/agpgart", O_RDWR);
   if (gartfd == -1)
     {	
	perror("open");
	exit(1);
     }
   
   init_agp();
   
   key = insert_gart(0, 1024);
   key2 = insert_gart(1024, 1024);
   
#ifdef DEBUG
   printf("Using AGPIOC_INFO\n");
   if(ioctl(gartfd, AGPIOC_INFO, &info) != 0)
     {
	perror("ioctl(AGPIOC_INFO)");
	exit(1);
     }
   
   printf("version: %i.%i\n", info.version.major, info.version.minor);
   printf("bridge id: 0x%lx\n", info.bridge_id);
   printf("agp_mode: 0x%lx\n", info.agp_mode);
   printf("aper_base: 0x%lx\n", info.aper_base);
   printf("aper_size: %i\n", info.aper_size);
   printf("pg_total: %i\n", info.pg_total);
   printf("pg_system: %i\n", info.pg_system);
   printf("pg_used: %i\n", info.pg_used);
#endif
   
   printf("Allocated 8 megs of GART memory\n");
   
   BenchMark();
   
   remove_gart(key);
   remove_gart(key2);

#ifdef DEBUG   
   printf("Using AGPIOC_RELEASE\n");
#endif
   if(ioctl(gartfd, AGPIOC_RELEASE) != 0)
     {
	perror("ioctl(AGPIOC_RELEASE)");
	exit(1);
     }
   
   close(gartfd);
}


--------------080405080702010108030102--

