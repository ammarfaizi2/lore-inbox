Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <S154788AbQASNpu>; Wed, 19 Jan 2000 08:45:50 -0500
Received: by vger.rutgers.edu id <S154549AbQASNbF>; Wed, 19 Jan 2000 08:31:05 -0500
Received: from sunsite.ms.mff.cuni.cz ([195.113.19.66]:4878 "EHLO sunsite.ms.mff.cuni.cz") by vger.rutgers.edu with ESMTP id <S154785AbQASN0v>; Wed, 19 Jan 2000 08:26:51 -0500
Date: Wed, 19 Jan 2000 14:29:54 +0100
From: Jakub Jelinek <jakub@redhat.com>
To: linux-kernel@vger.rutgers.edu
Subject: siginfo testing program
Message-ID: <20000119142954.E2708@mff.cuni.cz>
Mail-Followup-To: linux-kernel@vger.rutgers.edu
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=0eh6TmSyL6TZE2Uz
X-Mailer: Mutt 0.95.4us
Sender: owner-linux-kernel@vger.rutgers.edu


--0eh6TmSyL6TZE2Uz
Content-Type: text/plain; charset=us-ascii

Hi!

Attached is a patch to test some of the common fault types and whether
proper siginfo is filled out (I forgot to send it with my last patch).
Compile with -D_GNU_SOURCE -lm.

Cheers,
    Jakub
___________________________________________________________________
Jakub Jelinek | jakub@redhat.com | http://sunsite.mff.cuni.cz/~jj
Linux version 2.3.40 on a sparc64 machine (1343.49 BogoMips)
___________________________________________________________________

--0eh6TmSyL6TZE2Uz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="siginfotest.c"

#include <stdio.h>
#include <signal.h>
#include <setjmp.h>
#include <fenv.h>
#include <unistd.h>
#include <sys/mman.h>

jmp_buf j;

int handler(int signum, siginfo_t *info)
{
	printf("sig %d\n", signum);
	printf("si_signo %d si_errno %d si_code %d\n", info->si_signo, info->si_errno, info->si_code);
	switch (signum) {
	case SIGFPE:
	case SIGBUS:
	case SIGILL:
	case SIGSEGV:
		printf("si_addr %08x", info->si_addr);
#ifdef __sparc__
		printf(" si_trapno %08x", *(int *)((&info->si_addr)+1));
#endif
		printf("\n");
		break;
	case SIGCHLD:
		printf("si_pid %d si_uid %d si_status %d\n", info->si_pid, info->si_uid, info->si_status);
		printf("si_utime %ld si_stime %ld", info->si_utime, info->si_stime);
#ifdef __i386__
		printf(" si_uid32 %d", ((unsigned int *)&info->si_stime)[1]);
#endif
		printf("\n");
	}
	siglongjmp(j, 1);
}

static int zero = 0;
double zerod = 0.0;
double small = 1e-30;
double big = 1e+100;
double a, b, c;
unsigned long d;

int main(void)
{
	struct sigaction sa;
	static int aa[10];
	int status;
	char *map;
	
	map = mmap(NULL, 8192, PROT_READ, MAP_PRIVATE|MAP_ANON, -1, 0);
	if (map == MAP_FAILED)
		perror("mmap");
	sa.sa_handler = (void *)handler;
	sigemptyset(&sa.sa_mask);
	sa.sa_flags = SA_SIGINFO;
	if (sigaction(SIGSEGV, &sa, NULL) < 0)
		perror("sigaction");
	if (sigaction(SIGBUS, &sa, NULL) < 0)
		perror("sigaction");
	if (sigaction(SIGFPE, &sa, NULL) < 0)
		perror("sigaction");
	if (sigaction(SIGILL, &sa, NULL) < 0)
		perror("sigaction");
	if (sigaction(SIGCHLD, &sa, NULL) < 0)
		perror("sigaction");
	if (!sigsetjmp(j, 1)) {
		*(volatile int *)0x4000 = 0;
	}
	if (!sigsetjmp(j, 1)) {
		map[56] = 0;
	}
	if (!sigsetjmp(j, 1)) {
		unsigned long a = (long)&aa[5];
		a += 5;
		*(volatile int *)(a) = 0;
	}
	if (!sigsetjmp(j, 1)) {
		fesetenv(FE_NOMASK_ENV);
		d = 26 / zero;
	}
	if (!sigsetjmp(j, 1)) {
		fesetenv(FE_NOMASK_ENV);
		a = 26.0 / zerod;
	}
	if (!sigsetjmp(j, 1)) {
		fesetenv(FE_NOMASK_ENV);
		b = zerod / zerod;
	}
	if (!sigsetjmp(j, 1)) {
		fesetenv(FE_NOMASK_ENV);
		c = small + big;
	}
	if (!sigsetjmp(j, 1)) {
		int pid = fork();
		if (pid < 0) perror("fork");
		if (!pid) {
			sleep(2);
			exit(4);
		}
		sleep(5);
	}
	wait(&status);
	printf("status %08x\n", status);
	if (!sigsetjmp(j, 1)) {
		int pid = fork();
		if (pid < 0) perror("fork");
		if (!pid) {
			kill(getpid(), SIGUSR1);
			exit(4);
		}
		sleep(5);
	}
	wait(&status);
	printf("status %08x\n", status);
	return 0;
}

--0eh6TmSyL6TZE2Uz--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
