Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262122AbVCZPgd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262122AbVCZPgd (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Mar 2005 10:36:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262124AbVCZPgd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Mar 2005 10:36:33 -0500
Received: from smtpout.mac.com ([17.250.248.83]:21211 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S262122AbVCZPgE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Mar 2005 10:36:04 -0500
In-Reply-To: <Pine.LNX.4.61.0503261139490.3958@yvahk01.tjqt.qr>
References: <Pine.LNX.4.61.0503261139490.3958@yvahk01.tjqt.qr>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <4de75d4e913f9c7fc93bde5ee6ec57b0@mac.com>
Content-Transfer-Encoding: 7bit
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: gettimeofday call
Date: Sat, 26 Mar 2005 10:35:56 -0500
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
X-Mailer: Apple Mail (2.619.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mar 26, 2005, at 05:40, Jan Engelhardt wrote:
> Hello list,
>
>
> I suppose that calling gettimeofday() repeatedly (to add a timestamp to
> some data) within the kernel is cheaper than doing it in userspace, is 
> it?

Well, the following daemon works on most archs that support mmap at only
the cost of a couple read-barriers per gettimeofday(), as opposed to a
whole context switch.  OTOH, some archs are getting a vDSO that also
supports a fully-userspace gettimeofday() automatically.  libc doesn't
have support code for that, though, and it isn't so portable.

Cheers,
Kyle Moffett

-----BEGIN GEEK CODE BLOCK-----
Version: 3.12
GCM/CS/IT/U d- s++: a18 C++++>$ UB/L/X/*++++(+)>$ P+++(++++)>$
L++++(+++) E W++(+) N+++(++) o? K? w--- O? M++ V? PS+() PE+(-) Y+
PGP+++ t+(+++) 5 X R? tv-(--) b++++(++) DI+ D+ G e->++++$ h!*()>++$ r  
!y?(-)
------END GEEK CODE BLOCK------


/*
  * NOTE: Make sure you set read_memory_barrier() and 
write_memory_barrier()
  * properly for your architecture, otherwise this code is not likely to 
work
  */

#include <stdarg.h>
#include <stdio.h>
#include <stdlib.h>
#include <errno.h>
#include <string.h>
#include <fcntl.h>
#include <unistd.h>
#include <signal.h>
#include <sys/types.h>
#include <sys/time.h>
#include <sys/mman.h>

static void handler(int signal);

static void usage(const char *arg0, int err, const char *fmt, ...)
	__attribute__((__noreturn__));

int main(int argc, char **argv);

enum status_t {
	STATUS_RUNNING,
	STATUS_STOPPED,
	STATUS_RESTART,
};

static enum status_t status = STATUS_STOPPED;
static int last_signal = 0;

static void usage(const char *arg0, int err, const char *fmt, ...) {
	va_list ap;
	va_start(ap,fmt);
	if (fmt) {
		if (err) {
			char buf[41] = { };
			strerror_r(err, buf, 40);
			fprintf(stderr,"Error: %s: ",buf);
			err = 0;
		} else {
			fprintf(stderr,"Error: ");
		}
		vfprintf(stderr,fmt,ap);
		fprintf(stderr,"\n");
	}
	va_end(ap);
	
	if (err) {
		char buf[41] = { };
		strerror_r(err, buf, 40);
		fprintf(stderr,"Error: %s\n",buf);
		err = 0;
	}
	
	if (!arg0) arg0 = "[" __FILE__ "]";
	
	fprintf(stderr,
		"Usage: %s ( -h | <timefile> ) \n"
		"    -h:       Display this help text.\n"
		"    timefile: The name of the file in which to provide\n"
		"          shared access to a monotonic time via mmap.\n",
		arg0);
	exit(1);
}

static void handler (int signal) {
	last_signal = signal;
}

/* These are for PPC only, fix for your arch */
#define read_memory_barrier()	__asm__ __volatile__ ("sync": : :"memory")
#define write_memory_barrier()	__asm__ __volatile__ ("eieio": : 
:"memory")

/*
  * The "old_time" is the currently stored value. NOTE: This value is
  * designed to be read and written locklessly, assuming that reading
  * and writing a "long" is atomic on your platform:
  *   To read:
  *     do {
  *       sec1 = time[2];
  *       read_memory_barrier();
  *       usec = time[1];
  *       read_memory_barrier();
  *       sec2 = time[0];
  *       read_memory_barrier();
  *     } while(sec1 != sec2);
  *   To write:
  *     time[0] = sec;
  *     write_memory_barrier();
  *     time[1] = usec;
  *     write_memory_barrier();
  *     time[2] = sec;
  */
#if 0
struct timeval read_time_nolk(volatile long *time) {
	struct timeval res;
	long lastsecs;
	
	do {
		res.tv_sec = time[2];
		read_memory_barrier();
		res.tv_usec = time[1];
		read_memory_barrier();
		lastsecs = time[0];
		read_memory_barrier();
	} while (lastsecs != res.tv_sec);
	
	return res;
}
#endif

static inline void write_time_nolk(volatile long *time, struct timeval 
val) {
	time[0] = val.tv_sec;
	write_memory_barrier();
	time[1] = val.tv_usec;
	write_memory_barrier();
	time[2] = val.tv_sec;
	write_memory_barrier();
}

int main(int argc, char **argv) {
	int fd; void *mem;
	long nulltimebuf[3] = { 0, 0, 0 };
	
	volatile long *oldtime = NULL;
	struct timeval newtime = { 0, 0 };
	struct timeval zerotime = { 0, 0 };
	
	if (argc <= 0)
		usage(NULL,0,"Missing first argument!");
	
	if (argc != 2)
		usage(argv[0],0,"Invalid arguments!");
	
	if (strlen(argv[1]) == 0)
		usage(argv[0],0,"Invalid argument!");
	
	if (!strcmp(argv[1],"-h"))
		usage(argv[0],0,NULL);
	
	/* Trap most signals */
	signal(SIGHUP,&handler);
	signal(SIGINT,&handler);
	signal(SIGQUIT,&handler);
	signal(SIGTERM,&handler);
	
startup:
	/* Open the file */
	fd = open(argv[1], O_RDWR|O_CREAT|O_EXCL, 0666);
	if (fd < 0)
		usage(argv[0],errno,"Could not open file: '%s'",argv[1]);
	
	/* Extend the file */
	if (0 > write(fd, nulltimebuf, 3*sizeof(long)))
		usage(argv[0],errno,"Could not resize file: '%s'",argv[1]);
	
	/* Mmap the file */
	mem = mmap(NULL,4096,PROT_READ|PROT_WRITE,MAP_SHARED,fd,0);
	if (mem == MAP_FAILED)
		usage(argv[0],errno,"Could not map file: '%s'",argv[1]);
	
	oldtime = (volatile long *)mem;
	write_time_nolk(oldtime,zerotime);
	
	/* Enter the run loop */
	status = STATUS_RUNNING;
	while(status == STATUS_RUNNING) {
		/* Get a new timestamp */
		int err = gettimeofday(&newtime,NULL);
		if (err) usage(argv[0],errno,"Could not get the time");
		
		/* Bound the microseconds within 10^6 */
		newtime.tv_usec %= 1000000;
		
		/* Check for the time going backwards.  Since we're the only
		 * writer, we can afford to ignore memory barriers here */
		if (oldtime[0] > newtime.tv_sec || (
					oldtime[0] == newtime.tv_sec &&
					oldtime[1] > newtime.tv_usec
				)) {
			/* Ahh, crud, just spew a warning */
			fprintf(stderr,"WARNING: Time regression: "
					"%lu seconds, %lu microseconds\n",
					oldtime[0] - newtime.tv_sec,
					oldtime[1] - newtime.tv_usec);
		} else {
			/* Ok, the time is fine, so store it in memory */
			write_time_nolk(oldtime,newtime);
		}
		
		/* Check our signal status, if we've received one, then we *
		 * need to handle it and restart or clean up and quit.     */
		switch(last_signal) {
		case 0:
			/* Since we've got no signal, sleep and repeat */
			usleep(1000);
			break;
			
		case SIGHUP:
			status = STATUS_RESTART;
			break;
			
		case SIGQUIT:
		case SIGINT:
		case SIGTERM:
			status = STATUS_STOPPED;
			break;
			
		default:
			fprintf(stderr,"WARNING: Unknown signal: %d\n",
					last_signal);
			status = STATUS_STOPPED;
			break;
		}
	}
	
	fprintf(stderr,"Caught signal, cleaning up...\n");
	
	/* First prevent new accesses */
	if (unlink(argv[1]))
		usage(argv[0],errno,"Could not delete file: '%s'",argv[1]);
	
	/* Now tell listening processes that we're stopped */
	write_time_nolk(oldtime,zerotime);
	
	if (munmap(mem,4096))
		usage(argv[0],errno,"Could not unmap file: '%s'",argv[1]);
	
	if (close(fd))
		usage(argv[0],errno,"Could not close file: '%s'",argv[1]);
	
	if (status == STATUS_RESTART) {
		fprintf(stderr,"Restarting...\n");
		goto startup;
	}
	
	fprintf(stderr,"Quitting...\n");
	exit(0);
}

