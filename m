Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129957AbRBAJN2>; Thu, 1 Feb 2001 04:13:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130224AbRBAJNS>; Thu, 1 Feb 2001 04:13:18 -0500
Received: from b002-m002-p024.acld.clear.net.nz ([203.167.198.88]:16388 "EHLO
	viola.shakespeare.tla") by vger.kernel.org with ESMTP
	id <S129957AbRBAJNJ>; Thu, 1 Feb 2001 04:13:09 -0500
Message-ID: <3A792872.4030306@cs.waikato.ac.nz>
Date: Thu, 01 Feb 2001 22:12:18 +1300
From: Nicholas Daley <ntd1@cs.waikato.ac.nz>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.2.13 i586; en-US; m18) Gecko/20001010
X-Accept-Language: en-gb, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: small socket send/receive buffers on TCP stream result in data not being transferred
Content-Type: multipart/mixed;
 boundary="------------000904040207030204020902"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------000904040207030204020902
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

I'm pretty sure this is a kernel problem

1. small socket send/receive buffers result in data not being transferred

2. I was playing with socket buffers using setsockopt() and SO_SNDBUF
and SO_RCVBUF (see small attached programs), I found that given small
enough buffers, data would stop being sent, although more was available.
I suspect what is happening is that one of the buffers fills, stops
accepting data, but doesn't reenable it when there's room again.
When I use netstat I find the buffer on the send side full, and the
buffer on the receive end empty.
This behaviour may depend on the speed of the system, on mine I can
usually get it to happen with buffer sizes around 100, especially if the
side sending data has a larger buffer.
I've tested this on a couple of machines running a 2.2 kernel, and one
running a 2.4 kernel.

3. Keywords: Networking, TCP, kernel

4. Kernel version (output of /proc/version):
Linux version 2.4.0 (root@viola) (gcc version egcs-2.91.66
19990314/Linux (egcs-1.1.2 release)) #2 Thu Jan 25 19:56:28 NZDT 2001

6. Attached at the end are two C++ programs (though they could as easily
have been C),
fakefeed - run first, acts as a server that just keeps sending data on a
connection.
fakesim - run second, connects to fake feed, and outputs what's received.
They both take as parameters a port number, and a buffer size.
e.g. fakefeed 8001 500
fakesim 8001 100

7.1. output of ver_linux script:
-- Versions installed: (if some fields are empty or look
-- unusual then possibly you have very old versions)
Linux viola 2.4.0 #2 Thu Jan 25 19:56:28 NZDT 2001 i586 unknown
Kernel modules         2.4.0
Gnu C                  egcs-2.91.66
Gnu Make               3.77
Binutils               2.9.1.0.25
Linux C Library        2.1.2
Dynamic linker         ldd: version 1.9.9
Procps                 2.0.2
Mount                  2.9v
Net-tools              1.52
Kbd                    0.99
Sh-utils               1.16
Modules Loaded         ppp_deflate ipt_state ipt_MASQUERADE
iptable_filter ip_nat_ftp iptable_nat ip_conntrack ip_tables de4x5
v_midi opl3 mpu401 sb sb_lib uart401 sound bsd_comp ppp_async

7.2 output of /proc/cpuinfo
processor
: 0
vendor_id
: GenuineIntel
cpu family	: 5
model
: 4
model name	: Pentium MMX
stepping
: 4
cpu MHz		: 167.049
fdiv_bug
: no
hlt_bug
: no
f00f_bug
: yes
coma_bug
: no
fpu
: yes
fpu_exception
: yes
cpuid level	: 1
wp
: yes
flags
: fpu vme de pse tsc msr mce cx8 mmx
bogomips
: 333.41


7.3 output of /proc/modules
ppp_deflate            40912   0 (autoclean)
ipt_state                800   2 (autoclean)
ipt_MASQUERADE          1312   1 (autoclean)
iptable_filter          1856   0 (autoclean) (unused)
ip_nat_ftp              3440   0 (unused)
iptable_nat            12608   1 [ipt_MASQUERADE ip_nat_ftp]
ip_conntrack           12992   2 [ipt_state ipt_MASQUERADE ip_nat_ftp
iptable_nat]
ip_tables              10656   6 [ipt_state ipt_MASQUERADE
iptable_filter iptable_nat]
de4x5                  42496   1
v_midi                  5264   0 (unused)
opl3                   11792   0 (unused)
mpu401                 18960   0 (unused)
sb                      6656   0 (unused)
sb_lib                 34352   0 [sb]
uart401                 6416   0 [sb_lib]
sound                  57280   0 [v_midi opl3 mpu401 sb_lib uart401]
bsd_comp                4160   0
ppp_async               6464   1


Thanks
-- 
bits and peace

Nicholas Daley  <mailto:ntd1@cs.waikato.ac.nz>
insert :-)=s as appropriate


--------------000904040207030204020902
Content-Type: text/plain;
 name="fakefeed.cc"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="fakefeed.cc"

#include <stdlib.h>
#include <errno.h>
#include <netdb.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <netinet/tcp.h>
#include <unistd.h>
#include <string.h>
#include <stdio.h>
#include <iostream.h>

int openList(int port) {
  int fd=-1;
  sockaddr_in sa;
  fd=socket(PF_INET, SOCK_STREAM, 0);
  if(fd<0) return -1;

  sa.sin_family=AF_INET;
  sa.sin_port=htons(port);
  sa.sin_addr.s_addr=htonl(INADDR_ANY);
  int s=1;
  setsockopt(fd,SOL_SOCKET,SO_REUSEADDR,&s,sizeof(s));
  if(bind(fd,(struct sockaddr*)&sa,sizeof(sa))<0) {
    shutdown(fd,2);
    fd=-1;
    return fd;
  };
  
  if(listen(fd,1)<0) {
    shutdown(fd,2);
    fd=-1;
    return fd;
  };
  return fd;  
};

int main(int argc, char** argv) {
  int listener=openList(argc>1?atoi(argv[1]):8001);
  int stream=accept(listener,NULL,NULL);
  size_t s;
  s=argc>2?atoi(argv[2]):3000;
  setsockopt(stream,SOL_SOCKET,SO_RCVBUF,&s,sizeof(s));
  setsockopt(stream,SOL_SOCKET,SO_SNDBUF,&s,sizeof(s));

  close(listener);
  char buff[200];
  long long sent=0;
  for(int i=1;i;i++) {
    sprintf(buff,"%d\n",i);
    int writeres=write(stream,buff,strlen(buff));
    if(writeres<0) { cerr<<"Write error "<<writeres<<','<<errno<<"\a\n";break;}
    if(writeres==0) { cerr<<"Write EOF\a\n";break;}
    if(writeres!=strlen(buff)) {cerr <<"Didn't finish writing\a\n";break;}
    cerr<<buff<<" Total bytes sent="<<(sent+=writeres)<<endl;
  }
  
};


--------------000904040207030204020902
Content-Type: text/plain;
 name="fakesim.cc"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="fakesim.cc"

#include <stdlib.h>
#include <errno.h>
#include <netdb.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <netinet/tcp.h>
#include <unistd.h>
#include <string.h>
#include <stdio.h>
#include <iostream.h>
typedef double sk_time;

int openCon(const char* hostname, int port) {
  int fd=-1;
  sockaddr_in sa;
  hostent *he;
  
  fd=socket(PF_INET, SOCK_STREAM, 0);
  if(fd<0) return -1;

  sa.sin_family=AF_INET;
  sa.sin_port=htons(port);
  he=gethostbyname(hostname);
  if(he==NULL) return fd=-1;
  sa.sin_addr=*(struct in_addr*) he->h_addr;
  if(connect(fd,(struct sockaddr*) &sa, sizeof(sa))<0) return fd=-1;

  return fd;
  
}
int main(int argc, char** argv) {
  int tracestream=openCon("localhost",argc>1?atoi(argv[1]):8001);
  size_t s;
  s=argc>2?atoi(argv[2]):3000;
  setsockopt(tracestream,SOL_SOCKET,SO_RCVBUF,&s,sizeof(s));
  setsockopt(tracestream,SOL_SOCKET,SO_SNDBUF,&s,sizeof(s));

  while(1) {
      char c;
      if(read(tracestream,&c,1)<=0) break;
      cerr<<c;
  }
  close(tracestream);
};


--------------000904040207030204020902--

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
