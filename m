Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132046AbRDNMSL>; Sat, 14 Apr 2001 08:18:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132053AbRDNMSC>; Sat, 14 Apr 2001 08:18:02 -0400
Received: from dial204.za.nextra.sk ([195.168.64.204]:54283 "HELO Boris.SHARK")
	by vger.kernel.org with SMTP id <S132046AbRDNMRw>;
	Sat, 14 Apr 2001 08:17:52 -0400
Date: Sat, 14 Apr 2001 16:12:16 +0200
From: Boris Pisarcik <boris@acheron.sk>
To: linux-kernel@vger.kernel.org
Cc: khttpd@fernus.demon.nl
Subject: OOPS in khttpd, 2.4.4-ac3
Message-ID: <20010414161216.A843@Boris>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello.

I was performing some benchmarks of http transfer with program 'ab' 
(apache benchmark), comparing, how it will perform with/without
kernel khttpd support.

I've got oops several times, the error is replicable on my machine,
without appache even started.

The exact order of actions i did:

modprobe khttpd

I let the default configuration for first try ( threads=2, maxconnect=1000,
         clientport=80, serverport=8080...)

echo 1 > /proc/sys/net/khttpd/start

ab -n 1000 http://localhost:8080/icons/logo.gif (included as attachement)
  and everithing goes well for now, really pretty boost.

echo 1 > /proc/sys/net/khttpd/stop

 got message: Daemon 1 has ended, Daemon 0 has ended

After this step, i see from ps aux: [khttpd - 0 <defunct>] 

Now, stopped the httpd accelerator and increased number of threads to four:
echo 1 > /proc/sys/net/khttpd/stop
echo 4 > /proc/sys/net/khttpd/threads

Restarted khttpd: 

echo 1 > /proc/sys/net/khttpd/start
  (i see some defunct-ed threads too now)


Then i reruned the 'ab' benchmark like above:

ab -n 1000 http://localhost:8080/icons/logo.gif

and the oops become.

If i optionally make yet another try of 'ab' benchmark after this oops, 
i get another oops of type "Aieee in interrupt...killing interrupt"...

-----------------------------------------

Here are infos:

ksymoops 2.3.7 on i586 2.4.3-ac3.  Options used
     -v /usr/src/linux/vmlinux (specified)
     -k ./ksyms (specified)
     -l ./modules (specified)
     -o /lib/modules/2.4.3-ac3/ (specified)
     -m /usr/src/linux/System.map (specified)

Apr 14 14:44:04 Boris kernel: Oops: 0000
Apr 14 14:44:04 Boris kernel: CPU:    0
Apr 14 14:44:04 Boris kernel: EIP:    0010:[<c01bd9a8>]
Using defaults from ksymoops -t elf32-i386 -a i386
Apr 14 14:44:04 Boris kernel: EFLAGS: 00010202
Apr 14 14:44:04 Boris kernel: eax: 00000000   ebx: c141702c   ecx: 00000004   edx: 00000004
Apr 14 14:44:04 Boris kernel: esi: 00000000   edi: c2897a01   ebp: 00000000   esp: c1415f14
Apr 14 14:44:04 Boris kernel: ds: 0018   es: 0018   ss: 0018
Apr 14 14:44:04 Boris kernel: Process khttpd - 0 (pid: 1016, stackpage=c1415000)
Apr 14 14:44:04 Boris kernel: Stack: c0000000 c1417000 c289638a 00000000 c2897a01 c141702c c0000000 c1417000 
Apr 14 14:44:04 Boris kernel:        00000000 00000000 00000000 00000000 00000000 00000000 c2897538 00000000 
Apr 14 14:44:04 Boris kernel:        00000000 c1417000 c02c936c c1417000 00000000 c2899e80 00000000 00000fff 
Apr 14 14:44:04 Boris kernel: Call Trace: [<c289638a>] [<c2897a01>] [<c2897538>] [<c2899e80>] [<c28973e6>] [<c28951f1>] [<c2898e40>] 
Apr 14 14:44:04 Boris kernel:        [<c2898e00>] [<c010542c>] [<c2898e40>] [<c2898e40>] 
Apr 14 14:44:04 Boris kernel: Code: f3 a6 74 0a 96 46 80 78 ff 00 75 ec 31 c0 5e 5f c3 90 90 90 

>>EIP; c01bd9a8 <strstr+20/38>   <=====
Trace; c289638a <[khttpd]ParseHeader+26/2dc>
Trace; c2897a01 <[khttpd].rodata.start+361/6ed>
Trace; c2897538 <[khttpd]DecodeHeader+b4/198>
Trace; c2899e80 <[khttpd]Buffer+180/37f>
Trace; c28973e6 <[khttpd]WaitForHeaders+76/b8>
Trace; c28951f1 <[khttpd]MainDaemon+155/218>
Trace; c2898e40 <[khttpd]CountBuf+0/40>
Trace; c2898e00 <[khttpd]Running+0/40>
Trace; c010542c <kernel_thread+28/38>
Trace; c2898e40 <[khttpd]CountBuf+0/40>
Trace; c2898e40 <[khttpd]CountBuf+0/40>
Code;  c01bd9a8 <strstr+20/38>
00000000 <_EIP>:
Code;  c01bd9a8 <strstr+20/38>   <=====
   0:   f3 a6                     repz cmpsb %es:(%edi),%ds:(%esi)   <=====
Code;  c01bd9aa <strstr+22/38>
   2:   74 0a                     je     e <_EIP+0xe> c01bd9b6 <strstr+2e/38>
Code;  c01bd9ac <strstr+24/38>
   4:   96                        xchg   %eax,%esi
Code;  c01bd9ad <strstr+25/38>
   5:   46                        inc    %esi
Code;  c01bd9ae <strstr+26/38>
   6:   80 78 ff 00               cmpb   $0x0,0xffffffff(%eax)
Code;  c01bd9b2 <strstr+2a/38>
   a:   75 ec                     jne    fffffff8 <_EIP+0xfffffff8> c01bd9a0 <strstr+18/38>
Code;  c01bd9b4 <strstr+2c/38>
   c:   31 c0                     xor    %eax,%eax
Code;  c01bd9b6 <strstr+2e/38>
   e:   5e                        pop    %esi
Code;  c01bd9b7 <strstr+2f/38>
   f:   5f                        pop    %edi
Code;  c01bd9b8 <strstr+30/38>
  10:   c3                        ret    
Code;  c01bd9b9 <strstr+31/38>
  11:   90                        nop    
Code;  c01bd9ba <strstr+32/38>
  12:   90                        nop    
Code;  c01bd9bb <strstr+33/38>
  13:   90                        nop    

---------------------------------------------

cat /proc/modules:

khttpd                 21072   5
autofs4                 8128   6 (autoclean)
3c509                   6896   1 (autoclean)
awe_wave              155936   0
sb                      7008   0
sb_lib                 32368   0 [sb]
uart401                 6000   0 [sb_lib]
sound                  52704   0 [awe_wave sb_lib uart401]
nls_iso8859-1           2848   2 (autoclean)
nls_cp437               4352   2 (autoclean)
vfat                    8400   2 (autoclean)
fat                    29120   0 (autoclean) [vfat]
floppy                 45872   0 (autoclean)
ide-cd                 25904   0 (autoclean)
cdrom                  27008   0 (autoclean) [ide-cd]

-----------------------------------------------------------

ver_linux script:

Linux Boris 2.4.3-ac3 #1 Fri Apr 13 20:48:04 CEST 2001 i586 unknown
 
Gnu C                  2.95.3
Gnu make               3.79.1
binutils               2.10.0.24
util-linux             2.10o
mount                  2.10o
modutils               2.4.5
e2fsprogs              1.19
PPP                    2.4.0
Linux C Library        2.1.3
Dynamic linker (ldd)   2.1.3
Procps                 2.0.7
Net-tools              1.57
Console-tools          0.2.3
Sh-utils               2.0
Modules Loaded         khttpd autofs4 3c509 awe_wave sb sb_lib uart401 sound 
                       nls_iso8859-1 nls_cp437 vfat fat floppy ide-cd cdrom

-------------------------------------------------------------

cat /proc/cpuinfo:

processor	: 0
vendor_id	: GenuineIntel
cpu family	: 5
model		: 4
model name	: Pentium MMX
stepping	: 3
cpu MHz		: 167.047
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: yes
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 1
wp		: yes
flags		: fpu vme de pse tsc msr mce cx8 mmx
bogomips	: 333.41

Maybe i did something stuppid, eg. it's required to unload httpd first
before changing number of threads. In this case or in case this
problem already is/was solved, i'm sorry.

Regards                                                                 B.

