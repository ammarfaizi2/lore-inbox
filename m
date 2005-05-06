Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262134AbVEFBl5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262134AbVEFBl5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 May 2005 21:41:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262136AbVEFBl5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 May 2005 21:41:57 -0400
Received: from rwcrmhc14.comcast.net ([216.148.227.89]:40870 "EHLO
	rwcrmhc14.comcast.net") by vger.kernel.org with ESMTP
	id S262134AbVEFBlO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 May 2005 21:41:14 -0400
From: Parag Warudkar <kernel-stuff@comcast.net>
To: linux-kernel@vger.kernel.org
Subject: X86_64 Ctx switch times - 32bit vs 64bit
Date: Thu, 5 May 2005 21:38:57 -0400
User-Agent: KMail/1.8
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_xqseC+3jSK+UMC2"
Message-Id: <200505052138.57821.kernel-stuff@comcast.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_xqseC+3jSK+UMC2
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I was experimenting with the attached program (taken from an IBM 
Developerworks article) to find the context switch times on AMD64 machine.

With a 64bit binary I get average 5 to 8 usec/cswitch, whereas the same 
program compiled as 32bit consistently gives >= 10 usec/cswitch - sometimes 
even 13 usec/cswitch.

Are there more context switching overheads when running 32bit programs on a 
64bit kernel?

Kernel version is 2.6.11-gentoo x86_64.
64bit compile  - g++ -O2 -pthread csfast5.cpp -ocsfast64
32bit compile  - g++ -m32 -O2 -pthread csfast5.cpp -ocsfast32
Run - ./csfast{32/64} -t 40 -c4 10

Parag

--Boundary-00=_xqseC+3jSK+UMC2
Content-Type: text/x-c++src;
  charset="us-ascii";
  name="csfast5.cpp"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="csfast5.cpp"

#ifdef _WIN32
#    include <windows.h>
#    define errno        GetLastError()
#    define SLEEP(n)        Sleep(1000*(n))
#    define CRITS CRITICAL_SECTION
#    define LOCK    EnterCriticalSection
#    define UNLOCK LeaveCriticalSection
#    define _WIN32_WINNT    0x0500
#    define SLASHC    '\\'
#    define SLASHSTR    "\\"

    char *facility = "CRITSECT";
    HANDLE *th_handles;
    typedef HANDLE THREAD_T;

    void tstart(LARGE_INTEGER *);
    void tend(LARGE_INTEGER *);
    double tval(LARGE_INTEGER *, LARGE_INTEGER *);

#else
#    define WINAPI
#    include <unistd.h>
#    include <stdlib.h>
#    include <string.h>
#    include <errno.h>
#    include <sys/types.h>
#    include <sys/wait.h>
#    include <sys/time.h>
#    include <fcntl.h>
#    include <pthread.h>
#    define SLEEP(n)        sleep(n)
#    define CRITS pthread_mutex_t
#    define LOCK    pthread_mutex_lock
#    define UNLOCK    pthread_mutex_unlock
#    define SLASHC    '/'
#    define SLASHSTR    "/"

    char *facility = "mutex_lock";
    pthread_t *th_handles;
    typedef pthread_t THREAD_T;

    void tstart(struct timeval *);
    void tend(struct timeval *);
    double tval(struct timeval *, struct timeval *);

#endif

typedef struct thrdmem {
    unsigned long thrdId;
#ifdef _WIN32
    LARGE_INTEGER _tstart;
    LARGE_INTEGER _tend;
#else
    struct timeval _tstart;
    struct timeval _tend;
#endif
    int threadnum;
    unsigned long tcounter;
} thrdmem_t;
CRITS *crits;
int ncrits;
thrdmem_t *thrdm;

int nthreads = 2;
int showme = 0;
int csv = 0;

int Unlock(int);
int Lock(int);

void *Malloc(size_t);

#include <stdio.h>
#include <ctype.h>

#define equal    !strcmp
#define equaln    !strncmp
#define MAXCOUNT    100000


//
// csfast [-d] -[t nthreads] [-c ncrits] [maxcount]
//
// This program does pthread_mutexes and Win2k Critical Sections
// These are the fastest thread synchronization primitives on the
// respective platforms.
//
// We create nthreads execution environments and and ncrits locks
// (ncrits > nthreads) and pass a token back and forth
// between them as fast as we can. We count the number and times and
// produce a context switches per second number.
//


void USAGE();
int do_threads();
size_t atoik(char *s);

unsigned long maxcount = MAXCOUNT;

char *applname;
char applnamebuf[256];

unsigned long thrdId;        // Thread ID

int main(int ac, char *av[])
{
    int ret = 0;

    //strcpy(applnamebuf,av[0]);
    if(strrchr(av[0],SLASHC))
        strcpy(applnamebuf, strrchr(av[0],SLASHC)+1);
    else
        strcpy(applnamebuf, av[0]);
#ifdef _WIN32
    {
        char *q;
        
        if((q=strrchr(applnamebuf, '.')))
            if(!equal(q+1,"exe"))
                strcat(applnamebuf,".exe");
    }
#endif
    applname = applnamebuf;

    if(ac == 1) {
        USAGE();
        return 0;
    }
    while(ac > 1) {
        if(equal(av[1],"-debug") || equal(av[1],"-d")) {
            ac--;
            av++;
            showme++;
        }
        else if(equal(av[1],"-csv")) {
            ac--;
            av++;
            csv = 1;
        }
        else if(equaln(av[1], "-t",2)) {
            if(av[1][2] == 0) {
                ac--;
                av++;
                nthreads = atoik(av[1]);
            }
            else {
                nthreads = atoik(&av[1][2]);
            }
            //if(nthreads > 1000) nthreads = 1000;
            if(nthreads < 2) nthreads = 2;
            ac--;
            av++;
        }
        else if(equaln(av[1], "-c",2)) {
            if(av[1][2] == 0) {
                ac--;
                av++;
                ncrits = atoik(av[1]);
            }
            else {
                ncrits = atoik(&av[1][2]);
            }
            ac--;
            av++;
        }
        else if(isdigit(av[1][0])) {
            maxcount = atoik(av[1]);
            ac--;
            av++;
            if(maxcount == 0)
                maxcount = 1;
        }
    }
    //
    // There has to be at least 1 more critical section than threads.
    //
    if(ncrits <= nthreads)
        ncrits = nthreads + 1;

    ret = do_threads();
    return ret;
}

void USAGE()
{
    printf("%s [-d [-d [-d]]] [-t nthreads] [-c ncrits] [maximum count]\n",applname);
    return;
}

unsigned long WINAPI threadrun(void * var)
{
    unsigned i;
    thrdmem_t *t = (thrdmem_t *)var;

    int tnum = t->threadnum;
    int k = tnum;
    int k1;
    int counterA = tnum;

    Lock(k);
#ifdef _WIN32
    Sleep(100);
#else
    sleep(1);
#endif

    tstart(&t->_tstart);

    for(i = 0; i < maxcount; i++) {
        k1 = k + 1;
        if(k1 >= ncrits)
            k1 = 0;
        Lock(k1);
        Unlock(k);
        if(showme) {
            if(showme > 1) {
                printf("T%d\n",tnum); fflush(stdout);
            }
            else if (showme > 2) {
                printf("T%d: i=%d %d\n", tnum,i,counterA); fflush(stdout);
            }
        }
        counterA += nthreads;

        k = k1;
        t->tcounter++;
    }
    Unlock(k);
    tend(&t->_tend);

    if(showme > 0) {
        // Don't let my printf's interfere with the timing of other threads.
        SLEEP(2+(nthreads/40));
        double tim = tval(&t->_tstart, &t->_tend);

        printf("%lu %s/thread Context switches in %7.3f sec ",
            maxcount, facility, tim);

        printf("%7.3f usec/cswitch",
            (tim*1e6)/(maxcount*nthreads));
        printf("\n");
        fflush(stdout);
    }
#ifdef _WIN32
    ExitThread(0);
#endif
    return 0;
}
int Unlock(int k)
{
    UNLOCK((CRITS *)&crits[k]);
    return 1;
}
int Lock(int k)
{
    LOCK((CRITS *)&crits[k]);
    return 1;
}

int do_threads()
{
    int i;
    unsigned mem;

    //
    // creates ncrits critical sections for use by the threads.
    // creates nthreads thread memories
    // creates nthreads threads and passes a token back and forth.
    //

    mem = (ncrits+1) * sizeof(CRITS);
    //mem = ((mem + 4095)/4096) * 4096;
    crits      = (CRITS     *) Malloc(mem);

    mem = (nthreads+1)*sizeof(thrdmem_t);
    //mem = ((mem + 4095)/4096) * 4096;
    thrdm      = (thrdmem_t *) Malloc(mem);

    mem = (nthreads+1)*sizeof(THREAD_T);
    //mem = ((mem + 4095)/4096) * 4096;
    th_handles = (THREAD_T  *) Malloc(mem);

    for(i = 0; i < ncrits + 1; i++)
#ifdef _WIN32
        InitializeCriticalSection(&crits[i]);
#else
        pthread_mutex_init(&crits[i],NULL);
#endif

    //printf("%d Threads\n",nthreads); fflush(stdout);
    for(i = 0; i < nthreads; i++) {
        thrdm[i].threadnum = i;
#ifdef _WIN32
        //printf("\b\b\b\b%4d",i); fflush(stdout);
        //if((th_handles[i] = CreateThread(NULL, 4096, threadrun,
        if((th_handles[i] = CreateThread(NULL, 8192, threadrun,
                    (void *)&thrdm[i], NULL, &thrdId)) == NULL) {
            printf("Creation of %d thread failed err=%d\n", i,errno);
            fflush(stdout);
            return 1;
        }
        thrdm[i].thrdId = thrdId;
#else
        int terr;

#        define DEC    ( void *(*)(void*) )
        terr = pthread_create(&th_handles[i], NULL,
                    DEC  threadrun, (void *)&thrdm[i]);
        if(terr) {
            printf("pthread_create %d failed: err=%d\n", i,terr);
	    printf("%s", strerror(terr));
            fflush(stdout);
            return 1;
        }
#endif
    }
    //printf("\n"); fflush(stdout);

    for(i = 0; i < nthreads; i++) {
        //printf("\b\b\b\b%4d",i); fflush(stdout);
#ifdef _WIN32
        if(WaitForSingleObject(th_handles[i],INFINITE) == WAIT_FAILED) {
            printf("WaitForSingleObject FAILED: err=%d\n",errno);
#else
        if(pthread_join(th_handles[i],NULL)) {
            printf("pthread_join FAILED: err=%d\n",errno);
#endif
            fflush(stdout);
            return 1;
        }
    }

    //  Check that all threads actually completed their tasks.
    if(thrdm[0].tcounter != maxcount) {
        printf("Thread 0 did %lu out of %lu work\n",
                thrdm[0].tcounter,maxcount);
        fflush(stdout);
        return 1;
    }
    for(i = 1; i < nthreads; i++) {
        if(thrdm[i].tcounter != thrdm[0].tcounter) {
            printf("Thread %d did %lu out of %lu work\n",
                    i,thrdm[0].tcounter,maxcount);
            fflush(stdout);
            return 1;
        }
    }
#ifdef _WIN32
    //printf("All Complete\n"); fflush(stdout);
#endif

    double sum = 0.0;
    double sum2 = 0.0;
    double maxv, minv;
    double avg = 0.0;
    double tim;

    maxv = minv = tval(&thrdm[0]._tstart, &thrdm[0]._tend);
    for(i = 0; i < nthreads; i++) {
        tim = tval(&thrdm[i]._tstart, &thrdm[i]._tend);
        sum  += tim;
        sum2 += (tim*tim);
        if(tim < minv)
            minv = tim;
        if(tim > maxv)
            maxv = tim;
    }

    avg = sum/nthreads;
    if(csv) {
        printf("\"%s\",%lu,%d,%d,",
            facility, maxcount, nthreads, ncrits);
        printf("%.6f,%.6f,%.6f",
            (avg*1e6)/(maxcount*nthreads),
            (minv*1e6)/(maxcount*nthreads),
            (maxv*1e6)/(maxcount*nthreads));
        fflush(stdout);
    }
    else {
        printf("AVG: %lu %s t=%d c=%d in %7.3f sec ",
            maxcount, facility, nthreads, ncrits, avg);
        printf("%7.3f usec/cswitch",
            (avg*1e6)/(maxcount*nthreads));
        fflush(stdout);
    }

    printf("\n");

    return 0;
}

#include <ctype.h>

size_t atoik(char *s)
{
    size_t ret = 0;
    size_t base;

    if(*s == '0') {
        base = 8;
        if(*++s == 'x' || *s == 'X') {
            base = 16;
            s++;
        }
    }
    else
        base = 10;

    for(; isxdigit(*s); s++) {
        if(base == 16)
            if(isalpha(*s))
                ret = base*ret + (toupper(*s) - 'A');
            else
                ret = base*ret + (*s - '0');
        else if(isdigit(*s))
                ret = base*ret + (*s - '0');
        else
            break;
    }
    for(; isalpha(*s); s++) {
        switch(toupper(*s)) {
        case 'K': ret *= 1024; break;
        case 'M': ret *= 1024*1024; break;
        default:
            return ret;
        }
    }
    return ret;
}

#ifdef _WIN32
static LARGE_INTEGER freq; // GLOBAL
static int tfirst = 1;

void tstart(LARGE_INTEGER *t)
{
    if(tfirst) {
        QueryPerformanceFrequency(&freq);
        tfirst = 0;
    }
    QueryPerformanceCounter(t);
}
void tend(LARGE_INTEGER *t)
{
    QueryPerformanceCounter(t);
}

double tval(LARGE_INTEGER *t1, LARGE_INTEGER *t2)
{
    return ((double)t2->QuadPart -
                (double)t1->QuadPart)/((double)freq.QuadPart);
}
#else

void tstart(struct timeval *t)
{
    gettimeofday(t, NULL);
}
void tend(struct timeval *t)
{
    gettimeofday(t,NULL);
}

double tval(struct timeval *tv1, struct timeval *tv2)
{
    double t1, t2;

    t1 =  (double)tv1->tv_sec + (double)tv1->tv_usec/(1000*1000);
    t2 =  (double)tv2->tv_sec + (double)tv2->tv_usec/(1000*1000);
    return t2-t1;
}
#endif
void *Malloc(size_t sz)
{
    char *p;

    if(showme) printf("Malloc(%d)=", sz);
    p = (char *)malloc(sz);
    if(p == NULL) {
        (void)printf("malloc(%d) failed\n",sz);
        fflush(stdout);
        exit(1);
    }
    memset(p, '\0', sz);
    if(showme) printf("%x\n",(unsigned int)p); if(showme) fflush(stdout);
    return (void *)p;
}

// typedef struct _RTL_CRITICAL_SECTION {
//     PRTL_CRITICAL_SECTION_DEBUG DebugInfo;
//     LONG LockCount;
//     LONG RecursionCount;
//     HANDLE OwningThread;        
//     HANDLE LockSemaphore;
//     ULONG_PTR SpinCount;        
// } RTL_CRITICAL_SECTION, *PRTL_CRITICAL_SECTION;

--Boundary-00=_xqseC+3jSK+UMC2--
