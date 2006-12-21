Return-Path: <linux-kernel-owner+w=401wt.eu-S1422769AbWLUGr6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422769AbWLUGr6 (ORCPT <rfc822;w@1wt.eu>);
	Thu, 21 Dec 2006 01:47:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422771AbWLUGr6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Dec 2006 01:47:58 -0500
Received: from nf-out-0910.google.com ([64.233.182.187]:10323 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422769AbWLUGr4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Dec 2006 01:47:56 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=q2yDEj+QlD2+/jT+6yxmYAxHljNHvTvkhJXBW2RmJ5oPHsPOU8gkgwiSS9rkkuy74Hy7bGgBBgzOXpGAAaxIkQ55ZQ3AvkoUoFYeAqFAE5EmVEEfCUozrPVe0LqnKBlHGykxJbsjXZsbLF9xdmNo/XpGExsmpTnB6jSPbs4RO+s=
Message-ID: <787b0d920612202247k1231ca6fy2800c80b52925814@mail.gmail.com>
Date: Thu, 21 Dec 2006 01:47:54 -0500
From: "Albert Cahalan" <acahalan@gmail.com>
To: linux-kernel <linux-kernel@vger.kernel.org>,
       "Linus Torvalds" <torvalds@osdl.org>, "Andrew Morton" <akpm@osdl.org>,
       oleg@tv-sign.ru, mingo@elte.hu, qiyong@fc-cn.com, ebiederm@xmission.com
Subject: nasty thread-related bugs, maybe in exit
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There are big nasty bugs related to threaded processes exiting,
especially when involving: zombie leaders, clone w/o SIGCHLD,
and ptrace. I can make tasks that remain until reboot. I've seen
things stuck in "X" state. I've seen pending SIGKILL and even
blocked SIGKILL. I've seen "D" state pretending to dump core
for eternity, despite having core dumps disabled.

Does this not bother anybody? I posted this twice already:

http://lkml.org/lkml/2006/12/18/312
http://lkml.org/lkml/2006/12/19/335

Killing the parent does NOT always clear these zombies. Well,
perhaps it would, but PID 1 is protected.

The source code included below is cloninator.c minus SIGCHLD.
Run it in a loop, periodically sending it SIGKILL, like this:

gcc -m32 -O2 -std=gnu99 -o foo foo.c
while true; do killall -9 foo; ./foo; sleep 1; done

Note: it's NOT an unlimited fork bomb.

The original has SIGCHLD in the clone flags. Things go very
badly if you rapidly SIGKILL things while ptracing. You can
cause this with "strace" and "killall", but a more reliable
method is to have the ptracer use tgkill to SIGKILL all the
tasks as fast as possible.

Tested: both mainline 2.6.19 and the latest Fedora Core 5 kernel

///////////////////////////////////////////////////////////////
#include <sys/mman.h>
#include <signal.h>
#include <sched.h>
#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <string.h>
#include <unistd.h>
#include <asm/unistd.h>

#include <sys/ipc.h>
#include <sys/shm.h>

#include <stdbool.h>

static void early_write(int fd, const void *buf, size_t count)
{
#if 0
        unsigned long eax = __NR_write;
        /* push and pop because -fPIC probably
           needs ebx for the GOT base pointer */
        __asm__ __volatile__(
                "push %%ebx ; "
                "push %1 ; pop %%ebx ; int $0x80"
                "; pop %%ebx"
                :"=a"(eax)
                :"r"(fd),"c"(buf),"d"(count),"0"(eax)
                :"memory"
        );
#endif
}

static void p_str(char *s)
{
        size_t count = strlen(s);
        early_write(STDERR_FILENO,s,count);
}

static void p_hex(unsigned long u)
{
        char buf[9];
        char x[] = "0123456789abcdef";
        char *s = buf;
        s[8] = '\0';
        int i = 8;
        while(i--)
                buf[7-i] = x[(u>>(i*4))&15];
        early_write(STDERR_FILENO,buf,8);
}

static void p_dec(unsigned long u)
{
        char buf[11];
        char *s = buf+10;
        *s-- = '\0';
        int count = 0;
        while(u || !count)
        {
                *s-- = u%10 + '0';
                u /= 10;
                count++;
        }
        early_write(STDERR_FILENO,s+1,count);
}


#define FUTEX_WAIT              0
#define FUTEX_WAKE              1


typedef int lock_t;

#define LOCK_INITIALIZER 0
static inline void init_lock(lock_t* l) { *l = 0; }

// lock_add performs an atomic add
// and returns the resulting value
static inline int lock_add(lock_t* l, int val)
{
        int result = val;
        __asm__ __volatile__ (
                "lock; xaddl %1, %0;"
                : "=m" (*l), "=r" (result)
                : "1" (result), "m" (*l)
                : "memory");
        return result + val;
        // Returns the value written to memory
}

// lock_bts_high_bit atomically tests and
// sets the high bit and returns
// true if the bit was clear initially
static inline bool lock_bts_high_bit(lock_t* l)
{
        bool result;
        __asm__ __volatile__ (
                "lock; btsl $31, %0;\n\t"
                "setnc %1;"
                : "=m" (*l), "=q" (result)
                : "m" (*l)
                : "memory");
        return result;
}

static int futex(int* uaddr, int op, int val,
const struct timespec*timeout, int*uaddr2, int val3)
{
        (void)timeout;
        (void)uaddr2;
        (void)val3;
        int eax = __NR_futex;
        __asm__ __volatile__(
                "push %%ebx ; push %1 ; pop %%ebx"
                " ; int $0x80; pop %%ebx"
                :"=a"(eax)
                :"r"(uaddr),"c"(op),"d"(val),"0"(eax)
                :"memory"
        );
        return eax;
}

// lock will wait for and lock a mutex
static void lock(lock_t* l)
{
        // Check the mutex and set held bit
        if (lock_bts_high_bit(l))
        {
                // Got the mutex
                return;
        }
        // Increment wait count
        lock_add(l, 1);

        while (true)
        {
                // Check the mutex and set held bit
                if (lock_bts_high_bit(l))
                {
                        // Got mutex, decrement wait count
                        lock_add(l, -1);
                        return;
                }

                int val = *l;
                // Ensure mutex not given up since check
                if (!(val & 0x80000000))
                        continue;

                // Wait for the mutex
                futex(l, FUTEX_WAIT, val, NULL, NULL, 0);
        }
}

// unlock will release a mutex
static void unlock(lock_t* l)
{
        // Turn off lock held bit and check for waiters
        if (lock_add(l, 0x80000000) == 0)
        {
                // No waiters
                return;
        }

        // Waiters found, wake up one of them
        futex(l, FUTEX_WAKE, 1, NULL, NULL, 0);
}

unsigned toomany = 42;

struct data {
        unsigned nprocs;
        lock_t lock;
        unsigned count;
};

struct data *data;

static struct data *get_shm(void)
{
        void *addr;
        int shmid;

        // create
        shmid = shmget(IPC_PRIVATE,42,IPC_CREAT|0666);
        // attach
        addr = shmat(shmid, NULL, 0);
        // don't want it to stay around
        shmctl(shmid, IPC_RMID, NULL);

        return addr;
}
static int
__attribute__((noreturn,regparm(3),used,unused))
do_stuff(void *arg)
{
        lock(&data->lock);
        data->nprocs++;
        unlock(&data->lock);
        srand((unsigned long)arg);

        int time_to_die;

        for(;;)
        {
                time_to_die = 0;
                lock(&data->lock);
                if(data->nprocs > toomany)
                {
                        data->nprocs--;
                        time_to_die = 1;
                }
                unlock(&data->lock);
                if(time_to_die)
                {
                        p_str("exiting\n");
                        /* don't even think of getting hit
                         * by a signal while the stack is
                         * getting freed */
                        __asm__ __volatile__(
                                "mov %%esp,%%ebx;"
                                "andl $0xfffff000,%%ebx;"
                                "int $0x80;"
                                "mov %0,%%eax;"
                                "int $0x80"
                                :
                                :"n"(__NR_exit),"c"(4096),"a"(__NR_munmap)
                                :"memory"
                        );
                }

                char *msg = "cloning\n";
                int clone_flags = CLONE_VM|CLONE_FS|CLONE_FILES;
                switch((int) (10.0 * (rand() / (RAND_MAX + 1.0))))
                {
                        int ret;
                default:
                        sched_yield();
                        break;
                case 1 ... 3:
                        p_str("forking\n");
                        __asm__ __volatile__(
                                "int $0x80"
                                :"=a"(ret)
                                :"0"(__NR_fork)
                                :"memory"
                        );
                        if(!ret)
                        {

                                // child of a fork
                                lock(&data->lock);
                                data->nprocs++;
                                unlock(&data->lock);
                                unsigned t1,t2;
                                __asm__ __volatile__(
                                        "rdtsc"
                                        :"=a"(t1),"=d"(t2)
                                );
                                srand(t1^t2);
                                continue;
                        }
                        if(ret<0)
                        {
                                char ec[80];
                                snprintf(
                                        ec,
                                        sizeof ec,
                                        "fork error %d (%s)\n",
                                        -ret,
                                        strerror(-ret)
                                );
                                p_str(ec);
                        }
                        break;
                case 4 ... 5:
                        msg = "threading\n";
                        clone_flags |= (CLONE_THREAD|CLONE_SIGHAND);
                        // FALL THROUGH
                case 6 ... 9:
                        p_str(msg);
                        ;
                        char *stack = mmap(
                                0,
                                4096,
                                PROT_READ|PROT_WRITE,
                                MAP_PRIVATE|MAP_ANONYMOUS,
                                0,
                                0
                        );
                        __asm__ __volatile__(
                                "pushl %%ebx\n\t"
                                "movl %[clone_flags],%%ebx\n\t"
                                "int $0x80\n\t"
                                "mov %%eax,%%ecx\n\t"
                                "jecxz 1f\n\t"
                                "jmp 2f\n"
                                "1:\n\t"
                                // child (ecx is 0)
                                "rdtsc\n\t"
                                "xorl %%edx,%%eax\n\t"
                                "jmp *%[do_stuff]\n"
                                // parent
                                "2:\n\t"
                                "popl %%ebx\n"
                                :"=c"(ret)
                                :"a"(__NR_clone)
                                ,"0"(stack+4096)
                                ,[do_stuff]"D"(do_stuff)
                                ,[clone_flags]"d"(clone_flags)
                                :"memory"
                        );

                        if(ret<0)
                        {
                                munmap(stack,4096);
                                char ec[80];
                                snprintf(
                                        ec,
                                        sizeof ec,
                                        "thread error %d (%s)\n",
                                        -ret,
                                        strerror(-ret)
                                );
                                p_str(ec);
                        }
                        break;
                }
        }
}

extern const char * const sys_siglist[];

static void signal_handler(int signo){
        char mb[80];
        snprintf(
                mb,
                sizeof mb,
                "dying with signal %d (%s)\n",
                signo,
                sys_siglist[signo]
        );
        p_str(mb);
        __asm__ __volatile__(
                "mov %0,%%ebx; int $0x80"
                :
                :"r"(signo+128),"a"(__NR_exit)
                :"memory"
        );
}

static char stack[10240];
int main(int argc, char *argv[])
{
        if(sizeof(void*)>4)
                return 7;
        nice(19);

#if  0
        stack_t ss = {
                .ss_sp = stack,
                .ss_flags = 0,
                .ss_size = sizeof stack,
        };
        sigaltstack(&ss,NULL);

        struct sigaction sa;
        int i = 32;
        memset(&sa, 0, sizeof(sa));
        sa.sa_handler = signal_handler;
        sigfillset(&sa.sa_mask);

        while(i--) switch(i){
        default:
                sigaction(i,&sa,NULL);
        case 0:
        case SIGINT:   /* ^C */
        case SIGTSTP:  /* ^Z */
        case SIGTTOU:  /* see stty(1) man page */
        case SIGQUIT:  /* ^\ */
        case SIGPROF:  /* profiling */
        case SIGKILL:  /* can not catch */
        case SIGSTOP:  /* can not catch */
        case SIGWINCH: /* don't care if window size changes */
                ;
        }
#endif

        data = get_shm();
        data->nprocs = 1;
        signal(SIGCHLD,SIG_IGN);
        char *stack = mmap(
                0,
                4096,
                PROT_READ|PROT_WRITE,
                MAP_PRIVATE|MAP_ANONYMOUS,
                0,
                0
        );
        __asm__ __volatile__(
                "mov %0, %%esp ; jmp *%1"
                :
                :"r"(stack+4096), "r"(do_stuff)
                :"memory"
        );
        return 0;
}

//////////////////////////////////////////////
