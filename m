Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262009AbUCLH7u (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Mar 2004 02:59:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262010AbUCLH7t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Mar 2004 02:59:49 -0500
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:53002 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S262009AbUCLH7M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Mar 2004 02:59:12 -0500
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: Stefan Smietanowski <stesmi@stesmi.com>,
       psycosonic <psycosonic@rootisg0d.org>
Subject: Re: Abysmal network performance since 2.4.25 !!!!!...
Date: Fri, 12 Mar 2004 09:54:08 +0200
X-Mailer: KMail [version 1.4]
Cc: linux-net@oss.sgi.com, linux-kernel@vger.kernel.org
References: <004c01c407cf$5fffa270$0700a8c0@darkgod> <40511B2E.5020704@stesmi.com>
In-Reply-To: <40511B2E.5020704@stesmi.com>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_8YDG8IK8JAVI2CUUT06D"
Message-Id: <200403120954.08103.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_8YDG8IK8JAVI2CUUT06D
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

On Friday 12 March 2004 04:06, Stefan Smietanowski wrote:
> psycosonic wrote:
> > Hey.
> >
> > I'm having some problems since i updated from kernel 2.4.24 to 2.4.25=
 ..
> > it seems that 2.4.25 has some real performance problems.
> > The problem is that i can't get the NIC's to work fine.. i don't know
> > why, i've already used several kernel configurations..
> > i've also tried with patch2.4.25pre4 and... nothin' ...even used anot=
her
> > switch 10/100mbit.. not even with patch-2.4.26pre2 it goes normal,
> > I've compiled the kernel in another computer, with too many different
> > configurations, different hardware.. etc.. and the result is the same=
=2E
> > Some friends of mine are having the same problem.
> > Well.. with kernel 2.4.24 i usually had a max speed of 12Mb/s .. now =
,
> > with 2.4.25 it only goes to 2,2Mb/s MAX speed.  :(
>
> If you're only seeing 12Mbit/s (b=3Dbit, B=3Dbyte) already before
> then there's something at play here with your network I'm afraid.

Most probably he meant 12 _megabytes_/s, =3D=3D 100Mbit/s.
As to 2.4.25 problems, maybe it's just a duplex mismatch.

Use attached program to collect more statistics
(CPU/network load etc).
In case you aren't able to compile it (it was compiled with dietlibc),
I attached static binary executable too.

> Replace the nics and you'll see the problems should go away.
>
> I haven't seen any problems so far with my equipment.
>
> > Computer 1:
> >
> > Pentium 3 @ 733Mhz
> > Board with SIS Chipset.
> > NIC's: SIS900 & Realtek 8139
>
> My laptop has an 8139 and it works fine.
>
> > AMD XP 2600+
> > Board ASUS A7V8X-MX Chipset VIA KT400
> > NIC's: VIA Rhine
>
> If you don't solve it I'll check with my Rhine.
>
> > Please gimme some answer ASAP.. i'm getting crazy :(
>
> Start by getting it up to 100Mbit on the old kernel and then ask
> for more help as 12Mbit/s points to other problems.
--=20
vda
--------------Boundary-00=_8YDG8IK8JAVI2CUUT06D
Content-Type: text/x-csrc;
  charset="iso-8859-1";
  name="nmeter.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="nmeter.c"

// Based on nanotop.c from floppyfw project
// Released under GPL
// Contact me: vda@port.imtp.ilyichevsk.odessa.ua

//TODO: 
// simplify code
// /proc/locks
// /proc/stat:
// disk_io: (3,0):(22272,17897,410702,4375,54750)
// btime 1059401962

//#include <ctype.h>
#include <sys/time.h>	// gettimeofday
#include <string.h>	// strstr etc
#include <stdarg.h>	// f(...)
#include <fcntl.h>	// O_RDONLY

#define VERSION_STR "0.7"
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

extern inline void reset_outbuf() {
    cur_outbuf = outbuf;
}

extern inline int outbuf_count() {
    return cur_outbuf-outbuf;
}

extern inline void print_outbuf() {
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
S_STAT(cpu_stat)
    sample_t old[4];
    int bar_sz;
    char *bar;
} cpu_stat;

//==============
int collect_cpu(cpu_stat *s) {
//==============
    sample_t data[4];
    sample_t frac[4];
    sample_t all = 0;
    int norm_all = 0;
    int bar_sz = s->bar_sz;
    char *bar = s->bar;
    int i;

    if(rdval(prepare(&proc_stat), "cpu ", data, 1, 2, 3, 4))
	return 1;
    
    put_c('[');

//dprintf("data1:");
    for(i=0; i<4; i++) {
	sample_t old = s->old[i];
	if(data[i] < old) old = data[i];	//sanitize
        s->old[i] = data[i];
        all += (data[i] -= old);
//dprintf(" %lu",data[i]);
    }
//dprintf(" all %lu\n",all);

    if(all) {
//dprintf("data2:");
	for(i=0; i<4; i++) {
	    ullong t = bar_sz*(ullong)data[i];
	    norm_all += data[i] = t / all;
	    frac[i] = t % all;
//dprintf(" %lu/%lu",data[i],frac[i]);
	}
//dprintf(" norm_all %lu\n",norm_all);
    
	while(norm_all<bar_sz) {
	    sample_t max=frac[0]; int pos=0;
	    //for(i=1; i<4; i++) if(frac[i]>=max) max=frac[i], pos=i;
	    if(frac[1]>=max) max=frac[1], pos=1;
	    if(frac[2]>=max) max=frac[2], pos=2;
	    if(frac[3]>=max) max=frac[3], pos=3;
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
    if(param[0]=='s') {
	s->label = "sio ";
	s->lookfor = "swap";
    } else {
	s->label = "bio ";
	s->lookfor = "page";
    }
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

    //dprintf("data1:");
    for(i=0; i<4; i++) {
	sample_t old = s->old[i];
	if(data[i] < old) old = data[i];	//sanitize
        s->old[i] = data[i];
        data[i] -= old;
	//dprintf(" %lu",data[i]);
    }
    //dprintf("\n");
    
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

//==============
int main(int argc, char* argv[]) {
//==============
    struct timezone tz;
    s_stat *first = 0;
    s_stat *last = 0;
    s_stat *s;
    int delta = 1000000;
    int deltanz = 1000000;
    int print_headers = 0;
    char *final_str = "\n";
    char *p;
    int fd;
    int i;
    
    if(argc==1) {
	put(
	"Nanometer " VERSION_STR " allows you to monitor your system in real time" NL
	NL
	"Options:" NL
	"c[N]	monitor CPU. N - bar size, default 10" NL
	"nIFACE	monitor network interface IFACE" NL
	"m[f/t]	monitor allocated/free/total memory" NL
	"s	monitor allocated swap" NL
	"f	monitor number of used filedescriptors" NL
	"i[NN]	monitor total/specific IRQ rate" NL
	"x	monitor context switch rate" NL
	"p	monitor process creation rate" NL
	"b[s]	monitor block io (swap io)" NL
	"t[N]	show time (with N decimal points)" NL
	"d[N]	milliseconds between updates. Default 1000" NL
	"h[N]	print headers above numbers (each N lines, default once)" NL
	"lLABEL	specify label for previous item" NL
	"LLABEL	same + label will be printed without surrounding blanks" NL
	"r	print <cr> instead of <lf> at EOL. Try it ;)" NL
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
	//gettimeofday(&tv,0);
	gettimeofday(&tv,&tz); //
	usleep(delta>1000000 ? 1000000 : delta-tv.tv_usec%deltanz);
    }
    while(1) {
	gettimeofday(&tv,&tz);
        tv.tv_sec -= tz.tz_minuteswest*60;

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

--------------Boundary-00=_8YDG8IK8JAVI2CUUT06D
Content-Type: application/x-executable;
  name="nmeter"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="nmeter"

f0VMRgEBAQAAAAAAAAAAAAIAAwABAAAAdIAECDQAAAAAAAAAAAAAADQAIAACAAAAAAAAAAEAAAAA
AAAAAIAECACABAiVIAAAlSAAAAUAAAAAEAAAAQAAAKAgAACgsAQIoLAECIgBAAAgEgAABgAAAAAQ
AABZieZRjUSOBFBWUaNAsgQI6KMOAABQ6AISAAD0w5BXVot0JAwxwIPJ/4n3/PKu99GNQf+LFdiw
BAi5wMIECCnROch+AonI/InXicHzpF4BBdiwBAhfw6HYsAQIPcDCBAiLVCQEcwiIEP8F2LAECMOQ
V1ZTi3QkFItcJBAB805LhfaLVCQYi3wkHMYDAH4muQoAAACJ0DHS9/GJwUuKgvecBAhPhcmIA4nK
dQSF/34FToX2f9qJ2FteX8NXVlOLfCQQi3QkFGoA/3QkHOiQEQAAicOF21hauAEAAAB4II1G/1BX
U+iAEQAAicZT6GARAACDxBCF9ngKxgQ+ADHAW15fw7gBAAAAxgcA6/KQVVdWU1eLfCQci2wkIFf/
dCQc6FkUAABbXonGhfa4AQAAAHRoMcD8g8n/8q730Y10Dv/HBCQBAAAAjXwkKItEJCSKFoD6IHRK
gPoJdEWKFoD6CnQ2hNJ0MjkEJHQQgD4gfgZGgD4gf/r/BCTr1GoKagBW6OUUAACJ64kDifiDxQSD
xwSLAIPEDOvTMcBZW15fXcNGihaA+iB0+ID6CXTz66yQVVdWU4t0JBiLXCQUMf/HBgAAAADHRgQA
AAAAigNHPCB0YjwJdF6KA4TAdFE8CnRIg/8GdDKD/wp1JQEuagpqAFPodBQAAAFGBIoDg8QMPAp0
yYTAdMVDigM8CnS+6/OAOyB+t0Pr+GoKagBT6EkUAACJxYPEDOvnMf9D655bXl8xwF3DQ4oDPCB0
+TwJdPXrlZBWU4PsXGtMJGgKMduB+ZaGAQB2FIH5DycAAHYMwekKQ4H5DycAAHf0hdsPhdUAAAAx
0rsQJwAAicj384qAAp0ECDwgiEQkTA+ElgAAALvoAwAAicgx0vfzuwoAAAAx0okEJPfzioL3nAQI
iEQkTYB8JE0gdE+7ZAAAAInIMdL387sKAAAAMdKJBCT384qC95wECL4KAAAAiEQkTjHSicj39jHS
9/aKgvecBAiIRCRPjUQkTMZEJFAAUOgg/f//g8RgW17Du2QAAACJyDHS9/O7CgAAADHSiQQk9/OK
ggKdBAjrr7voAwAAicgx0vfzuwoAAAAx0okEJPfzioICnQQI6WX///+D+WN2fTHSvugDAACJyPf2
ioACnQQIPCCIRCRMdEW+ZAAAAInIMdL39r4KAAAAMdKJBCT39oqC95wECL4KAAAAiEQkTTHSicj3
9jHS9/aKgvecBAiIRCROioMNnQQI6UP///++ZAAAAInIMdL39r4KAAAAMdKJBCT39oqCAp0ECOu5
vgoAAACJyDHS9/aKgPecBAiIRCRMxkQkTS7rsJBTi1wkCIN7CAB0JKHQsAQIOUMEdBWJQwT/M2gA
EAAA/3MI6K/8//+DxAyLQwhbw2gAEAAA6GMPAACJQwhY68yQVVdWU4PsQItEJFSLVCRUi1Iki0Ag
iVQkEIlEJBTHRCQcAAAAAMdEJBgAAAAAagRqA2oCagGNRCRAUGgVnQQIaKCwBAjod////4kEJOiX
/P//g8QchcC6AQAAAHQKg8RAW15fidBdw2pb6MT7///HRCQQAAAAAFuLTCQMi1wkVItUixCLRIww
OdBzAonCi0wkDItcJFSJRIsQi0SMMCnQiUSMMEEBRCQcg/kDiUwkDH7Gg3wkHAAPhD0BAADHRCQM
AAAAAItEJBSLTCQMmYnVi1SMMInHMcmJ0IlUJASJTCQI9+eLTCQIicOLRCQED6/PD6/FidYx7Yt8
JBwBzlUBxldWU+iwEgAAg8QQi0wkDIlEjDABRCQYiQQkVVdWU+jBFAAAg8QQi0wkDIlEjCBBg/kD
iUwkDH6Mi1wkFDlcJBh9SYtEJCCLVCQkMck5wnIHidC5AQAAAItUJCg5wnIHidC5AgAAADlEJCxy
BbkDAAAA/0QkGItEJBT/RIwwOUQkGMdEjCAAAAAAfLf/dCQUai7/dCQY6FoPAAD/dCREalP/dCQk
6EsPAACLVCRQAVQkKP90JEhqVf90JDDoNA8AAItMJFQBTCQ0g8Qk/3QkNGpO/3QkGOgaDwAAg8QM
i1wkVP9zJOgR+v//al3oQvr//1gx0lnpZP7///90JBRqP+vQkFZTaijoUQ0AAMdABJiEBAjHQAgV
nQQIx0AMBAAAAGoAagD/dCQYicbojQ8AAIPEEIP4CYnDfwW7CgAAAIH76AMAAH4Fu+gDAACNQwFQ
6AgNAACJRiTGBAMAjUMCiUYMWIleIFuJ8F7DU1OLXCQM/3MUjUQkBFBoGp0ECGigsAQI6Dn9//+J
BCToWfr//4PEEIXAugEAAAB1GotTEIsEJDnQcwKJwolDECnQUOhq+///MdJZidBaW8NWU4t0JAxq
IOiVDAAAx0AEAocECMdADAQAAACAPgCJw1h1E8dDFAEAAADHQwgfnQQIidhbXsNqAGoAVuhKDwAA
icKNQAKJQxSDxAyNQxiD+gmJQwjGQxhpxkMZbsZDGnSNQjB+A41CN4hDG8ZDHCDGQx0A67yQU1OL
XCQMagGNRCQEUGgknQQIaKCwBAjodPz//4kEJOiU+f//g8QQhcC6AQAAAHUai1MQiwQkOdBzAonC
iUMQKdBQ6KX6//8x0lmJ0Fpbw5BqFOjVCwAAx0AEyIcECMdACCmdBAjHQAwEAAAAWsNXVlNWVot8
JBhqAmoBjXQkCFb/dxBooLAECOgD/P//iQQk6CP5//+DxBSFwLoBAAAAdUUxybsBAAAAi1QPFIsE
DjnQcwKJwolEDxQpFA6DwQRLeeaLBCTB4ApQ6B76//9qIOgt+P//i0YEweAKUOgL+v//MdKDxAxZ
W1teidBfw1dWU1ZWieaLfCQYVmjEsAQI6Iz7//+JBCToTvn//4XAWVu6AQAAAHVFMcm7AQAAAItU
DxSLBA450HMCicKJRA8UKRQOg8EES3nmiwQkweAJUOio+f//aiDot/f//4tGBMHgCVDolfn//zHS
g8QMX4nQWlteX8ODPdSwBAgAi0QkBHQF6Xj///+JRCQE6e/+//+QahzopQoAAMdABCyJBAiJwliL
RCQEgDhzdBjHQggunQQIx0IQM50ECMdCDAkAAACJ0MPHQgg4nQQIx0IQPZ0ECOvmU1OLXCQMagGN
RCQEUGhCnQQIaKCwBAjosvr//4kEJOjS9///g8QQhcC6AQAAAHUai1MQiwQkOdBzAonCiUMQKdBQ
6OP4//8x0lmJ0Fpbw5BqFOgTCgAAx0AEiokECMdACEydBAjHQAwEAAAAWsNTg+wQi1wkGGoLaglq
A2oBjUQkEFD/cyRorLAECOg++v//iQQk6F73//+DxByFwLoBAAAAdVcxyYtUixCLBIw50HMCicKJ
RIsQKRSMQYP5A37mg3wkBAB0QrgqAAAAUOhu9v///3QkBOhP+P//g3wkFAB0ILgqAAAAUOhT9v//
/3QkFOg0+P//MdKDxBCDxBCJ0FvDuCAAAADr3rggAAAA67xXVlOLdCQQaijoTAkAAInDiXAIiXAg
x0AE+IkECMdADAoAAAD8ifcxwIPJ//Ku99lR6CQJAABWUIlDJOj+CgAAaFGdBAj/cyTouQoAAIPE
GInYW15fw4PsEGoBjUQkEFBoU50ECGi4sAQI6E/5//+JBCTob/b//4PEEIXAugEAAAB0BonQg8QQ
w2oBjUQkDFBoXZ0ECGi4sAQI6B/5//+JBCToP/b//4PEEIXAugEAAAB10GoBjUQkCFBoZp0ECGi4
sAQI6PX4//+JBCToFfb//4PEEIXAugEAAAB1pmoBjUQkBFBob50ECGi4sAQI6Mv4//+JBCTo6/X/
/4PEEIXAugEAAAAPhXj///+LRCQUD75AEIP4ZnQrg/h0dCCLRCQMK0QkCCtEJAQrBCTB4ApQ6OX2
//9ZMdLpRv///4tEJAzr6YtEJAQDRCQIAwQk69xqFOgDCAAAicLHQATwigQIx0AMBAAAAItEJAgP
vgCD+GaIQhBZdBiD+HR0CsdCCHedBAiJ0MPHQgh8nQQI6/THQgiBnQQI6+tQagKNRCQEUGiHnQQI
aLiwBAjoD/j//4kEJOgv9f//g8QQhcC6AQAAAHQEidBaw/80JOhL9v//MdJZ6+9qEOh/BwAAx0AE
MowECMdACI2dBAjHQAwEAAAAWsNTgewIEAAAaJKdBAhoABAAAI1cJBBT6If0//9qAmoBjUQkFFBo
p50ECFPoxfT//4PEIIXAugEAAAB0CoHECBAAAInQW8OLBCQrRCQEUOjW9f//MdJZ6+SQahDoCQcA
AMdABIyMBAjHQAionQQIx0AMBAAAAFrDV1ZTg+wQoaCyBAi6EA4AAInRmff5uhgAAACJ0ZmLdCQg
9/lqAlJqA418JAxX6LDz//+hoLIECLs8AAAAmff7mcZEJBI69/tqAlJqA41EJB9Q6Izz//+hoLIE
CMZEJCU6mYPEIGoC9/tSagONRCQSUOht8///i04Qg8QQhcl1D1foC/P//4PEFFteMcBfw6GksgQI
xkQkCC6ZUfd+FFCNQQFQjUQkFVDoNvP//4PEEOvOkFNqGOg4BgAAx0AIp50ECMdABAKNBAiJwYtE
JAwPvgCJwoPqMFt4QIP6Bn4FugYAAACF0o1CCHQDjUIJiUEMidCJURBCg/gFx0EUAQAAAH8TuwEA
AACJ0GvbCkKD+AV+9YlZFInIW8Mx0uvGkFdWi3QkDIX2dCyLRggx/4A4IHQXUOhY8v//i34IMcD8
g8n/8q730Y15/1g7fgx+QYs2hfZ11GoK6G3y//+h2LAECC2/sgQIiQQk6IUFAACLDdiwBAheiceB
6cCyBAi+wLIECPyjqLIECPOkxgcAXl/DaiBH6DHy//87fgxYfvLrr5ChqLIECIXAdQXpcP///4lE
JATp2fH//5BXVlOLdCQQ/wXQsAQIhfaLfCQUugEAAAB0OotGCIA4IHRLhdJ0PYX/dC5W/1YEhcBa
dBmLXgyJ2EuFwH4Paj/ozPH//1iJ2EuFwH/xizYx0oX2dcZbXl/D/3YI6Hjx//9Z68dqIOim8f//
W+u5QFDr6pBVV1ZTg+xAMe2DfCRUAcdEJBQAAAAAx0QkEAAAAAC/QEIPAMdEJAxAQg8Ax0QkCLed
BAgPhOQCAABqAGi5nQQI6GMDAACFwFmJw154NWogjXQkJFZQ6FYDAACDxAyFwH4aaMedBAhW6FgG
AACFwA+VwF4PtsBao9SwBAhT6BcDAABZvgEAAAA7dCRUD42PAAAAi0QkWIscsA++A1BorJ0ECOju
BQAAhcBZWnQzicKNQwGB6qydBAhQ/xSV4LAECIXAWnQbg3wkFADHAAAAAAAPhD8CAACLVCQQiQKJ
RCQQi1QkWIsEsooQgPpyD4QWAgAAgPpkD4TdAQAAgPpoD4SxAQAAgPpsD4SaAQAAgPpMD4RwAQAA
Rjt0JFQPjHH///+D/f8PhB4BAABV/3QkGOhb/v//WYX/W8cF2LAECMCyBAh4Mo1EJBhQaKCyBAjo
TgIAAIH/QEIPAA+P3wAAAKGksgQImfd8JBSJ+CnQUOhGBwAAg8QMjUQkGFBooLIECOgcAgAAa0Qk
IDwpBaCyBAhYhe1afhah0LAECJn3/YXSdQr/dCQU6Mz9//9YVf90JBjo2f3///90JBDoqO///6HY
sAQIg8QMPcCyBAh2Hy3AsgQIUGjAsgQIagHo2QEAAIPEDMcF2LAECMCyBAiF/3iFuUBCDwChoLIE
CPfpicGhpLIECInTmQHBi0QkDBHTmVJQU1HoOAkAAIn5KcG6gAAAAIn4idaZ9/6DxBA5wX0CAflR
6IEGAABe6Tj///+4QEIPAOkl/////3QkFOik/P//odiwBAg9wLIECF4Phsj+//8twLIECFBowLIE
CGoB6EUBAACDxAzHBdiwBAjAsgQI6aT+//+DfCQQAA+Ehf7//8YAIItUJFiLBLKLVCQQiUII6W/+
//+DfCQQAA+EZP7//0Dr5oB4AQB1CIPN/+lT/v//agBqAEBQ6FsEAACJxYPEDOk+/v//agBqAEBQ
6EYEAACJx2n/6AMAAIl8JBiDxAyD/wEPjRv+///HRCQMAQAAAOkO/v//x0QkCNqdBAjpAf7//4lE
JBTpvv3//2jgnQQI6D/u//+h2LAECD3AsgQIX3cKg8RAW15fMcBdwy3AsgQIUGjAsgQIagHoaAAA
AIPEDMcF2LAECMCyBAjr1ZAPt8DrBbABD7bAV1ZTieeLXxCLTxSLVxiLdxyLfyDNgIP4hHYO99iJ
w+jKAgAAiRiDyP9bXl/DkLAG6cj///+QsE7pwP///5CwBem4////kLAD6bD///+QsATpqP///5Bq
AGr/aiJqA1BqAOgMBQAAg8QYwzHShcB0EEgl/w8AAMHoBHQFQtHodfuJ0MOQifZVV1ZTUYnGjUD8
iQQkidCJ0+jO////MdKJxYs8JIjQidn886q5YLIECIsUqYsEJIlW/IkEqVhbXl9dw5BWU4nD6J//
//+LDIVgsgQIhcmJxnQUiwGJBLVgsgQIxwEAAAAAichbXsO4ABAAAOhg////icGDyP+D+f906THS
uAAQAAD380iFwIkMtWCyBAh+DInCjQQLSokBicF19scBAAAAAIsMtWCyBAjrqIn2i0QkBIXAdBuL
UPyF0o1I/HQRgfoACAAAdgpSUeg3BAAAWFrD6Sv///+QifZTi0QkCIXAdDiDwASD+AN2MD0ACAAA
djYF/w8AAInDgeMA8P//dR6DyP+D+P90B4kYg8AEW8PoVQEAAMcADAAAADHA6++J2Ois/v//69zo
uf7//4nBuxAAAADT44nY6AH////rxZCJ9ldWU4tcJBSLVCQQidkPr8qF0nQdideJyDHS9/c52HQR
6AMBAADHAAwAAABbXjHAX8OJTCQQW15f6Vv///+QifZVV1ZTi2wkFIXti1wkGA+ExgAAAIXbD4S1
AAAAjXMEg/4DjX38D4aCAAAAgf4ACAAAD4aFAAAAjYMDEAAAJQDw//+JxosHOfB0Nj0ACAAAdzZT
6AH///+Jw4XbWHQgi3P8iwc5xnYCicaF9nQKjU78/Infie7zpFXor/7//16J3VteX4noXcOBxv8P
AABqAYHmAPD//1b/N1fo3gIAAIPEEIP4/3QHjWgEiTDr0+g2AAAAMe3HAAwAAADrxInw6KH9//+J
wbgQAAAA0+Dpcf///1XoVf7//1nrpoXbdKJT6HT+//+JxevvuICyBAjDkJBXi3wkCItEJAyLTCQQ
/Ffzqlhfw1dWi3wkDIt0JBBXMcAxyUnyrk+sqoTAdfpYXl/DkJCQi0wkBIpUJAiKATjCdAdBhMB1
9THJicjDVleLVCQMi3QkEInX/KyqCMB1+l9eidDDVVdWU1GDzv8x0ojQi3wkHPyJ8fKui2wkGInL
ie+J8fKu99P30UuNUf+JHCR0MTHAOdN3GSsUJInTQ3QPi3wkHIoHOEUAdAxFS3XxMcBaW15fXcOL
DCSJ7vw5yfOmdeiJ6OvqkFZTU4tcJBAx9ooDiEQkAw++wFDoxAEAAIXAWXQDQ+vpgHwkAy10WP90
JBj/dCQYU+hTAAAAg8QMPf///392OD0AAACAdBvo5f7//8cAIgAAADHAhfYPlcAF////f1pbXsOF
9nTh6Mb+///HAAAAAAC4AAAAgOvmhfZ04vfY696Dzv9D66KQkJBVV1ZTUVGLXCQci2wkIIt0JCQx
/8dEJAQAAAAAigOIRCQDD77AUOgpAQAAhcBadAND6+mAfCQDLQ+EuQAAAIA7Kw+EqgAAAIP+EA+E
lgAAAIX2dQqAOzB0cL4KAAAAgDsAdDKKAzxgjVCpdxA8QI1QyXcJPDmy/3cDjVDQD7bSOfJ9Eon4
D6/GOfhyLUOAOwCNPAJ1zoXtdAOJXQDoB/7//4N8JAQAxwAAAAAAifh0AvfYWllbXl9dw+jq/f//
xwAiAAAAg8j/6+m+CAAAAIpDATx4dAQ8WHWFg8MCvhAAAADpeP///4A7MA+FYf///+vdQ+lQ////
x0QkBAEAAABD6Tn///+QkJCLRCQEMdK5QEIPAPfxadLoAwAAUlCJ4FBQ6CYAAACDxBDDkJCwWo1U
JARS6H/6//9Zw5CQsKPpdPr//5CwW+ls+v//kLCi6WT6//+Qi1QkBI1C9zHJg/gEdgiD+iB0A4nI
w7kBAAAA6/aQkJBVieWD7BRqAP91FP91EP91DP91COgDAAAAycOQVYnlV1aD7DCLVRSLdQiLfQyL
RRCF0sdF8AAAAADHRfQAAAAAx0XoAAAAAMdF7AAAAACJRcyJVeSJdeCJfdwPhYgAAAA5+HZQifCJ
+vd1zIlV4IlF2MdF1AAAAACLdRiF9nQbi1XgiVXox0XsAAAAAItNGItF6ItV7IkBiVEEi1XYi03U
iVXwiU30i0Xwi1X0g8QwXl/Jw5CLfcyF/3UNuAEAAAAx0vd1zIlFzItF3ItV5Pd1zIlV3IlF1ItF
4Pd1zIlV4IlF2OuTjXYAi0XcOUXkdjCLTRiFycdF2AAAAADHRdQAAAAAdJWJdeiJReyLVeiLRRiL
TeyJEIlIBOl8////ifYPvUXkicaD9h91VYtV5DlV3HcIi03MOU3gcjyLVdyLReArRcwbVeTHRdgB
AAAAiUXgiVXci1UYhdLHRdQAAAAAD4Q0////i0Xgi1XciUXoiVXs6RX////HRdgAAAAA69S4IAAA
ACnwiUXQi1XkifHT4otFzIpN0NPoCcKJ8dNlzIlV5IpN0ItV3NPqi33cifHT54tF4IpN0NPoCceJ
+Pd15Il93InxiVXciUXY92XM02XgO1Xcicd3RjtV3HQ8i0UYhcDHRdQAAAAAD4Sq/v//i03ci0Xg
KfgZ0YlN3InKik3Q0+KJ8YlF4NPoCcKLRdyJVejT6Onu/v//O0Xgdr//TdgrfcwbVeTrtIn2VYnl
jUX4g+wUUP91FP91EP91DP91COgJAAAAi0X4i1X8ycOQVYnlV1aD7DCLVRSLdQiLfQyLRRCF0sdF
8AAAAADHRfQAAAAAx0XoAAAAAMdF7AAAAACJRcyJVeSJdeCJfdwPhYgAAAA5+HZQifCJ+vd1zIlV
4IlF2MdF1AAAAACLdRiF9nQbi1XgiVXox0XsAAAAAItNGItF6ItV7IkBiVEEi1XYi03UiVXwiU30
i0Xwi1X0g8QwXl/Jw5CLfcyF/3UNuAEAAAAx0vd1zIlFzItF3ItV5Pd1zIlV3IlF1ItF4Pd1zIlV
4IlF2OuTjXYAi0XcOUXkdjCLTRiFycdF2AAAAADHRdQAAAAAdJWJdeiJReyLVeiLRRiLTeyJEIlI
BOl8////ifYPvUXkicaD9h91VYtV5DlV3HcIi03MOU3gcjyLVdyLReArRcwbVeTHRdgBAAAAiUXg
iVXci1UYhdLHRdQAAAAAD4Q0////i0Xgi1XciUXoiVXs6RX////HRdgAAAAA69S4IAAAACnwiUXQ
i1XkifHT4otFzIpN0NPoCcKJ8dNlzIlV5IpN0ItV3NPqi33cifHT54tF4IpN0NPoCceJ+Pd15Il9
3InxiVXciUXY92XM02XgO1Xcicd3RjtV3HQ8i0UYhcDHRdQAAAAAD4Sq/v//i03ci0XgKfgZ0YlN
3InKik3Q0+KJ8YlF4NPoCcKLRdyJVejT6Onu/v//O0Xgdr//TdgrfcwbVeTrtIn2AAAAAAAAAAAA
AAAAAAAAAC9wcm9jL3N0YXQAL3Byb2MvbmV0L2RldgAvcHJvYy9tZW1pbmZvAC9wcm9jL2Rpc2tz
dGF0cwAwMTIzNDU2Nzg5ACAxMjM0NTY3ODkAIGtNR1RFUABjcHUgAGludHIAaW50IABjdHh0AGN0
eCAAYmlvIABwYWdlAHNpbyAAc3dhcABwcm9jZXNzZXMAZm9yawA6AE1lbVRvdGFsOgBNZW1GcmVl
OgBCdWZmZXJzOgBDYWNoZWQ6AG1lbSAAdG90IABmcmVlIABTd2FwOgBzd3AgAC9wcm9jL3N5cy9m
cy9maWxlLW5yAABmZCAAbmNtc2ZpeHB0YgAKAC9wcm9jL3ZlcnNpb24ATGludXggdmVyc2lvbiAy
LjYuAA0AAAAAAE5hbm9tZXRlciAwLjcgYWxsb3dzIHlvdSB0byBtb25pdG9yIHlvdXIgc3lzdGVt
IGluIHJlYWwgdGltZQoKT3B0aW9uczoKY1tOXQltb25pdG9yIENQVS4gTiAtIGJhciBzaXplLCBk
ZWZhdWx0IDEwCm5JRkFDRQltb25pdG9yIG5ldHdvcmsgaW50ZXJmYWNlIElGQUNFCm1bZi90XQlt
b25pdG9yIGFsbG9jYXRlZC9mcmVlL3RvdGFsIG1lbW9yeQpzCW1vbml0b3IgYWxsb2NhdGVkIHN3
YXAKZgltb25pdG9yIG51bWJlciBvZiB1c2VkIGZpbGVkZXNjcmlwdG9ycwppW05OXQltb25pdG9y
IHRvdGFsL3NwZWNpZmljIElSUSByYXRlCngJbW9uaXRvciBjb250ZXh0IHN3aXRjaCByYXRlCnAJ
bW9uaXRvciBwcm9jZXNzIGNyZWF0aW9uIHJhdGUKYltzXQltb25pdG9yIGJsb2NrIGlvIChzd2Fw
IGlvKQp0W05dCXNob3cgdGltZSAod2l0aCBOIGRlY2ltYWwgcG9pbnRzKQpkW05dCW1pbGxpc2Vj
b25kcyBiZXR3ZWVuIHVwZGF0ZXMuIERlZmF1bHQgMTAwMApoW05dCXByaW50IGhlYWRlcnMgYWJv
dmUgbnVtYmVycyAoZWFjaCBOIGxpbmVzLCBkZWZhdWx0IG9uY2UpCmxMQUJFTAlzcGVjaWZ5IGxh
YmVsIGZvciBwcmV2aW91cyBpdGVtCkxMQUJFTAlzYW1lICsgbGFiZWwgd2lsbCBiZSBwcmludGVk
IHdpdGhvdXQgc3Vycm91bmRpbmcgYmxhbmtzCnIJcHJpbnQgPGNyPiBpbnN0ZWFkIG9mIDxsZj4g
YXQgRU9MLiBUcnkgaXQgOykKAAAAAAAAAAAAAAAAwJwECP////8AAAAAy5wECP////8AAAAA2ZwE
CP////8AAAAA55wECP////8AAAAA/////wAAAADAsgQIAAAAAJqKBAiahgQI6osECG6MBAjkjAQI
UocECBiIBAjaiQQItI0ECEiJBAgUAAAAAAAAAAF6UgABfAgBGwwEBIgBAABIAAAAHAAAACjn//8b
AAAAAAQBAAAADgiFAgQCAAAADQUEBQAAAC4EBAMAAAAuCAQDAAAALgwEAwAAAC4QBAMAAAAuFAQH
AAAALgAAKAAAAGgAAAD45v//DgIAAAAEAQAAAA4IhQIEAgAAAA0FBAUAAACGBIcDAAAUAAAAAAAA
AAF6UgABfAgBGwwEBIgBAABIAAAAHAAAAMTo//8jAAAAAAQBAAAADgiFAgQCAAAADQUEBwAAAC4E
BAMAAAAuCAQDAAAALgwEAwAAAC4QBAMAAAAuFAQNAAAALgAAKAAAAGgAAACc6P//DgIAAAAEAQAA
AA4IhQIEAgAAAA0FBAUAAACGBIcDAAA=

--------------Boundary-00=_8YDG8IK8JAVI2CUUT06D--

