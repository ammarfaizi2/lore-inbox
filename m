Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319212AbSH2ORq>; Thu, 29 Aug 2002 10:17:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319213AbSH2ORq>; Thu, 29 Aug 2002 10:17:46 -0400
Received: from 200.225.73.82.netcenter.com.br ([200.225.73.82]:24548 "EHLO
	interaction.com.br") by vger.kernel.org with ESMTP
	id <S319212AbSH2ORm>; Thu, 29 Aug 2002 10:17:42 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Luiz Henrique Shigunov <luiz.shigunov@automatos.com>
To: linux-kernel@vger.kernel.org
Subject: %gs segment register reset when calling signal handler
Date: Thu, 29 Aug 2002 11:23:11 -0300
User-Agent: KMail/1.4.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200208291123.11305.luiz.shigunov@automatos.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I've been working on a program to get process stat from the /proc. The program 
uses pthreads (linuxthreads) and on 2.4 SMP kernels it always SIGSEGV. It 
works fine on 2.4 UP kernels and 2.2 UP and SMP kernels.

Investigating the problem I've found that the SIGSEGV always happens on the 
signal handler of the linuxthreads (pthread_handle_sigrestart). And it 
happens because the %gs segment register is 0.

Sometimes you'll see that only the main thread will stay alive and the other 
ones will die.

I've made this little program to test. It will SIGSEGV after 30 min-1 hour on 
a SMP box. I've tested with this Red Hat box:
Linux 2.4.9-21enterprise #1 SMP Thu Jan 17 13:37:56 EST 2002 i686 unknown
glibc-2.2.4-29

The work around is to use the /lib/libpthread.so.0 (this one doesn't uses the 
%gs register) instead of the default /lib/i686/libpthread.so.0. At least on a 
Red Hat box it works fine.

#include <pthread.h>
#include <unistd.h>
#include <fcntl.h>
#include <limits.h>
#include <dirent.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/time.h>
#include <signal.h>

int walkDir(void) {
    DIR *dir;
    struct dirent *de;
    int file;
    char path[128],st_comm[17];
    pid_t pid,ppid;
    struct dirent dirbuf;

    char st_state;
    int st_utime,st_stime;
    int sm_size,sm_resident ,sm_shared ,sm_trs ,sm_lrs ,sm_drs ,sm_dt ;

    if (!(dir = ::opendir("/proc"))) {
        return -1;
    }

    while ((::readdir_r(dir, &dirbuf, &de) == 0) && (de != NULL))
        if ((pid = ::atoi(de->d_name))) {
            ::snprintf(path, sizeof(path), "/proc/%d/stat",pid);
            if ((file = ::open(path, 0)) >= 0) {
                char readBuf[512];
                size_t num;

                num = ::read(file, readBuf, sizeof(readBuf)-1);
                ::close(file);
                if (num < 0) {
                    ::perror(path);
                    continue;
                }

                readBuf[num] = 0;
                char *tailStr;
                tailStr = ::strrchr(readBuf, ')');
                *tailStr = 0;
                ::memset(st_comm, 0, sizeof(st_comm));
                if (::sscanf(readBuf, "%*d (%15c", st_comm) != 1) {
                    continue;
                }
                if (::sscanf(tailStr+2, "%c %d %*d %*d %*d %*d %*u %*u %*u %*u 
%*u %d %d",
                             &st_state,&ppid,&st_utime,&st_stime) != 4) {
                    continue;
                }

                ::snprintf(path, sizeof(path), "/proc/%d/statm",pid);
                if ((file = ::open(path,0)) >= 0) {
                    num = ::read(file, readBuf, sizeof(readBuf)-1);
                    ::close(file);
                    if (num < 0) {
                        ::perror(path);
                        continue;
                    }
                    readBuf[num] = 0;
                    if (::sscanf(readBuf,"%d %d %d %d %d %d %d ",
                                 &sm_size,&sm_resident ,&sm_shared ,&sm_trs 
,&sm_lrs ,&sm_drs ,&sm_dt) != 7) {
                        ::perror(path);
                        continue;
                    }

                    int openfiles = 0;
                    ::snprintf(path, sizeof(path), "/proc/%d/fd",pid);
                    DIR *pdir;
                    if ((pdir = ::opendir(path))) {
                        struct dirent *pde;
                        while ((::readdir_r(pdir, &dirbuf, &pde) == 0) && (pde 
!= NULL))
                             openfiles++;
                        (void) ::closedir(pdir);
                    }
                }

            }
        }
    (void) ::closedir(dir);
    return 0;
}

#ifdef MY_SIGNAL
pid_t thread_pid, main_pid;
int thread_gs, main_gs;
void (*old_sigrestart)(int);
#endif

pthread_mutex_t mutex = PTHREAD_MUTEX_INITIALIZER;
pthread_cond_t cond = PTHREAD_COND_INITIALIZER;

#ifdef MY_SIGNAL
static void my_pthread_sigrestart(int sig) {
        pid_t my_pid;
        int my_gs;

        my_pid = getpid();
        __asm__ __volatile__ ("mov %%gs, %0": "=a" (my_gs));
        if (my_pid == thread_pid) {
             if (my_gs != thread_gs) {
                  printf("Thread GS dif!! %d - %d\n", my_gs, thread_gs);
                  exit(1);
             }
        } else if (my_pid == main_pid) {
             if (my_gs != main_gs) {
                   printf("main GS dif!! %d - %d\n", my_gs, main_gs);
                   exit(1);
             }
        } else {
             printf("Other thread!\n");
        }
        old_sigrestart(sig);
}

extern "C" int __libc_sigaction(int signum, const struct sigaction *act, 
struct sigaction *oldact);
#endif

void *thread_main(void *arg) {
#ifdef MY_SIGNAL
    struct sigaction sa, oldsa;

    thread_pid = getpid();
    __asm__ __volatile__ ("mov %%gs, %0": "=a" (thread_gs));
    sa.sa_handler = my_pthread_sigrestart;
    sigemptyset(&sa.sa_mask);
    sa.sa_flags = 0;
    if (__libc_sigaction(__SIGRTMIN, &sa, &oldsa)) {
        perror("sigaction thread");
        exit(1);
    }
    old_sigrestart = oldsa.sa_handler;
#endif
    while (1) {
        struct timezone tzone;
        struct timeval now;
        struct timespec timeout;

        ::pthread_mutex_lock(&mutex);
        ::gettimeofday(&now,&tzone);
        timeout.tv_sec  = now.tv_sec + 4;
        timeout.tv_nsec = now.tv_usec * 1000;
        ::pthread_cond_timedwait(&cond, &mutex, &timeout);
        ::pthread_mutex_unlock(&mutex);
    }
}

int main(int argc, char *argv[]) {
    pthread_t threadID;
#ifdef MY_SIGNAL
    struct sigaction sa, oldsa;
#endif

    if (pthread_create(&threadID, NULL, thread_main, NULL)) {
        perror("pthread");
        exit(1);
    }

#ifdef MY_SIGNAL
    main_pid = getpid();
    __asm__ __volatile__ ("mov %%gs, %0": "=a" (main_gs));
    sa.sa_handler = my_pthread_sigrestart;
    sigemptyset(&sa.sa_mask);
    sa.sa_flags = 0;
    if (__libc_sigaction(__SIGRTMIN, &sa, &oldsa)) {
        perror("sigaction main");
        exit(1);
    }
    old_sigrestart = oldsa.sa_handler;
#endif
    while (1) {
        walkDir();
        ::pthread_cond_signal(&cond);
        ::sleep(3);
    }
}

-- 
Luiz Henrique Shigunov
System Analyst
try Automatos - The Automatic MSP
@ www.automatos.com
