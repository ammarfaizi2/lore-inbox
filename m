Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261444AbUJZTSC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261444AbUJZTSC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 15:18:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261485AbUJZTSC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 15:18:02 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:60683 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S261444AbUJZTJx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 15:09:53 -0400
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: "Rui Nuno Capela" <rncbc@rncbc.org>
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.9-mm1-V0
Date: Tue, 26 Oct 2004 22:09:30 +0300
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org
References: <20041022155048.GA16240@elte.hu> <200410260827.39888.vda@port.imtp.ilyichevsk.odessa.ua> <62112.195.245.190.94.1098787213.squirrel@195.245.190.94>
In-Reply-To: <62112.195.245.190.94.1098787213.squirrel@195.245.190.94>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_qDqfB9BcT1KYAlk"
Message-Id: <200410262209.30332.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_qDqfB9BcT1KYAlk
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Tuesday 26 October 2004 13:40, Rui Nuno Capela wrote:
> Denis Vlasenko wrote:
> >
> > <shameless plug>
> > Maybe this program will be useful. It is designed to give you
> > overall system statistics without the need to scan entire /proc/NNN
> > forest. Together with nice -20, it will hopefully not stall.
> >
> > Compiled with dietlibc. If you will have trouble compiling it,
> > binary is attached too.
> >
> > Latest version is 0.9 but it seems I forgot it in my home box :(
> </shameless plug>
> 
> Thanks for nmeter. I have changed a couple of little bits to build with
> gcc-3.4 here (see diff attached).

Hmm will it compile on 3.4 with "static inline"?

> Indeed, it says 0.7 as its version string. What's up on 0.9?

Here it is.
--
vda

--Boundary-00=_qDqfB9BcT1KYAlk
Content-Type: text/x-csrc;
  charset="koi8-r";
  name="nmeter.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="nmeter.c"

// Based on nanotop.c from floppyfw project
// Released under GPL
// Contact me: vda@port.imtp.ilyichevsk.odessa.ua

//TODO: 
// simplify code
// /proc/locks
// /proc/stat:
// disk_io: (3,0):(22272,17897,410702,4375,54750)
// btime 1059401962

#include <time.h>	// timezone (global var)
#include <sys/time.h>	// gettimeofday
#include <string.h>	// strstr etc
#include <stdarg.h>	// f(...)
#include <fcntl.h>	// O_RDONLY

#define VERSION_STR "0.9"
#define DELIM_CHAR ' '

//==============
#define NL "\n"
typedef unsigned long long ullong;
typedef unsigned long ulong;

typedef ulong sample_t;

//==============
#define proc_file_size 4096

typedef struct proc_file {
    char *name;
    int gen;
    char *file;
} proc_file;

proc_file proc_stat = { "/proc/stat", -1 };
proc_file proc_net_dev = { "/proc/net/dev", -1 };
proc_file proc_meminfo = { "/proc/meminfo", -1 };
proc_file proc_diskstats = { "/proc/diskstats", -1 };
struct timeval tv;
int gen=-1;
int is26=0;

//==============
#if 0
#include <stdio.h>
void dprintf(const char *fmt, ...) {
    va_list ap;
    va_start(ap, fmt);
    vprintf(fmt, ap);
    va_end(ap);
}
#else
extern void dprintf(const char *fmt, ...) {}
#endif

//==============
char outbuf[4096];
char *cur_outbuf = outbuf;
int delta = 1000000;
int deltanz = 1000000;

static inline void reset_outbuf() {
    cur_outbuf = outbuf;
}

static inline int outbuf_count() {
    return cur_outbuf-outbuf;
}

static inline void print_outbuf() {
    if(cur_outbuf>outbuf) {
	write(1, outbuf, cur_outbuf-outbuf);
	cur_outbuf = outbuf;
    }
}

void put(const char *s) {
    int sz = strlen(s);
    if(sz > (outbuf+sizeof(outbuf))-cur_outbuf)
	sz = (outbuf+sizeof(outbuf))-cur_outbuf;
    memcpy(cur_outbuf, s, sz);
    cur_outbuf += sz;
}

void put_c(char c) {
    if(cur_outbuf < outbuf+sizeof(outbuf))
	*cur_outbuf++ = c;
}

//==============
char* simple_itoa(char *s, int sz, unsigned long v, int pad) {
//==============
    s += sz;
    *--s = '\0';
    while (--sz > 0) {
        *--s = "0123456789"[v%10];
        pad--;
        v /= 10;
        if(!v && pad<=0) break;
    }
    return s;
}

//==============
int readfile_z(char *buf, int sz, const char* fname) {
//==============
    int fd;
    fd=open(fname,O_RDONLY);
    if(fd<0) return 1;
    sz = read(fd,buf,sz-1);
    close(fd);
    if(sz<0) {
	buf[0]='\0';
	return 1;
    }
    buf[sz]='\0';
    return 0;
}

//==============
int rdval(const char* p, const char* key, sample_t *vec, ...) {
//==============
    va_list arg_ptr;
    int indexline;
    int indexnext;

    p = strstr(p,key);
    if(!p) return 1;
	
    p += strlen(key);
    va_start(arg_ptr, vec);
    indexline = 1;
    indexnext = va_arg(arg_ptr, int);
    while(1) {
    	while(*p==' ' || *p=='\t') p++;
	if(*p=='\n' || *p=='\0') break;

        if(indexline == indexnext) { // read this value
            *vec++ = strtoul(p, NULL, 10);
            indexnext = va_arg(arg_ptr, int);
        }
    	while(*p > ' ') p++; // skip over value
        indexline++;
    }
    va_end(arg_ptr);
    return 0;
}

//==============
int rdval_diskstats(const char* p, sample_t *vec) {
//   1    2 3   4     5     6(rd)  7      8     9     10(wr) 11      12 13    14
//   3    0 hda 51292 14441 841783 926052 25717 79650 843256 3029804 0 148459 3956933
//   3    1 hda1 0 0 0 0 <- ignore if only 4 fields
//==============
    sample_t rd;
    int indexline = 0;
    vec[0] = 0;
    vec[1] = 0;
    while(1) {
        indexline++;
        while(*p==' ' || *p=='\t') p++;
        if(*p=='\0') break;
        if(*p=='\n') {
            indexline = 0;
	    p++;
            continue;
        }
        if(indexline == 6) {
            rd = strtoul(p, NULL, 10);
        } else
        if(indexline == 10) {
            vec[0] += rd;  // TODO: *sectorsize (don't know how to find out sectorsize)
            vec[1] += strtoul(p, NULL, 10);
    	    while(*p!='\n' && *p!='\0') p++;
	    continue;
        }
        while(*p > ' ') p++; // skip over value
    }
    return 0;
}

//==============
void scale(sample_t ul) {
//==============
    char buf[5];
    int index = 0;
    ul *= 10;
    if(ul>9999*10) { // do not scale if 9999 or less
	while(ul >= 10000) {
	    ul /= 1024;
	    index++;
	}
    }

    if(!index) {/* use 1234 format */
	buf[0] = " 123456789"[ul/10000];
	if(buf[0]== ' ') buf[1] = " 123456789"[ul/1000%10];
	            else buf[1] = "0123456789"[ul/1000%10];
	if(buf[1]== ' ') buf[2] = " 123456789"[ul/100%10];
                    else buf[2] = "0123456789"[ul/100%10];
	buf[3] = "0123456789"[ul/10%10];
    } else if(ul>=100) { /* use 123k format */
	if( (buf[0]= " 123456789"[ul/1000]) == ' ')
	    buf[1] = " 123456789"[ul/100%10];
	else
	    buf[1] = "0123456789"[ul/100%10];
	buf[2] = "0123456789"[ul/10%10];
	buf[3] = " kMGTEP"[index];
    } else { /* use 1.2M format */
	buf[0] = "0123456789"[ul/10];
	buf[1] = '.';
	buf[2] = "0123456789"[ul%10];
	buf[3] = " kMGTEP"[index];
    }
    buf[4] = 0;
    put(buf);
}

//==============
const char* prepare(proc_file *pf) {
    if(!pf->file) pf->file = (char*)malloc(proc_file_size);
    if(pf->gen != gen) {
	pf->gen = gen;
	readfile_z(pf->file, proc_file_size, pf->name);
    }
    return pf->file;
}

//==============
#define S_STAT(a) \
typedef struct a { \
    struct s_stat *next; \
    int (*collect)(struct a *s); \
    const char *label; \
    int width;

S_STAT(s_stat)
} s_stat;

#define MALLOC_STAT(type,var) type *var = (type*)malloc(sizeof(type))

//==============
//     user nice system idle  iowait irq  softirq (last 3 only in 2.6)
//cpu  649369 0 341297 4336769 11640 7122 1183
//cpuN 649369 0 341297 4336769 11640 7122 1183
#define N 7
S_STAT(cpu_stat)
    sample_t old[N];
    int bar_sz;
    char *bar;
} cpu_stat;

//==============
int collect_cpu(cpu_stat *s) {
//==============
    sample_t data[N] = {0,0,0,0,0,0,0};
    sample_t frac[N] = {0,0,0,0,0,0,0};
    sample_t all = 0;
    int norm_all = 0;
    int bar_sz = s->bar_sz;
    char *bar = s->bar;
    int i;

    if(rdval(prepare(&proc_stat), "cpu ", data, 1, 2, 3, 4, 5, 6 ,7))
	return 1;
    
    put_c('[');

    for(i=0; i<N; i++) {
	sample_t old = s->old[i];
	if(data[i] < old) old = data[i];	//sanitize
        s->old[i] = data[i];
        all += (data[i] -= old);
    }

    if(all) {
//dprintf("data2:");
	for(i=0; i<N; i++) {
	    ullong t = bar_sz*(ullong)data[i];
	    norm_all += data[i] = t / all;
	    frac[i] = t % all;
//dprintf(" %lu/%lu",data[i],frac[i]);
	}
//dprintf(" norm_all %lu\n",norm_all);
    
	while(norm_all<bar_sz) {
	    sample_t max=frac[0]; int pos=0;
	    //for(i=1; i<4; i++) if(frac[i]>=max) max=frac[i], pos=i;
	    for(i=1; i<N; i++) {
		if(frac[i]>=max) max=frac[i], pos=i;
	    }
	    frac[pos]=0;	//avoid bumping same value twice
	    data[pos]++;
//dprintf("bumped %i\n",pos);
	    norm_all++;
        }
    
//dprintf("bar_sz %i\n",bar_sz);
//dprintf("sys %i\n",data[2]);
//dprintf("usr %i\n",data[0]);
//dprintf("nice %i\n",data[1]);
	memset(bar,'.',bar_sz);
	memset(bar,'S',data[2]); bar+=data[2]; //sys
	memset(bar,'U',data[0]); bar+=data[0]; //usr
	memset(bar,'N',data[1]); bar+=data[1]; //nice
	memset(bar,'D',data[4]); bar+=data[4]; //iowait
	memset(bar,'I',data[5]); bar+=data[5]; //irq
	memset(bar,'i',data[6]); bar+=data[6]; //softirq
    } else {
	memset(bar,'?',bar_sz);
    }
    put(s->bar);
    put_c(']');
    return 0;
}

//==============
s_stat* init_cpu(const char *param) {
//==============
    int sz;
    MALLOC_STAT(cpu_stat,s);
    s->collect = collect_cpu;
    s->label = "cpu ";
    s->width = 4;

    sz = strtol(param, NULL, 0);
    if(sz<10) sz=10;
    if(sz>1000) sz=1000;

    s->bar = (char*)malloc(sz+1);
    s->bar[sz]=0;
    s->bar_sz = sz;
    s->width = sz+2;
    return (s_stat*)s;
}

//==============
S_STAT(int_stat)
    sample_t old;
    int no;
    char numlabel[6];
} int_stat;

//==============
int collect_int(int_stat *s) {
//==============
    sample_t data[1];

    if(rdval(prepare(&proc_stat), "intr", data, s->no))
	return 1;

    sample_t old = s->old;
    if(data[0] < old) old = data[0];	//sanitize
    s->old = data[0];
    scale(data[0] - old);
    return 0;
}

//==============
s_stat* init_int(const char *param) {
//==============
    MALLOC_STAT(int_stat,s);
    s->collect = collect_int;
    s->width = 4;
    if(param[0]=='\0') {
	s->no = 1;
	s->label = "int ";
    } else {
	int n = strtoul(param, NULL, 0);
	s->no = n+2;
	s->label = s->numlabel;
	s->numlabel[0]='i';
	s->numlabel[1]='n';
	s->numlabel[2]='t';
	s->numlabel[3]=(n<=9 ? '0'+n : n+('A'-10));
	s->numlabel[4]=' ';
	s->numlabel[5]='\0';
    }
    return (s_stat*)s;
}

//==============
S_STAT(ctx_stat)
    sample_t old;
} ctx_stat;

//==============
int collect_ctx(ctx_stat *s) {
//==============
    sample_t data[1];

    if(rdval(prepare(&proc_stat), "ctxt", data, 1))
	return 1;

    sample_t old = s->old;
    if(data[0] < old) old = data[0];	//sanitize
    s->old = data[0];
    scale(data[0] - old);
    return 0;
}

//==============
s_stat* init_ctx(const char *param) {
//==============
    MALLOC_STAT(ctx_stat,s);
    s->collect = collect_ctx;
    s->label = "ctx ";
    s->width = 4;
    return (s_stat*)s;
}

//==============
S_STAT(blk_stat)
    const char* lookfor;
    sample_t old[2];
} blk_stat;

//==============
int collect_blk24(blk_stat *s) {
//==============
    sample_t data[2];
    int i;
    if(rdval(prepare(&proc_stat), s->lookfor, data, 1, 2))
    	return 1;

    for(i=0; i<2; i++) {
	sample_t old = s->old[i];
	if(data[i] < old) old = data[i];	//sanitize
	s->old[i] = data[i];
	data[i] -= old;
    }
    scale(data[0]*1024);
    put_c(' ');
    scale(data[1]*1024);
    return 0;
}

//==============
int collect_blk26(blk_stat *s) {
//==============
    sample_t data[2];
    int i;
    if(rdval_diskstats(prepare(&proc_diskstats), data))
	return 1;

    for(i=0; i<2; i++) {
	sample_t old = s->old[i];
	if(data[i] < old) old = data[i];	//sanitize
	s->old[i] = data[i];
	data[i] -= old;
    }
    scale(data[0]*512);
    put_c(' ');
    scale(data[1]*512);
    return 0;
}

//==============
int collect_blk(blk_stat *s) {
//==============
    if(is26) return collect_blk26(s);
    return collect_blk24(s);
}

//==============
s_stat* init_blk(const char *param) {
//==============
    MALLOC_STAT(blk_stat,s);
    s->collect = collect_blk;
//    if(param[0]=='s') {
//	s->label = "sio ";
//	s->lookfor = "swap";
//    } else {
	s->label = "bio ";
	s->lookfor = "page";
//    }
    s->width = 9;
    return (s_stat*)s;
}

//==============
S_STAT(fork_stat)
    sample_t old;
} fork_stat;

//==============
int collect_fork(fork_stat *s) {
//==============
    sample_t data[1];

    if(rdval(prepare(&proc_stat), "processes", data, 1))
	return 1;

    sample_t old = s->old;
    if(data[0] < old) old = data[0];	//sanitize
    s->old = data[0];
    scale(data[0] - old);
    return 0;
}

//==============
s_stat* init_fork(const char *param) {
//==============
    MALLOC_STAT(fork_stat,s);
    s->collect = collect_fork;
    s->label = "fork";  // no trailing space: there usually <1000 forks,
    s->width = 4;       // we trade usual "fork    3" for rare "fork1234"
    return (s_stat*)s;
}

//==============
S_STAT(if_stat)
    sample_t old[4];
    const char *device;
    char *device_colon;
} if_stat;

//==============
int collect_if(if_stat *s) {
//==============
    sample_t data[4];
    int i;

    if(rdval(prepare(&proc_net_dev), s->device_colon, data, 1, 3, 9, 11))
	return 1;

    for(i=0; i<4; i++) {
	sample_t old = s->old[i];
	if(data[i] < old) old = data[i];	//sanitize
        s->old[i] = data[i];
        data[i] -= old;
    }
    put_c(data[1] ? '*' : ' ');
    scale(data[0]);
    put_c(data[3] ? '*' : ' ');
    scale(data[2]);
    return 0;
}

//==============
s_stat* init_if(const char *device) {
//==============
    MALLOC_STAT(if_stat,s);
    s->collect = collect_if;
    s->label = device;
    s->width = 10;
    
    s->device = device;
    s->device_colon = (char*)malloc(strlen(device)+2);
    strcpy(s->device_colon,device);
    strcat(s->device_colon,":");
    return (s_stat*)s;
}

//==============
S_STAT(mem_stat)
    char opt;
} mem_stat;

//==============
int collect_mem(mem_stat *s) {
//==============
//        total:    used:    free:  shared: buffers:  cached:
//Mem:  29306880 21946368  7360512        0  2101248 11956224
//Swap: 100655104 10207232 90447872
//MemTotal:        28620 kB
//MemFree:          7188 kB
//MemShared:           0 kB  <-- ?
//Buffers:          2052 kB
//Cached:           9080 kB
//SwapCached:       2596 kB  <-- ?

    // Not available in 2.6:
    //if(rdval(prepare(&proc_meminfo), "Mem:", data, 1, 2, 5, 6))
    //    return 1;
    sample_t m_total;
    sample_t m_free;
    sample_t m_bufs;
    sample_t m_cached;
    if(rdval(prepare(&proc_meminfo), "MemTotal:", &m_total , 1)) return 1;
    if(rdval(prepare(&proc_meminfo), "MemFree:",  &m_free  , 1)) return 1;
    if(rdval(prepare(&proc_meminfo), "Buffers:",  &m_bufs  , 1)) return 1;
    if(rdval(prepare(&proc_meminfo), "Cached:",   &m_cached, 1)) return 1;
    switch(s->opt) {
    case 'f':
        scale((m_free + m_bufs + m_cached)<<10); break;
    case 't':
        scale(m_total<<10); break;
    default:
        scale((m_total - m_free - m_bufs - m_cached)<<10); break;
    }
    return 0;
}

//==============
s_stat* init_mem(const char *param) {
//==============
    MALLOC_STAT(mem_stat,s);
    s->collect = collect_mem;
    s->width = 4;
    s->opt=param[0];
    switch(param[0]) {
    case 'f':
	s->label = "free "; break;
    case 't':
	s->label = "tot "; break;
    default:
	s->label = "mem "; break;
    }
    return (s_stat*)s;
}

//==============
S_STAT(swp_stat)
} swp_stat;

//==============
int collect_swp(swp_stat *s) {
//==============
    sample_t data[1];
    if(rdval(prepare(&proc_meminfo), "Swap:", data, 2))
	return 1;
	
    scale(data[0]);
    return 0;
}

//==============
s_stat* init_swp(const char *param) {
//==============
    MALLOC_STAT(swp_stat,s);
    s->collect = collect_swp;
    s->label = "swp ";
    s->width = 4;
    return (s_stat*)s;
}

//==============
S_STAT(fd_stat)
} fd_stat;

//==============
int collect_fd(fd_stat *s) {
//==============
    char file[4096];
    sample_t data[2];

    readfile_z(file, sizeof(file), "/proc/sys/fs/file-nr");
    if(rdval(file, "", data, 1, 2))
	return 1;

    scale(data[0]-data[1]);
    return 0;
}

//==============
s_stat* init_fd(const char *param) {
//==============
    MALLOC_STAT(fd_stat,s);
    s->collect = collect_fd;
    s->label = "fd ";
    s->width = 4;
    return (s_stat*)s;
}

//==============
S_STAT(time_stat)
    int prec;
    int scale;
} time_stat;

//==============
int collect_time(time_stat *s) {
//==============
    char buf[16];	// 12:34:56.123456<eol>
			// 1234567890123456
    simple_itoa(buf, 3, tv.tv_sec/(60*60)%24, 2);
    buf[2] = ':';
    simple_itoa(buf+3, 3, tv.tv_sec/60%60, 2);
    buf[5] = ':';
    simple_itoa(buf+6, 3, tv.tv_sec%60, 2);
    
    if(s->prec) {
	buf[8] = '.';
	//simple_itoa(buf+9, s->prec+1, (tv.tv_usec + s->scale/2) / s->scale, s->prec);
	// (fixme: round up seconds too!)
	// so... rounding omitted! just use more prec if you need it! ;)
	simple_itoa(buf+9, s->prec+1, tv.tv_usec / s->scale, s->prec);
    }
    put(buf);
    return 0;
}

//==============
s_stat* init_time(const char *param) {
//==============
    int prec;
    MALLOC_STAT(time_stat,s);
    s->collect = collect_time;
    s->label = "";
    prec = param[0]-'0';
    if(prec<0) prec = 0;
    else if(prec>6) prec = 6;
    s->width = 8+prec + (prec!=0);
    s->prec = prec;
    s->scale = 1;
    while(prec++ < 6)
	s->scale *= 10;
    return (s_stat*)s;
}

//==============
char *header;
//==============
void build_n_put_hdr(s_stat *s) {
//==============
    while(s) {
	int l = 0;
        if(s->label[0]!=' ') {
    	    put(s->label);
	    l = strlen(s->label);
	}
	while(l <= s->width) {
	    put_c(' ');	
	    l++;
	}
        s = s->next;
    }
    put_c('\n');

    header = (char*)malloc(outbuf_count()+1);
    memcpy(header, outbuf, outbuf_count());
    header[outbuf_count()] = '\0';
    //print_outbuf();
}

//==============
void put_hdr(s_stat *s) {
//==============
    if(!header) build_n_put_hdr(s);
    else {
	put(header);
	//print_outbuf();
    }
}

//==============
void run_once(s_stat *s, int without_headers) {
//==============
    gen++;
    int first = 1;
    while(s) {
	if(s->label[0]!=' ') {		// "[prev ][LABEL]data
	    if(!first) put_c(DELIM_CHAR);
    	    if(!without_headers) put(s->label);
	} else {			// "prevLABELdata
	    put(s->label+1);
	}
        if(s->collect(s)) {
	    int w = s->width;
	    while(w-- > 0)
		put_c('?');
	}
        s = s->next;
	first = 0;
    }
}

//==============
typedef s_stat* init_func(const char *param);

const char options[] = "ncmsfixptb";
init_func* init_functions[] = {
    init_if,  
    init_cpu, 
    init_mem, 
    init_swp, 
    init_fd,  
    init_int, 
    init_ctx, 
    init_fork,
    init_time,
    init_blk,
};

//#include <signal.h>
//static void setup_signals() {
//    sigset_t ss;
//
//    sigemptyset(&ss);
//    sigaddset(&ss, SIGPIPE);	
//    sigprocmask(SIG_BLOCK, &ss, NULL);
//}

//==============
int main(int argc, char* argv[]) {
//==============
    s_stat *first = 0;
    s_stat *last = 0;
    s_stat *s;
    int print_headers = 0;
    char *final_str = "\n";
    char *p;
    int fd;
    int i;

    //setup_signals();

    { // this incredibly ugly code is used only for timezone brain damage
	time_t tmp=0;
	// used only for a side effect of setting global timezone var:
	localtime(&tmp); 
    }
    
    if(argc==1) {
	put(
	"Nmeter " VERSION_STR " allows you to monitor your system in real time" NL
	NL
	"Options:" NL
	"c[N]	monitor CPU. N - bar size, default 10" NL
	"	(legend: S:system U:user N:niced D:iowait I:irq i:softirq)" NL
	"nIFACE	monitor network interface IFACE" NL
	"m[f/t]	monitor allocated/free/total memory" NL
	"s	monitor allocated swap" NL
	"f	monitor number of used filedescriptors" NL
	"i[NN]	monitor total/specific IRQ rate" NL
	"x	monitor context switch rate" NL
	"p	monitor process creation rate" NL
	"b	monitor block io" NL
	//"b[s]	monitor block io (swap io)" NL
	"t[N]	show time (with N decimal points)" NL
	"d[N]	milliseconds between updates. Default 1000" NL
	"h[N]	print headers above numbers (each N lines, default once)" NL
	"lLABEL	specify label for previous item" NL
	"LLABEL	same + label will be printed without surrounding blanks" NL
	"r	print <cr> instead of <lf> at EOL" NL
	);
	print_outbuf();
	return 0;
    }

    fd = open("/proc/version",O_RDONLY);
    if(fd>=0) {
	char buf[32];
	if(0<read(fd,buf,sizeof(buf)))
	    is26 = (strstr(buf,"Linux version 2.6.")!=NULL);
	close(fd);
    }
    for(i=1; i<argc; i++) {
	p = strchr(options,argv[i][0]);
	if(p) {
	    s = init_functions[p-options](argv[i]+1);
	    if(s) {
		s->next = 0;
		if(!first)
		    first = s;
		else
		    last->next = s;
		last = s;
	    }
	}

// You have to see it... gcc 3.2 coded switch() as 40 element jump table
// OH NO! >>>:^O
/*
#define SW(a) switch(a) {
#define ENDSW }
#define CASE(a,b) case (b): {
#define ENDCASE }
*/
#define SW(a) do {
#define ENDSW } while(0);
#define CASE(a,b) if((a)==(b)) {
#define ENDCASE }
	SW(argv[i][0])
	CASE(argv[i][0],'r')
	    final_str = "\r";
	    break;
	ENDCASE
	CASE(argv[i][0],'d')
	    delta = strtol(argv[i]+1, NULL, 0)*1000;
	    deltanz = delta>0? delta : 1;
	    break;
	ENDCASE
	CASE(argv[i][0],'h')
	    if(argv[i][1]=='\0')
		print_headers = -1;
	    else
		print_headers = strtol(argv[i]+1, NULL, 0);
	    break;
	ENDCASE
	CASE(argv[i][0],'l')
	    if(last)
		last->label=argv[i]+1;
	    break;
	ENDCASE
	CASE(argv[i][0],'L')
	    if(last) {
		argv[i][0]=' ';
		last->label=argv[i];
	    }
	    break;
	ENDCASE
	ENDSW
    }
	
    if(print_headers == -1) {
	build_n_put_hdr(first);
	print_outbuf();
    }
    run_once(first, print_headers);
    reset_outbuf();
    if(delta>=0) {
	gettimeofday(&tv,0);
	usleep(delta>1000000 ? 1000000 : delta-tv.tv_usec%deltanz);
    }
    while(1) {
	gettimeofday(&tv,0);
	tv.tv_sec -= timezone;

	if(print_headers > 0 && gen%print_headers == 0)
	    put_hdr(first);
	run_once(first, print_headers);
	put(final_str);
	print_outbuf();

	// Negative delta -> no usleep at all
	// This will hog the CPU but you can have REALLY GOOD
	// time resolution ;)
	// TODO: detect and avoid useless updates
	// (like: nothing happens except time)
        if(delta>=0) {
	    int rem = delta - ((ullong)tv.tv_sec*1000000+tv.tv_usec)%deltanz;
	    // Sometimes kernel wakes us up just a tiny bit earlier than asked
	    // Do not go to very short sleep in this case
	    if(rem < delta/128) {
		rem += delta;
	    }
	    usleep(rem);
	}
    }

    return 0;
}

--Boundary-00=_qDqfB9BcT1KYAlk--

